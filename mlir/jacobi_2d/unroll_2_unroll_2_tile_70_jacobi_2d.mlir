#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 70, s0)>
#map2 = affine_map<()[s0] -> (s0 - 1)>
#map3 = affine_map<()[s0] -> (((s0 floordiv 2 - 1) floordiv 2) * 4 + 1)>
#map4 = affine_map<(d0) -> (d0 + 1)>
#map5 = affine_map<(d0) -> (d0 + 2)>
#map6 = affine_map<()[s0] -> ((s0 floordiv 2) * 2 - 1)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_jacobi_2d(%arg0: i32, %arg1: i32, %arg2: memref<?x1300xf64>, %arg3: memref<?x1300xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 2.000000e-01 : f64
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg0 : i32 to index
    affine.for %arg4 = 0 to %1 step 70 {
      affine.for %arg5 = #map(%arg4) to min #map1(%arg4)[%1] {
        affine.for %arg6 = 1 to #map2()[%0] {
          affine.for %arg7 = 1 to #map3()[%0] step 4 {
            %2 = affine.load %arg2[%arg6, %arg7] : memref<?x1300xf64>
            %3 = affine.load %arg2[%arg6, %arg7 - 1] : memref<?x1300xf64>
            %4 = arith.addf %2, %3 : f64
            %5 = affine.load %arg2[%arg6, %arg7 + 1] : memref<?x1300xf64>
            %6 = arith.addf %4, %5 : f64
            %7 = affine.load %arg2[%arg6 + 1, %arg7] : memref<?x1300xf64>
            %8 = arith.addf %6, %7 : f64
            %9 = affine.load %arg2[%arg6 - 1, %arg7] : memref<?x1300xf64>
            %10 = arith.addf %8, %9 : f64
            %11 = arith.mulf %10, %cst : f64
            affine.store %11, %arg3[%arg6, %arg7] : memref<?x1300xf64>
            %12 = affine.apply #map4(%arg7)
            %13 = affine.load %arg2[%arg6, %12] : memref<?x1300xf64>
            %14 = affine.load %arg2[%arg6, %12 - 1] : memref<?x1300xf64>
            %15 = arith.addf %13, %14 : f64
            %16 = affine.load %arg2[%arg6, %12 + 1] : memref<?x1300xf64>
            %17 = arith.addf %15, %16 : f64
            %18 = affine.load %arg2[%arg6 + 1, %12] : memref<?x1300xf64>
            %19 = arith.addf %17, %18 : f64
            %20 = affine.load %arg2[%arg6 - 1, %12] : memref<?x1300xf64>
            %21 = arith.addf %19, %20 : f64
            %22 = arith.mulf %21, %cst : f64
            affine.store %22, %arg3[%arg6, %12] : memref<?x1300xf64>
            %23 = affine.apply #map5(%arg7)
            %24 = affine.load %arg2[%arg6, %23] : memref<?x1300xf64>
            %25 = affine.load %arg2[%arg6, %23 - 1] : memref<?x1300xf64>
            %26 = arith.addf %24, %25 : f64
            %27 = affine.load %arg2[%arg6, %23 + 1] : memref<?x1300xf64>
            %28 = arith.addf %26, %27 : f64
            %29 = affine.load %arg2[%arg6 + 1, %23] : memref<?x1300xf64>
            %30 = arith.addf %28, %29 : f64
            %31 = affine.load %arg2[%arg6 - 1, %23] : memref<?x1300xf64>
            %32 = arith.addf %30, %31 : f64
            %33 = arith.mulf %32, %cst : f64
            affine.store %33, %arg3[%arg6, %23] : memref<?x1300xf64>
            %34 = affine.apply #map4(%23)
            %35 = affine.load %arg2[%arg6, %34] : memref<?x1300xf64>
            %36 = affine.load %arg2[%arg6, %34 - 1] : memref<?x1300xf64>
            %37 = arith.addf %35, %36 : f64
            %38 = affine.load %arg2[%arg6, %34 + 1] : memref<?x1300xf64>
            %39 = arith.addf %37, %38 : f64
            %40 = affine.load %arg2[%arg6 + 1, %34] : memref<?x1300xf64>
            %41 = arith.addf %39, %40 : f64
            %42 = affine.load %arg2[%arg6 - 1, %34] : memref<?x1300xf64>
            %43 = arith.addf %41, %42 : f64
            %44 = arith.mulf %43, %cst : f64
            affine.store %44, %arg3[%arg6, %34] : memref<?x1300xf64>
          }
          affine.for %arg7 = #map3()[%0] to #map6()[%0] step 2 {
            %2 = affine.load %arg2[%arg6, %arg7] : memref<?x1300xf64>
            %3 = affine.load %arg2[%arg6, %arg7 - 1] : memref<?x1300xf64>
            %4 = arith.addf %2, %3 : f64
            %5 = affine.load %arg2[%arg6, %arg7 + 1] : memref<?x1300xf64>
            %6 = arith.addf %4, %5 : f64
            %7 = affine.load %arg2[%arg6 + 1, %arg7] : memref<?x1300xf64>
            %8 = arith.addf %6, %7 : f64
            %9 = affine.load %arg2[%arg6 - 1, %arg7] : memref<?x1300xf64>
            %10 = arith.addf %8, %9 : f64
            %11 = arith.mulf %10, %cst : f64
            affine.store %11, %arg3[%arg6, %arg7] : memref<?x1300xf64>
            %12 = affine.apply #map4(%arg7)
            %13 = affine.load %arg2[%arg6, %12] : memref<?x1300xf64>
            %14 = affine.load %arg2[%arg6, %12 - 1] : memref<?x1300xf64>
            %15 = arith.addf %13, %14 : f64
            %16 = affine.load %arg2[%arg6, %12 + 1] : memref<?x1300xf64>
            %17 = arith.addf %15, %16 : f64
            %18 = affine.load %arg2[%arg6 + 1, %12] : memref<?x1300xf64>
            %19 = arith.addf %17, %18 : f64
            %20 = affine.load %arg2[%arg6 - 1, %12] : memref<?x1300xf64>
            %21 = arith.addf %19, %20 : f64
            %22 = arith.mulf %21, %cst : f64
            affine.store %22, %arg3[%arg6, %12] : memref<?x1300xf64>
          }
          affine.for %arg7 = #map6()[%0] to #map6()[%0] step 2 {
            %2 = affine.load %arg2[%arg6, %arg7] : memref<?x1300xf64>
            %3 = affine.load %arg2[%arg6, %arg7 - 1] : memref<?x1300xf64>
            %4 = arith.addf %2, %3 : f64
            %5 = affine.load %arg2[%arg6, %arg7 + 1] : memref<?x1300xf64>
            %6 = arith.addf %4, %5 : f64
            %7 = affine.load %arg2[%arg6 + 1, %arg7] : memref<?x1300xf64>
            %8 = arith.addf %6, %7 : f64
            %9 = affine.load %arg2[%arg6 - 1, %arg7] : memref<?x1300xf64>
            %10 = arith.addf %8, %9 : f64
            %11 = arith.mulf %10, %cst : f64
            affine.store %11, %arg3[%arg6, %arg7] : memref<?x1300xf64>
            %12 = affine.apply #map4(%arg7)
            %13 = affine.load %arg2[%arg6, %12] : memref<?x1300xf64>
            %14 = affine.load %arg2[%arg6, %12 - 1] : memref<?x1300xf64>
            %15 = arith.addf %13, %14 : f64
            %16 = affine.load %arg2[%arg6, %12 + 1] : memref<?x1300xf64>
            %17 = arith.addf %15, %16 : f64
            %18 = affine.load %arg2[%arg6 + 1, %12] : memref<?x1300xf64>
            %19 = arith.addf %17, %18 : f64
            %20 = affine.load %arg2[%arg6 - 1, %12] : memref<?x1300xf64>
            %21 = arith.addf %19, %20 : f64
            %22 = arith.mulf %21, %cst : f64
            affine.store %22, %arg3[%arg6, %12] : memref<?x1300xf64>
          }
          affine.for %arg7 = #map6()[%0] to #map2()[%0] {
            %2 = affine.load %arg2[%arg6, %arg7] : memref<?x1300xf64>
            %3 = affine.load %arg2[%arg6, %arg7 - 1] : memref<?x1300xf64>
            %4 = arith.addf %2, %3 : f64
            %5 = affine.load %arg2[%arg6, %arg7 + 1] : memref<?x1300xf64>
            %6 = arith.addf %4, %5 : f64
            %7 = affine.load %arg2[%arg6 + 1, %arg7] : memref<?x1300xf64>
            %8 = arith.addf %6, %7 : f64
            %9 = affine.load %arg2[%arg6 - 1, %arg7] : memref<?x1300xf64>
            %10 = arith.addf %8, %9 : f64
            %11 = arith.mulf %10, %cst : f64
            affine.store %11, %arg3[%arg6, %arg7] : memref<?x1300xf64>
          }
        }
        affine.for %arg6 = 1 to #map2()[%0] {
          affine.for %arg7 = 1 to #map3()[%0] step 4 {
            %2 = affine.load %arg3[%arg6, %arg7] : memref<?x1300xf64>
            %3 = affine.load %arg3[%arg6, %arg7 - 1] : memref<?x1300xf64>
            %4 = arith.addf %2, %3 : f64
            %5 = affine.load %arg3[%arg6, %arg7 + 1] : memref<?x1300xf64>
            %6 = arith.addf %4, %5 : f64
            %7 = affine.load %arg3[%arg6 + 1, %arg7] : memref<?x1300xf64>
            %8 = arith.addf %6, %7 : f64
            %9 = affine.load %arg3[%arg6 - 1, %arg7] : memref<?x1300xf64>
            %10 = arith.addf %8, %9 : f64
            %11 = arith.mulf %10, %cst : f64
            affine.store %11, %arg2[%arg6, %arg7] : memref<?x1300xf64>
            %12 = affine.apply #map4(%arg7)
            %13 = affine.load %arg3[%arg6, %12] : memref<?x1300xf64>
            %14 = affine.load %arg3[%arg6, %12 - 1] : memref<?x1300xf64>
            %15 = arith.addf %13, %14 : f64
            %16 = affine.load %arg3[%arg6, %12 + 1] : memref<?x1300xf64>
            %17 = arith.addf %15, %16 : f64
            %18 = affine.load %arg3[%arg6 + 1, %12] : memref<?x1300xf64>
            %19 = arith.addf %17, %18 : f64
            %20 = affine.load %arg3[%arg6 - 1, %12] : memref<?x1300xf64>
            %21 = arith.addf %19, %20 : f64
            %22 = arith.mulf %21, %cst : f64
            affine.store %22, %arg2[%arg6, %12] : memref<?x1300xf64>
            %23 = affine.apply #map5(%arg7)
            %24 = affine.load %arg3[%arg6, %23] : memref<?x1300xf64>
            %25 = affine.load %arg3[%arg6, %23 - 1] : memref<?x1300xf64>
            %26 = arith.addf %24, %25 : f64
            %27 = affine.load %arg3[%arg6, %23 + 1] : memref<?x1300xf64>
            %28 = arith.addf %26, %27 : f64
            %29 = affine.load %arg3[%arg6 + 1, %23] : memref<?x1300xf64>
            %30 = arith.addf %28, %29 : f64
            %31 = affine.load %arg3[%arg6 - 1, %23] : memref<?x1300xf64>
            %32 = arith.addf %30, %31 : f64
            %33 = arith.mulf %32, %cst : f64
            affine.store %33, %arg2[%arg6, %23] : memref<?x1300xf64>
            %34 = affine.apply #map4(%23)
            %35 = affine.load %arg3[%arg6, %34] : memref<?x1300xf64>
            %36 = affine.load %arg3[%arg6, %34 - 1] : memref<?x1300xf64>
            %37 = arith.addf %35, %36 : f64
            %38 = affine.load %arg3[%arg6, %34 + 1] : memref<?x1300xf64>
            %39 = arith.addf %37, %38 : f64
            %40 = affine.load %arg3[%arg6 + 1, %34] : memref<?x1300xf64>
            %41 = arith.addf %39, %40 : f64
            %42 = affine.load %arg3[%arg6 - 1, %34] : memref<?x1300xf64>
            %43 = arith.addf %41, %42 : f64
            %44 = arith.mulf %43, %cst : f64
            affine.store %44, %arg2[%arg6, %34] : memref<?x1300xf64>
          }
          affine.for %arg7 = #map3()[%0] to #map6()[%0] step 2 {
            %2 = affine.load %arg3[%arg6, %arg7] : memref<?x1300xf64>
            %3 = affine.load %arg3[%arg6, %arg7 - 1] : memref<?x1300xf64>
            %4 = arith.addf %2, %3 : f64
            %5 = affine.load %arg3[%arg6, %arg7 + 1] : memref<?x1300xf64>
            %6 = arith.addf %4, %5 : f64
            %7 = affine.load %arg3[%arg6 + 1, %arg7] : memref<?x1300xf64>
            %8 = arith.addf %6, %7 : f64
            %9 = affine.load %arg3[%arg6 - 1, %arg7] : memref<?x1300xf64>
            %10 = arith.addf %8, %9 : f64
            %11 = arith.mulf %10, %cst : f64
            affine.store %11, %arg2[%arg6, %arg7] : memref<?x1300xf64>
            %12 = affine.apply #map4(%arg7)
            %13 = affine.load %arg3[%arg6, %12] : memref<?x1300xf64>
            %14 = affine.load %arg3[%arg6, %12 - 1] : memref<?x1300xf64>
            %15 = arith.addf %13, %14 : f64
            %16 = affine.load %arg3[%arg6, %12 + 1] : memref<?x1300xf64>
            %17 = arith.addf %15, %16 : f64
            %18 = affine.load %arg3[%arg6 + 1, %12] : memref<?x1300xf64>
            %19 = arith.addf %17, %18 : f64
            %20 = affine.load %arg3[%arg6 - 1, %12] : memref<?x1300xf64>
            %21 = arith.addf %19, %20 : f64
            %22 = arith.mulf %21, %cst : f64
            affine.store %22, %arg2[%arg6, %12] : memref<?x1300xf64>
          }
          affine.for %arg7 = #map6()[%0] to #map6()[%0] step 2 {
            %2 = affine.load %arg3[%arg6, %arg7] : memref<?x1300xf64>
            %3 = affine.load %arg3[%arg6, %arg7 - 1] : memref<?x1300xf64>
            %4 = arith.addf %2, %3 : f64
            %5 = affine.load %arg3[%arg6, %arg7 + 1] : memref<?x1300xf64>
            %6 = arith.addf %4, %5 : f64
            %7 = affine.load %arg3[%arg6 + 1, %arg7] : memref<?x1300xf64>
            %8 = arith.addf %6, %7 : f64
            %9 = affine.load %arg3[%arg6 - 1, %arg7] : memref<?x1300xf64>
            %10 = arith.addf %8, %9 : f64
            %11 = arith.mulf %10, %cst : f64
            affine.store %11, %arg2[%arg6, %arg7] : memref<?x1300xf64>
            %12 = affine.apply #map4(%arg7)
            %13 = affine.load %arg3[%arg6, %12] : memref<?x1300xf64>
            %14 = affine.load %arg3[%arg6, %12 - 1] : memref<?x1300xf64>
            %15 = arith.addf %13, %14 : f64
            %16 = affine.load %arg3[%arg6, %12 + 1] : memref<?x1300xf64>
            %17 = arith.addf %15, %16 : f64
            %18 = affine.load %arg3[%arg6 + 1, %12] : memref<?x1300xf64>
            %19 = arith.addf %17, %18 : f64
            %20 = affine.load %arg3[%arg6 - 1, %12] : memref<?x1300xf64>
            %21 = arith.addf %19, %20 : f64
            %22 = arith.mulf %21, %cst : f64
            affine.store %22, %arg2[%arg6, %12] : memref<?x1300xf64>
          }
          affine.for %arg7 = #map6()[%0] to #map2()[%0] {
            %2 = affine.load %arg3[%arg6, %arg7] : memref<?x1300xf64>
            %3 = affine.load %arg3[%arg6, %arg7 - 1] : memref<?x1300xf64>
            %4 = arith.addf %2, %3 : f64
            %5 = affine.load %arg3[%arg6, %arg7 + 1] : memref<?x1300xf64>
            %6 = arith.addf %4, %5 : f64
            %7 = affine.load %arg3[%arg6 + 1, %arg7] : memref<?x1300xf64>
            %8 = arith.addf %6, %7 : f64
            %9 = affine.load %arg3[%arg6 - 1, %arg7] : memref<?x1300xf64>
            %10 = arith.addf %8, %9 : f64
            %11 = arith.mulf %10, %cst : f64
            affine.store %11, %arg2[%arg6, %arg7] : memref<?x1300xf64>
          }
        }
      }
    }
    return
  }
}

