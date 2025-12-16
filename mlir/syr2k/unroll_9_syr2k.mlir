#map = affine_map<(d0) -> (((d0 + 1) floordiv 9) * 9)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0 + 3)>
#map4 = affine_map<(d0) -> (d0 + 4)>
#map5 = affine_map<(d0) -> (d0 + 5)>
#map6 = affine_map<(d0) -> (d0 + 6)>
#map7 = affine_map<(d0) -> (d0 + 7)>
#map8 = affine_map<(d0) -> (d0 + 8)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_syr2k(%arg0: i32, %arg1: i32, %arg2: f64, %arg3: f64, %arg4: memref<?x1200xf64>, %arg5: memref<?x1000xf64>, %arg6: memref<?x1000xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg0 : i32 to index
    affine.for %arg7 = 0 to %1 {
      affine.for %arg8 = 0 to #map(%arg7) step 9 {
        %2 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
        %3 = arith.mulf %2, %arg3 : f64
        affine.store %3, %arg4[%arg7, %arg8] : memref<?x1200xf64>
        %4 = affine.apply #map1(%arg8)
        %5 = affine.load %arg4[%arg7, %4] : memref<?x1200xf64>
        %6 = arith.mulf %5, %arg3 : f64
        affine.store %6, %arg4[%arg7, %4] : memref<?x1200xf64>
        %7 = affine.apply #map2(%arg8)
        %8 = affine.load %arg4[%arg7, %7] : memref<?x1200xf64>
        %9 = arith.mulf %8, %arg3 : f64
        affine.store %9, %arg4[%arg7, %7] : memref<?x1200xf64>
        %10 = affine.apply #map3(%arg8)
        %11 = affine.load %arg4[%arg7, %10] : memref<?x1200xf64>
        %12 = arith.mulf %11, %arg3 : f64
        affine.store %12, %arg4[%arg7, %10] : memref<?x1200xf64>
        %13 = affine.apply #map4(%arg8)
        %14 = affine.load %arg4[%arg7, %13] : memref<?x1200xf64>
        %15 = arith.mulf %14, %arg3 : f64
        affine.store %15, %arg4[%arg7, %13] : memref<?x1200xf64>
        %16 = affine.apply #map5(%arg8)
        %17 = affine.load %arg4[%arg7, %16] : memref<?x1200xf64>
        %18 = arith.mulf %17, %arg3 : f64
        affine.store %18, %arg4[%arg7, %16] : memref<?x1200xf64>
        %19 = affine.apply #map6(%arg8)
        %20 = affine.load %arg4[%arg7, %19] : memref<?x1200xf64>
        %21 = arith.mulf %20, %arg3 : f64
        affine.store %21, %arg4[%arg7, %19] : memref<?x1200xf64>
        %22 = affine.apply #map7(%arg8)
        %23 = affine.load %arg4[%arg7, %22] : memref<?x1200xf64>
        %24 = arith.mulf %23, %arg3 : f64
        affine.store %24, %arg4[%arg7, %22] : memref<?x1200xf64>
        %25 = affine.apply #map8(%arg8)
        %26 = affine.load %arg4[%arg7, %25] : memref<?x1200xf64>
        %27 = arith.mulf %26, %arg3 : f64
        affine.store %27, %arg4[%arg7, %25] : memref<?x1200xf64>
      }
      affine.for %arg8 = #map(%arg7) to #map1(%arg7) {
        %2 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
        %3 = arith.mulf %2, %arg3 : f64
        affine.store %3, %arg4[%arg7, %arg8] : memref<?x1200xf64>
      }
      affine.for %arg8 = 0 to %0 {
        affine.for %arg9 = 0 to #map(%arg7) step 9 {
          %2 = affine.load %arg5[%arg9, %arg8] : memref<?x1000xf64>
          %3 = arith.mulf %2, %arg2 : f64
          %4 = affine.load %arg6[%arg7, %arg8] : memref<?x1000xf64>
          %5 = arith.mulf %3, %4 : f64
          %6 = affine.load %arg6[%arg9, %arg8] : memref<?x1000xf64>
          %7 = arith.mulf %6, %arg2 : f64
          %8 = affine.load %arg5[%arg7, %arg8] : memref<?x1000xf64>
          %9 = arith.mulf %7, %8 : f64
          %10 = arith.addf %5, %9 : f64
          %11 = affine.load %arg4[%arg7, %arg9] : memref<?x1200xf64>
          %12 = arith.addf %11, %10 : f64
          affine.store %12, %arg4[%arg7, %arg9] : memref<?x1200xf64>
          %13 = affine.apply #map1(%arg9)
          %14 = affine.load %arg5[%13, %arg8] : memref<?x1000xf64>
          %15 = arith.mulf %14, %arg2 : f64
          %16 = affine.load %arg6[%arg7, %arg8] : memref<?x1000xf64>
          %17 = arith.mulf %15, %16 : f64
          %18 = affine.load %arg6[%13, %arg8] : memref<?x1000xf64>
          %19 = arith.mulf %18, %arg2 : f64
          %20 = affine.load %arg5[%arg7, %arg8] : memref<?x1000xf64>
          %21 = arith.mulf %19, %20 : f64
          %22 = arith.addf %17, %21 : f64
          %23 = affine.load %arg4[%arg7, %13] : memref<?x1200xf64>
          %24 = arith.addf %23, %22 : f64
          affine.store %24, %arg4[%arg7, %13] : memref<?x1200xf64>
          %25 = affine.apply #map2(%arg9)
          %26 = affine.load %arg5[%25, %arg8] : memref<?x1000xf64>
          %27 = arith.mulf %26, %arg2 : f64
          %28 = affine.load %arg6[%arg7, %arg8] : memref<?x1000xf64>
          %29 = arith.mulf %27, %28 : f64
          %30 = affine.load %arg6[%25, %arg8] : memref<?x1000xf64>
          %31 = arith.mulf %30, %arg2 : f64
          %32 = affine.load %arg5[%arg7, %arg8] : memref<?x1000xf64>
          %33 = arith.mulf %31, %32 : f64
          %34 = arith.addf %29, %33 : f64
          %35 = affine.load %arg4[%arg7, %25] : memref<?x1200xf64>
          %36 = arith.addf %35, %34 : f64
          affine.store %36, %arg4[%arg7, %25] : memref<?x1200xf64>
          %37 = affine.apply #map3(%arg9)
          %38 = affine.load %arg5[%37, %arg8] : memref<?x1000xf64>
          %39 = arith.mulf %38, %arg2 : f64
          %40 = affine.load %arg6[%arg7, %arg8] : memref<?x1000xf64>
          %41 = arith.mulf %39, %40 : f64
          %42 = affine.load %arg6[%37, %arg8] : memref<?x1000xf64>
          %43 = arith.mulf %42, %arg2 : f64
          %44 = affine.load %arg5[%arg7, %arg8] : memref<?x1000xf64>
          %45 = arith.mulf %43, %44 : f64
          %46 = arith.addf %41, %45 : f64
          %47 = affine.load %arg4[%arg7, %37] : memref<?x1200xf64>
          %48 = arith.addf %47, %46 : f64
          affine.store %48, %arg4[%arg7, %37] : memref<?x1200xf64>
          %49 = affine.apply #map4(%arg9)
          %50 = affine.load %arg5[%49, %arg8] : memref<?x1000xf64>
          %51 = arith.mulf %50, %arg2 : f64
          %52 = affine.load %arg6[%arg7, %arg8] : memref<?x1000xf64>
          %53 = arith.mulf %51, %52 : f64
          %54 = affine.load %arg6[%49, %arg8] : memref<?x1000xf64>
          %55 = arith.mulf %54, %arg2 : f64
          %56 = affine.load %arg5[%arg7, %arg8] : memref<?x1000xf64>
          %57 = arith.mulf %55, %56 : f64
          %58 = arith.addf %53, %57 : f64
          %59 = affine.load %arg4[%arg7, %49] : memref<?x1200xf64>
          %60 = arith.addf %59, %58 : f64
          affine.store %60, %arg4[%arg7, %49] : memref<?x1200xf64>
          %61 = affine.apply #map5(%arg9)
          %62 = affine.load %arg5[%61, %arg8] : memref<?x1000xf64>
          %63 = arith.mulf %62, %arg2 : f64
          %64 = affine.load %arg6[%arg7, %arg8] : memref<?x1000xf64>
          %65 = arith.mulf %63, %64 : f64
          %66 = affine.load %arg6[%61, %arg8] : memref<?x1000xf64>
          %67 = arith.mulf %66, %arg2 : f64
          %68 = affine.load %arg5[%arg7, %arg8] : memref<?x1000xf64>
          %69 = arith.mulf %67, %68 : f64
          %70 = arith.addf %65, %69 : f64
          %71 = affine.load %arg4[%arg7, %61] : memref<?x1200xf64>
          %72 = arith.addf %71, %70 : f64
          affine.store %72, %arg4[%arg7, %61] : memref<?x1200xf64>
          %73 = affine.apply #map6(%arg9)
          %74 = affine.load %arg5[%73, %arg8] : memref<?x1000xf64>
          %75 = arith.mulf %74, %arg2 : f64
          %76 = affine.load %arg6[%arg7, %arg8] : memref<?x1000xf64>
          %77 = arith.mulf %75, %76 : f64
          %78 = affine.load %arg6[%73, %arg8] : memref<?x1000xf64>
          %79 = arith.mulf %78, %arg2 : f64
          %80 = affine.load %arg5[%arg7, %arg8] : memref<?x1000xf64>
          %81 = arith.mulf %79, %80 : f64
          %82 = arith.addf %77, %81 : f64
          %83 = affine.load %arg4[%arg7, %73] : memref<?x1200xf64>
          %84 = arith.addf %83, %82 : f64
          affine.store %84, %arg4[%arg7, %73] : memref<?x1200xf64>
          %85 = affine.apply #map7(%arg9)
          %86 = affine.load %arg5[%85, %arg8] : memref<?x1000xf64>
          %87 = arith.mulf %86, %arg2 : f64
          %88 = affine.load %arg6[%arg7, %arg8] : memref<?x1000xf64>
          %89 = arith.mulf %87, %88 : f64
          %90 = affine.load %arg6[%85, %arg8] : memref<?x1000xf64>
          %91 = arith.mulf %90, %arg2 : f64
          %92 = affine.load %arg5[%arg7, %arg8] : memref<?x1000xf64>
          %93 = arith.mulf %91, %92 : f64
          %94 = arith.addf %89, %93 : f64
          %95 = affine.load %arg4[%arg7, %85] : memref<?x1200xf64>
          %96 = arith.addf %95, %94 : f64
          affine.store %96, %arg4[%arg7, %85] : memref<?x1200xf64>
          %97 = affine.apply #map8(%arg9)
          %98 = affine.load %arg5[%97, %arg8] : memref<?x1000xf64>
          %99 = arith.mulf %98, %arg2 : f64
          %100 = affine.load %arg6[%arg7, %arg8] : memref<?x1000xf64>
          %101 = arith.mulf %99, %100 : f64
          %102 = affine.load %arg6[%97, %arg8] : memref<?x1000xf64>
          %103 = arith.mulf %102, %arg2 : f64
          %104 = affine.load %arg5[%arg7, %arg8] : memref<?x1000xf64>
          %105 = arith.mulf %103, %104 : f64
          %106 = arith.addf %101, %105 : f64
          %107 = affine.load %arg4[%arg7, %97] : memref<?x1200xf64>
          %108 = arith.addf %107, %106 : f64
          affine.store %108, %arg4[%arg7, %97] : memref<?x1200xf64>
        }
        affine.for %arg9 = #map(%arg7) to #map1(%arg7) {
          %2 = affine.load %arg5[%arg9, %arg8] : memref<?x1000xf64>
          %3 = arith.mulf %2, %arg2 : f64
          %4 = affine.load %arg6[%arg7, %arg8] : memref<?x1000xf64>
          %5 = arith.mulf %3, %4 : f64
          %6 = affine.load %arg6[%arg9, %arg8] : memref<?x1000xf64>
          %7 = arith.mulf %6, %arg2 : f64
          %8 = affine.load %arg5[%arg7, %arg8] : memref<?x1000xf64>
          %9 = arith.mulf %7, %8 : f64
          %10 = arith.addf %5, %9 : f64
          %11 = affine.load %arg4[%arg7, %arg9] : memref<?x1200xf64>
          %12 = arith.addf %11, %10 : f64
          affine.store %12, %arg4[%arg7, %arg9] : memref<?x1200xf64>
        }
      }
    }
    return
  }
}

