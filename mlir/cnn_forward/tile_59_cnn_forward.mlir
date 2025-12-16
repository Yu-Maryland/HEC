#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 59, s0)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>, #dlti.dl_entry<"dlti.endianness", "little">>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @cnn_forward(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: memref<?x40x9x9xf64>, %arg12: memref<?x75x6x6xf64>, %arg13: memref<?x75x50x50xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg2 : i32 to index
    %2 = arith.index_cast %arg3 : i32 to index
    %3 = arith.index_cast %arg4 : i32 to index
    %4 = arith.index_cast %arg5 : i32 to index
    %5 = arith.index_cast %arg6 : i32 to index
    %6 = arith.index_cast %arg9 : i32 to index
    %7 = arith.index_cast %arg0 : i32 to index
    affine.for %arg14 = 0 to %7 step 59 {
      affine.for %arg15 = 0 to %0 step 59 {
        affine.for %arg16 = 0 to %1 step 59 {
          affine.for %arg17 = 0 to %2 step 59 {
            affine.for %arg18 = 0 to %3 step 59 {
              affine.for %arg19 = 0 to %4 step 59 {
                affine.for %arg20 = 0 to %5 step 59 {
                  affine.for %arg21 = #map(%arg14) to min #map1(%arg14)[%7] {
                    affine.for %arg22 = #map(%arg15) to min #map1(%arg15)[%0] {
                      affine.for %arg23 = #map(%arg16) to min #map1(%arg16)[%1] {
                        affine.for %arg24 = #map(%arg17) to min #map1(%arg17)[%2] {
                          affine.for %arg25 = #map(%arg18) to min #map1(%arg18)[%3] {
                            affine.for %arg26 = #map(%arg19) to min #map1(%arg19)[%4] {
                              affine.for %arg27 = #map(%arg20) to min #map1(%arg20)[%5] {
                                %8 = affine.load %arg12[%arg22, %arg25, %arg26, %arg27] : memref<?x75x6x6xf64>
                                %9 = affine.load %arg13[%arg21, %arg25, -%arg26 + %arg23 * symbol(%6) + 5, -%arg27 + %arg24 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                                %10 = arith.mulf %8, %9 : f64
                                %11 = affine.load %arg11[%arg21, %arg22, %arg23, %arg24] : memref<?x40x9x9xf64>
                                %12 = arith.addf %11, %10 : f64
                                affine.store %12, %arg11[%arg21, %arg22, %arg23, %arg24] : memref<?x40x9x9xf64>
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    return
  }
}

