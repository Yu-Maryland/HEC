#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0) -> (((d0 floordiv 2) floordiv 3) * 6)>
#map2 = affine_map<(d0) -> (d0 + 1)>
#map3 = affine_map<(d0) -> (d0 + 2)>
#map4 = affine_map<(d0) -> (d0 + 4)>
#map5 = affine_map<(d0) -> ((d0 floordiv 2) * 2)>
#map6 = affine_map<(d0) -> ((d0 floordiv 2) * 2 + ((d0 mod 2) floordiv 3) * 3)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_lu(%arg0: i32, %arg1: memref<?x2000xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg0 : i32 to index
    affine.for %arg2 = 0 to %0 {
      affine.for %arg3 = 0 to #map(%arg2) {
        affine.for %arg4 = 0 to #map1(%arg3) step 6 {
          %4 = affine.load %arg1[%arg2, %arg4] : memref<?x2000xf64>
          %5 = affine.load %arg1[%arg4, %arg3] : memref<?x2000xf64>
          %6 = arith.mulf %4, %5 : f64
          %7 = affine.load %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %8 = arith.subf %7, %6 : f64
          affine.store %8, %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %9 = affine.apply #map2(%arg4)
          %10 = affine.load %arg1[%arg2, %9] : memref<?x2000xf64>
          %11 = affine.load %arg1[%9, %arg3] : memref<?x2000xf64>
          %12 = arith.mulf %10, %11 : f64
          %13 = affine.load %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %14 = arith.subf %13, %12 : f64
          affine.store %14, %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %15 = affine.apply #map3(%arg4)
          %16 = affine.load %arg1[%arg2, %15] : memref<?x2000xf64>
          %17 = affine.load %arg1[%15, %arg3] : memref<?x2000xf64>
          %18 = arith.mulf %16, %17 : f64
          %19 = affine.load %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %20 = arith.subf %19, %18 : f64
          affine.store %20, %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %21 = affine.apply #map2(%15)
          %22 = affine.load %arg1[%arg2, %21] : memref<?x2000xf64>
          %23 = affine.load %arg1[%21, %arg3] : memref<?x2000xf64>
          %24 = arith.mulf %22, %23 : f64
          %25 = affine.load %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %26 = arith.subf %25, %24 : f64
          affine.store %26, %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %27 = affine.apply #map4(%arg4)
          %28 = affine.load %arg1[%arg2, %27] : memref<?x2000xf64>
          %29 = affine.load %arg1[%27, %arg3] : memref<?x2000xf64>
          %30 = arith.mulf %28, %29 : f64
          %31 = affine.load %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %32 = arith.subf %31, %30 : f64
          affine.store %32, %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %33 = affine.apply #map2(%27)
          %34 = affine.load %arg1[%arg2, %33] : memref<?x2000xf64>
          %35 = affine.load %arg1[%33, %arg3] : memref<?x2000xf64>
          %36 = arith.mulf %34, %35 : f64
          %37 = affine.load %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %38 = arith.subf %37, %36 : f64
          affine.store %38, %arg1[%arg2, %arg3] : memref<?x2000xf64>
        }
        affine.for %arg4 = #map1(%arg3) to #map5(%arg3) step 2 {
          %4 = affine.load %arg1[%arg2, %arg4] : memref<?x2000xf64>
          %5 = affine.load %arg1[%arg4, %arg3] : memref<?x2000xf64>
          %6 = arith.mulf %4, %5 : f64
          %7 = affine.load %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %8 = arith.subf %7, %6 : f64
          affine.store %8, %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %9 = affine.apply #map2(%arg4)
          %10 = affine.load %arg1[%arg2, %9] : memref<?x2000xf64>
          %11 = affine.load %arg1[%9, %arg3] : memref<?x2000xf64>
          %12 = arith.mulf %10, %11 : f64
          %13 = affine.load %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %14 = arith.subf %13, %12 : f64
          affine.store %14, %arg1[%arg2, %arg3] : memref<?x2000xf64>
        }
        affine.for %arg4 = #map5(%arg3) to #map6(%arg3) step 3 {
          %4 = affine.load %arg1[%arg2, %arg4] : memref<?x2000xf64>
          %5 = affine.load %arg1[%arg4, %arg3] : memref<?x2000xf64>
          %6 = arith.mulf %4, %5 : f64
          %7 = affine.load %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %8 = arith.subf %7, %6 : f64
          affine.store %8, %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %9 = affine.apply #map2(%arg4)
          %10 = affine.load %arg1[%arg2, %9] : memref<?x2000xf64>
          %11 = affine.load %arg1[%9, %arg3] : memref<?x2000xf64>
          %12 = arith.mulf %10, %11 : f64
          %13 = affine.load %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %14 = arith.subf %13, %12 : f64
          affine.store %14, %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %15 = affine.apply #map3(%arg4)
          %16 = affine.load %arg1[%arg2, %15] : memref<?x2000xf64>
          %17 = affine.load %arg1[%15, %arg3] : memref<?x2000xf64>
          %18 = arith.mulf %16, %17 : f64
          %19 = affine.load %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %20 = arith.subf %19, %18 : f64
          affine.store %20, %arg1[%arg2, %arg3] : memref<?x2000xf64>
        }
        affine.for %arg4 = #map6(%arg3) to #map(%arg3) {
          %4 = affine.load %arg1[%arg2, %arg4] : memref<?x2000xf64>
          %5 = affine.load %arg1[%arg4, %arg3] : memref<?x2000xf64>
          %6 = arith.mulf %4, %5 : f64
          %7 = affine.load %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %8 = arith.subf %7, %6 : f64
          affine.store %8, %arg1[%arg2, %arg3] : memref<?x2000xf64>
        }
        %1 = affine.load %arg1[%arg3, %arg3] : memref<?x2000xf64>
        %2 = affine.load %arg1[%arg2, %arg3] : memref<?x2000xf64>
        %3 = arith.divf %2, %1 : f64
        affine.store %3, %arg1[%arg2, %arg3] : memref<?x2000xf64>
      }
      affine.for %arg3 = #map(%arg2) to %0 {
        affine.for %arg4 = 0 to #map1(%arg2) step 6 {
          %1 = affine.load %arg1[%arg2, %arg4] : memref<?x2000xf64>
          %2 = affine.load %arg1[%arg4, %arg3] : memref<?x2000xf64>
          %3 = arith.mulf %1, %2 : f64
          %4 = affine.load %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %5 = arith.subf %4, %3 : f64
          affine.store %5, %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %6 = affine.apply #map2(%arg4)
          %7 = affine.load %arg1[%arg2, %6] : memref<?x2000xf64>
          %8 = affine.load %arg1[%6, %arg3] : memref<?x2000xf64>
          %9 = arith.mulf %7, %8 : f64
          %10 = affine.load %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %11 = arith.subf %10, %9 : f64
          affine.store %11, %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %12 = affine.apply #map3(%arg4)
          %13 = affine.load %arg1[%arg2, %12] : memref<?x2000xf64>
          %14 = affine.load %arg1[%12, %arg3] : memref<?x2000xf64>
          %15 = arith.mulf %13, %14 : f64
          %16 = affine.load %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %17 = arith.subf %16, %15 : f64
          affine.store %17, %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %18 = affine.apply #map2(%12)
          %19 = affine.load %arg1[%arg2, %18] : memref<?x2000xf64>
          %20 = affine.load %arg1[%18, %arg3] : memref<?x2000xf64>
          %21 = arith.mulf %19, %20 : f64
          %22 = affine.load %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %23 = arith.subf %22, %21 : f64
          affine.store %23, %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %24 = affine.apply #map4(%arg4)
          %25 = affine.load %arg1[%arg2, %24] : memref<?x2000xf64>
          %26 = affine.load %arg1[%24, %arg3] : memref<?x2000xf64>
          %27 = arith.mulf %25, %26 : f64
          %28 = affine.load %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %29 = arith.subf %28, %27 : f64
          affine.store %29, %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %30 = affine.apply #map2(%24)
          %31 = affine.load %arg1[%arg2, %30] : memref<?x2000xf64>
          %32 = affine.load %arg1[%30, %arg3] : memref<?x2000xf64>
          %33 = arith.mulf %31, %32 : f64
          %34 = affine.load %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %35 = arith.subf %34, %33 : f64
          affine.store %35, %arg1[%arg2, %arg3] : memref<?x2000xf64>
        }
        affine.for %arg4 = #map1(%arg2) to #map5(%arg2) step 2 {
          %1 = affine.load %arg1[%arg2, %arg4] : memref<?x2000xf64>
          %2 = affine.load %arg1[%arg4, %arg3] : memref<?x2000xf64>
          %3 = arith.mulf %1, %2 : f64
          %4 = affine.load %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %5 = arith.subf %4, %3 : f64
          affine.store %5, %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %6 = affine.apply #map2(%arg4)
          %7 = affine.load %arg1[%arg2, %6] : memref<?x2000xf64>
          %8 = affine.load %arg1[%6, %arg3] : memref<?x2000xf64>
          %9 = arith.mulf %7, %8 : f64
          %10 = affine.load %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %11 = arith.subf %10, %9 : f64
          affine.store %11, %arg1[%arg2, %arg3] : memref<?x2000xf64>
        }
        affine.for %arg4 = #map5(%arg2) to #map6(%arg2) step 3 {
          %1 = affine.load %arg1[%arg2, %arg4] : memref<?x2000xf64>
          %2 = affine.load %arg1[%arg4, %arg3] : memref<?x2000xf64>
          %3 = arith.mulf %1, %2 : f64
          %4 = affine.load %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %5 = arith.subf %4, %3 : f64
          affine.store %5, %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %6 = affine.apply #map2(%arg4)
          %7 = affine.load %arg1[%arg2, %6] : memref<?x2000xf64>
          %8 = affine.load %arg1[%6, %arg3] : memref<?x2000xf64>
          %9 = arith.mulf %7, %8 : f64
          %10 = affine.load %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %11 = arith.subf %10, %9 : f64
          affine.store %11, %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %12 = affine.apply #map3(%arg4)
          %13 = affine.load %arg1[%arg2, %12] : memref<?x2000xf64>
          %14 = affine.load %arg1[%12, %arg3] : memref<?x2000xf64>
          %15 = arith.mulf %13, %14 : f64
          %16 = affine.load %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %17 = arith.subf %16, %15 : f64
          affine.store %17, %arg1[%arg2, %arg3] : memref<?x2000xf64>
        }
        affine.for %arg4 = #map6(%arg2) to #map(%arg2) {
          %1 = affine.load %arg1[%arg2, %arg4] : memref<?x2000xf64>
          %2 = affine.load %arg1[%arg4, %arg3] : memref<?x2000xf64>
          %3 = arith.mulf %1, %2 : f64
          %4 = affine.load %arg1[%arg2, %arg3] : memref<?x2000xf64>
          %5 = arith.subf %4, %3 : f64
          affine.store %5, %arg1[%arg2, %arg3] : memref<?x2000xf64>
        }
      }
    }
    return
  }
}

