#map = affine_map<()[s0] -> (((s0 floordiv 7) floordiv 6) * 42)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0 + 3)>
#map4 = affine_map<(d0) -> (d0 + 4)>
#map5 = affine_map<(d0) -> (d0 + 5)>
#map6 = affine_map<(d0) -> (d0 + 6)>
#map7 = affine_map<(d0) -> (d0 + 7)>
#map8 = affine_map<(d0) -> (d0 + 14)>
#map9 = affine_map<(d0) -> (d0 + 21)>
#map10 = affine_map<(d0) -> (d0 + 28)>
#map11 = affine_map<(d0) -> (d0 + 35)>
#map12 = affine_map<()[s0] -> ((s0 floordiv 7) * 7)>
#map13 = affine_map<()[s0] -> ((s0 floordiv 7) * 7 + ((s0 mod 7) floordiv 6) * 6)>
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
                affine.for %arg20 = 0 to #map()[%5] step 42 {
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
                  %55 = affine.apply #map1(%49)
                  %56 = affine.load %arg12[%arg15, %arg18, %arg19, %55] : memref<?x75x6x6xf64>
                  %57 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%55 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %58 = arith.mulf %56, %57 : f64
                  %59 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %60 = arith.addf %59, %58 : f64
                  affine.store %60, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %61 = affine.apply #map2(%49)
                  %62 = affine.load %arg12[%arg15, %arg18, %arg19, %61] : memref<?x75x6x6xf64>
                  %63 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%61 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %64 = arith.mulf %62, %63 : f64
                  %65 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %66 = arith.addf %65, %64 : f64
                  affine.store %66, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %67 = affine.apply #map3(%49)
                  %68 = affine.load %arg12[%arg15, %arg18, %arg19, %67] : memref<?x75x6x6xf64>
                  %69 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%67 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %70 = arith.mulf %68, %69 : f64
                  %71 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %72 = arith.addf %71, %70 : f64
                  affine.store %72, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %73 = affine.apply #map4(%49)
                  %74 = affine.load %arg12[%arg15, %arg18, %arg19, %73] : memref<?x75x6x6xf64>
                  %75 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%73 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %76 = arith.mulf %74, %75 : f64
                  %77 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %78 = arith.addf %77, %76 : f64
                  affine.store %78, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %79 = affine.apply #map5(%49)
                  %80 = affine.load %arg12[%arg15, %arg18, %arg19, %79] : memref<?x75x6x6xf64>
                  %81 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%79 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %82 = arith.mulf %80, %81 : f64
                  %83 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %84 = arith.addf %83, %82 : f64
                  affine.store %84, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %85 = affine.apply #map6(%49)
                  %86 = affine.load %arg12[%arg15, %arg18, %arg19, %85] : memref<?x75x6x6xf64>
                  %87 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%85 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %88 = arith.mulf %86, %87 : f64
                  %89 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %90 = arith.addf %89, %88 : f64
                  affine.store %90, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %91 = affine.apply #map8(%arg20)
                  %92 = affine.load %arg12[%arg15, %arg18, %arg19, %91] : memref<?x75x6x6xf64>
                  %93 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%91 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %94 = arith.mulf %92, %93 : f64
                  %95 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %96 = arith.addf %95, %94 : f64
                  affine.store %96, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %97 = affine.apply #map1(%91)
                  %98 = affine.load %arg12[%arg15, %arg18, %arg19, %97] : memref<?x75x6x6xf64>
                  %99 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%97 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %100 = arith.mulf %98, %99 : f64
                  %101 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %102 = arith.addf %101, %100 : f64
                  affine.store %102, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %103 = affine.apply #map2(%91)
                  %104 = affine.load %arg12[%arg15, %arg18, %arg19, %103] : memref<?x75x6x6xf64>
                  %105 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%103 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %106 = arith.mulf %104, %105 : f64
                  %107 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %108 = arith.addf %107, %106 : f64
                  affine.store %108, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %109 = affine.apply #map3(%91)
                  %110 = affine.load %arg12[%arg15, %arg18, %arg19, %109] : memref<?x75x6x6xf64>
                  %111 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%109 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %112 = arith.mulf %110, %111 : f64
                  %113 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %114 = arith.addf %113, %112 : f64
                  affine.store %114, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %115 = affine.apply #map4(%91)
                  %116 = affine.load %arg12[%arg15, %arg18, %arg19, %115] : memref<?x75x6x6xf64>
                  %117 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%115 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %118 = arith.mulf %116, %117 : f64
                  %119 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %120 = arith.addf %119, %118 : f64
                  affine.store %120, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %121 = affine.apply #map5(%91)
                  %122 = affine.load %arg12[%arg15, %arg18, %arg19, %121] : memref<?x75x6x6xf64>
                  %123 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%121 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %124 = arith.mulf %122, %123 : f64
                  %125 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %126 = arith.addf %125, %124 : f64
                  affine.store %126, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %127 = affine.apply #map6(%91)
                  %128 = affine.load %arg12[%arg15, %arg18, %arg19, %127] : memref<?x75x6x6xf64>
                  %129 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%127 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %130 = arith.mulf %128, %129 : f64
                  %131 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %132 = arith.addf %131, %130 : f64
                  affine.store %132, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %133 = affine.apply #map9(%arg20)
                  %134 = affine.load %arg12[%arg15, %arg18, %arg19, %133] : memref<?x75x6x6xf64>
                  %135 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%133 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %136 = arith.mulf %134, %135 : f64
                  %137 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %138 = arith.addf %137, %136 : f64
                  affine.store %138, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %139 = affine.apply #map1(%133)
                  %140 = affine.load %arg12[%arg15, %arg18, %arg19, %139] : memref<?x75x6x6xf64>
                  %141 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%139 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %142 = arith.mulf %140, %141 : f64
                  %143 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %144 = arith.addf %143, %142 : f64
                  affine.store %144, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %145 = affine.apply #map2(%133)
                  %146 = affine.load %arg12[%arg15, %arg18, %arg19, %145] : memref<?x75x6x6xf64>
                  %147 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%145 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %148 = arith.mulf %146, %147 : f64
                  %149 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %150 = arith.addf %149, %148 : f64
                  affine.store %150, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %151 = affine.apply #map3(%133)
                  %152 = affine.load %arg12[%arg15, %arg18, %arg19, %151] : memref<?x75x6x6xf64>
                  %153 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%151 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %154 = arith.mulf %152, %153 : f64
                  %155 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %156 = arith.addf %155, %154 : f64
                  affine.store %156, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %157 = affine.apply #map4(%133)
                  %158 = affine.load %arg12[%arg15, %arg18, %arg19, %157] : memref<?x75x6x6xf64>
                  %159 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%157 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %160 = arith.mulf %158, %159 : f64
                  %161 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %162 = arith.addf %161, %160 : f64
                  affine.store %162, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %163 = affine.apply #map5(%133)
                  %164 = affine.load %arg12[%arg15, %arg18, %arg19, %163] : memref<?x75x6x6xf64>
                  %165 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%163 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %166 = arith.mulf %164, %165 : f64
                  %167 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %168 = arith.addf %167, %166 : f64
                  affine.store %168, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %169 = affine.apply #map6(%133)
                  %170 = affine.load %arg12[%arg15, %arg18, %arg19, %169] : memref<?x75x6x6xf64>
                  %171 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%169 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %172 = arith.mulf %170, %171 : f64
                  %173 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %174 = arith.addf %173, %172 : f64
                  affine.store %174, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %175 = affine.apply #map10(%arg20)
                  %176 = affine.load %arg12[%arg15, %arg18, %arg19, %175] : memref<?x75x6x6xf64>
                  %177 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%175 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %178 = arith.mulf %176, %177 : f64
                  %179 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %180 = arith.addf %179, %178 : f64
                  affine.store %180, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %181 = affine.apply #map1(%175)
                  %182 = affine.load %arg12[%arg15, %arg18, %arg19, %181] : memref<?x75x6x6xf64>
                  %183 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%181 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %184 = arith.mulf %182, %183 : f64
                  %185 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %186 = arith.addf %185, %184 : f64
                  affine.store %186, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %187 = affine.apply #map2(%175)
                  %188 = affine.load %arg12[%arg15, %arg18, %arg19, %187] : memref<?x75x6x6xf64>
                  %189 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%187 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %190 = arith.mulf %188, %189 : f64
                  %191 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %192 = arith.addf %191, %190 : f64
                  affine.store %192, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %193 = affine.apply #map3(%175)
                  %194 = affine.load %arg12[%arg15, %arg18, %arg19, %193] : memref<?x75x6x6xf64>
                  %195 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%193 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %196 = arith.mulf %194, %195 : f64
                  %197 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %198 = arith.addf %197, %196 : f64
                  affine.store %198, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %199 = affine.apply #map4(%175)
                  %200 = affine.load %arg12[%arg15, %arg18, %arg19, %199] : memref<?x75x6x6xf64>
                  %201 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%199 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %202 = arith.mulf %200, %201 : f64
                  %203 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %204 = arith.addf %203, %202 : f64
                  affine.store %204, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %205 = affine.apply #map5(%175)
                  %206 = affine.load %arg12[%arg15, %arg18, %arg19, %205] : memref<?x75x6x6xf64>
                  %207 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%205 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %208 = arith.mulf %206, %207 : f64
                  %209 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %210 = arith.addf %209, %208 : f64
                  affine.store %210, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %211 = affine.apply #map6(%175)
                  %212 = affine.load %arg12[%arg15, %arg18, %arg19, %211] : memref<?x75x6x6xf64>
                  %213 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%211 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %214 = arith.mulf %212, %213 : f64
                  %215 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %216 = arith.addf %215, %214 : f64
                  affine.store %216, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %217 = affine.apply #map11(%arg20)
                  %218 = affine.load %arg12[%arg15, %arg18, %arg19, %217] : memref<?x75x6x6xf64>
                  %219 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%217 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %220 = arith.mulf %218, %219 : f64
                  %221 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %222 = arith.addf %221, %220 : f64
                  affine.store %222, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %223 = affine.apply #map1(%217)
                  %224 = affine.load %arg12[%arg15, %arg18, %arg19, %223] : memref<?x75x6x6xf64>
                  %225 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%223 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %226 = arith.mulf %224, %225 : f64
                  %227 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %228 = arith.addf %227, %226 : f64
                  affine.store %228, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %229 = affine.apply #map2(%217)
                  %230 = affine.load %arg12[%arg15, %arg18, %arg19, %229] : memref<?x75x6x6xf64>
                  %231 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%229 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %232 = arith.mulf %230, %231 : f64
                  %233 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %234 = arith.addf %233, %232 : f64
                  affine.store %234, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %235 = affine.apply #map3(%217)
                  %236 = affine.load %arg12[%arg15, %arg18, %arg19, %235] : memref<?x75x6x6xf64>
                  %237 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%235 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %238 = arith.mulf %236, %237 : f64
                  %239 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %240 = arith.addf %239, %238 : f64
                  affine.store %240, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %241 = affine.apply #map4(%217)
                  %242 = affine.load %arg12[%arg15, %arg18, %arg19, %241] : memref<?x75x6x6xf64>
                  %243 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%241 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %244 = arith.mulf %242, %243 : f64
                  %245 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %246 = arith.addf %245, %244 : f64
                  affine.store %246, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %247 = affine.apply #map5(%217)
                  %248 = affine.load %arg12[%arg15, %arg18, %arg19, %247] : memref<?x75x6x6xf64>
                  %249 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%247 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %250 = arith.mulf %248, %249 : f64
                  %251 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %252 = arith.addf %251, %250 : f64
                  affine.store %252, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %253 = affine.apply #map6(%217)
                  %254 = affine.load %arg12[%arg15, %arg18, %arg19, %253] : memref<?x75x6x6xf64>
                  %255 = affine.load %arg13[%arg14, %arg18, -%arg19 + %arg16 * symbol(%6) + 5, -%253 + %arg17 * symbol(%6) + 5] : memref<?x75x50x50xf64>
                  %256 = arith.mulf %254, %255 : f64
                  %257 = affine.load %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                  %258 = arith.addf %257, %256 : f64
                  affine.store %258, %arg11[%arg14, %arg15, %arg16, %arg17] : memref<?x40x9x9xf64>
                }
                affine.for %arg20 = #map()[%5] to #map12()[%5] step 7 {
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
                }
                affine.for %arg20 = #map12()[%5] to #map13()[%5] step 6 {
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
                }
                affine.for %arg20 = #map13()[%5] to %5 {
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

