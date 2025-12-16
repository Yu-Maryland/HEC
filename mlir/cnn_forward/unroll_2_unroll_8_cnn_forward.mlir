#map = affine_map<()[s0] -> (((s0 floordiv 8) floordiv 2) * 16)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0 + 3)>
#map4 = affine_map<(d0) -> (d0 + 4)>
#map5 = affine_map<(d0) -> (d0 + 5)>
#map6 = affine_map<(d0) -> (d0 + 6)>
#map7 = affine_map<(d0) -> (d0 + 7)>
#map8 = affine_map<(d0) -> (d0 + 8)>
#map9 = affine_map<()[s0] -> ((s0 floordiv 8) * 8)>
#map10 = affine_map<()[s0] -> ((s0 floordiv 2) * 2)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>, #dlti.dl_entry<"dlti.endianness", "little">>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @cnn_forward(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32, %arg11: memref<?x40x9x9xf64>, %arg12: memref<?x75x6x6xf64>, %arg13: memref<?x75x50x50xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg2 : i32 to index
    %2 = arith.index_cast %arg3 : i32 to index
    %3 = arith.index_cast %arg4 : i32 to index
    %4 = arith.index_cast %arg5 : i32 to index
    %5 = arith.index_cast %arg6 : i32 to index
    %6 = arith.index_cast %arg9 : i32 to index
    %7 = arith.index_cast %arg0 : i32 to index
    affine.for %arg14 = 0 to %7 {
      affine.for %arg15 = 0 to %0 {
        affine.for %arg16 = 0 to %1 {
          affine.for %arg17 = 0 to %2 {
            affine.for %arg18 = 0 to %3 {
              affine.for %arg19 = 0 to %4 {
                affine.for %arg20 = 0 to #map()[%5] step 16 {
                  %8 = affine.load %arg12[%arg15, %arg18, %arg19, %arg20] : memref<?x75x6x6xf64>
                  %9 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%arg20 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %10 = arith.mulf %8, %9 : f64
                  %11 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %12 = arith.addf %11, %10 : f64
                  affine.store %12, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %13 = affine.apply #map1(%arg20)
                  %14 = affine.load %arg12[%arg15, %arg18, %arg19, %13] : memref<?x75x6x6xf64>
                  %15 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%13 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %16 = arith.mulf %14, %15 : f64
                  %17 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %18 = arith.addf %17, %16 : f64
                  affine.store %18, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %19 = affine.apply #map2(%arg20)
                  %20 = affine.load %arg12[%arg15, %arg18, %arg19, %19] : memref<?x75x6x6xf64>
                  %21 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%19 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %22 = arith.mulf %20, %21 : f64
                  %23 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %24 = arith.addf %23, %22 : f64
                  affine.store %24, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %25 = affine.apply #map3(%arg20)
                  %26 = affine.load %arg12[%arg15, %arg18, %arg19, %25] : memref<?x75x6x6xf64>
                  %27 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%25 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %28 = arith.mulf %26, %27 : f64
                  %29 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %30 = arith.addf %29, %28 : f64
                  affine.store %30, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %31 = affine.apply #map4(%arg20)
                  %32 = affine.load %arg12[%arg15, %arg18, %arg19, %31] : memref<?x75x6x6xf64>
                  %33 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%31 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %34 = arith.mulf %32, %33 : f64
                  %35 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %36 = arith.addf %35, %34 : f64
                  affine.store %36, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %37 = affine.apply #map5(%arg20)
                  %38 = affine.load %arg12[%arg15, %arg18, %arg19, %37] : memref<?x75x6x6xf64>
                  %39 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%37 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %40 = arith.mulf %38, %39 : f64
                  %41 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %42 = arith.addf %41, %40 : f64
                  affine.store %42, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %43 = affine.apply #map6(%arg20)
                  %44 = affine.load %arg12[%arg15, %arg18, %arg19, %43] : memref<?x75x6x6xf64>
                  %45 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%43 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %46 = arith.mulf %44, %45 : f64
                  %47 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %48 = arith.addf %47, %46 : f64
                  affine.store %48, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %49 = affine.apply #map7(%arg20)
                  %50 = affine.load %arg12[%arg15, %arg18, %arg19, %49] : memref<?x75x6x6xf64>
                  %51 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%49 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %52 = arith.mulf %50, %51 : f64
                  %53 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %54 = arith.addf %53, %52 : f64
                  affine.store %54, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %55 = affine.apply #map8(%arg20)
                  %56 = affine.load %arg12[%arg15, %arg18, %arg19, %55] : memref<?x75x6x6xf64>
                  %57 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%55 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %58 = arith.mulf %56, %57 : f64
                  %59 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %60 = arith.addf %59, %58 : f64
                  affine.store %60, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %61 = affine.apply #map1(%55)
                  %62 = affine.load %arg12[%arg15, %arg18, %arg19, %61] : memref<?x75x6x6xf64>
                  %63 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%61 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %64 = arith.mulf %62, %63 : f64
                  %65 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %66 = arith.addf %65, %64 : f64
                  affine.store %66, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %67 = affine.apply #map2(%55)
                  %68 = affine.load %arg12[%arg15, %arg18, %arg19, %67] : memref<?x75x6x6xf64>
                  %69 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%67 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %70 = arith.mulf %68, %69 : f64
                  %71 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %72 = arith.addf %71, %70 : f64
                  affine.store %72, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %73 = affine.apply #map3(%55)
                  %74 = affine.load %arg12[%arg15, %arg18, %arg19, %73] : memref<?x75x6x6xf64>
                  %75 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%73 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %76 = arith.mulf %74, %75 : f64
                  %77 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %78 = arith.addf %77, %76 : f64
                  affine.store %78, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %79 = affine.apply #map4(%55)
                  %80 = affine.load %arg12[%arg15, %arg18, %arg19, %79] : memref<?x75x6x6xf64>
                  %81 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%79 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %82 = arith.mulf %80, %81 : f64
                  %83 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %84 = arith.addf %83, %82 : f64
                  affine.store %84, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %85 = affine.apply #map5(%55)
                  %86 = affine.load %arg12[%arg15, %arg18, %arg19, %85] : memref<?x75x6x6xf64>
                  %87 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%85 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %88 = arith.mulf %86, %87 : f64
                  %89 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %90 = arith.addf %89, %88 : f64
                  affine.store %90, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %91 = affine.apply #map6(%55)
                  %92 = affine.load %arg12[%arg15, %arg18, %arg19, %91] : memref<?x75x6x6xf64>
                  %93 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%91 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %94 = arith.mulf %92, %93 : f64
                  %95 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %96 = arith.addf %95, %94 : f64
                  affine.store %96, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %97 = affine.apply #map7(%55)
                  %98 = affine.load %arg12[%arg15, %arg18, %arg19, %97] : memref<?x75x6x6xf64>
                  %99 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%97 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %100 = arith.mulf %98, %99 : f64
                  %101 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %102 = arith.addf %101, %100 : f64
                  affine.store %102, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                }
                affine.for %arg20 = #map()[%5] to #map9()[%5] step 8 {
                  %8 = affine.load %arg12[%arg15, %arg18, %arg19, %arg20] : memref<?x75x6x6xf64>
                  %9 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%arg20 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %10 = arith.mulf %8, %9 : f64
                  %11 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %12 = arith.addf %11, %10 : f64
                  affine.store %12, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %13 = affine.apply #map1(%arg20)
                  %14 = affine.load %arg12[%arg15, %arg18, %arg19, %13] : memref<?x75x6x6xf64>
                  %15 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%13 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %16 = arith.mulf %14, %15 : f64
                  %17 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %18 = arith.addf %17, %16 : f64
                  affine.store %18, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %19 = affine.apply #map2(%arg20)
                  %20 = affine.load %arg12[%arg15, %arg18, %arg19, %19] : memref<?x75x6x6xf64>
                  %21 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%19 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %22 = arith.mulf %20, %21 : f64
                  %23 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %24 = arith.addf %23, %22 : f64
                  affine.store %24, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %25 = affine.apply #map3(%arg20)
                  %26 = affine.load %arg12[%arg15, %arg18, %arg19, %25] : memref<?x75x6x6xf64>
                  %27 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%25 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %28 = arith.mulf %26, %27 : f64
                  %29 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %30 = arith.addf %29, %28 : f64
                  affine.store %30, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %31 = affine.apply #map4(%arg20)
                  %32 = affine.load %arg12[%arg15, %arg18, %arg19, %31] : memref<?x75x6x6xf64>
                  %33 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%31 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %34 = arith.mulf %32, %33 : f64
                  %35 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %36 = arith.addf %35, %34 : f64
                  affine.store %36, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %37 = affine.apply #map5(%arg20)
                  %38 = affine.load %arg12[%arg15, %arg18, %arg19, %37] : memref<?x75x6x6xf64>
                  %39 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%37 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %40 = arith.mulf %38, %39 : f64
                  %41 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %42 = arith.addf %41, %40 : f64
                  affine.store %42, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %43 = affine.apply #map6(%arg20)
                  %44 = affine.load %arg12[%arg15, %arg18, %arg19, %43] : memref<?x75x6x6xf64>
                  %45 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%43 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %46 = arith.mulf %44, %45 : f64
                  %47 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %48 = arith.addf %47, %46 : f64
                  affine.store %48, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %49 = affine.apply #map7(%arg20)
                  %50 = affine.load %arg12[%arg15, %arg18, %arg19, %49] : memref<?x75x6x6xf64>
                  %51 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%49 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %52 = arith.mulf %50, %51 : f64
                  %53 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %54 = arith.addf %53, %52 : f64
                  affine.store %54, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                }
                affine.for %arg20 = #map9()[%5] to #map10()[%5] step 2 {
                  %8 = affine.load %arg12[%arg15, %arg18, %arg19, %arg20] : memref<?x75x6x6xf64>
                  %9 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%arg20 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %10 = arith.mulf %8, %9 : f64
                  %11 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %12 = arith.addf %11, %10 : f64
                  affine.store %12, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %13 = affine.apply #map1(%arg20)
                  %14 = affine.load %arg12[%arg15, %arg18, %arg19, %13] : memref<?x75x6x6xf64>
                  %15 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%13 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %16 = arith.mulf %14, %15 : f64
                  %17 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %18 = arith.addf %17, %16 : f64
                  affine.store %18, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                }
                affine.for %arg20 = #map10()[%5] to %5 {
                  %8 = affine.load %arg12[%arg15, %arg18, %arg19, %arg20] : memref<?x75x6x6xf64>
                  %9 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%arg20 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %10 = arith.mulf %8, %9 : f64
                  %11 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %12 = arith.addf %11, %10 : f64
                  affine.store %12, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                }
              }
            }
          }
        }
      }
    }
    return
  }
}

