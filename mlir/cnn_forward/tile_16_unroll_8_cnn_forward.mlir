#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 16, s0)>
#map2 = affine_map<()[s0] -> ((s0 floordiv 8) * 8)>
#map3 = affine_map<(d0) -> (d0 + 1)>
#map4 = affine_map<(d0) -> (d0 + 2)>
#map5 = affine_map<(d0) -> (d0 + 3)>
#map6 = affine_map<(d0) -> (d0 + 4)>
#map7 = affine_map<(d0) -> (d0 + 5)>
#map8 = affine_map<(d0) -> (d0 + 6)>
#map9 = affine_map<(d0) -> (d0 + 7)>
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
    affine.for %arg14 = 0 to %7 step 16 {
      affine.for %arg15 = 0 to %0 step 16 {
        affine.for %arg16 = 0 to %1 step 16 {
          affine.for %arg17 = 0 to %2 step 16 {
            affine.for %arg18 = 0 to %3 step 16 {
              affine.for %arg19 = 0 to %4 step 16 {
                affine.for %arg20 = #map(%arg14) to min #map1(%arg14)[%7] {
                  affine.for %arg21 = #map(%arg15) to min #map1(%arg15)[%0] {
                    affine.for %arg22 = #map(%arg16) to min #map1(%arg16)[%1] {
                      affine.for %arg23 = #map(%arg17) to min #map1(%arg17)[%2] {
                        affine.for %arg24 = #map(%arg18) to min #map1(%arg18)[%3] {
                          affine.for %arg25 = #map(%arg19) to min #map1(%arg19)[%4] {
                            affine.for %arg26 = 0 to #map2()[%5] step 8 {
                              %8 = affine.load %arg12[%arg21, %arg24, %arg25, %arg26] : memref<?x75x6x6xf64>
                              %9 = affine.load %arg13[%arg20, %arg24, -%arg25 + %arg22 * symbol(%6) + 5, -%arg26 + %arg23 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                              %10 = arith.mulf %8, %9 : f64
                              %11 = affine.load %arg11[%arg20, %arg21, %arg22, %arg23] : memref<?x40x9x9xf64>
                              %12 = arith.addf %11, %10 : f64
                              affine.store %12, %arg11[%arg20, %arg21, %arg22, %arg23] : memref<?x40x9x9xf64>
                              %13 = affine.apply #map3(%arg26)
                              %14 = affine.load %arg12[%arg21, %arg24, %arg25, %13] : memref<?x75x6x6xf64>
                              %15 = affine.load %arg13[%arg20, %arg24, -%arg25 + %arg22 * symbol(%6) + 5, -%13 + %arg23 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                              %16 = arith.mulf %14, %15 : f64
                              %17 = affine.load %arg11[%arg20, %arg21, %arg22, %arg23] : memref<?x40x9x9xf64>
                              %18 = arith.addf %17, %16 : f64
                              affine.store %18, %arg11[%arg20, %arg21, %arg22, %arg23] : memref<?x40x9x9xf64>
                              %19 = affine.apply #map4(%arg26)
                              %20 = affine.load %arg12[%arg21, %arg24, %arg25, %19] : memref<?x75x6x6xf64>
                              %21 = affine.load %arg13[%arg20, %arg24, -%arg25 + %arg22 * symbol(%6) + 5, -%19 + %arg23 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                              %22 = arith.mulf %20, %21 : f64
                              %23 = affine.load %arg11[%arg20, %arg21, %arg22, %arg23] : memref<?x40x9x9xf64>
                              %24 = arith.addf %23, %22 : f64
                              affine.store %24, %arg11[%arg20, %arg21, %arg22, %arg23] : memref<?x40x9x9xf64>
                              %25 = affine.apply #map5(%arg26)
                              %26 = affine.load %arg12[%arg21, %arg24, %arg25, %25] : memref<?x75x6x6xf64>
                              %27 = affine.load %arg13[%arg20, %arg24, -%arg25 + %arg22 * symbol(%6) + 5, -%25 + %arg23 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                              %28 = arith.mulf %26, %27 : f64
                              %29 = affine.load %arg11[%arg20, %arg21, %arg22, %arg23] : memref<?x40x9x9xf64>
                              %30 = arith.addf %29, %28 : f64
                              affine.store %30, %arg11[%arg20, %arg21, %arg22, %arg23] : memref<?x40x9x9xf64>
                              %31 = affine.apply #map6(%arg26)
                              %32 = affine.load %arg12[%arg21, %arg24, %arg25, %31] : memref<?x75x6x6xf64>
                              %33 = affine.load %arg13[%arg20, %arg24, -%arg25 + %arg22 * symbol(%6) + 5, -%31 + %arg23 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                              %34 = arith.mulf %32, %33 : f64
                              %35 = affine.load %arg11[%arg20, %arg21, %arg22, %arg23] : memref<?x40x9x9xf64>
                              %36 = arith.addf %35, %34 : f64
                              affine.store %36, %arg11[%arg20, %arg21, %arg22, %arg23] : memref<?x40x9x9xf64>
                              %37 = affine.apply #map7(%arg26)
                              %38 = affine.load %arg12[%arg21, %arg24, %arg25, %37] : memref<?x75x6x6xf64>
                              %39 = affine.load %arg13[%arg20, %arg24, -%arg25 + %arg22 * symbol(%6) + 5, -%37 + %arg23 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                              %40 = arith.mulf %38, %39 : f64
                              %41 = affine.load %arg11[%arg20, %arg21, %arg22, %arg23] : memref<?x40x9x9xf64>
                              %42 = arith.addf %41, %40 : f64
                              affine.store %42, %arg11[%arg20, %arg21, %arg22, %arg23] : memref<?x40x9x9xf64>
                              %43 = affine.apply #map8(%arg26)
                              %44 = affine.load %arg12[%arg21, %arg24, %arg25, %43] : memref<?x75x6x6xf64>
                              %45 = affine.load %arg13[%arg20, %arg24, -%arg25 + %arg22 * symbol(%6) + 5, -%43 + %arg23 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                              %46 = arith.mulf %44, %45 : f64
                              %47 = affine.load %arg11[%arg20, %arg21, %arg22, %arg23] : memref<?x40x9x9xf64>
                              %48 = arith.addf %47, %46 : f64
                              affine.store %48, %arg11[%arg20, %arg21, %arg22, %arg23] : memref<?x40x9x9xf64>
                              %49 = affine.apply #map9(%arg26)
                              %50 = affine.load %arg12[%arg21, %arg24, %arg25, %49] : memref<?x75x6x6xf64>
                              %51 = affine.load %arg13[%arg20, %arg24, -%arg25 + %arg22 * symbol(%6) + 5, -%49 + %arg23 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                              %52 = arith.mulf %50, %51 : f64
                              %53 = affine.load %arg11[%arg20, %arg21, %arg22, %arg23] : memref<?x40x9x9xf64>
                              %54 = arith.addf %53, %52 : f64
                              affine.store %54, %arg11[%arg20, %arg21, %arg22, %arg23] : memref<?x40x9x9xf64>
                            }
                            affine.for %arg26 = #map2()[%5] to %5 {
                              %8 = affine.load %arg12[%arg21, %arg24, %arg25, %arg26] : memref<?x75x6x6xf64>
                              %9 = affine.load %arg13[%arg20, %arg24, -%arg25 + %arg22 * symbol(%6) + 5, -%arg26 + %arg23 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                              %10 = arith.mulf %8, %9 : f64
                              %11 = affine.load %arg11[%arg20, %arg21, %arg22, %arg23] : memref<?x40x9x9xf64>
                              %12 = arith.addf %11, %10 : f64
                              affine.store %12, %arg11[%arg20, %arg21, %arg22, %arg23] : memref<?x40x9x9xf64>
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

