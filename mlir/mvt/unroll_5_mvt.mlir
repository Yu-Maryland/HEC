#map = affine_map<()[s0] -> ((s0 floordiv 5) * 5)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0 + 3)>
#map4 = affine_map<(d0) -> (d0 + 4)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>, #dlti.dl_entry<"dlti.endianness", "little">>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_mvt(%arg0: i32, %arg1: memref<?xf64>, %arg2: memref<?xf64>, %arg3: memref<?xf64>, %arg4: memref<?xf64>, %arg5: memref<?x2000xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg0 : i32 to index
    affine.for %arg6 = 0 to %0 {
      affine.for %arg7 = 0 to #map()[%0] step 5 {
        %1 = affine.load %arg1[%arg6] : memref<?xf64>
        %2 = affine.load %arg5[%arg6, %arg7] : memref<?x2000xf64>
        %3 = affine.load %arg3[%arg7] : memref<?xf64>
        %4 = arith.mulf %2, %3 : f64
        %5 = arith.addf %1, %4 : f64
        affine.store %5, %arg1[%arg6] : memref<?xf64>
        %6 = affine.apply #map1(%arg7)
        %7 = affine.load %arg1[%arg6] : memref<?xf64>
        %8 = affine.load %arg5[%arg6, %6] : memref<?x2000xf64>
        %9 = affine.load %arg3[%6] : memref<?xf64>
        %10 = arith.mulf %8, %9 : f64
        %11 = arith.addf %7, %10 : f64
        affine.store %11, %arg1[%arg6] : memref<?xf64>
        %12 = affine.apply #map2(%arg7)
        %13 = affine.load %arg1[%arg6] : memref<?xf64>
        %14 = affine.load %arg5[%arg6, %12] : memref<?x2000xf64>
        %15 = affine.load %arg3[%12] : memref<?xf64>
        %16 = arith.mulf %14, %15 : f64
        %17 = arith.addf %13, %16 : f64
        affine.store %17, %arg1[%arg6] : memref<?xf64>
        %18 = affine.apply #map3(%arg7)
        %19 = affine.load %arg1[%arg6] : memref<?xf64>
        %20 = affine.load %arg5[%arg6, %18] : memref<?x2000xf64>
        %21 = affine.load %arg3[%18] : memref<?xf64>
        %22 = arith.mulf %20, %21 : f64
        %23 = arith.addf %19, %22 : f64
        affine.store %23, %arg1[%arg6] : memref<?xf64>
        %24 = affine.apply #map4(%arg7)
        %25 = affine.load %arg1[%arg6] : memref<?xf64>
        %26 = affine.load %arg5[%arg6, %24] : memref<?x2000xf64>
        %27 = affine.load %arg3[%24] : memref<?xf64>
        %28 = arith.mulf %26, %27 : f64
        %29 = arith.addf %25, %28 : f64
        affine.store %29, %arg1[%arg6] : memref<?xf64>
      }
      affine.for %arg7 = #map()[%0] to %0 {
        %1 = affine.load %arg1[%arg6] : memref<?xf64>
        %2 = affine.load %arg5[%arg6, %arg7] : memref<?x2000xf64>
        %3 = affine.load %arg3[%arg7] : memref<?xf64>
        %4 = arith.mulf %2, %3 : f64
        %5 = arith.addf %1, %4 : f64
        affine.store %5, %arg1[%arg6] : memref<?xf64>
      }
    }
    affine.for %arg6 = 0 to %0 {
      affine.for %arg7 = 0 to #map()[%0] step 5 {
        %1 = affine.load %arg2[%arg6] : memref<?xf64>
        %2 = affine.load %arg5[%arg7, %arg6] : memref<?x2000xf64>
        %3 = affine.load %arg4[%arg7] : memref<?xf64>
        %4 = arith.mulf %2, %3 : f64
        %5 = arith.addf %1, %4 : f64
        affine.store %5, %arg2[%arg6] : memref<?xf64>
        %6 = affine.apply #map1(%arg7)
        %7 = affine.load %arg2[%arg6] : memref<?xf64>
        %8 = affine.load %arg5[%6, %arg6] : memref<?x2000xf64>
        %9 = affine.load %arg4[%6] : memref<?xf64>
        %10 = arith.mulf %8, %9 : f64
        %11 = arith.addf %7, %10 : f64
        affine.store %11, %arg2[%arg6] : memref<?xf64>
        %12 = affine.apply #map2(%arg7)
        %13 = affine.load %arg2[%arg6] : memref<?xf64>
        %14 = affine.load %arg5[%12, %arg6] : memref<?x2000xf64>
        %15 = affine.load %arg4[%12] : memref<?xf64>
        %16 = arith.mulf %14, %15 : f64
        %17 = arith.addf %13, %16 : f64
        affine.store %17, %arg2[%arg6] : memref<?xf64>
        %18 = affine.apply #map3(%arg7)
        %19 = affine.load %arg2[%arg6] : memref<?xf64>
        %20 = affine.load %arg5[%18, %arg6] : memref<?x2000xf64>
        %21 = affine.load %arg4[%18] : memref<?xf64>
        %22 = arith.mulf %20, %21 : f64
        %23 = arith.addf %19, %22 : f64
        affine.store %23, %arg2[%arg6] : memref<?xf64>
        %24 = affine.apply #map4(%arg7)
        %25 = affine.load %arg2[%arg6] : memref<?xf64>
        %26 = affine.load %arg5[%24, %arg6] : memref<?x2000xf64>
        %27 = affine.load %arg4[%24] : memref<?xf64>
        %28 = arith.mulf %26, %27 : f64
        %29 = arith.addf %25, %28 : f64
        affine.store %29, %arg2[%arg6] : memref<?xf64>
      }
      affine.for %arg7 = #map()[%0] to %0 {
        %1 = affine.load %arg2[%arg6] : memref<?xf64>
        %2 = affine.load %arg5[%arg7, %arg6] : memref<?x2000xf64>
        %3 = affine.load %arg4[%arg7] : memref<?xf64>
        %4 = arith.mulf %2, %3 : f64
        %5 = arith.addf %1, %4 : f64
        affine.store %5, %arg2[%arg6] : memref<?xf64>
      }
    }
    return
  }
}

