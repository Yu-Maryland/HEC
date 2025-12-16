#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 10, s0)>
#map2 = affine_map<()[s0] -> ((s0 floordiv 11) * 11)>
#map3 = affine_map<(d0) -> (d0 + 1)>
#map4 = affine_map<(d0) -> (d0 + 2)>
#map5 = affine_map<(d0) -> (d0 + 3)>
#map6 = affine_map<(d0) -> (d0 + 4)>
#map7 = affine_map<(d0) -> (d0 + 5)>
#map8 = affine_map<(d0) -> (d0 + 6)>
#map9 = affine_map<(d0) -> (d0 + 7)>
#map10 = affine_map<(d0) -> (d0 + 8)>
#map11 = affine_map<(d0) -> (d0 + 9)>
#map12 = affine_map<(d0) -> (d0 + 10)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_covariance(%arg0: i32, %arg1: i32, %arg2: f64, %arg3: memref<?x1200xf64>, %arg4: memref<?x1200xf64>, %arg5: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 0.000000e+00 : f64
    %cst_0 = arith.constant 1.000000e+00 : f64
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg0 : i32 to index
    affine.for %arg6 = 0 to %1 step 10 {
      affine.for %arg7 = #map(%arg6) to min #map1(%arg6)[%1] {
        affine.store %cst, %arg5[%arg7] : memref<?xf64>
        affine.for %arg8 = 0 to #map2()[%0] step 11 {
          %5 = affine.load %arg3[%arg8, %arg7] : memref<?x1200xf64>
          %6 = affine.load %arg5[%arg7] : memref<?xf64>
          %7 = arith.addf %6, %5 : f64
          affine.store %7, %arg5[%arg7] : memref<?xf64>
          %8 = affine.apply #map3(%arg8)
          %9 = affine.load %arg3[%8, %arg7] : memref<?x1200xf64>
          %10 = affine.load %arg5[%arg7] : memref<?xf64>
          %11 = arith.addf %10, %9 : f64
          affine.store %11, %arg5[%arg7] : memref<?xf64>
          %12 = affine.apply #map4(%arg8)
          %13 = affine.load %arg3[%12, %arg7] : memref<?x1200xf64>
          %14 = affine.load %arg5[%arg7] : memref<?xf64>
          %15 = arith.addf %14, %13 : f64
          affine.store %15, %arg5[%arg7] : memref<?xf64>
          %16 = affine.apply #map5(%arg8)
          %17 = affine.load %arg3[%16, %arg7] : memref<?x1200xf64>
          %18 = affine.load %arg5[%arg7] : memref<?xf64>
          %19 = arith.addf %18, %17 : f64
          affine.store %19, %arg5[%arg7] : memref<?xf64>
          %20 = affine.apply #map6(%arg8)
          %21 = affine.load %arg3[%20, %arg7] : memref<?x1200xf64>
          %22 = affine.load %arg5[%arg7] : memref<?xf64>
          %23 = arith.addf %22, %21 : f64
          affine.store %23, %arg5[%arg7] : memref<?xf64>
          %24 = affine.apply #map7(%arg8)
          %25 = affine.load %arg3[%24, %arg7] : memref<?x1200xf64>
          %26 = affine.load %arg5[%arg7] : memref<?xf64>
          %27 = arith.addf %26, %25 : f64
          affine.store %27, %arg5[%arg7] : memref<?xf64>
          %28 = affine.apply #map8(%arg8)
          %29 = affine.load %arg3[%28, %arg7] : memref<?x1200xf64>
          %30 = affine.load %arg5[%arg7] : memref<?xf64>
          %31 = arith.addf %30, %29 : f64
          affine.store %31, %arg5[%arg7] : memref<?xf64>
          %32 = affine.apply #map9(%arg8)
          %33 = affine.load %arg3[%32, %arg7] : memref<?x1200xf64>
          %34 = affine.load %arg5[%arg7] : memref<?xf64>
          %35 = arith.addf %34, %33 : f64
          affine.store %35, %arg5[%arg7] : memref<?xf64>
          %36 = affine.apply #map10(%arg8)
          %37 = affine.load %arg3[%36, %arg7] : memref<?x1200xf64>
          %38 = affine.load %arg5[%arg7] : memref<?xf64>
          %39 = arith.addf %38, %37 : f64
          affine.store %39, %arg5[%arg7] : memref<?xf64>
          %40 = affine.apply #map11(%arg8)
          %41 = affine.load %arg3[%40, %arg7] : memref<?x1200xf64>
          %42 = affine.load %arg5[%arg7] : memref<?xf64>
          %43 = arith.addf %42, %41 : f64
          affine.store %43, %arg5[%arg7] : memref<?xf64>
          %44 = affine.apply #map12(%arg8)
          %45 = affine.load %arg3[%44, %arg7] : memref<?x1200xf64>
          %46 = affine.load %arg5[%arg7] : memref<?xf64>
          %47 = arith.addf %46, %45 : f64
          affine.store %47, %arg5[%arg7] : memref<?xf64>
        }
        affine.for %arg8 = #map2()[%0] to %0 {
          %5 = affine.load %arg3[%arg8, %arg7] : memref<?x1200xf64>
          %6 = affine.load %arg5[%arg7] : memref<?xf64>
          %7 = arith.addf %6, %5 : f64
          affine.store %7, %arg5[%arg7] : memref<?xf64>
        }
        %3 = affine.load %arg5[%arg7] : memref<?xf64>
        %4 = arith.divf %3, %arg2 : f64
        affine.store %4, %arg5[%arg7] : memref<?xf64>
      }
    }
    affine.for %arg6 = 0 to %0 step 10 {
      affine.for %arg7 = 0 to %1 step 10 {
        affine.for %arg8 = #map(%arg6) to min #map1(%arg6)[%0] {
          affine.for %arg9 = #map(%arg7) to min #map1(%arg7)[%1] {
            %3 = affine.load %arg5[%arg9] : memref<?xf64>
            %4 = affine.load %arg3[%arg8, %arg9] : memref<?x1200xf64>
            %5 = arith.subf %4, %3 : f64
            affine.store %5, %arg3[%arg8, %arg9] : memref<?x1200xf64>
          }
        }
      }
    }
    %2 = arith.subf %arg2, %cst_0 : f64
    affine.for %arg6 = 0 to %1 {
      affine.for %arg7 = #map(%arg6) to %1 {
        affine.store %cst, %arg4[%arg6, %arg7] : memref<?x1200xf64>
        affine.for %arg8 = 0 to #map2()[%0] step 11 {
          %5 = affine.load %arg3[%arg8, %arg6] : memref<?x1200xf64>
          %6 = affine.load %arg3[%arg8, %arg7] : memref<?x1200xf64>
          %7 = arith.mulf %5, %6 : f64
          %8 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %9 = arith.addf %8, %7 : f64
          affine.store %9, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %10 = affine.apply #map3(%arg8)
          %11 = affine.load %arg3[%10, %arg6] : memref<?x1200xf64>
          %12 = affine.load %arg3[%10, %arg7] : memref<?x1200xf64>
          %13 = arith.mulf %11, %12 : f64
          %14 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %15 = arith.addf %14, %13 : f64
          affine.store %15, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %16 = affine.apply #map4(%arg8)
          %17 = affine.load %arg3[%16, %arg6] : memref<?x1200xf64>
          %18 = affine.load %arg3[%16, %arg7] : memref<?x1200xf64>
          %19 = arith.mulf %17, %18 : f64
          %20 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %21 = arith.addf %20, %19 : f64
          affine.store %21, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %22 = affine.apply #map5(%arg8)
          %23 = affine.load %arg3[%22, %arg6] : memref<?x1200xf64>
          %24 = affine.load %arg3[%22, %arg7] : memref<?x1200xf64>
          %25 = arith.mulf %23, %24 : f64
          %26 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %27 = arith.addf %26, %25 : f64
          affine.store %27, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %28 = affine.apply #map6(%arg8)
          %29 = affine.load %arg3[%28, %arg6] : memref<?x1200xf64>
          %30 = affine.load %arg3[%28, %arg7] : memref<?x1200xf64>
          %31 = arith.mulf %29, %30 : f64
          %32 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %33 = arith.addf %32, %31 : f64
          affine.store %33, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %34 = affine.apply #map7(%arg8)
          %35 = affine.load %arg3[%34, %arg6] : memref<?x1200xf64>
          %36 = affine.load %arg3[%34, %arg7] : memref<?x1200xf64>
          %37 = arith.mulf %35, %36 : f64
          %38 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %39 = arith.addf %38, %37 : f64
          affine.store %39, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %40 = affine.apply #map8(%arg8)
          %41 = affine.load %arg3[%40, %arg6] : memref<?x1200xf64>
          %42 = affine.load %arg3[%40, %arg7] : memref<?x1200xf64>
          %43 = arith.mulf %41, %42 : f64
          %44 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %45 = arith.addf %44, %43 : f64
          affine.store %45, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %46 = affine.apply #map9(%arg8)
          %47 = affine.load %arg3[%46, %arg6] : memref<?x1200xf64>
          %48 = affine.load %arg3[%46, %arg7] : memref<?x1200xf64>
          %49 = arith.mulf %47, %48 : f64
          %50 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %51 = arith.addf %50, %49 : f64
          affine.store %51, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %52 = affine.apply #map10(%arg8)
          %53 = affine.load %arg3[%52, %arg6] : memref<?x1200xf64>
          %54 = affine.load %arg3[%52, %arg7] : memref<?x1200xf64>
          %55 = arith.mulf %53, %54 : f64
          %56 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %57 = arith.addf %56, %55 : f64
          affine.store %57, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %58 = affine.apply #map11(%arg8)
          %59 = affine.load %arg3[%58, %arg6] : memref<?x1200xf64>
          %60 = affine.load %arg3[%58, %arg7] : memref<?x1200xf64>
          %61 = arith.mulf %59, %60 : f64
          %62 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %63 = arith.addf %62, %61 : f64
          affine.store %63, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %64 = affine.apply #map12(%arg8)
          %65 = affine.load %arg3[%64, %arg6] : memref<?x1200xf64>
          %66 = affine.load %arg3[%64, %arg7] : memref<?x1200xf64>
          %67 = arith.mulf %65, %66 : f64
          %68 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %69 = arith.addf %68, %67 : f64
          affine.store %69, %arg4[%arg6, %arg7] : memref<?x1200xf64>
        }
        affine.for %arg8 = #map2()[%0] to %0 {
          %5 = affine.load %arg3[%arg8, %arg6] : memref<?x1200xf64>
          %6 = affine.load %arg3[%arg8, %arg7] : memref<?x1200xf64>
          %7 = arith.mulf %5, %6 : f64
          %8 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %9 = arith.addf %8, %7 : f64
          affine.store %9, %arg4[%arg6, %arg7] : memref<?x1200xf64>
        }
        %3 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
        %4 = arith.divf %3, %2 : f64
        affine.store %4, %arg4[%arg6, %arg7] : memref<?x1200xf64>
        affine.store %4, %arg4[%arg7, %arg6] : memref<?x1200xf64>
      }
    }
    return
  }
}

