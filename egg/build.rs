use std::path::Path;

fn main() {
    // Only link LP extractor when the feature is enabled
    if cfg!(feature = "lp-extractor") {
        // Get the directory containing this build.rs (egg directory)
        let manifest_dir = std::env::var("CARGO_MANIFEST_DIR").unwrap();
        let lp_extractor_dir = Path::new(&manifest_dir).join("lp_extractor");
        
        // Convert to string for cargo instructions
        let lp_path = lp_extractor_dir.to_str().unwrap();
        
        // Tell rustc where to find the C++ library for linking
        println!("cargo:rustc-link-search=native={}", lp_path);
        println!("cargo:rustc-link-lib=lp_extract");
        
        // Link Gurobi libraries and C++ standard library
        if let Ok(gurobi_home) = std::env::var("GUROBI_HOME") {
            let gurobi_lib_dir = format!("{}/lib", gurobi_home);
            println!("cargo:rustc-link-search=native={}", gurobi_lib_dir);
            println!("cargo:rustc-link-lib=gurobi_c++");
            println!("cargo:rustc-link-lib=gurobi120");
            println!("cargo:rustc-link-lib=stdc++");
        }
    }
}