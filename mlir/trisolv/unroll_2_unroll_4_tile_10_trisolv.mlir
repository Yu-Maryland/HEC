#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 10, s0)>
#map2 = affine_map<(d0) -> (((d0 floordiv 4) floordiv 2) * 8)>
#map3 = affine_map<(d0) -> (d0 + 1)>
#map4 = affine_map<(d0) -> (d0 + 2)>
#map5 = affine_map<(d0) -> (d0 + 3)>
#map6 = affine_map<(d0) -> (d0 + 4)>
#map7 = affine_map<(d0) -> ((d0 floordiv 4) * 4)>
#map8 = affine_map<(d0) -> ((d0 floordiv 2) * 2)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_trisolv(%arg0: i32, %arg1: memref<?x2000xf64>, %arg2: memref<?xf64>, %arg3: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg0 : i32 to index
    affine.for %arg4 = 0 to %0 step 10 {
      affine.for %arg5 = #map(%arg4) to min #map1(%arg4)[%0] {
        %1 = affine.load %arg3[%arg5] : memref<?xf64>
        affine.store %1, %arg2[%arg5] : memref<?xf64>
        affine.for %arg6 = 0 to #map2(%arg5) step 8 {
          %5 = affine.load %arg1[%arg5, %arg6] : memref<?x2000xf64>
          %6 = affine.load %arg2[%arg6] : memref<?xf64>
          %7 = arith.mulf %5, %6 : f64
          %8 = affine.load %arg2[%arg5] : memref<?xf64>
          %9 = arith.subf %8, %7 : f64
          affine.store %9, %arg2[%arg5] : memref<?xf64>
          %10 = affine.apply #map3(%arg6)
          %11 = affine.load %arg1[%arg5, %10] : memref<?x2000xf64>
          %12 = affine.load %arg2[%10] : memref<?xf64>
          %13 = arith.mulf %11, %12 : f64
          %14 = affine.load %arg2[%arg5] : memref<?xf64>
          %15 = arith.subf %14, %13 : f64
          affine.store %15, %arg2[%arg5] : memref<?xf64>
          %16 = affine.apply #map4(%arg6)
          %17 = affine.load %arg1[%arg5, %16] : memref<?x2000xf64>
          %18 = affine.load %arg2[%16] : memref<?xf64>
          %19 = arith.mulf %17, %18 : f64
          %20 = affine.load %arg2[%arg5] : memref<?xf64>
          %21 = arith.subf %20, %19 : f64
          affine.store %21, %arg2[%arg5] : memref<?xf64>
          %22 = affine.apply #map5(%arg6)
          %23 = affine.load %arg1[%arg5, %22] : memref<?x2000xf64>
          %24 = affine.load %arg2[%22] : memref<?xf64>
          %25 = arith.mulf %23, %24 : f64
          %26 = affine.load %arg2[%arg5] : memref<?xf64>
          %27 = arith.subf %26, %25 : f64
          affine.store %27, %arg2[%arg5] : memref<?xf64>
          %28 = affine.apply #map6(%arg6)
          %29 = affine.load %arg1[%arg5, %28] : memref<?x2000xf64>
          %30 = affine.load %arg2[%28] : memref<?xf64>
          %31 = arith.mulf %29, %30 : f64
          %32 = affine.load %arg2[%arg5] : memref<?xf64>
          %33 = arith.subf %32, %31 : f64
          affine.store %33, %arg2[%arg5] : memref<?xf64>
          %34 = affine.apply #map3(%28)
          %35 = affine.load %arg1[%arg5, %34] : memref<?x2000xf64>
          %36 = affine.load %arg2[%34] : memref<?xf64>
          %37 = arith.mulf %35, %36 : f64
          %38 = affine.load %arg2[%arg5] : memref<?xf64>
          %39 = arith.subf %38, %37 : f64
          affine.store %39, %arg2[%arg5] : memref<?xf64>
          %40 = affine.apply #map4(%28)
          %41 = affine.load %arg1[%arg5, %40] : memref<?x2000xf64>
          %42 = affine.load %arg2[%40] : memref<?xf64>
          %43 = arith.mulf %41, %42 : f64
          %44 = affine.load %arg2[%arg5] : memref<?xf64>
          %45 = arith.subf %44, %43 : f64
          affine.store %45, %arg2[%arg5] : memref<?xf64>
          %46 = affine.apply #map5(%28)
          %47 = affine.load %arg1[%arg5, %46] : memref<?x2000xf64>
          %48 = affine.load %arg2[%46] : memref<?xf64>
          %49 = arith.mulf %47, %48 : f64
          %50 = affine.load %arg2[%arg5] : memref<?xf64>
          %51 = arith.subf %50, %49 : f64
          affine.store %51, %arg2[%arg5] : memref<?xf64>
        }
        affine.for %arg6 = #map2(%arg5) to #map7(%arg5) step 4 {
          %5 = affine.load %arg1[%arg5, %arg6] : memref<?x2000xf64>
          %6 = affine.load %arg2[%arg6] : memref<?xf64>
          %7 = arith.mulf %5, %6 : f64
          %8 = affine.load %arg2[%arg5] : memref<?xf64>
          %9 = arith.subf %8, %7 : f64
          affine.store %9, %arg2[%arg5] : memref<?xf64>
          %10 = affine.apply #map3(%arg6)
          %11 = affine.load %arg1[%arg5, %10] : memref<?x2000xf64>
          %12 = affine.load %arg2[%10] : memref<?xf64>
          %13 = arith.mulf %11, %12 : f64
          %14 = affine.load %arg2[%arg5] : memref<?xf64>
          %15 = arith.subf %14, %13 : f64
          affine.store %15, %arg2[%arg5] : memref<?xf64>
          %16 = affine.apply #map4(%arg6)
          %17 = affine.load %arg1[%arg5, %16] : memref<?x2000xf64>
          %18 = affine.load %arg2[%16] : memref<?xf64>
          %19 = arith.mulf %17, %18 : f64
          %20 = affine.load %arg2[%arg5] : memref<?xf64>
          %21 = arith.subf %20, %19 : f64
          affine.store %21, %arg2[%arg5] : memref<?xf64>
          %22 = affine.apply #map5(%arg6)
          %23 = affine.load %arg1[%arg5, %22] : memref<?x2000xf64>
          %24 = affine.load %arg2[%22] : memref<?xf64>
          %25 = arith.mulf %23, %24 : f64
          %26 = affine.load %arg2[%arg5] : memref<?xf64>
          %27 = arith.subf %26, %25 : f64
          affine.store %27, %arg2[%arg5] : memref<?xf64>
        }
        affine.for %arg6 = #map7(%arg5) to #map8(%arg5) step 2 {
          %5 = affine.load %arg1[%arg5, %arg6] : memref<?x2000xf64>
          %6 = affine.load %arg2[%arg6] : memref<?xf64>
          %7 = arith.mulf %5, %6 : f64
          %8 = affine.load %arg2[%arg5] : memref<?xf64>
          %9 = arith.subf %8, %7 : f64
          affine.store %9, %arg2[%arg5] : memref<?xf64>
          %10 = affine.apply #map3(%arg6)
          %11 = affine.load %arg1[%arg5, %10] : memref<?x2000xf64>
          %12 = affine.load %arg2[%10] : memref<?xf64>
          %13 = arith.mulf %11, %12 : f64
          %14 = affine.load %arg2[%arg5] : memref<?xf64>
          %15 = arith.subf %14, %13 : f64
          affine.store %15, %arg2[%arg5] : memref<?xf64>
        }
        affine.for %arg6 = #map8(%arg5) to #map(%arg5) {
          %5 = affine.load %arg1[%arg5, %arg6] : memref<?x2000xf64>
          %6 = affine.load %arg2[%arg6] : memref<?xf64>
          %7 = arith.mulf %5, %6 : f64
          %8 = affine.load %arg2[%arg5] : memref<?xf64>
          %9 = arith.subf %8, %7 : f64
          affine.store %9, %arg2[%arg5] : memref<?xf64>
        }
        %2 = affine.load %arg2[%arg5] : memref<?xf64>
        %3 = affine.load %arg1[%arg5, %arg5] : memref<?x2000xf64>
        %4 = arith.divf %2, %3 : f64
        affine.store %4, %arg2[%arg5] : memref<?xf64>
      }
    }
    return
  }
}

