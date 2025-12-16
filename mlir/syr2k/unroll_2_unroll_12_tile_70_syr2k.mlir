#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 70, s0)>
#map2 = affine_map<(d0) -> ((((d0 + 1) floordiv 12) floordiv 2) * 24)>
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
#map13 = affine_map<(d0) -> (d0 + 11)>
#map14 = affine_map<(d0) -> (d0 + 12)>
#map15 = affine_map<(d0) -> (((d0 + 1) floordiv 12) * 12)>
#map16 = affine_map<(d0) -> (((d0 + 1) floordiv 12) * 12 + ((d0 - ((d0 + 1) floordiv 12) * 12 + 1) floordiv 2) * 2)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_syr2k(%arg0: i32, %arg1: i32, %arg2: f64, %arg3: f64, %arg4: memref<?x1200xf64>, %arg5: memref<?x1000xf64>, %arg6: memref<?x1000xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg0 : i32 to index
    affine.for %arg7 = 0 to %1 step 70 {
      affine.for %arg8 = #map(%arg7) to min #map1(%arg7)[%1] {
        affine.for %arg9 = 0 to #map2(%arg8) step 24 {
          %2 = affine.load %arg4[%arg8, %arg9] : memref<?x1200xf64>
          %3 = arith.mulf %2, %arg3 : f64
          affine.store %3, %arg4[%arg8, %arg9] : memref<?x1200xf64>
          %4 = affine.apply #map3(%arg9)
          %5 = affine.load %arg4[%arg8, %4] : memref<?x1200xf64>
          %6 = arith.mulf %5, %arg3 : f64
          affine.store %6, %arg4[%arg8, %4] : memref<?x1200xf64>
          %7 = affine.apply #map4(%arg9)
          %8 = affine.load %arg4[%arg8, %7] : memref<?x1200xf64>
          %9 = arith.mulf %8, %arg3 : f64
          affine.store %9, %arg4[%arg8, %7] : memref<?x1200xf64>
          %10 = affine.apply #map5(%arg9)
          %11 = affine.load %arg4[%arg8, %10] : memref<?x1200xf64>
          %12 = arith.mulf %11, %arg3 : f64
          affine.store %12, %arg4[%arg8, %10] : memref<?x1200xf64>
          %13 = affine.apply #map6(%arg9)
          %14 = affine.load %arg4[%arg8, %13] : memref<?x1200xf64>
          %15 = arith.mulf %14, %arg3 : f64
          affine.store %15, %arg4[%arg8, %13] : memref<?x1200xf64>
          %16 = affine.apply #map7(%arg9)
          %17 = affine.load %arg4[%arg8, %16] : memref<?x1200xf64>
          %18 = arith.mulf %17, %arg3 : f64
          affine.store %18, %arg4[%arg8, %16] : memref<?x1200xf64>
          %19 = affine.apply #map8(%arg9)
          %20 = affine.load %arg4[%arg8, %19] : memref<?x1200xf64>
          %21 = arith.mulf %20, %arg3 : f64
          affine.store %21, %arg4[%arg8, %19] : memref<?x1200xf64>
          %22 = affine.apply #map9(%arg9)
          %23 = affine.load %arg4[%arg8, %22] : memref<?x1200xf64>
          %24 = arith.mulf %23, %arg3 : f64
          affine.store %24, %arg4[%arg8, %22] : memref<?x1200xf64>
          %25 = affine.apply #map10(%arg9)
          %26 = affine.load %arg4[%arg8, %25] : memref<?x1200xf64>
          %27 = arith.mulf %26, %arg3 : f64
          affine.store %27, %arg4[%arg8, %25] : memref<?x1200xf64>
          %28 = affine.apply #map11(%arg9)
          %29 = affine.load %arg4[%arg8, %28] : memref<?x1200xf64>
          %30 = arith.mulf %29, %arg3 : f64
          affine.store %30, %arg4[%arg8, %28] : memref<?x1200xf64>
          %31 = affine.apply #map12(%arg9)
          %32 = affine.load %arg4[%arg8, %31] : memref<?x1200xf64>
          %33 = arith.mulf %32, %arg3 : f64
          affine.store %33, %arg4[%arg8, %31] : memref<?x1200xf64>
          %34 = affine.apply #map13(%arg9)
          %35 = affine.load %arg4[%arg8, %34] : memref<?x1200xf64>
          %36 = arith.mulf %35, %arg3 : f64
          affine.store %36, %arg4[%arg8, %34] : memref<?x1200xf64>
          %37 = affine.apply #map14(%arg9)
          %38 = affine.load %arg4[%arg8, %37] : memref<?x1200xf64>
          %39 = arith.mulf %38, %arg3 : f64
          affine.store %39, %arg4[%arg8, %37] : memref<?x1200xf64>
          %40 = affine.apply #map3(%37)
          %41 = affine.load %arg4[%arg8, %40] : memref<?x1200xf64>
          %42 = arith.mulf %41, %arg3 : f64
          affine.store %42, %arg4[%arg8, %40] : memref<?x1200xf64>
          %43 = affine.apply #map4(%37)
          %44 = affine.load %arg4[%arg8, %43] : memref<?x1200xf64>
          %45 = arith.mulf %44, %arg3 : f64
          affine.store %45, %arg4[%arg8, %43] : memref<?x1200xf64>
          %46 = affine.apply #map5(%37)
          %47 = affine.load %arg4[%arg8, %46] : memref<?x1200xf64>
          %48 = arith.mulf %47, %arg3 : f64
          affine.store %48, %arg4[%arg8, %46] : memref<?x1200xf64>
          %49 = affine.apply #map6(%37)
          %50 = affine.load %arg4[%arg8, %49] : memref<?x1200xf64>
          %51 = arith.mulf %50, %arg3 : f64
          affine.store %51, %arg4[%arg8, %49] : memref<?x1200xf64>
          %52 = affine.apply #map7(%37)
          %53 = affine.load %arg4[%arg8, %52] : memref<?x1200xf64>
          %54 = arith.mulf %53, %arg3 : f64
          affine.store %54, %arg4[%arg8, %52] : memref<?x1200xf64>
          %55 = affine.apply #map8(%37)
          %56 = affine.load %arg4[%arg8, %55] : memref<?x1200xf64>
          %57 = arith.mulf %56, %arg3 : f64
          affine.store %57, %arg4[%arg8, %55] : memref<?x1200xf64>
          %58 = affine.apply #map9(%37)
          %59 = affine.load %arg4[%arg8, %58] : memref<?x1200xf64>
          %60 = arith.mulf %59, %arg3 : f64
          affine.store %60, %arg4[%arg8, %58] : memref<?x1200xf64>
          %61 = affine.apply #map10(%37)
          %62 = affine.load %arg4[%arg8, %61] : memref<?x1200xf64>
          %63 = arith.mulf %62, %arg3 : f64
          affine.store %63, %arg4[%arg8, %61] : memref<?x1200xf64>
          %64 = affine.apply #map11(%37)
          %65 = affine.load %arg4[%arg8, %64] : memref<?x1200xf64>
          %66 = arith.mulf %65, %arg3 : f64
          affine.store %66, %arg4[%arg8, %64] : memref<?x1200xf64>
          %67 = affine.apply #map12(%37)
          %68 = affine.load %arg4[%arg8, %67] : memref<?x1200xf64>
          %69 = arith.mulf %68, %arg3 : f64
          affine.store %69, %arg4[%arg8, %67] : memref<?x1200xf64>
          %70 = affine.apply #map13(%37)
          %71 = affine.load %arg4[%arg8, %70] : memref<?x1200xf64>
          %72 = arith.mulf %71, %arg3 : f64
          affine.store %72, %arg4[%arg8, %70] : memref<?x1200xf64>
        }
        affine.for %arg9 = #map2(%arg8) to #map15(%arg8) step 12 {
          %2 = affine.load %arg4[%arg8, %arg9] : memref<?x1200xf64>
          %3 = arith.mulf %2, %arg3 : f64
          affine.store %3, %arg4[%arg8, %arg9] : memref<?x1200xf64>
          %4 = affine.apply #map3(%arg9)
          %5 = affine.load %arg4[%arg8, %4] : memref<?x1200xf64>
          %6 = arith.mulf %5, %arg3 : f64
          affine.store %6, %arg4[%arg8, %4] : memref<?x1200xf64>
          %7 = affine.apply #map4(%arg9)
          %8 = affine.load %arg4[%arg8, %7] : memref<?x1200xf64>
          %9 = arith.mulf %8, %arg3 : f64
          affine.store %9, %arg4[%arg8, %7] : memref<?x1200xf64>
          %10 = affine.apply #map5(%arg9)
          %11 = affine.load %arg4[%arg8, %10] : memref<?x1200xf64>
          %12 = arith.mulf %11, %arg3 : f64
          affine.store %12, %arg4[%arg8, %10] : memref<?x1200xf64>
          %13 = affine.apply #map6(%arg9)
          %14 = affine.load %arg4[%arg8, %13] : memref<?x1200xf64>
          %15 = arith.mulf %14, %arg3 : f64
          affine.store %15, %arg4[%arg8, %13] : memref<?x1200xf64>
          %16 = affine.apply #map7(%arg9)
          %17 = affine.load %arg4[%arg8, %16] : memref<?x1200xf64>
          %18 = arith.mulf %17, %arg3 : f64
          affine.store %18, %arg4[%arg8, %16] : memref<?x1200xf64>
          %19 = affine.apply #map8(%arg9)
          %20 = affine.load %arg4[%arg8, %19] : memref<?x1200xf64>
          %21 = arith.mulf %20, %arg3 : f64
          affine.store %21, %arg4[%arg8, %19] : memref<?x1200xf64>
          %22 = affine.apply #map9(%arg9)
          %23 = affine.load %arg4[%arg8, %22] : memref<?x1200xf64>
          %24 = arith.mulf %23, %arg3 : f64
          affine.store %24, %arg4[%arg8, %22] : memref<?x1200xf64>
          %25 = affine.apply #map10(%arg9)
          %26 = affine.load %arg4[%arg8, %25] : memref<?x1200xf64>
          %27 = arith.mulf %26, %arg3 : f64
          affine.store %27, %arg4[%arg8, %25] : memref<?x1200xf64>
          %28 = affine.apply #map11(%arg9)
          %29 = affine.load %arg4[%arg8, %28] : memref<?x1200xf64>
          %30 = arith.mulf %29, %arg3 : f64
          affine.store %30, %arg4[%arg8, %28] : memref<?x1200xf64>
          %31 = affine.apply #map12(%arg9)
          %32 = affine.load %arg4[%arg8, %31] : memref<?x1200xf64>
          %33 = arith.mulf %32, %arg3 : f64
          affine.store %33, %arg4[%arg8, %31] : memref<?x1200xf64>
          %34 = affine.apply #map13(%arg9)
          %35 = affine.load %arg4[%arg8, %34] : memref<?x1200xf64>
          %36 = arith.mulf %35, %arg3 : f64
          affine.store %36, %arg4[%arg8, %34] : memref<?x1200xf64>
        }
        affine.for %arg9 = #map15(%arg8) to #map16(%arg8) step 2 {
          %2 = affine.load %arg4[%arg8, %arg9] : memref<?x1200xf64>
          %3 = arith.mulf %2, %arg3 : f64
          affine.store %3, %arg4[%arg8, %arg9] : memref<?x1200xf64>
          %4 = affine.apply #map3(%arg9)
          %5 = affine.load %arg4[%arg8, %4] : memref<?x1200xf64>
          %6 = arith.mulf %5, %arg3 : f64
          affine.store %6, %arg4[%arg8, %4] : memref<?x1200xf64>
        }
        affine.for %arg9 = #map16(%arg8) to #map3(%arg8) {
          %2 = affine.load %arg4[%arg8, %arg9] : memref<?x1200xf64>
          %3 = arith.mulf %2, %arg3 : f64
          affine.store %3, %arg4[%arg8, %arg9] : memref<?x1200xf64>
        }
        affine.for %arg9 = 0 to %0 {
          affine.for %arg10 = 0 to #map2(%arg8) step 24 {
            %2 = affine.load %arg5[%arg10, %arg9] : memref<?x1000xf64>
            %3 = arith.mulf %2, %arg2 : f64
            %4 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %5 = arith.mulf %3, %4 : f64
            %6 = affine.load %arg6[%arg10, %arg9] : memref<?x1000xf64>
            %7 = arith.mulf %6, %arg2 : f64
            %8 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %9 = arith.mulf %7, %8 : f64
            %10 = arith.addf %5, %9 : f64
            %11 = affine.load %arg4[%arg8, %arg10] : memref<?x1200xf64>
            %12 = arith.addf %11, %10 : f64
            affine.store %12, %arg4[%arg8, %arg10] : memref<?x1200xf64>
            %13 = affine.apply #map3(%arg10)
            %14 = affine.load %arg5[%13, %arg9] : memref<?x1000xf64>
            %15 = arith.mulf %14, %arg2 : f64
            %16 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %17 = arith.mulf %15, %16 : f64
            %18 = affine.load %arg6[%13, %arg9] : memref<?x1000xf64>
            %19 = arith.mulf %18, %arg2 : f64
            %20 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %21 = arith.mulf %19, %20 : f64
            %22 = arith.addf %17, %21 : f64
            %23 = affine.load %arg4[%arg8, %13] : memref<?x1200xf64>
            %24 = arith.addf %23, %22 : f64
            affine.store %24, %arg4[%arg8, %13] : memref<?x1200xf64>
            %25 = affine.apply #map4(%arg10)
            %26 = affine.load %arg5[%25, %arg9] : memref<?x1000xf64>
            %27 = arith.mulf %26, %arg2 : f64
            %28 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %29 = arith.mulf %27, %28 : f64
            %30 = affine.load %arg6[%25, %arg9] : memref<?x1000xf64>
            %31 = arith.mulf %30, %arg2 : f64
            %32 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %33 = arith.mulf %31, %32 : f64
            %34 = arith.addf %29, %33 : f64
            %35 = affine.load %arg4[%arg8, %25] : memref<?x1200xf64>
            %36 = arith.addf %35, %34 : f64
            affine.store %36, %arg4[%arg8, %25] : memref<?x1200xf64>
            %37 = affine.apply #map5(%arg10)
            %38 = affine.load %arg5[%37, %arg9] : memref<?x1000xf64>
            %39 = arith.mulf %38, %arg2 : f64
            %40 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %41 = arith.mulf %39, %40 : f64
            %42 = affine.load %arg6[%37, %arg9] : memref<?x1000xf64>
            %43 = arith.mulf %42, %arg2 : f64
            %44 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %45 = arith.mulf %43, %44 : f64
            %46 = arith.addf %41, %45 : f64
            %47 = affine.load %arg4[%arg8, %37] : memref<?x1200xf64>
            %48 = arith.addf %47, %46 : f64
            affine.store %48, %arg4[%arg8, %37] : memref<?x1200xf64>
            %49 = affine.apply #map6(%arg10)
            %50 = affine.load %arg5[%49, %arg9] : memref<?x1000xf64>
            %51 = arith.mulf %50, %arg2 : f64
            %52 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %53 = arith.mulf %51, %52 : f64
            %54 = affine.load %arg6[%49, %arg9] : memref<?x1000xf64>
            %55 = arith.mulf %54, %arg2 : f64
            %56 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %57 = arith.mulf %55, %56 : f64
            %58 = arith.addf %53, %57 : f64
            %59 = affine.load %arg4[%arg8, %49] : memref<?x1200xf64>
            %60 = arith.addf %59, %58 : f64
            affine.store %60, %arg4[%arg8, %49] : memref<?x1200xf64>
            %61 = affine.apply #map7(%arg10)
            %62 = affine.load %arg5[%61, %arg9] : memref<?x1000xf64>
            %63 = arith.mulf %62, %arg2 : f64
            %64 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %65 = arith.mulf %63, %64 : f64
            %66 = affine.load %arg6[%61, %arg9] : memref<?x1000xf64>
            %67 = arith.mulf %66, %arg2 : f64
            %68 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %69 = arith.mulf %67, %68 : f64
            %70 = arith.addf %65, %69 : f64
            %71 = affine.load %arg4[%arg8, %61] : memref<?x1200xf64>
            %72 = arith.addf %71, %70 : f64
            affine.store %72, %arg4[%arg8, %61] : memref<?x1200xf64>
            %73 = affine.apply #map8(%arg10)
            %74 = affine.load %arg5[%73, %arg9] : memref<?x1000xf64>
            %75 = arith.mulf %74, %arg2 : f64
            %76 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %77 = arith.mulf %75, %76 : f64
            %78 = affine.load %arg6[%73, %arg9] : memref<?x1000xf64>
            %79 = arith.mulf %78, %arg2 : f64
            %80 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %81 = arith.mulf %79, %80 : f64
            %82 = arith.addf %77, %81 : f64
            %83 = affine.load %arg4[%arg8, %73] : memref<?x1200xf64>
            %84 = arith.addf %83, %82 : f64
            affine.store %84, %arg4[%arg8, %73] : memref<?x1200xf64>
            %85 = affine.apply #map9(%arg10)
            %86 = affine.load %arg5[%85, %arg9] : memref<?x1000xf64>
            %87 = arith.mulf %86, %arg2 : f64
            %88 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %89 = arith.mulf %87, %88 : f64
            %90 = affine.load %arg6[%85, %arg9] : memref<?x1000xf64>
            %91 = arith.mulf %90, %arg2 : f64
            %92 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %93 = arith.mulf %91, %92 : f64
            %94 = arith.addf %89, %93 : f64
            %95 = affine.load %arg4[%arg8, %85] : memref<?x1200xf64>
            %96 = arith.addf %95, %94 : f64
            affine.store %96, %arg4[%arg8, %85] : memref<?x1200xf64>
            %97 = affine.apply #map10(%arg10)
            %98 = affine.load %arg5[%97, %arg9] : memref<?x1000xf64>
            %99 = arith.mulf %98, %arg2 : f64
            %100 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %101 = arith.mulf %99, %100 : f64
            %102 = affine.load %arg6[%97, %arg9] : memref<?x1000xf64>
            %103 = arith.mulf %102, %arg2 : f64
            %104 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %105 = arith.mulf %103, %104 : f64
            %106 = arith.addf %101, %105 : f64
            %107 = affine.load %arg4[%arg8, %97] : memref<?x1200xf64>
            %108 = arith.addf %107, %106 : f64
            affine.store %108, %arg4[%arg8, %97] : memref<?x1200xf64>
            %109 = affine.apply #map11(%arg10)
            %110 = affine.load %arg5[%109, %arg9] : memref<?x1000xf64>
            %111 = arith.mulf %110, %arg2 : f64
            %112 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %113 = arith.mulf %111, %112 : f64
            %114 = affine.load %arg6[%109, %arg9] : memref<?x1000xf64>
            %115 = arith.mulf %114, %arg2 : f64
            %116 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %117 = arith.mulf %115, %116 : f64
            %118 = arith.addf %113, %117 : f64
            %119 = affine.load %arg4[%arg8, %109] : memref<?x1200xf64>
            %120 = arith.addf %119, %118 : f64
            affine.store %120, %arg4[%arg8, %109] : memref<?x1200xf64>
            %121 = affine.apply #map12(%arg10)
            %122 = affine.load %arg5[%121, %arg9] : memref<?x1000xf64>
            %123 = arith.mulf %122, %arg2 : f64
            %124 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %125 = arith.mulf %123, %124 : f64
            %126 = affine.load %arg6[%121, %arg9] : memref<?x1000xf64>
            %127 = arith.mulf %126, %arg2 : f64
            %128 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %129 = arith.mulf %127, %128 : f64
            %130 = arith.addf %125, %129 : f64
            %131 = affine.load %arg4[%arg8, %121] : memref<?x1200xf64>
            %132 = arith.addf %131, %130 : f64
            affine.store %132, %arg4[%arg8, %121] : memref<?x1200xf64>
            %133 = affine.apply #map13(%arg10)
            %134 = affine.load %arg5[%133, %arg9] : memref<?x1000xf64>
            %135 = arith.mulf %134, %arg2 : f64
            %136 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %137 = arith.mulf %135, %136 : f64
            %138 = affine.load %arg6[%133, %arg9] : memref<?x1000xf64>
            %139 = arith.mulf %138, %arg2 : f64
            %140 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %141 = arith.mulf %139, %140 : f64
            %142 = arith.addf %137, %141 : f64
            %143 = affine.load %arg4[%arg8, %133] : memref<?x1200xf64>
            %144 = arith.addf %143, %142 : f64
            affine.store %144, %arg4[%arg8, %133] : memref<?x1200xf64>
            %145 = affine.apply #map14(%arg10)
            %146 = affine.load %arg5[%145, %arg9] : memref<?x1000xf64>
            %147 = arith.mulf %146, %arg2 : f64
            %148 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %149 = arith.mulf %147, %148 : f64
            %150 = affine.load %arg6[%145, %arg9] : memref<?x1000xf64>
            %151 = arith.mulf %150, %arg2 : f64
            %152 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %153 = arith.mulf %151, %152 : f64
            %154 = arith.addf %149, %153 : f64
            %155 = affine.load %arg4[%arg8, %145] : memref<?x1200xf64>
            %156 = arith.addf %155, %154 : f64
            affine.store %156, %arg4[%arg8, %145] : memref<?x1200xf64>
            %157 = affine.apply #map3(%145)
            %158 = affine.load %arg5[%157, %arg9] : memref<?x1000xf64>
            %159 = arith.mulf %158, %arg2 : f64
            %160 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %161 = arith.mulf %159, %160 : f64
            %162 = affine.load %arg6[%157, %arg9] : memref<?x1000xf64>
            %163 = arith.mulf %162, %arg2 : f64
            %164 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %165 = arith.mulf %163, %164 : f64
            %166 = arith.addf %161, %165 : f64
            %167 = affine.load %arg4[%arg8, %157] : memref<?x1200xf64>
            %168 = arith.addf %167, %166 : f64
            affine.store %168, %arg4[%arg8, %157] : memref<?x1200xf64>
            %169 = affine.apply #map4(%145)
            %170 = affine.load %arg5[%169, %arg9] : memref<?x1000xf64>
            %171 = arith.mulf %170, %arg2 : f64
            %172 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %173 = arith.mulf %171, %172 : f64
            %174 = affine.load %arg6[%169, %arg9] : memref<?x1000xf64>
            %175 = arith.mulf %174, %arg2 : f64
            %176 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %177 = arith.mulf %175, %176 : f64
            %178 = arith.addf %173, %177 : f64
            %179 = affine.load %arg4[%arg8, %169] : memref<?x1200xf64>
            %180 = arith.addf %179, %178 : f64
            affine.store %180, %arg4[%arg8, %169] : memref<?x1200xf64>
            %181 = affine.apply #map5(%145)
            %182 = affine.load %arg5[%181, %arg9] : memref<?x1000xf64>
            %183 = arith.mulf %182, %arg2 : f64
            %184 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %185 = arith.mulf %183, %184 : f64
            %186 = affine.load %arg6[%181, %arg9] : memref<?x1000xf64>
            %187 = arith.mulf %186, %arg2 : f64
            %188 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %189 = arith.mulf %187, %188 : f64
            %190 = arith.addf %185, %189 : f64
            %191 = affine.load %arg4[%arg8, %181] : memref<?x1200xf64>
            %192 = arith.addf %191, %190 : f64
            affine.store %192, %arg4[%arg8, %181] : memref<?x1200xf64>
            %193 = affine.apply #map6(%145)
            %194 = affine.load %arg5[%193, %arg9] : memref<?x1000xf64>
            %195 = arith.mulf %194, %arg2 : f64
            %196 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %197 = arith.mulf %195, %196 : f64
            %198 = affine.load %arg6[%193, %arg9] : memref<?x1000xf64>
            %199 = arith.mulf %198, %arg2 : f64
            %200 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %201 = arith.mulf %199, %200 : f64
            %202 = arith.addf %197, %201 : f64
            %203 = affine.load %arg4[%arg8, %193] : memref<?x1200xf64>
            %204 = arith.addf %203, %202 : f64
            affine.store %204, %arg4[%arg8, %193] : memref<?x1200xf64>
            %205 = affine.apply #map7(%145)
            %206 = affine.load %arg5[%205, %arg9] : memref<?x1000xf64>
            %207 = arith.mulf %206, %arg2 : f64
            %208 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %209 = arith.mulf %207, %208 : f64
            %210 = affine.load %arg6[%205, %arg9] : memref<?x1000xf64>
            %211 = arith.mulf %210, %arg2 : f64
            %212 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %213 = arith.mulf %211, %212 : f64
            %214 = arith.addf %209, %213 : f64
            %215 = affine.load %arg4[%arg8, %205] : memref<?x1200xf64>
            %216 = arith.addf %215, %214 : f64
            affine.store %216, %arg4[%arg8, %205] : memref<?x1200xf64>
            %217 = affine.apply #map8(%145)
            %218 = affine.load %arg5[%217, %arg9] : memref<?x1000xf64>
            %219 = arith.mulf %218, %arg2 : f64
            %220 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %221 = arith.mulf %219, %220 : f64
            %222 = affine.load %arg6[%217, %arg9] : memref<?x1000xf64>
            %223 = arith.mulf %222, %arg2 : f64
            %224 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %225 = arith.mulf %223, %224 : f64
            %226 = arith.addf %221, %225 : f64
            %227 = affine.load %arg4[%arg8, %217] : memref<?x1200xf64>
            %228 = arith.addf %227, %226 : f64
            affine.store %228, %arg4[%arg8, %217] : memref<?x1200xf64>
            %229 = affine.apply #map9(%145)
            %230 = affine.load %arg5[%229, %arg9] : memref<?x1000xf64>
            %231 = arith.mulf %230, %arg2 : f64
            %232 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %233 = arith.mulf %231, %232 : f64
            %234 = affine.load %arg6[%229, %arg9] : memref<?x1000xf64>
            %235 = arith.mulf %234, %arg2 : f64
            %236 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %237 = arith.mulf %235, %236 : f64
            %238 = arith.addf %233, %237 : f64
            %239 = affine.load %arg4[%arg8, %229] : memref<?x1200xf64>
            %240 = arith.addf %239, %238 : f64
            affine.store %240, %arg4[%arg8, %229] : memref<?x1200xf64>
            %241 = affine.apply #map10(%145)
            %242 = affine.load %arg5[%241, %arg9] : memref<?x1000xf64>
            %243 = arith.mulf %242, %arg2 : f64
            %244 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %245 = arith.mulf %243, %244 : f64
            %246 = affine.load %arg6[%241, %arg9] : memref<?x1000xf64>
            %247 = arith.mulf %246, %arg2 : f64
            %248 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %249 = arith.mulf %247, %248 : f64
            %250 = arith.addf %245, %249 : f64
            %251 = affine.load %arg4[%arg8, %241] : memref<?x1200xf64>
            %252 = arith.addf %251, %250 : f64
            affine.store %252, %arg4[%arg8, %241] : memref<?x1200xf64>
            %253 = affine.apply #map11(%145)
            %254 = affine.load %arg5[%253, %arg9] : memref<?x1000xf64>
            %255 = arith.mulf %254, %arg2 : f64
            %256 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %257 = arith.mulf %255, %256 : f64
            %258 = affine.load %arg6[%253, %arg9] : memref<?x1000xf64>
            %259 = arith.mulf %258, %arg2 : f64
            %260 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %261 = arith.mulf %259, %260 : f64
            %262 = arith.addf %257, %261 : f64
            %263 = affine.load %arg4[%arg8, %253] : memref<?x1200xf64>
            %264 = arith.addf %263, %262 : f64
            affine.store %264, %arg4[%arg8, %253] : memref<?x1200xf64>
            %265 = affine.apply #map12(%145)
            %266 = affine.load %arg5[%265, %arg9] : memref<?x1000xf64>
            %267 = arith.mulf %266, %arg2 : f64
            %268 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %269 = arith.mulf %267, %268 : f64
            %270 = affine.load %arg6[%265, %arg9] : memref<?x1000xf64>
            %271 = arith.mulf %270, %arg2 : f64
            %272 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %273 = arith.mulf %271, %272 : f64
            %274 = arith.addf %269, %273 : f64
            %275 = affine.load %arg4[%arg8, %265] : memref<?x1200xf64>
            %276 = arith.addf %275, %274 : f64
            affine.store %276, %arg4[%arg8, %265] : memref<?x1200xf64>
            %277 = affine.apply #map13(%145)
            %278 = affine.load %arg5[%277, %arg9] : memref<?x1000xf64>
            %279 = arith.mulf %278, %arg2 : f64
            %280 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %281 = arith.mulf %279, %280 : f64
            %282 = affine.load %arg6[%277, %arg9] : memref<?x1000xf64>
            %283 = arith.mulf %282, %arg2 : f64
            %284 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %285 = arith.mulf %283, %284 : f64
            %286 = arith.addf %281, %285 : f64
            %287 = affine.load %arg4[%arg8, %277] : memref<?x1200xf64>
            %288 = arith.addf %287, %286 : f64
            affine.store %288, %arg4[%arg8, %277] : memref<?x1200xf64>
          }
          affine.for %arg10 = #map2(%arg8) to #map15(%arg8) step 12 {
            %2 = affine.load %arg5[%arg10, %arg9] : memref<?x1000xf64>
            %3 = arith.mulf %2, %arg2 : f64
            %4 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %5 = arith.mulf %3, %4 : f64
            %6 = affine.load %arg6[%arg10, %arg9] : memref<?x1000xf64>
            %7 = arith.mulf %6, %arg2 : f64
            %8 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %9 = arith.mulf %7, %8 : f64
            %10 = arith.addf %5, %9 : f64
            %11 = affine.load %arg4[%arg8, %arg10] : memref<?x1200xf64>
            %12 = arith.addf %11, %10 : f64
            affine.store %12, %arg4[%arg8, %arg10] : memref<?x1200xf64>
            %13 = affine.apply #map3(%arg10)
            %14 = affine.load %arg5[%13, %arg9] : memref<?x1000xf64>
            %15 = arith.mulf %14, %arg2 : f64
            %16 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %17 = arith.mulf %15, %16 : f64
            %18 = affine.load %arg6[%13, %arg9] : memref<?x1000xf64>
            %19 = arith.mulf %18, %arg2 : f64
            %20 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %21 = arith.mulf %19, %20 : f64
            %22 = arith.addf %17, %21 : f64
            %23 = affine.load %arg4[%arg8, %13] : memref<?x1200xf64>
            %24 = arith.addf %23, %22 : f64
            affine.store %24, %arg4[%arg8, %13] : memref<?x1200xf64>
            %25 = affine.apply #map4(%arg10)
            %26 = affine.load %arg5[%25, %arg9] : memref<?x1000xf64>
            %27 = arith.mulf %26, %arg2 : f64
            %28 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %29 = arith.mulf %27, %28 : f64
            %30 = affine.load %arg6[%25, %arg9] : memref<?x1000xf64>
            %31 = arith.mulf %30, %arg2 : f64
            %32 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %33 = arith.mulf %31, %32 : f64
            %34 = arith.addf %29, %33 : f64
            %35 = affine.load %arg4[%arg8, %25] : memref<?x1200xf64>
            %36 = arith.addf %35, %34 : f64
            affine.store %36, %arg4[%arg8, %25] : memref<?x1200xf64>
            %37 = affine.apply #map5(%arg10)
            %38 = affine.load %arg5[%37, %arg9] : memref<?x1000xf64>
            %39 = arith.mulf %38, %arg2 : f64
            %40 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %41 = arith.mulf %39, %40 : f64
            %42 = affine.load %arg6[%37, %arg9] : memref<?x1000xf64>
            %43 = arith.mulf %42, %arg2 : f64
            %44 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %45 = arith.mulf %43, %44 : f64
            %46 = arith.addf %41, %45 : f64
            %47 = affine.load %arg4[%arg8, %37] : memref<?x1200xf64>
            %48 = arith.addf %47, %46 : f64
            affine.store %48, %arg4[%arg8, %37] : memref<?x1200xf64>
            %49 = affine.apply #map6(%arg10)
            %50 = affine.load %arg5[%49, %arg9] : memref<?x1000xf64>
            %51 = arith.mulf %50, %arg2 : f64
            %52 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %53 = arith.mulf %51, %52 : f64
            %54 = affine.load %arg6[%49, %arg9] : memref<?x1000xf64>
            %55 = arith.mulf %54, %arg2 : f64
            %56 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %57 = arith.mulf %55, %56 : f64
            %58 = arith.addf %53, %57 : f64
            %59 = affine.load %arg4[%arg8, %49] : memref<?x1200xf64>
            %60 = arith.addf %59, %58 : f64
            affine.store %60, %arg4[%arg8, %49] : memref<?x1200xf64>
            %61 = affine.apply #map7(%arg10)
            %62 = affine.load %arg5[%61, %arg9] : memref<?x1000xf64>
            %63 = arith.mulf %62, %arg2 : f64
            %64 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %65 = arith.mulf %63, %64 : f64
            %66 = affine.load %arg6[%61, %arg9] : memref<?x1000xf64>
            %67 = arith.mulf %66, %arg2 : f64
            %68 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %69 = arith.mulf %67, %68 : f64
            %70 = arith.addf %65, %69 : f64
            %71 = affine.load %arg4[%arg8, %61] : memref<?x1200xf64>
            %72 = arith.addf %71, %70 : f64
            affine.store %72, %arg4[%arg8, %61] : memref<?x1200xf64>
            %73 = affine.apply #map8(%arg10)
            %74 = affine.load %arg5[%73, %arg9] : memref<?x1000xf64>
            %75 = arith.mulf %74, %arg2 : f64
            %76 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %77 = arith.mulf %75, %76 : f64
            %78 = affine.load %arg6[%73, %arg9] : memref<?x1000xf64>
            %79 = arith.mulf %78, %arg2 : f64
            %80 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %81 = arith.mulf %79, %80 : f64
            %82 = arith.addf %77, %81 : f64
            %83 = affine.load %arg4[%arg8, %73] : memref<?x1200xf64>
            %84 = arith.addf %83, %82 : f64
            affine.store %84, %arg4[%arg8, %73] : memref<?x1200xf64>
            %85 = affine.apply #map9(%arg10)
            %86 = affine.load %arg5[%85, %arg9] : memref<?x1000xf64>
            %87 = arith.mulf %86, %arg2 : f64
            %88 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %89 = arith.mulf %87, %88 : f64
            %90 = affine.load %arg6[%85, %arg9] : memref<?x1000xf64>
            %91 = arith.mulf %90, %arg2 : f64
            %92 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %93 = arith.mulf %91, %92 : f64
            %94 = arith.addf %89, %93 : f64
            %95 = affine.load %arg4[%arg8, %85] : memref<?x1200xf64>
            %96 = arith.addf %95, %94 : f64
            affine.store %96, %arg4[%arg8, %85] : memref<?x1200xf64>
            %97 = affine.apply #map10(%arg10)
            %98 = affine.load %arg5[%97, %arg9] : memref<?x1000xf64>
            %99 = arith.mulf %98, %arg2 : f64
            %100 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %101 = arith.mulf %99, %100 : f64
            %102 = affine.load %arg6[%97, %arg9] : memref<?x1000xf64>
            %103 = arith.mulf %102, %arg2 : f64
            %104 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %105 = arith.mulf %103, %104 : f64
            %106 = arith.addf %101, %105 : f64
            %107 = affine.load %arg4[%arg8, %97] : memref<?x1200xf64>
            %108 = arith.addf %107, %106 : f64
            affine.store %108, %arg4[%arg8, %97] : memref<?x1200xf64>
            %109 = affine.apply #map11(%arg10)
            %110 = affine.load %arg5[%109, %arg9] : memref<?x1000xf64>
            %111 = arith.mulf %110, %arg2 : f64
            %112 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %113 = arith.mulf %111, %112 : f64
            %114 = affine.load %arg6[%109, %arg9] : memref<?x1000xf64>
            %115 = arith.mulf %114, %arg2 : f64
            %116 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %117 = arith.mulf %115, %116 : f64
            %118 = arith.addf %113, %117 : f64
            %119 = affine.load %arg4[%arg8, %109] : memref<?x1200xf64>
            %120 = arith.addf %119, %118 : f64
            affine.store %120, %arg4[%arg8, %109] : memref<?x1200xf64>
            %121 = affine.apply #map12(%arg10)
            %122 = affine.load %arg5[%121, %arg9] : memref<?x1000xf64>
            %123 = arith.mulf %122, %arg2 : f64
            %124 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %125 = arith.mulf %123, %124 : f64
            %126 = affine.load %arg6[%121, %arg9] : memref<?x1000xf64>
            %127 = arith.mulf %126, %arg2 : f64
            %128 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %129 = arith.mulf %127, %128 : f64
            %130 = arith.addf %125, %129 : f64
            %131 = affine.load %arg4[%arg8, %121] : memref<?x1200xf64>
            %132 = arith.addf %131, %130 : f64
            affine.store %132, %arg4[%arg8, %121] : memref<?x1200xf64>
            %133 = affine.apply #map13(%arg10)
            %134 = affine.load %arg5[%133, %arg9] : memref<?x1000xf64>
            %135 = arith.mulf %134, %arg2 : f64
            %136 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %137 = arith.mulf %135, %136 : f64
            %138 = affine.load %arg6[%133, %arg9] : memref<?x1000xf64>
            %139 = arith.mulf %138, %arg2 : f64
            %140 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %141 = arith.mulf %139, %140 : f64
            %142 = arith.addf %137, %141 : f64
            %143 = affine.load %arg4[%arg8, %133] : memref<?x1200xf64>
            %144 = arith.addf %143, %142 : f64
            affine.store %144, %arg4[%arg8, %133] : memref<?x1200xf64>
          }
          affine.for %arg10 = #map15(%arg8) to #map16(%arg8) step 2 {
            %2 = affine.load %arg5[%arg10, %arg9] : memref<?x1000xf64>
            %3 = arith.mulf %2, %arg2 : f64
            %4 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %5 = arith.mulf %3, %4 : f64
            %6 = affine.load %arg6[%arg10, %arg9] : memref<?x1000xf64>
            %7 = arith.mulf %6, %arg2 : f64
            %8 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %9 = arith.mulf %7, %8 : f64
            %10 = arith.addf %5, %9 : f64
            %11 = affine.load %arg4[%arg8, %arg10] : memref<?x1200xf64>
            %12 = arith.addf %11, %10 : f64
            affine.store %12, %arg4[%arg8, %arg10] : memref<?x1200xf64>
            %13 = affine.apply #map3(%arg10)
            %14 = affine.load %arg5[%13, %arg9] : memref<?x1000xf64>
            %15 = arith.mulf %14, %arg2 : f64
            %16 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %17 = arith.mulf %15, %16 : f64
            %18 = affine.load %arg6[%13, %arg9] : memref<?x1000xf64>
            %19 = arith.mulf %18, %arg2 : f64
            %20 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %21 = arith.mulf %19, %20 : f64
            %22 = arith.addf %17, %21 : f64
            %23 = affine.load %arg4[%arg8, %13] : memref<?x1200xf64>
            %24 = arith.addf %23, %22 : f64
            affine.store %24, %arg4[%arg8, %13] : memref<?x1200xf64>
          }
          affine.for %arg10 = #map16(%arg8) to #map3(%arg8) {
            %2 = affine.load %arg5[%arg10, %arg9] : memref<?x1000xf64>
            %3 = arith.mulf %2, %arg2 : f64
            %4 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %5 = arith.mulf %3, %4 : f64
            %6 = affine.load %arg6[%arg10, %arg9] : memref<?x1000xf64>
            %7 = arith.mulf %6, %arg2 : f64
            %8 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %9 = arith.mulf %7, %8 : f64
            %10 = arith.addf %5, %9 : f64
            %11 = affine.load %arg4[%arg8, %arg10] : memref<?x1200xf64>
            %12 = arith.addf %11, %10 : f64
            affine.store %12, %arg4[%arg8, %arg10] : memref<?x1200xf64>
          }
        }
      }
    }
    return
  }
}

