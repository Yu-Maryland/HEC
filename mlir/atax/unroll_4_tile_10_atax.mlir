#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 10, s0)>
#map2 = affine_map<()[s0] -> ((s0 floordiv 4) * 4)>
#map3 = affine_map<(d0) -> (d0 + 1)>
#map4 = affine_map<(d0) -> (d0 + 2)>
#map5 = affine_map<(d0) -> (d0 + 3)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_atax(%arg0: i32, %arg1: i32, %arg2: memref<?x2100xf64>, %arg3: memref<?xf64>, %arg4: memref<?xf64>, %arg5: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 0.000000e+00 : f64
    %0 = arith.index_cast %arg1 : i32 to index
    affine.for %arg6 = 0 to %0 step 10 {
      affine.for %arg7 = #map(%arg6) to min #map1(%arg6)[%0] {
        affine.store %cst, %arg4[%arg7] : memref<?xf64>
      }
    }
    %1 = arith.index_cast %arg0 : i32 to index
    affine.for %arg6 = 0 to %1 step 10 {
      affine.for %arg7 = #map(%arg6) to min #map1(%arg6)[%1] {
        affine.store %cst, %arg5[%arg7] : memref<?xf64>
        affine.for %arg8 = 0 to #map2()[%0] step 4 {
          %2 = affine.load %arg5[%arg7] : memref<?xf64>
          %3 = affine.load %arg2[%arg7, %arg8] : memref<?x2100xf64>
          %4 = affine.load %arg3[%arg8] : memref<?xf64>
          %5 = arith.mulf %3, %4 : f64
          %6 = arith.addf %2, %5 : f64
          affine.store %6, %arg5[%arg7] : memref<?xf64>
          %7 = affine.apply #map3(%arg8)
          %8 = affine.load %arg5[%arg7] : memref<?xf64>
          %9 = affine.load %arg2[%arg7, %7] : memref<?x2100xf64>
          %10 = affine.load %arg3[%7] : memref<?xf64>
          %11 = arith.mulf %9, %10 : f64
          %12 = arith.addf %8, %11 : f64
          affine.store %12, %arg5[%arg7] : memref<?xf64>
          %13 = affine.apply #map4(%arg8)
          %14 = affine.load %arg5[%arg7] : memref<?xf64>
          %15 = affine.load %arg2[%arg7, %13] : memref<?x2100xf64>
          %16 = affine.load %arg3[%13] : memref<?xf64>
          %17 = arith.mulf %15, %16 : f64
          %18 = arith.addf %14, %17 : f64
          affine.store %18, %arg5[%arg7] : memref<?xf64>
          %19 = affine.apply #map5(%arg8)
          %20 = affine.load %arg5[%arg7] : memref<?xf64>
          %21 = affine.load %arg2[%arg7, %19] : memref<?x2100xf64>
          %22 = affine.load %arg3[%19] : memref<?xf64>
          %23 = arith.mulf %21, %22 : f64
          %24 = arith.addf %20, %23 : f64
          affine.store %24, %arg5[%arg7] : memref<?xf64>
        }
        affine.for %arg8 = #map2()[%0] to %0 {
          %2 = affine.load %arg5[%arg7] : memref<?xf64>
          %3 = affine.load %arg2[%arg7, %arg8] : memref<?x2100xf64>
          %4 = affine.load %arg3[%arg8] : memref<?xf64>
          %5 = arith.mulf %3, %4 : f64
          %6 = arith.addf %2, %5 : f64
          affine.store %6, %arg5[%arg7] : memref<?xf64>
        }
        affine.for %arg8 = 0 to #map2()[%0] step 4 {
          %2 = affine.load %arg4[%arg8] : memref<?xf64>
          %3 = affine.load %arg2[%arg7, %arg8] : memref<?x2100xf64>
          %4 = affine.load %arg5[%arg7] : memref<?xf64>
          %5 = arith.mulf %3, %4 : f64
          %6 = arith.addf %2, %5 : f64
          affine.store %6, %arg4[%arg8] : memref<?xf64>
          %7 = affine.apply #map3(%arg8)
          %8 = affine.load %arg4[%7] : memref<?xf64>
          %9 = affine.load %arg2[%arg7, %7] : memref<?x2100xf64>
          %10 = affine.load %arg5[%arg7] : memref<?xf64>
          %11 = arith.mulf %9, %10 : f64
          %12 = arith.addf %8, %11 : f64
          affine.store %12, %arg4[%7] : memref<?xf64>
          %13 = affine.apply #map4(%arg8)
          %14 = affine.load %arg4[%13] : memref<?xf64>
          %15 = affine.load %arg2[%arg7, %13] : memref<?x2100xf64>
          %16 = affine.load %arg5[%arg7] : memref<?xf64>
          %17 = arith.mulf %15, %16 : f64
          %18 = arith.addf %14, %17 : f64
          affine.store %18, %arg4[%13] : memref<?xf64>
          %19 = affine.apply #map5(%arg8)
          %20 = affine.load %arg4[%19] : memref<?xf64>
          %21 = affine.load %arg2[%arg7, %19] : memref<?x2100xf64>
          %22 = affine.load %arg5[%arg7] : memref<?xf64>
          %23 = arith.mulf %21, %22 : f64
          %24 = arith.addf %20, %23 : f64
          affine.store %24, %arg4[%19] : memref<?xf64>
        }
        affine.for %arg8 = #map2()[%0] to %0 {
          %2 = affine.load %arg4[%arg8] : memref<?xf64>
          %3 = affine.load %arg2[%arg7, %arg8] : memref<?x2100xf64>
          %4 = affine.load %arg5[%arg7] : memref<?xf64>
          %5 = arith.mulf %3, %4 : f64
          %6 = arith.addf %2, %5 : f64
          affine.store %6, %arg4[%arg8] : memref<?xf64>
        }
      }
    }
    return
  }
}

