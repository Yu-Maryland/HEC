#map = affine_map<()[s0] -> (((s0 floordiv 3) floordiv 13) * 39)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0 + 3)>
#map4 = affine_map<(d0) -> (d0 + 6)>
#map5 = affine_map<(d0) -> (d0 + 9)>
#map6 = affine_map<(d0) -> (d0 + 12)>
#map7 = affine_map<(d0) -> (d0 + 15)>
#map8 = affine_map<(d0) -> (d0 + 18)>
#map9 = affine_map<(d0) -> (d0 + 21)>
#map10 = affine_map<(d0) -> (d0 + 24)>
#map11 = affine_map<(d0) -> (d0 + 27)>
#map12 = affine_map<(d0) -> (d0 + 30)>
#map13 = affine_map<(d0) -> (d0 + 33)>
#map14 = affine_map<(d0) -> (d0 + 36)>
#map15 = affine_map<()[s0] -> ((s0 floordiv 3) * 3)>
#map16 = affine_map<()[s0] -> ((s0 floordiv 3) * 3 + ((s0 mod 3) floordiv 13) * 13)>
#map17 = affine_map<(d0) -> (d0 + 4)>
#map18 = affine_map<(d0) -> (d0 + 5)>
#map19 = affine_map<(d0) -> (d0 + 7)>
#map20 = affine_map<(d0) -> (d0 + 8)>
#map21 = affine_map<(d0) -> (d0 + 10)>
#map22 = affine_map<(d0) -> (d0 + 11)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_gemm(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: f64, %arg4: f64, %arg5: memref<?x1100xf64>, %arg6: memref<?x1200xf64>, %arg7: memref<?x1100xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg2 : i32 to index
    %2 = arith.index_cast %arg0 : i32 to index
    affine.for %arg8 = 0 to %2 {
      affine.for %arg9 = 0 to #map()[%0] step 39 {
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
        %14 = affine.apply #map1(%11)
        %15 = affine.load %arg5[%arg8, %14] : memref<?x1100xf64>
        %16 = arith.mulf %15, %arg4 : f64
        affine.store %16, %arg5[%arg8, %14] : memref<?x1100xf64>
        %17 = affine.apply #map2(%11)
        %18 = affine.load %arg5[%arg8, %17] : memref<?x1100xf64>
        %19 = arith.mulf %18, %arg4 : f64
        affine.store %19, %arg5[%arg8, %17] : memref<?x1100xf64>
        %20 = affine.apply #map4(%arg9)
        %21 = affine.load %arg5[%arg8, %20] : memref<?x1100xf64>
        %22 = arith.mulf %21, %arg4 : f64
        affine.store %22, %arg5[%arg8, %20] : memref<?x1100xf64>
        %23 = affine.apply #map1(%20)
        %24 = affine.load %arg5[%arg8, %23] : memref<?x1100xf64>
        %25 = arith.mulf %24, %arg4 : f64
        affine.store %25, %arg5[%arg8, %23] : memref<?x1100xf64>
        %26 = affine.apply #map2(%20)
        %27 = affine.load %arg5[%arg8, %26] : memref<?x1100xf64>
        %28 = arith.mulf %27, %arg4 : f64
        affine.store %28, %arg5[%arg8, %26] : memref<?x1100xf64>
        %29 = affine.apply #map5(%arg9)
        %30 = affine.load %arg5[%arg8, %29] : memref<?x1100xf64>
        %31 = arith.mulf %30, %arg4 : f64
        affine.store %31, %arg5[%arg8, %29] : memref<?x1100xf64>
        %32 = affine.apply #map1(%29)
        %33 = affine.load %arg5[%arg8, %32] : memref<?x1100xf64>
        %34 = arith.mulf %33, %arg4 : f64
        affine.store %34, %arg5[%arg8, %32] : memref<?x1100xf64>
        %35 = affine.apply #map2(%29)
        %36 = affine.load %arg5[%arg8, %35] : memref<?x1100xf64>
        %37 = arith.mulf %36, %arg4 : f64
        affine.store %37, %arg5[%arg8, %35] : memref<?x1100xf64>
        %38 = affine.apply #map6(%arg9)
        %39 = affine.load %arg5[%arg8, %38] : memref<?x1100xf64>
        %40 = arith.mulf %39, %arg4 : f64
        affine.store %40, %arg5[%arg8, %38] : memref<?x1100xf64>
        %41 = affine.apply #map1(%38)
        %42 = affine.load %arg5[%arg8, %41] : memref<?x1100xf64>
        %43 = arith.mulf %42, %arg4 : f64
        affine.store %43, %arg5[%arg8, %41] : memref<?x1100xf64>
        %44 = affine.apply #map2(%38)
        %45 = affine.load %arg5[%arg8, %44] : memref<?x1100xf64>
        %46 = arith.mulf %45, %arg4 : f64
        affine.store %46, %arg5[%arg8, %44] : memref<?x1100xf64>
        %47 = affine.apply #map7(%arg9)
        %48 = affine.load %arg5[%arg8, %47] : memref<?x1100xf64>
        %49 = arith.mulf %48, %arg4 : f64
        affine.store %49, %arg5[%arg8, %47] : memref<?x1100xf64>
        %50 = affine.apply #map1(%47)
        %51 = affine.load %arg5[%arg8, %50] : memref<?x1100xf64>
        %52 = arith.mulf %51, %arg4 : f64
        affine.store %52, %arg5[%arg8, %50] : memref<?x1100xf64>
        %53 = affine.apply #map2(%47)
        %54 = affine.load %arg5[%arg8, %53] : memref<?x1100xf64>
        %55 = arith.mulf %54, %arg4 : f64
        affine.store %55, %arg5[%arg8, %53] : memref<?x1100xf64>
        %56 = affine.apply #map8(%arg9)
        %57 = affine.load %arg5[%arg8, %56] : memref<?x1100xf64>
        %58 = arith.mulf %57, %arg4 : f64
        affine.store %58, %arg5[%arg8, %56] : memref<?x1100xf64>
        %59 = affine.apply #map1(%56)
        %60 = affine.load %arg5[%arg8, %59] : memref<?x1100xf64>
        %61 = arith.mulf %60, %arg4 : f64
        affine.store %61, %arg5[%arg8, %59] : memref<?x1100xf64>
        %62 = affine.apply #map2(%56)
        %63 = affine.load %arg5[%arg8, %62] : memref<?x1100xf64>
        %64 = arith.mulf %63, %arg4 : f64
        affine.store %64, %arg5[%arg8, %62] : memref<?x1100xf64>
        %65 = affine.apply #map9(%arg9)
        %66 = affine.load %arg5[%arg8, %65] : memref<?x1100xf64>
        %67 = arith.mulf %66, %arg4 : f64
        affine.store %67, %arg5[%arg8, %65] : memref<?x1100xf64>
        %68 = affine.apply #map1(%65)
        %69 = affine.load %arg5[%arg8, %68] : memref<?x1100xf64>
        %70 = arith.mulf %69, %arg4 : f64
        affine.store %70, %arg5[%arg8, %68] : memref<?x1100xf64>
        %71 = affine.apply #map2(%65)
        %72 = affine.load %arg5[%arg8, %71] : memref<?x1100xf64>
        %73 = arith.mulf %72, %arg4 : f64
        affine.store %73, %arg5[%arg8, %71] : memref<?x1100xf64>
        %74 = affine.apply #map10(%arg9)
        %75 = affine.load %arg5[%arg8, %74] : memref<?x1100xf64>
        %76 = arith.mulf %75, %arg4 : f64
        affine.store %76, %arg5[%arg8, %74] : memref<?x1100xf64>
        %77 = affine.apply #map1(%74)
        %78 = affine.load %arg5[%arg8, %77] : memref<?x1100xf64>
        %79 = arith.mulf %78, %arg4 : f64
        affine.store %79, %arg5[%arg8, %77] : memref<?x1100xf64>
        %80 = affine.apply #map2(%74)
        %81 = affine.load %arg5[%arg8, %80] : memref<?x1100xf64>
        %82 = arith.mulf %81, %arg4 : f64
        affine.store %82, %arg5[%arg8, %80] : memref<?x1100xf64>
        %83 = affine.apply #map11(%arg9)
        %84 = affine.load %arg5[%arg8, %83] : memref<?x1100xf64>
        %85 = arith.mulf %84, %arg4 : f64
        affine.store %85, %arg5[%arg8, %83] : memref<?x1100xf64>
        %86 = affine.apply #map1(%83)
        %87 = affine.load %arg5[%arg8, %86] : memref<?x1100xf64>
        %88 = arith.mulf %87, %arg4 : f64
        affine.store %88, %arg5[%arg8, %86] : memref<?x1100xf64>
        %89 = affine.apply #map2(%83)
        %90 = affine.load %arg5[%arg8, %89] : memref<?x1100xf64>
        %91 = arith.mulf %90, %arg4 : f64
        affine.store %91, %arg5[%arg8, %89] : memref<?x1100xf64>
        %92 = affine.apply #map12(%arg9)
        %93 = affine.load %arg5[%arg8, %92] : memref<?x1100xf64>
        %94 = arith.mulf %93, %arg4 : f64
        affine.store %94, %arg5[%arg8, %92] : memref<?x1100xf64>
        %95 = affine.apply #map1(%92)
        %96 = affine.load %arg5[%arg8, %95] : memref<?x1100xf64>
        %97 = arith.mulf %96, %arg4 : f64
        affine.store %97, %arg5[%arg8, %95] : memref<?x1100xf64>
        %98 = affine.apply #map2(%92)
        %99 = affine.load %arg5[%arg8, %98] : memref<?x1100xf64>
        %100 = arith.mulf %99, %arg4 : f64
        affine.store %100, %arg5[%arg8, %98] : memref<?x1100xf64>
        %101 = affine.apply #map13(%arg9)
        %102 = affine.load %arg5[%arg8, %101] : memref<?x1100xf64>
        %103 = arith.mulf %102, %arg4 : f64
        affine.store %103, %arg5[%arg8, %101] : memref<?x1100xf64>
        %104 = affine.apply #map1(%101)
        %105 = affine.load %arg5[%arg8, %104] : memref<?x1100xf64>
        %106 = arith.mulf %105, %arg4 : f64
        affine.store %106, %arg5[%arg8, %104] : memref<?x1100xf64>
        %107 = affine.apply #map2(%101)
        %108 = affine.load %arg5[%arg8, %107] : memref<?x1100xf64>
        %109 = arith.mulf %108, %arg4 : f64
        affine.store %109, %arg5[%arg8, %107] : memref<?x1100xf64>
        %110 = affine.apply #map14(%arg9)
        %111 = affine.load %arg5[%arg8, %110] : memref<?x1100xf64>
        %112 = arith.mulf %111, %arg4 : f64
        affine.store %112, %arg5[%arg8, %110] : memref<?x1100xf64>
        %113 = affine.apply #map1(%110)
        %114 = affine.load %arg5[%arg8, %113] : memref<?x1100xf64>
        %115 = arith.mulf %114, %arg4 : f64
        affine.store %115, %arg5[%arg8, %113] : memref<?x1100xf64>
        %116 = affine.apply #map2(%110)
        %117 = affine.load %arg5[%arg8, %116] : memref<?x1100xf64>
        %118 = arith.mulf %117, %arg4 : f64
        affine.store %118, %arg5[%arg8, %116] : memref<?x1100xf64>
      }
      affine.for %arg9 = #map()[%0] to #map15()[%0] step 3 {
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
      }
      affine.for %arg9 = #map15()[%0] to #map16()[%0] step 13 {
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
        %14 = affine.apply #map17(%arg9)
        %15 = affine.load %arg5[%arg8, %14] : memref<?x1100xf64>
        %16 = arith.mulf %15, %arg4 : f64
        affine.store %16, %arg5[%arg8, %14] : memref<?x1100xf64>
        %17 = affine.apply #map18(%arg9)
        %18 = affine.load %arg5[%arg8, %17] : memref<?x1100xf64>
        %19 = arith.mulf %18, %arg4 : f64
        affine.store %19, %arg5[%arg8, %17] : memref<?x1100xf64>
        %20 = affine.apply #map4(%arg9)
        %21 = affine.load %arg5[%arg8, %20] : memref<?x1100xf64>
        %22 = arith.mulf %21, %arg4 : f64
        affine.store %22, %arg5[%arg8, %20] : memref<?x1100xf64>
        %23 = affine.apply #map19(%arg9)
        %24 = affine.load %arg5[%arg8, %23] : memref<?x1100xf64>
        %25 = arith.mulf %24, %arg4 : f64
        affine.store %25, %arg5[%arg8, %23] : memref<?x1100xf64>
        %26 = affine.apply #map20(%arg9)
        %27 = affine.load %arg5[%arg8, %26] : memref<?x1100xf64>
        %28 = arith.mulf %27, %arg4 : f64
        affine.store %28, %arg5[%arg8, %26] : memref<?x1100xf64>
        %29 = affine.apply #map5(%arg9)
        %30 = affine.load %arg5[%arg8, %29] : memref<?x1100xf64>
        %31 = arith.mulf %30, %arg4 : f64
        affine.store %31, %arg5[%arg8, %29] : memref<?x1100xf64>
        %32 = affine.apply #map21(%arg9)
        %33 = affine.load %arg5[%arg8, %32] : memref<?x1100xf64>
        %34 = arith.mulf %33, %arg4 : f64
        affine.store %34, %arg5[%arg8, %32] : memref<?x1100xf64>
        %35 = affine.apply #map22(%arg9)
        %36 = affine.load %arg5[%arg8, %35] : memref<?x1100xf64>
        %37 = arith.mulf %36, %arg4 : f64
        affine.store %37, %arg5[%arg8, %35] : memref<?x1100xf64>
        %38 = affine.apply #map6(%arg9)
        %39 = affine.load %arg5[%arg8, %38] : memref<?x1100xf64>
        %40 = arith.mulf %39, %arg4 : f64
        affine.store %40, %arg5[%arg8, %38] : memref<?x1100xf64>
      }
      affine.for %arg9 = #map16()[%0] to %0 {
        %3 = affine.load %arg5[%arg8, %arg9] : memref<?x1100xf64>
        %4 = arith.mulf %3, %arg4 : f64
        affine.store %4, %arg5[%arg8, %arg9] : memref<?x1100xf64>
      }
      affine.for %arg9 = 0 to %1 {
        affine.for %arg10 = 0 to #map()[%0] step 39 {
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
          %30 = affine.apply #map1(%23)
          %31 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %32 = arith.mulf %arg3, %31 : f64
          %33 = affine.load %arg7[%arg9, %30] : memref<?x1100xf64>
          %34 = arith.mulf %32, %33 : f64
          %35 = affine.load %arg5[%arg8, %30] : memref<?x1100xf64>
          %36 = arith.addf %35, %34 : f64
          affine.store %36, %arg5[%arg8, %30] : memref<?x1100xf64>
          %37 = affine.apply #map2(%23)
          %38 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %39 = arith.mulf %arg3, %38 : f64
          %40 = affine.load %arg7[%arg9, %37] : memref<?x1100xf64>
          %41 = arith.mulf %39, %40 : f64
          %42 = affine.load %arg5[%arg8, %37] : memref<?x1100xf64>
          %43 = arith.addf %42, %41 : f64
          affine.store %43, %arg5[%arg8, %37] : memref<?x1100xf64>
          %44 = affine.apply #map4(%arg10)
          %45 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %46 = arith.mulf %arg3, %45 : f64
          %47 = affine.load %arg7[%arg9, %44] : memref<?x1100xf64>
          %48 = arith.mulf %46, %47 : f64
          %49 = affine.load %arg5[%arg8, %44] : memref<?x1100xf64>
          %50 = arith.addf %49, %48 : f64
          affine.store %50, %arg5[%arg8, %44] : memref<?x1100xf64>
          %51 = affine.apply #map1(%44)
          %52 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %53 = arith.mulf %arg3, %52 : f64
          %54 = affine.load %arg7[%arg9, %51] : memref<?x1100xf64>
          %55 = arith.mulf %53, %54 : f64
          %56 = affine.load %arg5[%arg8, %51] : memref<?x1100xf64>
          %57 = arith.addf %56, %55 : f64
          affine.store %57, %arg5[%arg8, %51] : memref<?x1100xf64>
          %58 = affine.apply #map2(%44)
          %59 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %60 = arith.mulf %arg3, %59 : f64
          %61 = affine.load %arg7[%arg9, %58] : memref<?x1100xf64>
          %62 = arith.mulf %60, %61 : f64
          %63 = affine.load %arg5[%arg8, %58] : memref<?x1100xf64>
          %64 = arith.addf %63, %62 : f64
          affine.store %64, %arg5[%arg8, %58] : memref<?x1100xf64>
          %65 = affine.apply #map5(%arg10)
          %66 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %67 = arith.mulf %arg3, %66 : f64
          %68 = affine.load %arg7[%arg9, %65] : memref<?x1100xf64>
          %69 = arith.mulf %67, %68 : f64
          %70 = affine.load %arg5[%arg8, %65] : memref<?x1100xf64>
          %71 = arith.addf %70, %69 : f64
          affine.store %71, %arg5[%arg8, %65] : memref<?x1100xf64>
          %72 = affine.apply #map1(%65)
          %73 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %74 = arith.mulf %arg3, %73 : f64
          %75 = affine.load %arg7[%arg9, %72] : memref<?x1100xf64>
          %76 = arith.mulf %74, %75 : f64
          %77 = affine.load %arg5[%arg8, %72] : memref<?x1100xf64>
          %78 = arith.addf %77, %76 : f64
          affine.store %78, %arg5[%arg8, %72] : memref<?x1100xf64>
          %79 = affine.apply #map2(%65)
          %80 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %81 = arith.mulf %arg3, %80 : f64
          %82 = affine.load %arg7[%arg9, %79] : memref<?x1100xf64>
          %83 = arith.mulf %81, %82 : f64
          %84 = affine.load %arg5[%arg8, %79] : memref<?x1100xf64>
          %85 = arith.addf %84, %83 : f64
          affine.store %85, %arg5[%arg8, %79] : memref<?x1100xf64>
          %86 = affine.apply #map6(%arg10)
          %87 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %88 = arith.mulf %arg3, %87 : f64
          %89 = affine.load %arg7[%arg9, %86] : memref<?x1100xf64>
          %90 = arith.mulf %88, %89 : f64
          %91 = affine.load %arg5[%arg8, %86] : memref<?x1100xf64>
          %92 = arith.addf %91, %90 : f64
          affine.store %92, %arg5[%arg8, %86] : memref<?x1100xf64>
          %93 = affine.apply #map1(%86)
          %94 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %95 = arith.mulf %arg3, %94 : f64
          %96 = affine.load %arg7[%arg9, %93] : memref<?x1100xf64>
          %97 = arith.mulf %95, %96 : f64
          %98 = affine.load %arg5[%arg8, %93] : memref<?x1100xf64>
          %99 = arith.addf %98, %97 : f64
          affine.store %99, %arg5[%arg8, %93] : memref<?x1100xf64>
          %100 = affine.apply #map2(%86)
          %101 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %102 = arith.mulf %arg3, %101 : f64
          %103 = affine.load %arg7[%arg9, %100] : memref<?x1100xf64>
          %104 = arith.mulf %102, %103 : f64
          %105 = affine.load %arg5[%arg8, %100] : memref<?x1100xf64>
          %106 = arith.addf %105, %104 : f64
          affine.store %106, %arg5[%arg8, %100] : memref<?x1100xf64>
          %107 = affine.apply #map7(%arg10)
          %108 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %109 = arith.mulf %arg3, %108 : f64
          %110 = affine.load %arg7[%arg9, %107] : memref<?x1100xf64>
          %111 = arith.mulf %109, %110 : f64
          %112 = affine.load %arg5[%arg8, %107] : memref<?x1100xf64>
          %113 = arith.addf %112, %111 : f64
          affine.store %113, %arg5[%arg8, %107] : memref<?x1100xf64>
          %114 = affine.apply #map1(%107)
          %115 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %116 = arith.mulf %arg3, %115 : f64
          %117 = affine.load %arg7[%arg9, %114] : memref<?x1100xf64>
          %118 = arith.mulf %116, %117 : f64
          %119 = affine.load %arg5[%arg8, %114] : memref<?x1100xf64>
          %120 = arith.addf %119, %118 : f64
          affine.store %120, %arg5[%arg8, %114] : memref<?x1100xf64>
          %121 = affine.apply #map2(%107)
          %122 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %123 = arith.mulf %arg3, %122 : f64
          %124 = affine.load %arg7[%arg9, %121] : memref<?x1100xf64>
          %125 = arith.mulf %123, %124 : f64
          %126 = affine.load %arg5[%arg8, %121] : memref<?x1100xf64>
          %127 = arith.addf %126, %125 : f64
          affine.store %127, %arg5[%arg8, %121] : memref<?x1100xf64>
          %128 = affine.apply #map8(%arg10)
          %129 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %130 = arith.mulf %arg3, %129 : f64
          %131 = affine.load %arg7[%arg9, %128] : memref<?x1100xf64>
          %132 = arith.mulf %130, %131 : f64
          %133 = affine.load %arg5[%arg8, %128] : memref<?x1100xf64>
          %134 = arith.addf %133, %132 : f64
          affine.store %134, %arg5[%arg8, %128] : memref<?x1100xf64>
          %135 = affine.apply #map1(%128)
          %136 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %137 = arith.mulf %arg3, %136 : f64
          %138 = affine.load %arg7[%arg9, %135] : memref<?x1100xf64>
          %139 = arith.mulf %137, %138 : f64
          %140 = affine.load %arg5[%arg8, %135] : memref<?x1100xf64>
          %141 = arith.addf %140, %139 : f64
          affine.store %141, %arg5[%arg8, %135] : memref<?x1100xf64>
          %142 = affine.apply #map2(%128)
          %143 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %144 = arith.mulf %arg3, %143 : f64
          %145 = affine.load %arg7[%arg9, %142] : memref<?x1100xf64>
          %146 = arith.mulf %144, %145 : f64
          %147 = affine.load %arg5[%arg8, %142] : memref<?x1100xf64>
          %148 = arith.addf %147, %146 : f64
          affine.store %148, %arg5[%arg8, %142] : memref<?x1100xf64>
          %149 = affine.apply #map9(%arg10)
          %150 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %151 = arith.mulf %arg3, %150 : f64
          %152 = affine.load %arg7[%arg9, %149] : memref<?x1100xf64>
          %153 = arith.mulf %151, %152 : f64
          %154 = affine.load %arg5[%arg8, %149] : memref<?x1100xf64>
          %155 = arith.addf %154, %153 : f64
          affine.store %155, %arg5[%arg8, %149] : memref<?x1100xf64>
          %156 = affine.apply #map1(%149)
          %157 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %158 = arith.mulf %arg3, %157 : f64
          %159 = affine.load %arg7[%arg9, %156] : memref<?x1100xf64>
          %160 = arith.mulf %158, %159 : f64
          %161 = affine.load %arg5[%arg8, %156] : memref<?x1100xf64>
          %162 = arith.addf %161, %160 : f64
          affine.store %162, %arg5[%arg8, %156] : memref<?x1100xf64>
          %163 = affine.apply #map2(%149)
          %164 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %165 = arith.mulf %arg3, %164 : f64
          %166 = affine.load %arg7[%arg9, %163] : memref<?x1100xf64>
          %167 = arith.mulf %165, %166 : f64
          %168 = affine.load %arg5[%arg8, %163] : memref<?x1100xf64>
          %169 = arith.addf %168, %167 : f64
          affine.store %169, %arg5[%arg8, %163] : memref<?x1100xf64>
          %170 = affine.apply #map10(%arg10)
          %171 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %172 = arith.mulf %arg3, %171 : f64
          %173 = affine.load %arg7[%arg9, %170] : memref<?x1100xf64>
          %174 = arith.mulf %172, %173 : f64
          %175 = affine.load %arg5[%arg8, %170] : memref<?x1100xf64>
          %176 = arith.addf %175, %174 : f64
          affine.store %176, %arg5[%arg8, %170] : memref<?x1100xf64>
          %177 = affine.apply #map1(%170)
          %178 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %179 = arith.mulf %arg3, %178 : f64
          %180 = affine.load %arg7[%arg9, %177] : memref<?x1100xf64>
          %181 = arith.mulf %179, %180 : f64
          %182 = affine.load %arg5[%arg8, %177] : memref<?x1100xf64>
          %183 = arith.addf %182, %181 : f64
          affine.store %183, %arg5[%arg8, %177] : memref<?x1100xf64>
          %184 = affine.apply #map2(%170)
          %185 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %186 = arith.mulf %arg3, %185 : f64
          %187 = affine.load %arg7[%arg9, %184] : memref<?x1100xf64>
          %188 = arith.mulf %186, %187 : f64
          %189 = affine.load %arg5[%arg8, %184] : memref<?x1100xf64>
          %190 = arith.addf %189, %188 : f64
          affine.store %190, %arg5[%arg8, %184] : memref<?x1100xf64>
          %191 = affine.apply #map11(%arg10)
          %192 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %193 = arith.mulf %arg3, %192 : f64
          %194 = affine.load %arg7[%arg9, %191] : memref<?x1100xf64>
          %195 = arith.mulf %193, %194 : f64
          %196 = affine.load %arg5[%arg8, %191] : memref<?x1100xf64>
          %197 = arith.addf %196, %195 : f64
          affine.store %197, %arg5[%arg8, %191] : memref<?x1100xf64>
          %198 = affine.apply #map1(%191)
          %199 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %200 = arith.mulf %arg3, %199 : f64
          %201 = affine.load %arg7[%arg9, %198] : memref<?x1100xf64>
          %202 = arith.mulf %200, %201 : f64
          %203 = affine.load %arg5[%arg8, %198] : memref<?x1100xf64>
          %204 = arith.addf %203, %202 : f64
          affine.store %204, %arg5[%arg8, %198] : memref<?x1100xf64>
          %205 = affine.apply #map2(%191)
          %206 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %207 = arith.mulf %arg3, %206 : f64
          %208 = affine.load %arg7[%arg9, %205] : memref<?x1100xf64>
          %209 = arith.mulf %207, %208 : f64
          %210 = affine.load %arg5[%arg8, %205] : memref<?x1100xf64>
          %211 = arith.addf %210, %209 : f64
          affine.store %211, %arg5[%arg8, %205] : memref<?x1100xf64>
          %212 = affine.apply #map12(%arg10)
          %213 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %214 = arith.mulf %arg3, %213 : f64
          %215 = affine.load %arg7[%arg9, %212] : memref<?x1100xf64>
          %216 = arith.mulf %214, %215 : f64
          %217 = affine.load %arg5[%arg8, %212] : memref<?x1100xf64>
          %218 = arith.addf %217, %216 : f64
          affine.store %218, %arg5[%arg8, %212] : memref<?x1100xf64>
          %219 = affine.apply #map1(%212)
          %220 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %221 = arith.mulf %arg3, %220 : f64
          %222 = affine.load %arg7[%arg9, %219] : memref<?x1100xf64>
          %223 = arith.mulf %221, %222 : f64
          %224 = affine.load %arg5[%arg8, %219] : memref<?x1100xf64>
          %225 = arith.addf %224, %223 : f64
          affine.store %225, %arg5[%arg8, %219] : memref<?x1100xf64>
          %226 = affine.apply #map2(%212)
          %227 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %228 = arith.mulf %arg3, %227 : f64
          %229 = affine.load %arg7[%arg9, %226] : memref<?x1100xf64>
          %230 = arith.mulf %228, %229 : f64
          %231 = affine.load %arg5[%arg8, %226] : memref<?x1100xf64>
          %232 = arith.addf %231, %230 : f64
          affine.store %232, %arg5[%arg8, %226] : memref<?x1100xf64>
          %233 = affine.apply #map13(%arg10)
          %234 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %235 = arith.mulf %arg3, %234 : f64
          %236 = affine.load %arg7[%arg9, %233] : memref<?x1100xf64>
          %237 = arith.mulf %235, %236 : f64
          %238 = affine.load %arg5[%arg8, %233] : memref<?x1100xf64>
          %239 = arith.addf %238, %237 : f64
          affine.store %239, %arg5[%arg8, %233] : memref<?x1100xf64>
          %240 = affine.apply #map1(%233)
          %241 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %242 = arith.mulf %arg3, %241 : f64
          %243 = affine.load %arg7[%arg9, %240] : memref<?x1100xf64>
          %244 = arith.mulf %242, %243 : f64
          %245 = affine.load %arg5[%arg8, %240] : memref<?x1100xf64>
          %246 = arith.addf %245, %244 : f64
          affine.store %246, %arg5[%arg8, %240] : memref<?x1100xf64>
          %247 = affine.apply #map2(%233)
          %248 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %249 = arith.mulf %arg3, %248 : f64
          %250 = affine.load %arg7[%arg9, %247] : memref<?x1100xf64>
          %251 = arith.mulf %249, %250 : f64
          %252 = affine.load %arg5[%arg8, %247] : memref<?x1100xf64>
          %253 = arith.addf %252, %251 : f64
          affine.store %253, %arg5[%arg8, %247] : memref<?x1100xf64>
          %254 = affine.apply #map14(%arg10)
          %255 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %256 = arith.mulf %arg3, %255 : f64
          %257 = affine.load %arg7[%arg9, %254] : memref<?x1100xf64>
          %258 = arith.mulf %256, %257 : f64
          %259 = affine.load %arg5[%arg8, %254] : memref<?x1100xf64>
          %260 = arith.addf %259, %258 : f64
          affine.store %260, %arg5[%arg8, %254] : memref<?x1100xf64>
          %261 = affine.apply #map1(%254)
          %262 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %263 = arith.mulf %arg3, %262 : f64
          %264 = affine.load %arg7[%arg9, %261] : memref<?x1100xf64>
          %265 = arith.mulf %263, %264 : f64
          %266 = affine.load %arg5[%arg8, %261] : memref<?x1100xf64>
          %267 = arith.addf %266, %265 : f64
          affine.store %267, %arg5[%arg8, %261] : memref<?x1100xf64>
          %268 = affine.apply #map2(%254)
          %269 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %270 = arith.mulf %arg3, %269 : f64
          %271 = affine.load %arg7[%arg9, %268] : memref<?x1100xf64>
          %272 = arith.mulf %270, %271 : f64
          %273 = affine.load %arg5[%arg8, %268] : memref<?x1100xf64>
          %274 = arith.addf %273, %272 : f64
          affine.store %274, %arg5[%arg8, %268] : memref<?x1100xf64>
        }
        affine.for %arg10 = #map()[%0] to #map15()[%0] step 3 {
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
        }
        affine.for %arg10 = #map15()[%0] to #map16()[%0] step 13 {
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
          %30 = affine.apply #map17(%arg10)
          %31 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %32 = arith.mulf %arg3, %31 : f64
          %33 = affine.load %arg7[%arg9, %30] : memref<?x1100xf64>
          %34 = arith.mulf %32, %33 : f64
          %35 = affine.load %arg5[%arg8, %30] : memref<?x1100xf64>
          %36 = arith.addf %35, %34 : f64
          affine.store %36, %arg5[%arg8, %30] : memref<?x1100xf64>
          %37 = affine.apply #map18(%arg10)
          %38 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %39 = arith.mulf %arg3, %38 : f64
          %40 = affine.load %arg7[%arg9, %37] : memref<?x1100xf64>
          %41 = arith.mulf %39, %40 : f64
          %42 = affine.load %arg5[%arg8, %37] : memref<?x1100xf64>
          %43 = arith.addf %42, %41 : f64
          affine.store %43, %arg5[%arg8, %37] : memref<?x1100xf64>
          %44 = affine.apply #map4(%arg10)
          %45 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %46 = arith.mulf %arg3, %45 : f64
          %47 = affine.load %arg7[%arg9, %44] : memref<?x1100xf64>
          %48 = arith.mulf %46, %47 : f64
          %49 = affine.load %arg5[%arg8, %44] : memref<?x1100xf64>
          %50 = arith.addf %49, %48 : f64
          affine.store %50, %arg5[%arg8, %44] : memref<?x1100xf64>
          %51 = affine.apply #map19(%arg10)
          %52 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %53 = arith.mulf %arg3, %52 : f64
          %54 = affine.load %arg7[%arg9, %51] : memref<?x1100xf64>
          %55 = arith.mulf %53, %54 : f64
          %56 = affine.load %arg5[%arg8, %51] : memref<?x1100xf64>
          %57 = arith.addf %56, %55 : f64
          affine.store %57, %arg5[%arg8, %51] : memref<?x1100xf64>
          %58 = affine.apply #map20(%arg10)
          %59 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %60 = arith.mulf %arg3, %59 : f64
          %61 = affine.load %arg7[%arg9, %58] : memref<?x1100xf64>
          %62 = arith.mulf %60, %61 : f64
          %63 = affine.load %arg5[%arg8, %58] : memref<?x1100xf64>
          %64 = arith.addf %63, %62 : f64
          affine.store %64, %arg5[%arg8, %58] : memref<?x1100xf64>
          %65 = affine.apply #map5(%arg10)
          %66 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %67 = arith.mulf %arg3, %66 : f64
          %68 = affine.load %arg7[%arg9, %65] : memref<?x1100xf64>
          %69 = arith.mulf %67, %68 : f64
          %70 = affine.load %arg5[%arg8, %65] : memref<?x1100xf64>
          %71 = arith.addf %70, %69 : f64
          affine.store %71, %arg5[%arg8, %65] : memref<?x1100xf64>
          %72 = affine.apply #map21(%arg10)
          %73 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %74 = arith.mulf %arg3, %73 : f64
          %75 = affine.load %arg7[%arg9, %72] : memref<?x1100xf64>
          %76 = arith.mulf %74, %75 : f64
          %77 = affine.load %arg5[%arg8, %72] : memref<?x1100xf64>
          %78 = arith.addf %77, %76 : f64
          affine.store %78, %arg5[%arg8, %72] : memref<?x1100xf64>
          %79 = affine.apply #map22(%arg10)
          %80 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %81 = arith.mulf %arg3, %80 : f64
          %82 = affine.load %arg7[%arg9, %79] : memref<?x1100xf64>
          %83 = arith.mulf %81, %82 : f64
          %84 = affine.load %arg5[%arg8, %79] : memref<?x1100xf64>
          %85 = arith.addf %84, %83 : f64
          affine.store %85, %arg5[%arg8, %79] : memref<?x1100xf64>
          %86 = affine.apply #map6(%arg10)
          %87 = affine.load %arg6[%arg8, %arg9] : memref<?x1200xf64>
          %88 = arith.mulf %arg3, %87 : f64
          %89 = affine.load %arg7[%arg9, %86] : memref<?x1100xf64>
          %90 = arith.mulf %88, %89 : f64
          %91 = affine.load %arg5[%arg8, %86] : memref<?x1100xf64>
          %92 = arith.addf %91, %90 : f64
          affine.store %92, %arg5[%arg8, %86] : memref<?x1100xf64>
        }
        affine.for %arg10 = #map16()[%0] to %0 {
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

