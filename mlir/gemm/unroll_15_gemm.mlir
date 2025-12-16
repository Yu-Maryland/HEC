#map = affine_map<()[s0] -> ((s0 floordiv 15) * 15)>
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
#map11 = affine_map<(d0) -> (d0 + 11)>
#map12 = affine_map<(d0) -> (d0 + 12)>
#map13 = affine_map<(d0) -> (d0 + 13)>
#map14 = affine_map<(d0) -> (d0 + 14)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_gemm(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: f64, %arg4: f64, %arg5: memref<?x1100xf64>, %arg6: memref<?x1200xf64>, %arg7: memref<?x1100xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg2 : i32 to index
    %2 = arith.index_cast %arg0 : i32 to index
    affine.for %arg8 = 0 to %2 {
      affine.for %arg9 = 0 to #map()[%0] step 15 {
        %3 = affine.load %arg5[%arg8, %arg9] : memref<?x1100xf64>
        %4 = arith.mulf %3, %arg4 : f64
        affine.store %4, %arg5[%arg8, %arg9] : memref<?x1100xf64>
        %5 = affine.apply #map1(%arg9)
        %6 = affine.load %arg5[%arg8, %5] : memref<?x1100xf64>
        %7 = arith.mulf %6, %arg4 : f64
        affine.store %7, %arg5[%arg8, %5] : memref<?x1100xf64>
        %8 = affine.apply #map2(%arg9)
        %9 = affine.load %arg5[%arg8, %8] : memref<?x1100xf64>
        %10 = arith.mulf %9, %arg4 : f64
        affine.store %10, %arg5[%arg8, %8] : memref<?x1100xf64>
        %11 = affine.apply #map3(%arg9)
        %12 = affine.load %arg5[%arg8, %11] : memref<?x1100xf64>
        %13 = arith.mulf %12, %arg4 : f64
        affine.store %13, %arg5[%arg8, %11] : memref<?x1100xf64>
        %14 = affine.apply #map4(%arg9)
        %15 = affine.load %arg5[%arg8, %14] : memref<?x1100xf64>
        %16 = arith.mulf %15, %arg4 : f64
        affine.store %16, %arg5[%arg8, %14] : memref<?x1100xf64>
        %17 = affine.apply #map5(%arg9)
        %18 = affine.load %arg5[%arg8, %17] : memref<?x1100xf64>
        %19 = arith.mulf %18, %arg4 : f64
        affine.store %19, %arg5[%arg8, %17] : memref<?x1100xf64>
        %20 = affine.apply #map6(%arg9)
        %21 = affine.load %arg5[%arg8, %20] : memref<?x1100xf64>
        %22 = arith.mulf %21, %arg4 : f64
        affine.store %22, %arg5[%arg8, %20] : memref<?x1100xf64>
        %23 = affine.apply #map7(%arg9)
        %24 = affine.load %arg5[%arg8, %23] : memref<?x1100xf64>
        %25 = arith.mulf %24, %arg4 : f64
        affine.store %25, %arg5[%arg8, %23] : memref<?x1100xf64>
        %26 = affine.apply #map8(%arg9)
        %27 = affine.load %arg5[%arg8, %26] : memref<?x1100xf64>
        %28 = arith.mulf %27, %arg4 : f64
        affine.store %28, %arg5[%arg8, %26] : memref<?x1100xf64>
        %29 = affine.apply #map9(%arg9)
        %30 = affine.load %arg5[%arg8, %29] : memref<?x1100xf64>
        %31 = arith.mulf %30, %arg4 : f64
        affine.store %31, %arg5[%arg8, %29] : memref<?x1100xf64>
        %32 = affine.apply #map10(%arg9)
        %33 = affine.load %arg5[%arg8, %32] : memref<?x1100xf64>
        %34 = arith.mulf %33, %arg4 : f64
        affine.store %34, %arg5[%arg8, %32] : memref<?x1100xf64>
        %35 = affine.apply #map11(%arg9)
        %36 = affine.load %arg5[%arg8, %35] : memref<?x1100xf64>
        %37 = arith.mulf %36, %arg4 : f64
        affine.store %37, %arg5[%arg8, %35] : memref<?x1100xf64>
        %38 = affine.apply #map12(%arg9)
        %39 = affine.load %arg5[%arg8, %38] : memref<?x1100xf64>
        %40 = arith.mulf %39, %arg4 : f64
        affine.store %40, %arg5[%arg8, %38] : memref<?x1100xf64>
        %41 = affine.apply #map13(%arg9)
        %42 = affine.load %arg5[%arg8, %41] : memref<?x1100xf64>
        %43 = arith.mulf %42, %arg4 : f64
        affine.store %43, %arg5[%arg8, %41] : memref<?x1100xf64>
        %44 = affine.apply #map14(%arg9)
        %45 = affine.load %arg5[%arg8, %44] : memref<?x1100xf64>
        %46 = arith.mulf %45, %arg4 : f64
        affine.store %46, %arg5[%arg8, %44] : memref<?x1100xf64>
      }
      affine.for %arg9 = #map()[%0] to %0 {
        %3 = affine.load %arg5[%arg8, %arg9] : memref<?x1100xf64>
        %4 = arith.mulf %3, %arg4 : f64
        affine.store %4, %arg5[%arg8, %arg9] : memref<?x1100xf64>
      }
      affine.for %arg9 = 0 to %1 {
        affine.for %arg10 = 0 to #map()[%0] step 15 {
          %3 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %4 = arith.mulf %arg3, %3 : f64
          %5 = affine.load %arg7[%arg9, %arg10] : memref<?x1100xf64>
          %6 = arith.mulf %4, %5 : f64
          %7 = affine.load %arg5[%arg8, %arg10] : memref<?x1100xf64>
          %8 = arith.addf %7, %6 : f64
          affine.store %8, %arg5[%arg8, %arg10] : memref<?x1100xf64>
          %9 = affine.apply #map1(%arg10)
          %10 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %11 = arith.mulf %arg3, %10 : f64
          %12 = affine.load %arg7[%arg9, %9] : memref<?x1100xf64>
          %13 = arith.mulf %11, %12 : f64
          %14 = affine.load %arg5[%arg8, %9] : memref<?x1100xf64>
          %15 = arith.addf %14, %13 : f64
          affine.store %15, %arg5[%arg8, %9] : memref<?x1100xf64>
          %16 = affine.apply #map2(%arg10)
          %17 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %18 = arith.mulf %arg3, %17 : f64
          %19 = affine.load %arg7[%arg9, %16] : memref<?x1100xf64>
          %20 = arith.mulf %18, %19 : f64
          %21 = affine.load %arg5[%arg8, %16] : memref<?x1100xf64>
          %22 = arith.addf %21, %20 : f64
          affine.store %22, %arg5[%arg8, %16] : memref<?x1100xf64>
          %23 = affine.apply #map3(%arg10)
          %24 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %25 = arith.mulf %arg3, %24 : f64
          %26 = affine.load %arg7[%arg9, %23] : memref<?x1100xf64>
          %27 = arith.mulf %25, %26 : f64
          %28 = affine.load %arg5[%arg8, %23] : memref<?x1100xf64>
          %29 = arith.addf %28, %27 : f64
          affine.store %29, %arg5[%arg8, %23] : memref<?x1100xf64>
          %30 = affine.apply #map4(%arg10)
          %31 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %32 = arith.mulf %arg3, %31 : f64
          %33 = affine.load %arg7[%arg9, %30] : memref<?x1100xf64>
          %34 = arith.mulf %32, %33 : f64
          %35 = affine.load %arg5[%arg8, %30] : memref<?x1100xf64>
          %36 = arith.addf %35, %34 : f64
          affine.store %36, %arg5[%arg8, %30] : memref<?x1100xf64>
          %37 = affine.apply #map5(%arg10)
          %38 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %39 = arith.mulf %arg3, %38 : f64
          %40 = affine.load %arg7[%arg9, %37] : memref<?x1100xf64>
          %41 = arith.mulf %39, %40 : f64
          %42 = affine.load %arg5[%arg8, %37] : memref<?x1100xf64>
          %43 = arith.addf %42, %41 : f64
          affine.store %43, %arg5[%arg8, %37] : memref<?x1100xf64>
          %44 = affine.apply #map6(%arg10)
          %45 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %46 = arith.mulf %arg3, %45 : f64
          %47 = affine.load %arg7[%arg9, %44] : memref<?x1100xf64>
          %48 = arith.mulf %46, %47 : f64
          %49 = affine.load %arg5[%arg8, %44] : memref<?x1100xf64>
          %50 = arith.addf %49, %48 : f64
          affine.store %50, %arg5[%arg8, %44] : memref<?x1100xf64>
          %51 = affine.apply #map7(%arg10)
          %52 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %53 = arith.mulf %arg3, %52 : f64
          %54 = affine.load %arg7[%arg9, %51] : memref<?x1100xf64>
          %55 = arith.mulf %53, %54 : f64
          %56 = affine.load %arg5[%arg8, %51] : memref<?x1100xf64>
          %57 = arith.addf %56, %55 : f64
          affine.store %57, %arg5[%arg8, %51] : memref<?x1100xf64>
          %58 = affine.apply #map8(%arg10)
          %59 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %60 = arith.mulf %arg3, %59 : f64
          %61 = affine.load %arg7[%arg9, %58] : memref<?x1100xf64>
          %62 = arith.mulf %60, %61 : f64
          %63 = affine.load %arg5[%arg8, %58] : memref<?x1100xf64>
          %64 = arith.addf %63, %62 : f64
          affine.store %64, %arg5[%arg8, %58] : memref<?x1100xf64>
          %65 = affine.apply #map9(%arg10)
          %66 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %67 = arith.mulf %arg3, %66 : f64
          %68 = affine.load %arg7[%arg9, %65] : memref<?x1100xf64>
          %69 = arith.mulf %67, %68 : f64
          %70 = affine.load %arg5[%arg8, %65] : memref<?x1100xf64>
          %71 = arith.addf %70, %69 : f64
          affine.store %71, %arg5[%arg8, %65] : memref<?x1100xf64>
          %72 = affine.apply #map10(%arg10)
          %73 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %74 = arith.mulf %arg3, %73 : f64
          %75 = affine.load %arg7[%arg9, %72] : memref<?x1100xf64>
          %76 = arith.mulf %74, %75 : f64
          %77 = affine.load %arg5[%arg8, %72] : memref<?x1100xf64>
          %78 = arith.addf %77, %76 : f64
          affine.store %78, %arg5[%arg8, %72] : memref<?x1100xf64>
          %79 = affine.apply #map11(%arg10)
          %80 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %81 = arith.mulf %arg3, %80 : f64
          %82 = affine.load %arg7[%arg9, %79] : memref<?x1100xf64>
          %83 = arith.mulf %81, %82 : f64
          %84 = affine.load %arg5[%arg8, %79] : memref<?x1100xf64>
          %85 = arith.addf %84, %83 : f64
          affine.store %85, %arg5[%arg8, %79] : memref<?x1100xf64>
          %86 = affine.apply #map12(%arg10)
          %87 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %88 = arith.mulf %arg3, %87 : f64
          %89 = affine.load %arg7[%arg9, %86] : memref<?x1100xf64>
          %90 = arith.mulf %88, %89 : f64
          %91 = affine.load %arg5[%arg8, %86] : memref<?x1100xf64>
          %92 = arith.addf %91, %90 : f64
          affine.store %92, %arg5[%arg8, %86] : memref<?x1100xf64>
          %93 = affine.apply #map13(%arg10)
          %94 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %95 = arith.mulf %arg3, %94 : f64
          %96 = affine.load %arg7[%arg9, %93] : memref<?x1100xf64>
          %97 = arith.mulf %95, %96 : f64
          %98 = affine.load %arg5[%arg8, %93] : memref<?x1100xf64>
          %99 = arith.addf %98, %97 : f64
          affine.store %99, %arg5[%arg8, %93] : memref<?x1100xf64>
          %100 = affine.apply #map14(%arg10)
          %101 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %102 = arith.mulf %arg3, %101 : f64
          %103 = affine.load %arg7[%arg9, %100] : memref<?x1100xf64>
          %104 = arith.mulf %102, %103 : f64
          %105 = affine.load %arg5[%arg8, %100] : memref<?x1100xf64>
          %106 = arith.addf %105, %104 : f64
          affine.store %106, %arg5[%arg8, %100] : memref<?x1100xf64>
        }
        affine.for %arg10 = #map()[%0] to %0 {
          %3 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %4 = arith.mulf %arg3, %3 : f64
          %5 = affine.load %arg7[%arg9, %arg10] : memref<?x1100xf64>
          %6 = arith.mulf %4, %5 : f64
          %7 = affine.load %arg5[%arg8, %arg10] : memref<?x1100xf64>
          %8 = arith.addf %7, %6 : f64
          affine.store %8, %arg5[%arg8, %arg10] : memref<?x1100xf64>
        }
      }
    }
    return
  }
}

