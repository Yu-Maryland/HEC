#map = affine_map<()[s0] -> ((s0 floordiv 3) * 3)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_gesummv(%arg0: i32, %arg1: f64, %arg2: f64, %arg3: memref<?x1300xf64>, %arg4: memref<?x1300xf64>, %arg5: memref<?xf64>, %arg6: memref<?xf64>, %arg7: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 0.000000e+00 : f64
    %0 = arith.index_cast %arg0 : i32 to index
    affine.for %arg8 = 0 to %0 {
      affine.store %cst, %arg5[%arg8] : memref<?xf64>
      affine.store %cst, %arg7[%arg8] : memref<?xf64>
      affine.for %arg9 = 0 to #map()[%0] step 3 {
        %6 = affine.load %arg3[%arg8, %arg9] : memref<?x1300xf64>
        %7 = affine.load %arg6[%arg9] : memref<?xf64>
        %8 = arith.mulf %6, %7 : f64
        %9 = affine.load %arg5[%arg8] : memref<?xf64>
        %10 = arith.addf %8, %9 : f64
        affine.store %10, %arg5[%arg8] : memref<?xf64>
        %11 = affine.load %arg4[%arg8, %arg9] : memref<?x1300xf64>
        %12 = affine.load %arg6[%arg9] : memref<?xf64>
        %13 = arith.mulf %11, %12 : f64
        %14 = affine.load %arg7[%arg8] : memref<?xf64>
        %15 = arith.addf %13, %14 : f64
        affine.store %15, %arg7[%arg8] : memref<?xf64>
        %16 = affine.apply #map1(%arg9)
        %17 = affine.load %arg3[%arg8, %16] : memref<?x1300xf64>
        %18 = affine.load %arg6[%16] : memref<?xf64>
        %19 = arith.mulf %17, %18 : f64
        %20 = affine.load %arg5[%arg8] : memref<?xf64>
        %21 = arith.addf %19, %20 : f64
        affine.store %21, %arg5[%arg8] : memref<?xf64>
        %22 = affine.load %arg4[%arg8, %16] : memref<?x1300xf64>
        %23 = affine.load %arg6[%16] : memref<?xf64>
        %24 = arith.mulf %22, %23 : f64
        %25 = affine.load %arg7[%arg8] : memref<?xf64>
        %26 = arith.addf %24, %25 : f64
        affine.store %26, %arg7[%arg8] : memref<?xf64>
        %27 = affine.apply #map2(%arg9)
        %28 = affine.load %arg3[%arg8, %27] : memref<?x1300xf64>
        %29 = affine.load %arg6[%27] : memref<?xf64>
        %30 = arith.mulf %28, %29 : f64
        %31 = affine.load %arg5[%arg8] : memref<?xf64>
        %32 = arith.addf %30, %31 : f64
        affine.store %32, %arg5[%arg8] : memref<?xf64>
        %33 = affine.load %arg4[%arg8, %27] : memref<?x1300xf64>
        %34 = affine.load %arg6[%27] : memref<?xf64>
        %35 = arith.mulf %33, %34 : f64
        %36 = affine.load %arg7[%arg8] : memref<?xf64>
        %37 = arith.addf %35, %36 : f64
        affine.store %37, %arg7[%arg8] : memref<?xf64>
      }
      affine.for %arg9 = #map()[%0] to %0 {
        %6 = affine.load %arg3[%arg8, %arg9] : memref<?x1300xf64>
        %7 = affine.load %arg6[%arg9] : memref<?xf64>
        %8 = arith.mulf %6, %7 : f64
        %9 = affine.load %arg5[%arg8] : memref<?xf64>
        %10 = arith.addf %8, %9 : f64
        affine.store %10, %arg5[%arg8] : memref<?xf64>
        %11 = affine.load %arg4[%arg8, %arg9] : memref<?x1300xf64>
        %12 = affine.load %arg6[%arg9] : memref<?xf64>
        %13 = arith.mulf %11, %12 : f64
        %14 = affine.load %arg7[%arg8] : memref<?xf64>
        %15 = arith.addf %13, %14 : f64
        affine.store %15, %arg7[%arg8] : memref<?xf64>
      }
      %1 = affine.load %arg5[%arg8] : memref<?xf64>
      %2 = arith.mulf %arg1, %1 : f64
      %3 = affine.load %arg7[%arg8] : memref<?xf64>
      %4 = arith.mulf %arg2, %3 : f64
      %5 = arith.addf %2, %4 : f64
      affine.store %5, %arg7[%arg8] : memref<?xf64>
    }
    return
  }
}

