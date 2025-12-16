#[allow(dead_code)]

use crate::HashMap;
use core::{default::Default, iter::Iterator};
use std::os::raw::{c_char};
use crate::{ClassType,NodeType,CostType};
use crate::json::{SerializedEnode,EnodeMap};
use std::sync::LazyLock;

// C-compatible POD structure corresponding to C++ egraph_node_POD
#[repr(C)]
pub struct EGraphNodePOD {
    pub op: u32,                 // uint32_t
    pub cost: CostType,
    pub eclass: ClassType,             // uint32_t
    pub node: NodeType,               // uint32_t
    pub children_ptr: *mut ClassType,  // uint32_t*
    pub children_num: usize,
    pub id_ptr: *mut c_char,
    pub id_num: usize,
}

const OP_NAMES: &[&str] = &["input","output","fanout","const0","const1","buffer","not","and","nand","or","nor","xor","xnor","bmux","ohmux"];

static OP_U32:LazyLock<HashMap<&'static str, u32>> = LazyLock::new(|| {OP_NAMES.iter().enumerate().map(|(i,&name)| (name, (i+1) as u32)).collect()});

// Convert POD array to nested HashMap structure using SerializedEnode
pub fn pod_to_egraph_data(nodes_slice: &[EGraphNodePOD],input_len: usize) -> EnodeMap {
    let mut egraph_data: EnodeMap = HashMap::default();
    
    
    for pod_node in nodes_slice {
        // Convert children
        let children = if pod_node.children_ptr.is_null() || pod_node.children_num == 0 {
            Vec::new()
        } else {
            unsafe {
                std::slice::from_raw_parts(pod_node.children_ptr, pod_node.children_num).to_vec()
            }
        };


        // Convert id
        let id = if pod_node.id_ptr.is_null() || pod_node.id_num == 0 {
            String::new()
        } else {
            unsafe {
                let slice = std::slice::from_raw_parts(pod_node.id_ptr as *const u8, pod_node.id_num);
                String::from_utf8_lossy(slice).into_owned()
            }
        };

        let op_name;
        if pod_node.op as u32 <= u32::MAX - 1 && pod_node.op as u32 > u32::MAX - 1 - input_len as u32 {
            let index = u32::MAX - pod_node.op as u32 - 1;
            op_name = format!("PI{}",index).to_string();
        }
        else {
            op_name = OP_NAMES.get(pod_node.op as usize - 1).unwrap_or(&"unknow").to_string();
        }

        // Create SerializedEnode directly
        let json_node = SerializedEnode {
            op: op_name,
            // TODO: 恢复原状，这是为C++接口准备的，当前注释掉避免影响编译
            // cost: pod_node.cost as CostType,
            costs: vec![("default".to_string(), pod_node.cost as CostType)],
            children,
            id,
        };


        // Insert into nested HashMap: egraph_data[eclass][node] = json_node
        egraph_data
            .entry(pod_node.eclass)
            .or_insert_with(HashMap::default)
            .insert(pod_node.node, json_node);
    }

    egraph_data
}

// Convert nested HashMap structure back to POD array
pub fn egraph_data_to_pod(egraph_data: &EnodeMap) -> Vec<EGraphNodePOD> {
    let mut pod_nodes = Vec::new();

    // Iterate through eclasses in sorted order for consistent output
    let mut eclass_ids: Vec<_> = egraph_data.keys().copied().collect();
    eclass_ids.sort();


    for eclass_id in eclass_ids {
        if let Some(node_map) = egraph_data.get(&eclass_id) {
            // Iterate through nodes in sorted order
            let mut node_ids: Vec<_> = node_map.keys().copied().collect();
            node_ids.sort();

            for node_id in node_ids {
                if let Some(json_node) = node_map.get(&node_id) {
                    let children_len = json_node.children.len();
                    let children_ptr = if json_node.children.is_empty() {
                        std::ptr::null_mut()
                    } else {
                        let children_box = json_node.children.clone().into_boxed_slice();
                        Box::into_raw(children_box) as *mut ClassType
                    };

                    let id_len = json_node.id.len();
                    let id_ptr = if json_node.id.is_empty() {
                        std::ptr::null_mut()
                    } else {
                        let id_bytes = json_node.id.clone().into_bytes().into_boxed_slice();
                        Box::into_raw(id_bytes) as *mut c_char
                    };

                    let pod_node = EGraphNodePOD {
                        op: {
                            if let Some(op_code)=OP_U32.get(json_node.op.as_str()).copied(){
                                op_code
                            } else if json_node.op.starts_with("PI"){
                                let num_str=&json_node.op[2..];
                                if let Ok(n) = num_str.parse::<u32>() {
                                    u32::MAX - n - 1
                                } else {
                                    u32::MAX
                                }
                            } else {
                                u32::MAX
                            }
                        },
                        // TODO: 恢复原状，这是为C++接口准备的，当前注释掉避免影响编译
                        // cost: json_node.cost as CostType,
                        cost: json_node.get_default_cost() as CostType,
                        eclass: eclass_id,
                        node: node_id,
                        children_ptr,
                        children_num: children_len,
                        id_ptr,
                        id_num: id_len,
                    };

                    pod_nodes.push(pod_node);
                }
            }
        }
    }

    pod_nodes
}


// Memory cleanup function
#[no_mangle]
pub extern "C" fn free_egraph_data(
    nodes_ptr: *mut EGraphNodePOD,
    nodes_len: usize,
    outputs_ptr: *mut ClassType,
    outputs_len: usize,
) {
    
    if !nodes_ptr.is_null() && nodes_len > 0 {
        unsafe {
            let nodes_slice = std::slice::from_raw_parts_mut(nodes_ptr, nodes_len);
            for node in nodes_slice {
                // Free children array
                if !node.children_ptr.is_null() && node.children_num > 0 {
                    let children_slice = std::slice::from_raw_parts_mut(
                        node.children_ptr, 
                        node.children_num
                    );
                    let _ = Box::from_raw(children_slice);
                }
                
                // Free id string
                if !node.id_ptr.is_null() && node.id_num > 0 {
                    let id_slice = std::slice::from_raw_parts_mut(
                        node.id_ptr as *mut u8, 
                        node.id_num
                    );
                    let _ = Box::from_raw(id_slice);
                }
            }
            
            // Free nodes array
            let _ = Box::from_raw(std::slice::from_raw_parts_mut(nodes_ptr, nodes_len));
        }
    }

    if !outputs_ptr.is_null() && outputs_len > 0 {
        unsafe {
            let outputs_slice = std::slice::from_raw_parts_mut(outputs_ptr, outputs_len);
            let _ = Box::from_raw(outputs_slice);
        }
    }
    
}
