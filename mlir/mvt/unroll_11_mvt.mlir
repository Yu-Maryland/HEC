#map = affine_map<()[s0] -> ((s0 floordiv 11) * 11)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0 + 3)>
#map4 = affine_map<(d0) -> (d0 + 4)>
#map5 = affine_map<(d0) -> (d0 + 5)>
#map6 = affine_map<(d0) -> (d0 + 6)>
#map7 = affine_map<(d0) -> (d0 + 7)>
#map8 = affine_map<(d0) -> (d0 + 8)>
#map9 = affine_map<(d0) -> (d0 + 9)>
#map10 = affine_map<(d0) -> (d0 + 10)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>, #dlti.dl_entry<"dlti.endianness", "little">>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_mvt(%arg0: i32, %arg1: memref<?xf64>, %arg2: memref<?xf64>, %arg3: memref<?xf64>, %arg4: memref<?xf64>, %arg5: memref<?x2000xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg0 : i32 to index
    affine.for %arg6 = 0 to %0 {
      affine.for %arg7 = 0 to #map()[%0] step 11 {
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
        %30 = affine.apply #map5(%arg7)
        %31 = affine.load %arg1[%arg6] : memref<?xf64>
        %32 = affine.load %arg5[%arg6, %30] : memref<?x2000xf64>
        %33 = affine.load %arg3[%30] : memref<?xf64>
        %34 = arith.mulf %32, %33 : f64
        %35 = arith.addf %31, %34 : f64
        affine.store %35, %arg1[%arg6] : memref<?xf64>
        %36 = affine.apply #map6(%arg7)
        %37 = affine.load %arg1[%arg6] : memref<?xf64>
        %38 = affine.load %arg5[%arg6, %36] : memref<?x2000xf64>
        %39 = affine.load %arg3[%36] : memref<?xf64>
        %40 = arith.mulf %38, %39 : f64
        %41 = arith.addf %37, %40 : f64
        affine.store %41, %arg1[%arg6] : memref<?xf64>
        %42 = affine.apply #map7(%arg7)
        %43 = affine.load %arg1[%arg6] : memref<?xf64>
        %44 = affine.load %arg5[%arg6, %42] : memref<?x2000xf64>
        %45 = affine.load %arg3[%42] : memref<?xf64>
        %46 = arith.mulf %44, %45 : f64
        %47 = arith.addf %43, %46 : f64
        affine.store %47, %arg1[%arg6] : memref<?xf64>
        %48 = affine.apply #map8(%arg7)
        %49 = affine.load %arg1[%arg6] : memref<?xf64>
        %50 = affine.load %arg5[%arg6, %48] : memref<?x2000xf64>
        %51 = affine.load %arg3[%48] : memref<?xf64>
        %52 = arith.mulf %50, %51 : f64
        %53 = arith.addf %49, %52 : f64
        affine.store %53, %arg1[%arg6] : memref<?xf64>
        %54 = affine.apply #map9(%arg7)
        %55 = affine.load %arg1[%arg6] : memref<?xf64>
        %56 = affine.load %arg5[%arg6, %54] : memref<?x2000xf64>
        %57 = affine.load %arg3[%54] : memref<?xf64>
        %58 = arith.mulf %56, %57 : f64
        %59 = arith.addf %55, %58 : f64
        affine.store %59, %arg1[%arg6] : memref<?xf64>
        %60 = affine.apply #map10(%arg7)
        %61 = affine.load %arg1[%arg6] : memref<?xf64>
        %62 = affine.load %arg5[%arg6, %60] : memref<?x2000xf64>
        %63 = affine.load %arg3[%60] : memref<?xf64>
        %64 = arith.mulf %62, %63 : f64
        %65 = arith.addf %61, %64 : f64
        affine.store %65, %arg1[%arg6] : memref<?xf64>
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
      affine.for %arg7 = 0 to #map()[%0] step 11 {
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
        %30 = affine.apply #map5(%arg7)
        %31 = affine.load %arg2[%arg6] : memref<?xf64>
        %32 = affine.load %arg5[%30, %arg6] : memref<?x2000xf64>
        %33 = affine.load %arg4[%30] : memref<?xf64>
        %34 = arith.mulf %32, %33 : f64
        %35 = arith.addf %31, %34 : f64
        affine.store %35, %arg2[%arg6] : memref<?xf64>
        %36 = affine.apply #map6(%arg7)
        %37 = affine.load %arg2[%arg6] : memref<?xf64>
        %38 = affine.load %arg5[%36, %arg6] : memref<?x2000xf64>
        %39 = affine.load %arg4[%36] : memref<?xf64>
        %40 = arith.mulf %38, %39 : f64
        %41 = arith.addf %37, %40 : f64
        affine.store %41, %arg2[%arg6] : memref<?xf64>
        %42 = affine.apply #map7(%arg7)
        %43 = affine.load %arg2[%arg6] : memref<?xf64>
        %44 = affine.load %arg5[%42, %arg6] : memref<?x2000xf64>
        %45 = affine.load %arg4[%42] : memref<?xf64>
        %46 = arith.mulf %44, %45 : f64
        %47 = arith.addf %43, %46 : f64
        affine.store %47, %arg2[%arg6] : memref<?xf64>
        %48 = affine.apply #map8(%arg7)
        %49 = affine.load %arg2[%arg6] : memref<?xf64>
        %50 = affine.load %arg5[%48, %arg6] : memref<?x2000xf64>
        %51 = affine.load %arg4[%48] : memref<?xf64>
        %52 = arith.mulf %50, %51 : f64
        %53 = arith.addf %49, %52 : f64
        affine.store %53, %arg2[%arg6] : memref<?xf64>
        %54 = affine.apply #map9(%arg7)
        %55 = affine.load %arg2[%arg6] : memref<?xf64>
        %56 = affine.load %arg5[%54, %arg6] : memref<?x2000xf64>
        %57 = affine.load %arg4[%54] : memref<?xf64>
        %58 = arith.mulf %56, %57 : f64
        %59 = arith.addf %55, %58 : f64
        affine.store %59, %arg2[%arg6] : memref<?xf64>
        %60 = affine.apply #map10(%arg7)
        %61 = affine.load %arg2[%arg6] : memref<?xf64>
        %62 = affine.load %arg5[%60, %arg6] : memref<?x2000xf64>
        %63 = affine.load %arg4[%60] : memref<?xf64>
        %64 = arith.mulf %62, %63 : f64
        %65 = arith.addf %61, %64 : f64
        affine.store %65, %arg2[%arg6] : memref<?xf64>
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

