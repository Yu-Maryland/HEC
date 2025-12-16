#map = affine_map<()[s0] -> (s0 - 1)>
#map1 = affine_map<()[s0] -> ((s0 floordiv 2) * 2 - 1)>
#map2 = affine_map<(d0) -> (d0 + 1)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_seidel_2d(%arg0: i32, %arg1: i32, %arg2: memref<?x2000xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 9.000000e+00 : f64
    %0 = arith.index_cast %arg0 : i32 to index
    %1 = arith.index_cast %arg1 : i32 to index
    affine.for %arg3 = 0 to %0 {
      affine.for %arg4 = 1 to #map()[%1] {
        affine.for %arg5 = 1 to #map1()[%1] step 2 {
          %2 = affine.load %arg2[%arg4 - 1, %arg5 - 1] : memref<?x2000xf64>
          %3 = affine.load %arg2[%arg4 - 1, %arg5] : memref<?x2000xf64>
          %4 = arith.addf %2, %3 : f64
          %5 = affine.load %arg2[%arg4 - 1, %arg5 + 1] : memref<?x2000xf64>
          %6 = arith.addf %4, %5 : f64
          %7 = affine.load %arg2[%arg4, %arg5 - 1] : memref<?x2000xf64>
          %8 = arith.addf %6, %7 : f64
          %9 = affine.load %arg2[%arg4, %arg5] : memref<?x2000xf64>
          %10 = arith.addf %8, %9 : f64
          %11 = affine.load %arg2[%arg4, %arg5 + 1] : memref<?x2000xf64>
          %12 = arith.addf %10, %11 : f64
          %13 = affine.load %arg2[%arg4 + 1, %arg5 - 1] : memref<?x2000xf64>
          %14 = arith.addf %12, %13 : f64
          %15 = affine.load %arg2[%arg4 + 1, %arg5] : memref<?x2000xf64>
          %16 = arith.addf %14, %15 : f64
          %17 = affine.load %arg2[%arg4 + 1, %arg5 + 1] : memref<?x2000xf64>
          %18 = arith.addf %16, %17 : f64
          %19 = arith.divf %18, %cst : f64
          affine.store %19, %arg2[%arg4, %arg5] : memref<?x2000xf64>
          %20 = affine.apply #map2(%arg5)
          %21 = affine.load %arg2[%arg4 - 1, %20 - 1] : memref<?x2000xf64>
          %22 = affine.load %arg2[%arg4 - 1, %20] : memref<?x2000xf64>
          %23 = arith.addf %21, %22 : f64
          %24 = affine.load %arg2[%arg4 - 1, %20 + 1] : memref<?x2000xf64>
          %25 = arith.addf %23, %24 : f64
          %26 = affine.load %arg2[%arg4, %20 - 1] : memref<?x2000xf64>
          %27 = arith.addf %25, %26 : f64
          %28 = affine.load %arg2[%arg4, %20] : memref<?x2000xf64>
          %29 = arith.addf %27, %28 : f64
          %30 = affine.load %arg2[%arg4, %20 + 1] : memref<?x2000xf64>
          %31 = arith.addf %29, %30 : f64
          %32 = affine.load %arg2[%arg4 + 1, %20 - 1] : memref<?x2000xf64>
          %33 = arith.addf %31, %32 : f64
          %34 = affine.load %arg2[%arg4 + 1, %20] : memref<?x2000xf64>
          %35 = arith.addf %33, %34 : f64
          %36 = affine.load %arg2[%arg4 + 1, %20 + 1] : memref<?x2000xf64>
          %37 = arith.addf %35, %36 : f64
          %38 = arith.divf %37, %cst : f64
          affine.store %38, %arg2[%arg4, %20] : memref<?x2000xf64>
        }
        affine.for %arg5 = #map1()[%1] to #map()[%1] {
          %2 = affine.load %arg2[%arg4 - 1, %arg5 - 1] : memref<?x2000xf64>
          %3 = affine.load %arg2[%arg4 - 1, %arg5] : memref<?x2000xf64>
          %4 = arith.addf %2, %3 : f64
          %5 = affine.load %arg2[%arg4 - 1, %arg5 + 1] : memref<?x2000xf64>
          %6 = arith.addf %4, %5 : f64
          %7 = affine.load %arg2[%arg4, %arg5 - 1] : memref<?x2000xf64>
          %8 = arith.addf %6, %7 : f64
          %9 = affine.load %arg2[%arg4, %arg5] : memref<?x2000xf64>
          %10 = arith.addf %8, %9 : f64
          %11 = affine.load %arg2[%arg4, %arg5 + 1] : memref<?x2000xf64>
          %12 = arith.addf %10, %11 : f64
          %13 = affine.load %arg2[%arg4 + 1, %arg5 - 1] : memref<?x2000xf64>
          %14 = arith.addf %12, %13 : f64
          %15 = affine.load %arg2[%arg4 + 1, %arg5] : memref<?x2000xf64>
          %16 = arith.addf %14, %15 : f64
          %17 = affine.load %arg2[%arg4 + 1, %arg5 + 1] : memref<?x2000xf64>
          %18 = arith.addf %16, %17 : f64
          %19 = arith.divf %18, %cst : f64
          affine.store %19, %arg2[%arg4, %arg5] : memref<?x2000xf64>
        }
      }
    }
    return
  }
}

