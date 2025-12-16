#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 40, s0)>
#map2 = affine_map<(d0) -> (((d0 floordiv 3) floordiv 3) * 9)>
#map3 = affine_map<(d0) -> (d0 + 1)>
#map4 = affine_map<(d0) -> (d0 + 2)>
#map5 = affine_map<(d0) -> (d0 + 3)>
#map6 = affine_map<(d0) -> (d0 + 6)>
#map7 = affine_map<(d0) -> ((d0 floordiv 3) * 3)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_lu(%arg0: i32, %arg1: memref<?x2000xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg0 : i32 to index
    affine.for %arg2 = 0 to %0 step 40 {
      affine.for %arg3 = #map(%arg2) to min #map1(%arg2)[%0] {
        affine.for %arg4 = 0 to #map(%arg3) {
          affine.for %arg5 = 0 to #map2(%arg4) step 9 {
            %4 = affine.load %arg1[%arg3, %arg5] : memref<?x2000xf64>
            %5 = affine.load %arg1[%arg5, %arg4] : memref<?x2000xf64>
            %6 = arith.mulf %4, %5 : f64
            %7 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %8 = arith.subf %7, %6 : f64
            affine.store %8, %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %9 = affine.apply #map3(%arg5)
            %10 = affine.load %arg1[%arg3, %9] : memref<?x2000xf64>
            %11 = affine.load %arg1[%9, %arg4] : memref<?x2000xf64>
            %12 = arith.mulf %10, %11 : f64
            %13 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %14 = arith.subf %13, %12 : f64
            affine.store %14, %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %15 = affine.apply #map4(%arg5)
            %16 = affine.load %arg1[%arg3, %15] : memref<?x2000xf64>
            %17 = affine.load %arg1[%15, %arg4] : memref<?x2000xf64>
            %18 = arith.mulf %16, %17 : f64
            %19 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %20 = arith.subf %19, %18 : f64
            affine.store %20, %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %21 = affine.apply #map5(%arg5)
            %22 = affine.load %arg1[%arg3, %21] : memref<?x2000xf64>
            %23 = affine.load %arg1[%21, %arg4] : memref<?x2000xf64>
            %24 = arith.mulf %22, %23 : f64
            %25 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %26 = arith.subf %25, %24 : f64
            affine.store %26, %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %27 = affine.apply #map3(%21)
            %28 = affine.load %arg1[%arg3, %27] : memref<?x2000xf64>
            %29 = affine.load %arg1[%27, %arg4] : memref<?x2000xf64>
            %30 = arith.mulf %28, %29 : f64
            %31 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %32 = arith.subf %31, %30 : f64
            affine.store %32, %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %33 = affine.apply #map4(%21)
            %34 = affine.load %arg1[%arg3, %33] : memref<?x2000xf64>
            %35 = affine.load %arg1[%33, %arg4] : memref<?x2000xf64>
            %36 = arith.mulf %34, %35 : f64
            %37 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %38 = arith.subf %37, %36 : f64
            affine.store %38, %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %39 = affine.apply #map6(%arg5)
            %40 = affine.load %arg1[%arg3, %39] : memref<?x2000xf64>
            %41 = affine.load %arg1[%39, %arg4] : memref<?x2000xf64>
            %42 = arith.mulf %40, %41 : f64
            %43 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %44 = arith.subf %43, %42 : f64
            affine.store %44, %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %45 = affine.apply #map3(%39)
            %46 = affine.load %arg1[%arg3, %45] : memref<?x2000xf64>
            %47 = affine.load %arg1[%45, %arg4] : memref<?x2000xf64>
            %48 = arith.mulf %46, %47 : f64
            %49 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %50 = arith.subf %49, %48 : f64
            affine.store %50, %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %51 = affine.apply #map4(%39)
            %52 = affine.load %arg1[%arg3, %51] : memref<?x2000xf64>
            %53 = affine.load %arg1[%51, %arg4] : memref<?x2000xf64>
            %54 = arith.mulf %52, %53 : f64
            %55 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %56 = arith.subf %55, %54 : f64
            affine.store %56, %arg1[%arg3, %arg4] : memref<?x2000xf64>
          }
          affine.for %arg5 = #map2(%arg4) to #map7(%arg4) step 3 {
            %4 = affine.load %arg1[%arg3, %arg5] : memref<?x2000xf64>
            %5 = affine.load %arg1[%arg5, %arg4] : memref<?x2000xf64>
            %6 = arith.mulf %4, %5 : f64
            %7 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %8 = arith.subf %7, %6 : f64
            affine.store %8, %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %9 = affine.apply #map3(%arg5)
            %10 = affine.load %arg1[%arg3, %9] : memref<?x2000xf64>
            %11 = affine.load %arg1[%9, %arg4] : memref<?x2000xf64>
            %12 = arith.mulf %10, %11 : f64
            %13 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %14 = arith.subf %13, %12 : f64
            affine.store %14, %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %15 = affine.apply #map4(%arg5)
            %16 = affine.load %arg1[%arg3, %15] : memref<?x2000xf64>
            %17 = affine.load %arg1[%15, %arg4] : memref<?x2000xf64>
            %18 = arith.mulf %16, %17 : f64
            %19 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %20 = arith.subf %19, %18 : f64
            affine.store %20, %arg1[%arg3, %arg4] : memref<?x2000xf64>
          }
          affine.for %arg5 = #map7(%arg4) to #map7(%arg4) step 3 {
            %4 = affine.load %arg1[%arg3, %arg5] : memref<?x2000xf64>
            %5 = affine.load %arg1[%arg5, %arg4] : memref<?x2000xf64>
            %6 = arith.mulf %4, %5 : f64
            %7 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %8 = arith.subf %7, %6 : f64
            affine.store %8, %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %9 = affine.apply #map3(%arg5)
            %10 = affine.load %arg1[%arg3, %9] : memref<?x2000xf64>
            %11 = affine.load %arg1[%9, %arg4] : memref<?x2000xf64>
            %12 = arith.mulf %10, %11 : f64
            %13 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %14 = arith.subf %13, %12 : f64
            affine.store %14, %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %15 = affine.apply #map4(%arg5)
            %16 = affine.load %arg1[%arg3, %15] : memref<?x2000xf64>
            %17 = affine.load %arg1[%15, %arg4] : memref<?x2000xf64>
            %18 = arith.mulf %16, %17 : f64
            %19 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %20 = arith.subf %19, %18 : f64
            affine.store %20, %arg1[%arg3, %arg4] : memref<?x2000xf64>
          }
          affine.for %arg5 = #map7(%arg4) to #map(%arg4) {
            %4 = affine.load %arg1[%arg3, %arg5] : memref<?x2000xf64>
            %5 = affine.load %arg1[%arg5, %arg4] : memref<?x2000xf64>
            %6 = arith.mulf %4, %5 : f64
            %7 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %8 = arith.subf %7, %6 : f64
            affine.store %8, %arg1[%arg3, %arg4] : memref<?x2000xf64>
          }
          %1 = affine.load %arg1[%arg4, %arg4] : memref<?x2000xf64>
          %2 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
          %3 = arith.divf %2, %1 : f64
          affine.store %3, %arg1[%arg3, %arg4] : memref<?x2000xf64>
        }
        affine.for %arg4 = #map(%arg3) to %0 {
          affine.for %arg5 = 0 to #map2(%arg3) step 9 {
            %1 = affine.load %arg1[%arg3, %arg5] : memref<?x2000xf64>
            %2 = affine.load %arg1[%arg5, %arg4] : memref<?x2000xf64>
            %3 = arith.mulf %1, %2 : f64
            %4 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %5 = arith.subf %4, %3 : f64
            affine.store %5, %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %6 = affine.apply #map3(%arg5)
            %7 = affine.load %arg1[%arg3, %6] : memref<?x2000xf64>
            %8 = affine.load %arg1[%6, %arg4] : memref<?x2000xf64>
            %9 = arith.mulf %7, %8 : f64
            %10 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %11 = arith.subf %10, %9 : f64
            affine.store %11, %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %12 = affine.apply #map4(%arg5)
            %13 = affine.load %arg1[%arg3, %12] : memref<?x2000xf64>
            %14 = affine.load %arg1[%12, %arg4] : memref<?x2000xf64>
            %15 = arith.mulf %13, %14 : f64
            %16 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %17 = arith.subf %16, %15 : f64
            affine.store %17, %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %18 = affine.apply #map5(%arg5)
            %19 = affine.load %arg1[%arg3, %18] : memref<?x2000xf64>
            %20 = affine.load %arg1[%18, %arg4] : memref<?x2000xf64>
            %21 = arith.mulf %19, %20 : f64
            %22 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %23 = arith.subf %22, %21 : f64
            affine.store %23, %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %24 = affine.apply #map3(%18)
            %25 = affine.load %arg1[%arg3, %24] : memref<?x2000xf64>
            %26 = affine.load %arg1[%24, %arg4] : memref<?x2000xf64>
            %27 = arith.mulf %25, %26 : f64
            %28 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %29 = arith.subf %28, %27 : f64
            affine.store %29, %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %30 = affine.apply #map4(%18)
            %31 = affine.load %arg1[%arg3, %30] : memref<?x2000xf64>
            %32 = affine.load %arg1[%30, %arg4] : memref<?x2000xf64>
            %33 = arith.mulf %31, %32 : f64
            %34 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %35 = arith.subf %34, %33 : f64
            affine.store %35, %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %36 = affine.apply #map6(%arg5)
            %37 = affine.load %arg1[%arg3, %36] : memref<?x2000xf64>
            %38 = affine.load %arg1[%36, %arg4] : memref<?x2000xf64>
            %39 = arith.mulf %37, %38 : f64
            %40 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %41 = arith.subf %40, %39 : f64
            affine.store %41, %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %42 = affine.apply #map3(%36)
            %43 = affine.load %arg1[%arg3, %42] : memref<?x2000xf64>
            %44 = affine.load %arg1[%42, %arg4] : memref<?x2000xf64>
            %45 = arith.mulf %43, %44 : f64
            %46 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %47 = arith.subf %46, %45 : f64
            affine.store %47, %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %48 = affine.apply #map4(%36)
            %49 = affine.load %arg1[%arg3, %48] : memref<?x2000xf64>
            %50 = affine.load %arg1[%48, %arg4] : memref<?x2000xf64>
            %51 = arith.mulf %49, %50 : f64
            %52 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %53 = arith.subf %52, %51 : f64
            affine.store %53, %arg1[%arg3, %arg4] : memref<?x2000xf64>
          }
          affine.for %arg5 = #map2(%arg3) to #map7(%arg3) step 3 {
            %1 = affine.load %arg1[%arg3, %arg5] : memref<?x2000xf64>
            %2 = affine.load %arg1[%arg5, %arg4] : memref<?x2000xf64>
            %3 = arith.mulf %1, %2 : f64
            %4 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %5 = arith.subf %4, %3 : f64
            affine.store %5, %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %6 = affine.apply #map3(%arg5)
            %7 = affine.load %arg1[%arg3, %6] : memref<?x2000xf64>
            %8 = affine.load %arg1[%6, %arg4] : memref<?x2000xf64>
            %9 = arith.mulf %7, %8 : f64
            %10 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %11 = arith.subf %10, %9 : f64
            affine.store %11, %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %12 = affine.apply #map4(%arg5)
            %13 = affine.load %arg1[%arg3, %12] : memref<?x2000xf64>
            %14 = affine.load %arg1[%12, %arg4] : memref<?x2000xf64>
            %15 = arith.mulf %13, %14 : f64
            %16 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %17 = arith.subf %16, %15 : f64
            affine.store %17, %arg1[%arg3, %arg4] : memref<?x2000xf64>
          }
          affine.for %arg5 = #map7(%arg3) to #map7(%arg3) step 3 {
            %1 = affine.load %arg1[%arg3, %arg5] : memref<?x2000xf64>
            %2 = affine.load %arg1[%arg5, %arg4] : memref<?x2000xf64>
            %3 = arith.mulf %1, %2 : f64
            %4 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %5 = arith.subf %4, %3 : f64
            affine.store %5, %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %6 = affine.apply #map3(%arg5)
            %7 = affine.load %arg1[%arg3, %6] : memref<?x2000xf64>
            %8 = affine.load %arg1[%6, %arg4] : memref<?x2000xf64>
            %9 = arith.mulf %7, %8 : f64
            %10 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %11 = arith.subf %10, %9 : f64
            affine.store %11, %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %12 = affine.apply #map4(%arg5)
            %13 = affine.load %arg1[%arg3, %12] : memref<?x2000xf64>
            %14 = affine.load %arg1[%12, %arg4] : memref<?x2000xf64>
            %15 = arith.mulf %13, %14 : f64
            %16 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %17 = arith.subf %16, %15 : f64
            affine.store %17, %arg1[%arg3, %arg4] : memref<?x2000xf64>
          }
          affine.for %arg5 = #map7(%arg3) to #map(%arg3) {
            %1 = affine.load %arg1[%arg3, %arg5] : memref<?x2000xf64>
            %2 = affine.load %arg1[%arg5, %arg4] : memref<?x2000xf64>
            %3 = arith.mulf %1, %2 : f64
            %4 = affine.load %arg1[%arg3, %arg4] : memref<?x2000xf64>
            %5 = arith.subf %4, %3 : f64
            affine.store %5, %arg1[%arg3, %arg4] : memref<?x2000xf64>
          }
        }
      }
    }
    return
  }
}

