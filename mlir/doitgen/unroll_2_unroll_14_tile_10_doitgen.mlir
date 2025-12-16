#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 10, s0)>
#map2 = affine_map<()[s0] -> (((s0 floordiv 14) floordiv 2) * 28)>
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
#map15 = affine_map<(d0) -> (d0 + 13)>
#map16 = affine_map<(d0) -> (d0 + 14)>
#map17 = affine_map<()[s0] -> ((s0 floordiv 14) * 14)>
#map18 = affine_map<()[s0] -> ((s0 floordiv 2) * 2)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>, #dlti.dl_entry<"dlti.endianness", "little">>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_doitgen(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: memref<?x140x160xf64>, %arg4: memref<?x160xf64>, %arg5: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 0.000000e+00 : f64
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg2 : i32 to index
    %2 = arith.index_cast %arg0 : i32 to index
    affine.for %arg6 = 0 to %2 step 10 {
      affine.for %arg7 = 0 to %0 step 10 {
        affine.for %arg8 = #map(%arg6) to min #map1(%arg6)[%2] {
          affine.for %arg9 = #map(%arg7) to min #map1(%arg7)[%0] {
            affine.for %arg10 = 0 to %1 {
              affine.store %cst, %arg5[%arg10] : memref<?xf64>
              affine.for %arg11 = 0 to #map2()[%1] step 28 {
                %3 = affine.load %arg3[%arg8, %arg9, %arg11] : memref<?x140x160xf64>
                %4 = affine.load %arg4[%arg11, %arg10] : memref<?x160xf64>
                %5 = arith.mulf %3, %4 : f64
                %6 = affine.load %arg5[%arg10] : memref<?xf64>
                %7 = arith.addf %6, %5 : f64
                affine.store %7, %arg5[%arg10] : memref<?xf64>
                %8 = affine.apply #map3(%arg11)
                %9 = affine.load %arg3[%arg8, %arg9, %8] : memref<?x140x160xf64>
                %10 = affine.load %arg4[%8, %arg10] : memref<?x160xf64>
                %11 = arith.mulf %9, %10 : f64
                %12 = affine.load %arg5[%arg10] : memref<?xf64>
                %13 = arith.addf %12, %11 : f64
                affine.store %13, %arg5[%arg10] : memref<?xf64>
                %14 = affine.apply #map4(%arg11)
                %15 = affine.load %arg3[%arg8, %arg9, %14] : memref<?x140x160xf64>
                %16 = affine.load %arg4[%14, %arg10] : memref<?x160xf64>
                %17 = arith.mulf %15, %16 : f64
                %18 = affine.load %arg5[%arg10] : memref<?xf64>
                %19 = arith.addf %18, %17 : f64
                affine.store %19, %arg5[%arg10] : memref<?xf64>
                %20 = affine.apply #map5(%arg11)
                %21 = affine.load %arg3[%arg8, %arg9, %20] : memref<?x140x160xf64>
                %22 = affine.load %arg4[%20, %arg10] : memref<?x160xf64>
                %23 = arith.mulf %21, %22 : f64
                %24 = affine.load %arg5[%arg10] : memref<?xf64>
                %25 = arith.addf %24, %23 : f64
                affine.store %25, %arg5[%arg10] : memref<?xf64>
                %26 = affine.apply #map6(%arg11)
                %27 = affine.load %arg3[%arg8, %arg9, %26] : memref<?x140x160xf64>
                %28 = affine.load %arg4[%26, %arg10] : memref<?x160xf64>
                %29 = arith.mulf %27, %28 : f64
                %30 = affine.load %arg5[%arg10] : memref<?xf64>
                %31 = arith.addf %30, %29 : f64
                affine.store %31, %arg5[%arg10] : memref<?xf64>
                %32 = affine.apply #map7(%arg11)
                %33 = affine.load %arg3[%arg8, %arg9, %32] : memref<?x140x160xf64>
                %34 = affine.load %arg4[%32, %arg10] : memref<?x160xf64>
                %35 = arith.mulf %33, %34 : f64
                %36 = affine.load %arg5[%arg10] : memref<?xf64>
                %37 = arith.addf %36, %35 : f64
                affine.store %37, %arg5[%arg10] : memref<?xf64>
                %38 = affine.apply #map8(%arg11)
                %39 = affine.load %arg3[%arg8, %arg9, %38] : memref<?x140x160xf64>
                %40 = affine.load %arg4[%38, %arg10] : memref<?x160xf64>
                %41 = arith.mulf %39, %40 : f64
                %42 = affine.load %arg5[%arg10] : memref<?xf64>
                %43 = arith.addf %42, %41 : f64
                affine.store %43, %arg5[%arg10] : memref<?xf64>
                %44 = affine.apply #map9(%arg11)
                %45 = affine.load %arg3[%arg8, %arg9, %44] : memref<?x140x160xf64>
                %46 = affine.load %arg4[%44, %arg10] : memref<?x160xf64>
                %47 = arith.mulf %45, %46 : f64
                %48 = affine.load %arg5[%arg10] : memref<?xf64>
                %49 = arith.addf %48, %47 : f64
                affine.store %49, %arg5[%arg10] : memref<?xf64>
                %50 = affine.apply #map10(%arg11)
                %51 = affine.load %arg3[%arg8, %arg9, %50] : memref<?x140x160xf64>
                %52 = affine.load %arg4[%50, %arg10] : memref<?x160xf64>
                %53 = arith.mulf %51, %52 : f64
                %54 = affine.load %arg5[%arg10] : memref<?xf64>
                %55 = arith.addf %54, %53 : f64
                affine.store %55, %arg5[%arg10] : memref<?xf64>
                %56 = affine.apply #map11(%arg11)
                %57 = affine.load %arg3[%arg8, %arg9, %56] : memref<?x140x160xf64>
                %58 = affine.load %arg4[%56, %arg10] : memref<?x160xf64>
                %59 = arith.mulf %57, %58 : f64
                %60 = affine.load %arg5[%arg10] : memref<?xf64>
                %61 = arith.addf %60, %59 : f64
                affine.store %61, %arg5[%arg10] : memref<?xf64>
                %62 = affine.apply #map12(%arg11)
                %63 = affine.load %arg3[%arg8, %arg9, %62] : memref<?x140x160xf64>
                %64 = affine.load %arg4[%62, %arg10] : memref<?x160xf64>
                %65 = arith.mulf %63, %64 : f64
                %66 = affine.load %arg5[%arg10] : memref<?xf64>
                %67 = arith.addf %66, %65 : f64
                affine.store %67, %arg5[%arg10] : memref<?xf64>
                %68 = affine.apply #map13(%arg11)
                %69 = affine.load %arg3[%arg8, %arg9, %68] : memref<?x140x160xf64>
                %70 = affine.load %arg4[%68, %arg10] : memref<?x160xf64>
                %71 = arith.mulf %69, %70 : f64
                %72 = affine.load %arg5[%arg10] : memref<?xf64>
                %73 = arith.addf %72, %71 : f64
                affine.store %73, %arg5[%arg10] : memref<?xf64>
                %74 = affine.apply #map14(%arg11)
                %75 = affine.load %arg3[%arg8, %arg9, %74] : memref<?x140x160xf64>
                %76 = affine.load %arg4[%74, %arg10] : memref<?x160xf64>
                %77 = arith.mulf %75, %76 : f64
                %78 = affine.load %arg5[%arg10] : memref<?xf64>
                %79 = arith.addf %78, %77 : f64
                affine.store %79, %arg5[%arg10] : memref<?xf64>
                %80 = affine.apply #map15(%arg11)
                %81 = affine.load %arg3[%arg8, %arg9, %80] : memref<?x140x160xf64>
                %82 = affine.load %arg4[%80, %arg10] : memref<?x160xf64>
                %83 = arith.mulf %81, %82 : f64
                %84 = affine.load %arg5[%arg10] : memref<?xf64>
                %85 = arith.addf %84, %83 : f64
                affine.store %85, %arg5[%arg10] : memref<?xf64>
                %86 = affine.apply #map16(%arg11)
                %87 = affine.load %arg3[%arg8, %arg9, %86] : memref<?x140x160xf64>
                %88 = affine.load %arg4[%86, %arg10] : memref<?x160xf64>
                %89 = arith.mulf %87, %88 : f64
                %90 = affine.load %arg5[%arg10] : memref<?xf64>
                %91 = arith.addf %90, %89 : f64
                affine.store %91, %arg5[%arg10] : memref<?xf64>
                %92 = affine.apply #map3(%86)
                %93 = affine.load %arg3[%arg8, %arg9, %92] : memref<?x140x160xf64>
                %94 = affine.load %arg4[%92, %arg10] : memref<?x160xf64>
                %95 = arith.mulf %93, %94 : f64
                %96 = affine.load %arg5[%arg10] : memref<?xf64>
                %97 = arith.addf %96, %95 : f64
                affine.store %97, %arg5[%arg10] : memref<?xf64>
                %98 = affine.apply #map4(%86)
                %99 = affine.load %arg3[%arg8, %arg9, %98] : memref<?x140x160xf64>
                %100 = affine.load %arg4[%98, %arg10] : memref<?x160xf64>
                %101 = arith.mulf %99, %100 : f64
                %102 = affine.load %arg5[%arg10] : memref<?xf64>
                %103 = arith.addf %102, %101 : f64
                affine.store %103, %arg5[%arg10] : memref<?xf64>
                %104 = affine.apply #map5(%86)
                %105 = affine.load %arg3[%arg8, %arg9, %104] : memref<?x140x160xf64>
                %106 = affine.load %arg4[%104, %arg10] : memref<?x160xf64>
                %107 = arith.mulf %105, %106 : f64
                %108 = affine.load %arg5[%arg10] : memref<?xf64>
                %109 = arith.addf %108, %107 : f64
                affine.store %109, %arg5[%arg10] : memref<?xf64>
                %110 = affine.apply #map6(%86)
                %111 = affine.load %arg3[%arg8, %arg9, %110] : memref<?x140x160xf64>
                %112 = affine.load %arg4[%110, %arg10] : memref<?x160xf64>
                %113 = arith.mulf %111, %112 : f64
                %114 = affine.load %arg5[%arg10] : memref<?xf64>
                %115 = arith.addf %114, %113 : f64
                affine.store %115, %arg5[%arg10] : memref<?xf64>
                %116 = affine.apply #map7(%86)
                %117 = affine.load %arg3[%arg8, %arg9, %116] : memref<?x140x160xf64>
                %118 = affine.load %arg4[%116, %arg10] : memref<?x160xf64>
                %119 = arith.mulf %117, %118 : f64
                %120 = affine.load %arg5[%arg10] : memref<?xf64>
                %121 = arith.addf %120, %119 : f64
                affine.store %121, %arg5[%arg10] : memref<?xf64>
                %122 = affine.apply #map8(%86)
                %123 = affine.load %arg3[%arg8, %arg9, %122] : memref<?x140x160xf64>
                %124 = affine.load %arg4[%122, %arg10] : memref<?x160xf64>
                %125 = arith.mulf %123, %124 : f64
                %126 = affine.load %arg5[%arg10] : memref<?xf64>
                %127 = arith.addf %126, %125 : f64
                affine.store %127, %arg5[%arg10] : memref<?xf64>
                %128 = affine.apply #map9(%86)
                %129 = affine.load %arg3[%arg8, %arg9, %128] : memref<?x140x160xf64>
                %130 = affine.load %arg4[%128, %arg10] : memref<?x160xf64>
                %131 = arith.mulf %129, %130 : f64
                %132 = affine.load %arg5[%arg10] : memref<?xf64>
                %133 = arith.addf %132, %131 : f64
                affine.store %133, %arg5[%arg10] : memref<?xf64>
                %134 = affine.apply #map10(%86)
                %135 = affine.load %arg3[%arg8, %arg9, %134] : memref<?x140x160xf64>
                %136 = affine.load %arg4[%134, %arg10] : memref<?x160xf64>
                %137 = arith.mulf %135, %136 : f64
                %138 = affine.load %arg5[%arg10] : memref<?xf64>
                %139 = arith.addf %138, %137 : f64
                affine.store %139, %arg5[%arg10] : memref<?xf64>
                %140 = affine.apply #map11(%86)
                %141 = affine.load %arg3[%arg8, %arg9, %140] : memref<?x140x160xf64>
                %142 = affine.load %arg4[%140, %arg10] : memref<?x160xf64>
                %143 = arith.mulf %141, %142 : f64
                %144 = affine.load %arg5[%arg10] : memref<?xf64>
                %145 = arith.addf %144, %143 : f64
                affine.store %145, %arg5[%arg10] : memref<?xf64>
                %146 = affine.apply #map12(%86)
                %147 = affine.load %arg3[%arg8, %arg9, %146] : memref<?x140x160xf64>
                %148 = affine.load %arg4[%146, %arg10] : memref<?x160xf64>
                %149 = arith.mulf %147, %148 : f64
                %150 = affine.load %arg5[%arg10] : memref<?xf64>
                %151 = arith.addf %150, %149 : f64
                affine.store %151, %arg5[%arg10] : memref<?xf64>
                %152 = affine.apply #map13(%86)
                %153 = affine.load %arg3[%arg8, %arg9, %152] : memref<?x140x160xf64>
                %154 = affine.load %arg4[%152, %arg10] : memref<?x160xf64>
                %155 = arith.mulf %153, %154 : f64
                %156 = affine.load %arg5[%arg10] : memref<?xf64>
                %157 = arith.addf %156, %155 : f64
                affine.store %157, %arg5[%arg10] : memref<?xf64>
                %158 = affine.apply #map14(%86)
                %159 = affine.load %arg3[%arg8, %arg9, %158] : memref<?x140x160xf64>
                %160 = affine.load %arg4[%158, %arg10] : memref<?x160xf64>
                %161 = arith.mulf %159, %160 : f64
                %162 = affine.load %arg5[%arg10] : memref<?xf64>
                %163 = arith.addf %162, %161 : f64
                affine.store %163, %arg5[%arg10] : memref<?xf64>
                %164 = affine.apply #map15(%86)
                %165 = affine.load %arg3[%arg8, %arg9, %164] : memref<?x140x160xf64>
                %166 = affine.load %arg4[%164, %arg10] : memref<?x160xf64>
                %167 = arith.mulf %165, %166 : f64
                %168 = affine.load %arg5[%arg10] : memref<?xf64>
                %169 = arith.addf %168, %167 : f64
                affine.store %169, %arg5[%arg10] : memref<?xf64>
              }
              affine.for %arg11 = #map2()[%1] to #map17()[%1] step 14 {
                %3 = affine.load %arg3[%arg8, %arg9, %arg11] : memref<?x140x160xf64>
                %4 = affine.load %arg4[%arg11, %arg10] : memref<?x160xf64>
                %5 = arith.mulf %3, %4 : f64
                %6 = affine.load %arg5[%arg10] : memref<?xf64>
                %7 = arith.addf %6, %5 : f64
                affine.store %7, %arg5[%arg10] : memref<?xf64>
                %8 = affine.apply #map3(%arg11)
                %9 = affine.load %arg3[%arg8, %arg9, %8] : memref<?x140x160xf64>
                %10 = affine.load %arg4[%8, %arg10] : memref<?x160xf64>
                %11 = arith.mulf %9, %10 : f64
                %12 = affine.load %arg5[%arg10] : memref<?xf64>
                %13 = arith.addf %12, %11 : f64
                affine.store %13, %arg5[%arg10] : memref<?xf64>
                %14 = affine.apply #map4(%arg11)
                %15 = affine.load %arg3[%arg8, %arg9, %14] : memref<?x140x160xf64>
                %16 = affine.load %arg4[%14, %arg10] : memref<?x160xf64>
                %17 = arith.mulf %15, %16 : f64
                %18 = affine.load %arg5[%arg10] : memref<?xf64>
                %19 = arith.addf %18, %17 : f64
                affine.store %19, %arg5[%arg10] : memref<?xf64>
                %20 = affine.apply #map5(%arg11)
                %21 = affine.load %arg3[%arg8, %arg9, %20] : memref<?x140x160xf64>
                %22 = affine.load %arg4[%20, %arg10] : memref<?x160xf64>
                %23 = arith.mulf %21, %22 : f64
                %24 = affine.load %arg5[%arg10] : memref<?xf64>
                %25 = arith.addf %24, %23 : f64
                affine.store %25, %arg5[%arg10] : memref<?xf64>
                %26 = affine.apply #map6(%arg11)
                %27 = affine.load %arg3[%arg8, %arg9, %26] : memref<?x140x160xf64>
                %28 = affine.load %arg4[%26, %arg10] : memref<?x160xf64>
                %29 = arith.mulf %27, %28 : f64
                %30 = affine.load %arg5[%arg10] : memref<?xf64>
                %31 = arith.addf %30, %29 : f64
                affine.store %31, %arg5[%arg10] : memref<?xf64>
                %32 = affine.apply #map7(%arg11)
                %33 = affine.load %arg3[%arg8, %arg9, %32] : memref<?x140x160xf64>
                %34 = affine.load %arg4[%32, %arg10] : memref<?x160xf64>
                %35 = arith.mulf %33, %34 : f64
                %36 = affine.load %arg5[%arg10] : memref<?xf64>
                %37 = arith.addf %36, %35 : f64
                affine.store %37, %arg5[%arg10] : memref<?xf64>
                %38 = affine.apply #map8(%arg11)
                %39 = affine.load %arg3[%arg8, %arg9, %38] : memref<?x140x160xf64>
                %40 = affine.load %arg4[%38, %arg10] : memref<?x160xf64>
                %41 = arith.mulf %39, %40 : f64
                %42 = affine.load %arg5[%arg10] : memref<?xf64>
                %43 = arith.addf %42, %41 : f64
                affine.store %43, %arg5[%arg10] : memref<?xf64>
                %44 = affine.apply #map9(%arg11)
                %45 = affine.load %arg3[%arg8, %arg9, %44] : memref<?x140x160xf64>
                %46 = affine.load %arg4[%44, %arg10] : memref<?x160xf64>
                %47 = arith.mulf %45, %46 : f64
                %48 = affine.load %arg5[%arg10] : memref<?xf64>
                %49 = arith.addf %48, %47 : f64
                affine.store %49, %arg5[%arg10] : memref<?xf64>
                %50 = affine.apply #map10(%arg11)
                %51 = affine.load %arg3[%arg8, %arg9, %50] : memref<?x140x160xf64>
                %52 = affine.load %arg4[%50, %arg10] : memref<?x160xf64>
                %53 = arith.mulf %51, %52 : f64
                %54 = affine.load %arg5[%arg10] : memref<?xf64>
                %55 = arith.addf %54, %53 : f64
                affine.store %55, %arg5[%arg10] : memref<?xf64>
                %56 = affine.apply #map11(%arg11)
                %57 = affine.load %arg3[%arg8, %arg9, %56] : memref<?x140x160xf64>
                %58 = affine.load %arg4[%56, %arg10] : memref<?x160xf64>
                %59 = arith.mulf %57, %58 : f64
                %60 = affine.load %arg5[%arg10] : memref<?xf64>
                %61 = arith.addf %60, %59 : f64
                affine.store %61, %arg5[%arg10] : memref<?xf64>
                %62 = affine.apply #map12(%arg11)
                %63 = affine.load %arg3[%arg8, %arg9, %62] : memref<?x140x160xf64>
                %64 = affine.load %arg4[%62, %arg10] : memref<?x160xf64>
                %65 = arith.mulf %63, %64 : f64
                %66 = affine.load %arg5[%arg10] : memref<?xf64>
                %67 = arith.addf %66, %65 : f64
                affine.store %67, %arg5[%arg10] : memref<?xf64>
                %68 = affine.apply #map13(%arg11)
                %69 = affine.load %arg3[%arg8, %arg9, %68] : memref<?x140x160xf64>
                %70 = affine.load %arg4[%68, %arg10] : memref<?x160xf64>
                %71 = arith.mulf %69, %70 : f64
                %72 = affine.load %arg5[%arg10] : memref<?xf64>
                %73 = arith.addf %72, %71 : f64
                affine.store %73, %arg5[%arg10] : memref<?xf64>
                %74 = affine.apply #map14(%arg11)
                %75 = affine.load %arg3[%arg8, %arg9, %74] : memref<?x140x160xf64>
                %76 = affine.load %arg4[%74, %arg10] : memref<?x160xf64>
                %77 = arith.mulf %75, %76 : f64
                %78 = affine.load %arg5[%arg10] : memref<?xf64>
                %79 = arith.addf %78, %77 : f64
                affine.store %79, %arg5[%arg10] : memref<?xf64>
                %80 = affine.apply #map15(%arg11)
                %81 = affine.load %arg3[%arg8, %arg9, %80] : memref<?x140x160xf64>
                %82 = affine.load %arg4[%80, %arg10] : memref<?x160xf64>
                %83 = arith.mulf %81, %82 : f64
                %84 = affine.load %arg5[%arg10] : memref<?xf64>
                %85 = arith.addf %84, %83 : f64
                affine.store %85, %arg5[%arg10] : memref<?xf64>
              }
              affine.for %arg11 = #map17()[%1] to #map18()[%1] step 2 {
                %3 = affine.load %arg3[%arg8, %arg9, %arg11] : memref<?x140x160xf64>
                %4 = affine.load %arg4[%arg11, %arg10] : memref<?x160xf64>
                %5 = arith.mulf %3, %4 : f64
                %6 = affine.load %arg5[%arg10] : memref<?xf64>
                %7 = arith.addf %6, %5 : f64
                affine.store %7, %arg5[%arg10] : memref<?xf64>
                %8 = affine.apply #map3(%arg11)
                %9 = affine.load %arg3[%arg8, %arg9, %8] : memref<?x140x160xf64>
                %10 = affine.load %arg4[%8, %arg10] : memref<?x160xf64>
                %11 = arith.mulf %9, %10 : f64
                %12 = affine.load %arg5[%arg10] : memref<?xf64>
                %13 = arith.addf %12, %11 : f64
                affine.store %13, %arg5[%arg10] : memref<?xf64>
              }
              affine.for %arg11 = #map18()[%1] to %1 {
                %3 = affine.load %arg3[%arg8, %arg9, %arg11] : memref<?x140x160xf64>
                %4 = affine.load %arg4[%arg11, %arg10] : memref<?x160xf64>
                %5 = arith.mulf %3, %4 : f64
                %6 = affine.load %arg5[%arg10] : memref<?xf64>
                %7 = arith.addf %6, %5 : f64
                affine.store %7, %arg5[%arg10] : memref<?xf64>
              }
            }
            affine.for %arg10 = 0 to #map2()[%1] step 28 {
              %3 = affine.load %arg5[%arg10] : memref<?xf64>
              affine.store %3, %arg3[%arg8, %arg9, %arg10] : memref<?x140x160xf64>
              %4 = affine.apply #map3(%arg10)
              %5 = affine.load %arg5[%4] : memref<?xf64>
              affine.store %5, %arg3[%arg8, %arg9, %4] : memref<?x140x160xf64>
              %6 = affine.apply #map4(%arg10)
              %7 = affine.load %arg5[%6] : memref<?xf64>
              affine.store %7, %arg3[%arg8, %arg9, %6] : memref<?x140x160xf64>
              %8 = affine.apply #map5(%arg10)
              %9 = affine.load %arg5[%8] : memref<?xf64>
              affine.store %9, %arg3[%arg8, %arg9, %8] : memref<?x140x160xf64>
              %10 = affine.apply #map6(%arg10)
              %11 = affine.load %arg5[%10] : memref<?xf64>
              affine.store %11, %arg3[%arg8, %arg9, %10] : memref<?x140x160xf64>
              %12 = affine.apply #map7(%arg10)
              %13 = affine.load %arg5[%12] : memref<?xf64>
              affine.store %13, %arg3[%arg8, %arg9, %12] : memref<?x140x160xf64>
              %14 = affine.apply #map8(%arg10)
              %15 = affine.load %arg5[%14] : memref<?xf64>
              affine.store %15, %arg3[%arg8, %arg9, %14] : memref<?x140x160xf64>
              %16 = affine.apply #map9(%arg10)
              %17 = affine.load %arg5[%16] : memref<?xf64>
              affine.store %17, %arg3[%arg8, %arg9, %16] : memref<?x140x160xf64>
              %18 = affine.apply #map10(%arg10)
              %19 = affine.load %arg5[%18] : memref<?xf64>
              affine.store %19, %arg3[%arg8, %arg9, %18] : memref<?x140x160xf64>
              %20 = affine.apply #map11(%arg10)
              %21 = affine.load %arg5[%20] : memref<?xf64>
              affine.store %21, %arg3[%arg8, %arg9, %20] : memref<?x140x160xf64>
              %22 = affine.apply #map12(%arg10)
              %23 = affine.load %arg5[%22] : memref<?xf64>
              affine.store %23, %arg3[%arg8, %arg9, %22] : memref<?x140x160xf64>
              %24 = affine.apply #map13(%arg10)
              %25 = affine.load %arg5[%24] : memref<?xf64>
              affine.store %25, %arg3[%arg8, %arg9, %24] : memref<?x140x160xf64>
              %26 = affine.apply #map14(%arg10)
              %27 = affine.load %arg5[%26] : memref<?xf64>
              affine.store %27, %arg3[%arg8, %arg9, %26] : memref<?x140x160xf64>
              %28 = affine.apply #map15(%arg10)
              %29 = affine.load %arg5[%28] : memref<?xf64>
              affine.store %29, %arg3[%arg8, %arg9, %28] : memref<?x140x160xf64>
              %30 = affine.apply #map16(%arg10)
              %31 = affine.load %arg5[%30] : memref<?xf64>
              affine.store %31, %arg3[%arg8, %arg9, %30] : memref<?x140x160xf64>
              %32 = affine.apply #map3(%30)
              %33 = affine.load %arg5[%32] : memref<?xf64>
              affine.store %33, %arg3[%arg8, %arg9, %32] : memref<?x140x160xf64>
              %34 = affine.apply #map4(%30)
              %35 = affine.load %arg5[%34] : memref<?xf64>
              affine.store %35, %arg3[%arg8, %arg9, %34] : memref<?x140x160xf64>
              %36 = affine.apply #map5(%30)
              %37 = affine.load %arg5[%36] : memref<?xf64>
              affine.store %37, %arg3[%arg8, %arg9, %36] : memref<?x140x160xf64>
              %38 = affine.apply #map6(%30)
              %39 = affine.load %arg5[%38] : memref<?xf64>
              affine.store %39, %arg3[%arg8, %arg9, %38] : memref<?x140x160xf64>
              %40 = affine.apply #map7(%30)
              %41 = affine.load %arg5[%40] : memref<?xf64>
              affine.store %41, %arg3[%arg8, %arg9, %40] : memref<?x140x160xf64>
              %42 = affine.apply #map8(%30)
              %43 = affine.load %arg5[%42] : memref<?xf64>
              affine.store %43, %arg3[%arg8, %arg9, %42] : memref<?x140x160xf64>
              %44 = affine.apply #map9(%30)
              %45 = affine.load %arg5[%44] : memref<?xf64>
              affine.store %45, %arg3[%arg8, %arg9, %44] : memref<?x140x160xf64>
              %46 = affine.apply #map10(%30)
              %47 = affine.load %arg5[%46] : memref<?xf64>
              affine.store %47, %arg3[%arg8, %arg9, %46] : memref<?x140x160xf64>
              %48 = affine.apply #map11(%30)
              %49 = affine.load %arg5[%48] : memref<?xf64>
              affine.store %49, %arg3[%arg8, %arg9, %48] : memref<?x140x160xf64>
              %50 = affine.apply #map12(%30)
              %51 = affine.load %arg5[%50] : memref<?xf64>
              affine.store %51, %arg3[%arg8, %arg9, %50] : memref<?x140x160xf64>
              %52 = affine.apply #map13(%30)
              %53 = affine.load %arg5[%52] : memref<?xf64>
              affine.store %53, %arg3[%arg8, %arg9, %52] : memref<?x140x160xf64>
              %54 = affine.apply #map14(%30)
              %55 = affine.load %arg5[%54] : memref<?xf64>
              affine.store %55, %arg3[%arg8, %arg9, %54] : memref<?x140x160xf64>
              %56 = affine.apply #map15(%30)
              %57 = affine.load %arg5[%56] : memref<?xf64>
              affine.store %57, %arg3[%arg8, %arg9, %56] : memref<?x140x160xf64>
            }
            affine.for %arg10 = #map2()[%1] to #map17()[%1] step 14 {
              %3 = affine.load %arg5[%arg10] : memref<?xf64>
              affine.store %3, %arg3[%arg8, %arg9, %arg10] : memref<?x140x160xf64>
              %4 = affine.apply #map3(%arg10)
              %5 = affine.load %arg5[%4] : memref<?xf64>
              affine.store %5, %arg3[%arg8, %arg9, %4] : memref<?x140x160xf64>
              %6 = affine.apply #map4(%arg10)
              %7 = affine.load %arg5[%6] : memref<?xf64>
              affine.store %7, %arg3[%arg8, %arg9, %6] : memref<?x140x160xf64>
              %8 = affine.apply #map5(%arg10)
              %9 = affine.load %arg5[%8] : memref<?xf64>
              affine.store %9, %arg3[%arg8, %arg9, %8] : memref<?x140x160xf64>
              %10 = affine.apply #map6(%arg10)
              %11 = affine.load %arg5[%10] : memref<?xf64>
              affine.store %11, %arg3[%arg8, %arg9, %10] : memref<?x140x160xf64>
              %12 = affine.apply #map7(%arg10)
              %13 = affine.load %arg5[%12] : memref<?xf64>
              affine.store %13, %arg3[%arg8, %arg9, %12] : memref<?x140x160xf64>
              %14 = affine.apply #map8(%arg10)
              %15 = affine.load %arg5[%14] : memref<?xf64>
              affine.store %15, %arg3[%arg8, %arg9, %14] : memref<?x140x160xf64>
              %16 = affine.apply #map9(%arg10)
              %17 = affine.load %arg5[%16] : memref<?xf64>
              affine.store %17, %arg3[%arg8, %arg9, %16] : memref<?x140x160xf64>
              %18 = affine.apply #map10(%arg10)
              %19 = affine.load %arg5[%18] : memref<?xf64>
              affine.store %19, %arg3[%arg8, %arg9, %18] : memref<?x140x160xf64>
              %20 = affine.apply #map11(%arg10)
              %21 = affine.load %arg5[%20] : memref<?xf64>
              affine.store %21, %arg3[%arg8, %arg9, %20] : memref<?x140x160xf64>
              %22 = affine.apply #map12(%arg10)
              %23 = affine.load %arg5[%22] : memref<?xf64>
              affine.store %23, %arg3[%arg8, %arg9, %22] : memref<?x140x160xf64>
              %24 = affine.apply #map13(%arg10)
              %25 = affine.load %arg5[%24] : memref<?xf64>
              affine.store %25, %arg3[%arg8, %arg9, %24] : memref<?x140x160xf64>
              %26 = affine.apply #map14(%arg10)
              %27 = affine.load %arg5[%26] : memref<?xf64>
              affine.store %27, %arg3[%arg8, %arg9, %26] : memref<?x140x160xf64>
              %28 = affine.apply #map15(%arg10)
              %29 = affine.load %arg5[%28] : memref<?xf64>
              affine.store %29, %arg3[%arg8, %arg9, %28] : memref<?x140x160xf64>
            }
            affine.for %arg10 = #map17()[%1] to #map18()[%1] step 2 {
              %3 = affine.load %arg5[%arg10] : memref<?xf64>
              affine.store %3, %arg3[%arg8, %arg9, %arg10] : memref<?x140x160xf64>
              %4 = affine.apply #map3(%arg10)
              %5 = affine.load %arg5[%4] : memref<?xf64>
              affine.store %5, %arg3[%arg8, %arg9, %4] : memref<?x140x160xf64>
            }
            affine.for %arg10 = #map18()[%1] to %1 {
              %3 = affine.load %arg5[%arg10] : memref<?xf64>
              affine.store %3, %arg3[%arg8, %arg9, %arg10] : memref<?x140x160xf64>
            }
          }
        }
      }
    }
    return
  }
}

