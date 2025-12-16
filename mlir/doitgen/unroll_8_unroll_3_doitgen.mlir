#map = affine_map<()[s0] -> (((s0 floordiv 3) floordiv 8) * 24)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0 + 3)>
#map4 = affine_map<(d0) -> (d0 + 6)>
#map5 = affine_map<(d0) -> (d0 + 9)>
#map6 = affine_map<(d0) -> (d0 + 12)>
#map7 = affine_map<(d0) -> (d0 + 15)>
#map8 = affine_map<(d0) -> (d0 + 18)>
#map9 = affine_map<(d0) -> (d0 + 21)>
#map10 = affine_map<()[s0] -> ((s0 floordiv 3) * 3)>
#map11 = affine_map<()[s0] -> ((s0 floordiv 3) * 3 + ((s0 mod 3) floordiv 8) * 8)>
#map12 = affine_map<(d0) -> (d0 + 4)>
#map13 = affine_map<(d0) -> (d0 + 5)>
#map14 = affine_map<(d0) -> (d0 + 7)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>, #dlti.dl_entry<"dlti.endianness", "little">>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_doitgen(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: memref<?x140x160xf64>, %arg4: memref<?x160xf64>, %arg5: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 0.000000e+00 : f64
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg2 : i32 to index
    %2 = arith.index_cast %arg0 : i32 to index
    affine.for %arg6 = 0 to %2 {
      affine.for %arg7 = 0 to %0 {
        affine.for %arg8 = 0 to %1 {
          affine.store %cst, %arg5[%arg8] : memref<?xf64>
          affine.for %arg9 = 0 to #map()[%1] step 24 {
            %3 = affine.load %arg3[%arg6, %arg7, %arg9] : memref<?x140x160xf64>
            %4 = affine.load %arg4[%arg9, %arg8] : memref<?x160xf64>
            %5 = arith.mulf %3, %4 : f64
            %6 = affine.load %arg5[%arg8] : memref<?xf64>
            %7 = arith.addf %6, %5 : f64
            affine.store %7, %arg5[%arg8] : memref<?xf64>
            %8 = affine.apply #map1(%arg9)
            %9 = affine.load %arg3[%arg6, %arg7, %8] : memref<?x140x160xf64>
            %10 = affine.load %arg4[%8, %arg8] : memref<?x160xf64>
            %11 = arith.mulf %9, %10 : f64
            %12 = affine.load %arg5[%arg8] : memref<?xf64>
            %13 = arith.addf %12, %11 : f64
            affine.store %13, %arg5[%arg8] : memref<?xf64>
            %14 = affine.apply #map2(%arg9)
            %15 = affine.load %arg3[%arg6, %arg7, %14] : memref<?x140x160xf64>
            %16 = affine.load %arg4[%14, %arg8] : memref<?x160xf64>
            %17 = arith.mulf %15, %16 : f64
            %18 = affine.load %arg5[%arg8] : memref<?xf64>
            %19 = arith.addf %18, %17 : f64
            affine.store %19, %arg5[%arg8] : memref<?xf64>
            %20 = affine.apply #map3(%arg9)
            %21 = affine.load %arg3[%arg6, %arg7, %20] : memref<?x140x160xf64>
            %22 = affine.load %arg4[%20, %arg8] : memref<?x160xf64>
            %23 = arith.mulf %21, %22 : f64
            %24 = affine.load %arg5[%arg8] : memref<?xf64>
            %25 = arith.addf %24, %23 : f64
            affine.store %25, %arg5[%arg8] : memref<?xf64>
            %26 = affine.apply #map1(%20)
            %27 = affine.load %arg3[%arg6, %arg7, %26] : memref<?x140x160xf64>
            %28 = affine.load %arg4[%26, %arg8] : memref<?x160xf64>
            %29 = arith.mulf %27, %28 : f64
            %30 = affine.load %arg5[%arg8] : memref<?xf64>
            %31 = arith.addf %30, %29 : f64
            affine.store %31, %arg5[%arg8] : memref<?xf64>
            %32 = affine.apply #map2(%20)
            %33 = affine.load %arg3[%arg6, %arg7, %32] : memref<?x140x160xf64>
            %34 = affine.load %arg4[%32, %arg8] : memref<?x160xf64>
            %35 = arith.mulf %33, %34 : f64
            %36 = affine.load %arg5[%arg8] : memref<?xf64>
            %37 = arith.addf %36, %35 : f64
            affine.store %37, %arg5[%arg8] : memref<?xf64>
            %38 = affine.apply #map4(%arg9)
            %39 = affine.load %arg3[%arg6, %arg7, %38] : memref<?x140x160xf64>
            %40 = affine.load %arg4[%38, %arg8] : memref<?x160xf64>
            %41 = arith.mulf %39, %40 : f64
            %42 = affine.load %arg5[%arg8] : memref<?xf64>
            %43 = arith.addf %42, %41 : f64
            affine.store %43, %arg5[%arg8] : memref<?xf64>
            %44 = affine.apply #map1(%38)
            %45 = affine.load %arg3[%arg6, %arg7, %44] : memref<?x140x160xf64>
            %46 = affine.load %arg4[%44, %arg8] : memref<?x160xf64>
            %47 = arith.mulf %45, %46 : f64
            %48 = affine.load %arg5[%arg8] : memref<?xf64>
            %49 = arith.addf %48, %47 : f64
            affine.store %49, %arg5[%arg8] : memref<?xf64>
            %50 = affine.apply #map2(%38)
            %51 = affine.load %arg3[%arg6, %arg7, %50] : memref<?x140x160xf64>
            %52 = affine.load %arg4[%50, %arg8] : memref<?x160xf64>
            %53 = arith.mulf %51, %52 : f64
            %54 = affine.load %arg5[%arg8] : memref<?xf64>
            %55 = arith.addf %54, %53 : f64
            affine.store %55, %arg5[%arg8] : memref<?xf64>
            %56 = affine.apply #map5(%arg9)
            %57 = affine.load %arg3[%arg6, %arg7, %56] : memref<?x140x160xf64>
            %58 = affine.load %arg4[%56, %arg8] : memref<?x160xf64>
            %59 = arith.mulf %57, %58 : f64
            %60 = affine.load %arg5[%arg8] : memref<?xf64>
            %61 = arith.addf %60, %59 : f64
            affine.store %61, %arg5[%arg8] : memref<?xf64>
            %62 = affine.apply #map1(%56)
            %63 = affine.load %arg3[%arg6, %arg7, %62] : memref<?x140x160xf64>
            %64 = affine.load %arg4[%62, %arg8] : memref<?x160xf64>
            %65 = arith.mulf %63, %64 : f64
            %66 = affine.load %arg5[%arg8] : memref<?xf64>
            %67 = arith.addf %66, %65 : f64
            affine.store %67, %arg5[%arg8] : memref<?xf64>
            %68 = affine.apply #map2(%56)
            %69 = affine.load %arg3[%arg6, %arg7, %68] : memref<?x140x160xf64>
            %70 = affine.load %arg4[%68, %arg8] : memref<?x160xf64>
            %71 = arith.mulf %69, %70 : f64
            %72 = affine.load %arg5[%arg8] : memref<?xf64>
            %73 = arith.addf %72, %71 : f64
            affine.store %73, %arg5[%arg8] : memref<?xf64>
            %74 = affine.apply #map6(%arg9)
            %75 = affine.load %arg3[%arg6, %arg7, %74] : memref<?x140x160xf64>
            %76 = affine.load %arg4[%74, %arg8] : memref<?x160xf64>
            %77 = arith.mulf %75, %76 : f64
            %78 = affine.load %arg5[%arg8] : memref<?xf64>
            %79 = arith.addf %78, %77 : f64
            affine.store %79, %arg5[%arg8] : memref<?xf64>
            %80 = affine.apply #map1(%74)
            %81 = affine.load %arg3[%arg6, %arg7, %80] : memref<?x140x160xf64>
            %82 = affine.load %arg4[%80, %arg8] : memref<?x160xf64>
            %83 = arith.mulf %81, %82 : f64
            %84 = affine.load %arg5[%arg8] : memref<?xf64>
            %85 = arith.addf %84, %83 : f64
            affine.store %85, %arg5[%arg8] : memref<?xf64>
            %86 = affine.apply #map2(%74)
            %87 = affine.load %arg3[%arg6, %arg7, %86] : memref<?x140x160xf64>
            %88 = affine.load %arg4[%86, %arg8] : memref<?x160xf64>
            %89 = arith.mulf %87, %88 : f64
            %90 = affine.load %arg5[%arg8] : memref<?xf64>
            %91 = arith.addf %90, %89 : f64
            affine.store %91, %arg5[%arg8] : memref<?xf64>
            %92 = affine.apply #map7(%arg9)
            %93 = affine.load %arg3[%arg6, %arg7, %92] : memref<?x140x160xf64>
            %94 = affine.load %arg4[%92, %arg8] : memref<?x160xf64>
            %95 = arith.mulf %93, %94 : f64
            %96 = affine.load %arg5[%arg8] : memref<?xf64>
            %97 = arith.addf %96, %95 : f64
            affine.store %97, %arg5[%arg8] : memref<?xf64>
            %98 = affine.apply #map1(%92)
            %99 = affine.load %arg3[%arg6, %arg7, %98] : memref<?x140x160xf64>
            %100 = affine.load %arg4[%98, %arg8] : memref<?x160xf64>
            %101 = arith.mulf %99, %100 : f64
            %102 = affine.load %arg5[%arg8] : memref<?xf64>
            %103 = arith.addf %102, %101 : f64
            affine.store %103, %arg5[%arg8] : memref<?xf64>
            %104 = affine.apply #map2(%92)
            %105 = affine.load %arg3[%arg6, %arg7, %104] : memref<?x140x160xf64>
            %106 = affine.load %arg4[%104, %arg8] : memref<?x160xf64>
            %107 = arith.mulf %105, %106 : f64
            %108 = affine.load %arg5[%arg8] : memref<?xf64>
            %109 = arith.addf %108, %107 : f64
            affine.store %109, %arg5[%arg8] : memref<?xf64>
            %110 = affine.apply #map8(%arg9)
            %111 = affine.load %arg3[%arg6, %arg7, %110] : memref<?x140x160xf64>
            %112 = affine.load %arg4[%110, %arg8] : memref<?x160xf64>
            %113 = arith.mulf %111, %112 : f64
            %114 = affine.load %arg5[%arg8] : memref<?xf64>
            %115 = arith.addf %114, %113 : f64
            affine.store %115, %arg5[%arg8] : memref<?xf64>
            %116 = affine.apply #map1(%110)
            %117 = affine.load %arg3[%arg6, %arg7, %116] : memref<?x140x160xf64>
            %118 = affine.load %arg4[%116, %arg8] : memref<?x160xf64>
            %119 = arith.mulf %117, %118 : f64
            %120 = affine.load %arg5[%arg8] : memref<?xf64>
            %121 = arith.addf %120, %119 : f64
            affine.store %121, %arg5[%arg8] : memref<?xf64>
            %122 = affine.apply #map2(%110)
            %123 = affine.load %arg3[%arg6, %arg7, %122] : memref<?x140x160xf64>
            %124 = affine.load %arg4[%122, %arg8] : memref<?x160xf64>
            %125 = arith.mulf %123, %124 : f64
            %126 = affine.load %arg5[%arg8] : memref<?xf64>
            %127 = arith.addf %126, %125 : f64
            affine.store %127, %arg5[%arg8] : memref<?xf64>
            %128 = affine.apply #map9(%arg9)
            %129 = affine.load %arg3[%arg6, %arg7, %128] : memref<?x140x160xf64>
            %130 = affine.load %arg4[%128, %arg8] : memref<?x160xf64>
            %131 = arith.mulf %129, %130 : f64
            %132 = affine.load %arg5[%arg8] : memref<?xf64>
            %133 = arith.addf %132, %131 : f64
            affine.store %133, %arg5[%arg8] : memref<?xf64>
            %134 = affine.apply #map1(%128)
            %135 = affine.load %arg3[%arg6, %arg7, %134] : memref<?x140x160xf64>
            %136 = affine.load %arg4[%134, %arg8] : memref<?x160xf64>
            %137 = arith.mulf %135, %136 : f64
            %138 = affine.load %arg5[%arg8] : memref<?xf64>
            %139 = arith.addf %138, %137 : f64
            affine.store %139, %arg5[%arg8] : memref<?xf64>
            %140 = affine.apply #map2(%128)
            %141 = affine.load %arg3[%arg6, %arg7, %140] : memref<?x140x160xf64>
            %142 = affine.load %arg4[%140, %arg8] : memref<?x160xf64>
            %143 = arith.mulf %141, %142 : f64
            %144 = affine.load %arg5[%arg8] : memref<?xf64>
            %145 = arith.addf %144, %143 : f64
            affine.store %145, %arg5[%arg8] : memref<?xf64>
          }
          affine.for %arg9 = #map()[%1] to #map10()[%1] step 3 {
            %3 = affine.load %arg3[%arg6, %arg7, %arg9] : memref<?x140x160xf64>
            %4 = affine.load %arg4[%arg9, %arg8] : memref<?x160xf64>
            %5 = arith.mulf %3, %4 : f64
            %6 = affine.load %arg5[%arg8] : memref<?xf64>
            %7 = arith.addf %6, %5 : f64
            affine.store %7, %arg5[%arg8] : memref<?xf64>
            %8 = affine.apply #map1(%arg9)
            %9 = affine.load %arg3[%arg6, %arg7, %8] : memref<?x140x160xf64>
            %10 = affine.load %arg4[%8, %arg8] : memref<?x160xf64>
            %11 = arith.mulf %9, %10 : f64
            %12 = affine.load %arg5[%arg8] : memref<?xf64>
            %13 = arith.addf %12, %11 : f64
            affine.store %13, %arg5[%arg8] : memref<?xf64>
            %14 = affine.apply #map2(%arg9)
            %15 = affine.load %arg3[%arg6, %arg7, %14] : memref<?x140x160xf64>
            %16 = affine.load %arg4[%14, %arg8] : memref<?x160xf64>
            %17 = arith.mulf %15, %16 : f64
            %18 = affine.load %arg5[%arg8] : memref<?xf64>
            %19 = arith.addf %18, %17 : f64
            affine.store %19, %arg5[%arg8] : memref<?xf64>
          }
          affine.for %arg9 = #map10()[%1] to #map11()[%1] step 8 {
            %3 = affine.load %arg3[%arg6, %arg7, %arg9] : memref<?x140x160xf64>
            %4 = affine.load %arg4[%arg9, %arg8] : memref<?x160xf64>
            %5 = arith.mulf %3, %4 : f64
            %6 = affine.load %arg5[%arg8] : memref<?xf64>
            %7 = arith.addf %6, %5 : f64
            affine.store %7, %arg5[%arg8] : memref<?xf64>
            %8 = affine.apply #map1(%arg9)
            %9 = affine.load %arg3[%arg6, %arg7, %8] : memref<?x140x160xf64>
            %10 = affine.load %arg4[%8, %arg8] : memref<?x160xf64>
            %11 = arith.mulf %9, %10 : f64
            %12 = affine.load %arg5[%arg8] : memref<?xf64>
            %13 = arith.addf %12, %11 : f64
            affine.store %13, %arg5[%arg8] : memref<?xf64>
            %14 = affine.apply #map2(%arg9)
            %15 = affine.load %arg3[%arg6, %arg7, %14] : memref<?x140x160xf64>
            %16 = affine.load %arg4[%14, %arg8] : memref<?x160xf64>
            %17 = arith.mulf %15, %16 : f64
            %18 = affine.load %arg5[%arg8] : memref<?xf64>
            %19 = arith.addf %18, %17 : f64
            affine.store %19, %arg5[%arg8] : memref<?xf64>
            %20 = affine.apply #map3(%arg9)
            %21 = affine.load %arg3[%arg6, %arg7, %20] : memref<?x140x160xf64>
            %22 = affine.load %arg4[%20, %arg8] : memref<?x160xf64>
            %23 = arith.mulf %21, %22 : f64
            %24 = affine.load %arg5[%arg8] : memref<?xf64>
            %25 = arith.addf %24, %23 : f64
            affine.store %25, %arg5[%arg8] : memref<?xf64>
            %26 = affine.apply #map12(%arg9)
            %27 = affine.load %arg3[%arg6, %arg7, %26] : memref<?x140x160xf64>
            %28 = affine.load %arg4[%26, %arg8] : memref<?x160xf64>
            %29 = arith.mulf %27, %28 : f64
            %30 = affine.load %arg5[%arg8] : memref<?xf64>
            %31 = arith.addf %30, %29 : f64
            affine.store %31, %arg5[%arg8] : memref<?xf64>
            %32 = affine.apply #map13(%arg9)
            %33 = affine.load %arg3[%arg6, %arg7, %32] : memref<?x140x160xf64>
            %34 = affine.load %arg4[%32, %arg8] : memref<?x160xf64>
            %35 = arith.mulf %33, %34 : f64
            %36 = affine.load %arg5[%arg8] : memref<?xf64>
            %37 = arith.addf %36, %35 : f64
            affine.store %37, %arg5[%arg8] : memref<?xf64>
            %38 = affine.apply #map4(%arg9)
            %39 = affine.load %arg3[%arg6, %arg7, %38] : memref<?x140x160xf64>
            %40 = affine.load %arg4[%38, %arg8] : memref<?x160xf64>
            %41 = arith.mulf %39, %40 : f64
            %42 = affine.load %arg5[%arg8] : memref<?xf64>
            %43 = arith.addf %42, %41 : f64
            affine.store %43, %arg5[%arg8] : memref<?xf64>
            %44 = affine.apply #map14(%arg9)
            %45 = affine.load %arg3[%arg6, %arg7, %44] : memref<?x140x160xf64>
            %46 = affine.load %arg4[%44, %arg8] : memref<?x160xf64>
            %47 = arith.mulf %45, %46 : f64
            %48 = affine.load %arg5[%arg8] : memref<?xf64>
            %49 = arith.addf %48, %47 : f64
            affine.store %49, %arg5[%arg8] : memref<?xf64>
          }
          affine.for %arg9 = #map11()[%1] to %1 {
            %3 = affine.load %arg3[%arg6, %arg7, %arg9] : memref<?x140x160xf64>
            %4 = affine.load %arg4[%arg9, %arg8] : memref<?x160xf64>
            %5 = arith.mulf %3, %4 : f64
            %6 = affine.load %arg5[%arg8] : memref<?xf64>
            %7 = arith.addf %6, %5 : f64
            affine.store %7, %arg5[%arg8] : memref<?xf64>
          }
        }
        affine.for %arg8 = 0 to #map()[%1] step 24 {
          %3 = affine.load %arg5[%arg8] : memref<?xf64>
          affine.store %3, %arg3[%arg6, %arg7, %arg8] : memref<?x140x160xf64>
          %4 = affine.apply #map1(%arg8)
          %5 = affine.load %arg5[%4] : memref<?xf64>
          affine.store %5, %arg3[%arg6, %arg7, %4] : memref<?x140x160xf64>
          %6 = affine.apply #map2(%arg8)
          %7 = affine.load %arg5[%6] : memref<?xf64>
          affine.store %7, %arg3[%arg6, %arg7, %6] : memref<?x140x160xf64>
          %8 = affine.apply #map3(%arg8)
          %9 = affine.load %arg5[%8] : memref<?xf64>
          affine.store %9, %arg3[%arg6, %arg7, %8] : memref<?x140x160xf64>
          %10 = affine.apply #map1(%8)
          %11 = affine.load %arg5[%10] : memref<?xf64>
          affine.store %11, %arg3[%arg6, %arg7, %10] : memref<?x140x160xf64>
          %12 = affine.apply #map2(%8)
          %13 = affine.load %arg5[%12] : memref<?xf64>
          affine.store %13, %arg3[%arg6, %arg7, %12] : memref<?x140x160xf64>
          %14 = affine.apply #map4(%arg8)
          %15 = affine.load %arg5[%14] : memref<?xf64>
          affine.store %15, %arg3[%arg6, %arg7, %14] : memref<?x140x160xf64>
          %16 = affine.apply #map1(%14)
          %17 = affine.load %arg5[%16] : memref<?xf64>
          affine.store %17, %arg3[%arg6, %arg7, %16] : memref<?x140x160xf64>
          %18 = affine.apply #map2(%14)
          %19 = affine.load %arg5[%18] : memref<?xf64>
          affine.store %19, %arg3[%arg6, %arg7, %18] : memref<?x140x160xf64>
          %20 = affine.apply #map5(%arg8)
          %21 = affine.load %arg5[%20] : memref<?xf64>
          affine.store %21, %arg3[%arg6, %arg7, %20] : memref<?x140x160xf64>
          %22 = affine.apply #map1(%20)
          %23 = affine.load %arg5[%22] : memref<?xf64>
          affine.store %23, %arg3[%arg6, %arg7, %22] : memref<?x140x160xf64>
          %24 = affine.apply #map2(%20)
          %25 = affine.load %arg5[%24] : memref<?xf64>
          affine.store %25, %arg3[%arg6, %arg7, %24] : memref<?x140x160xf64>
          %26 = affine.apply #map6(%arg8)
          %27 = affine.load %arg5[%26] : memref<?xf64>
          affine.store %27, %arg3[%arg6, %arg7, %26] : memref<?x140x160xf64>
          %28 = affine.apply #map1(%26)
          %29 = affine.load %arg5[%28] : memref<?xf64>
          affine.store %29, %arg3[%arg6, %arg7, %28] : memref<?x140x160xf64>
          %30 = affine.apply #map2(%26)
          %31 = affine.load %arg5[%30] : memref<?xf64>
          affine.store %31, %arg3[%arg6, %arg7, %30] : memref<?x140x160xf64>
          %32 = affine.apply #map7(%arg8)
          %33 = affine.load %arg5[%32] : memref<?xf64>
          affine.store %33, %arg3[%arg6, %arg7, %32] : memref<?x140x160xf64>
          %34 = affine.apply #map1(%32)
          %35 = affine.load %arg5[%34] : memref<?xf64>
          affine.store %35, %arg3[%arg6, %arg7, %34] : memref<?x140x160xf64>
          %36 = affine.apply #map2(%32)
          %37 = affine.load %arg5[%36] : memref<?xf64>
          affine.store %37, %arg3[%arg6, %arg7, %36] : memref<?x140x160xf64>
          %38 = affine.apply #map8(%arg8)
          %39 = affine.load %arg5[%38] : memref<?xf64>
          affine.store %39, %arg3[%arg6, %arg7, %38] : memref<?x140x160xf64>
          %40 = affine.apply #map1(%38)
          %41 = affine.load %arg5[%40] : memref<?xf64>
          affine.store %41, %arg3[%arg6, %arg7, %40] : memref<?x140x160xf64>
          %42 = affine.apply #map2(%38)
          %43 = affine.load %arg5[%42] : memref<?xf64>
          affine.store %43, %arg3[%arg6, %arg7, %42] : memref<?x140x160xf64>
          %44 = affine.apply #map9(%arg8)
          %45 = affine.load %arg5[%44] : memref<?xf64>
          affine.store %45, %arg3[%arg6, %arg7, %44] : memref<?x140x160xf64>
          %46 = affine.apply #map1(%44)
          %47 = affine.load %arg5[%46] : memref<?xf64>
          affine.store %47, %arg3[%arg6, %arg7, %46] : memref<?x140x160xf64>
          %48 = affine.apply #map2(%44)
          %49 = affine.load %arg5[%48] : memref<?xf64>
          affine.store %49, %arg3[%arg6, %arg7, %48] : memref<?x140x160xf64>
        }
        affine.for %arg8 = #map()[%1] to #map10()[%1] step 3 {
          %3 = affine.load %arg5[%arg8] : memref<?xf64>
          affine.store %3, %arg3[%arg6, %arg7, %arg8] : memref<?x140x160xf64>
          %4 = affine.apply #map1(%arg8)
          %5 = affine.load %arg5[%4] : memref<?xf64>
          affine.store %5, %arg3[%arg6, %arg7, %4] : memref<?x140x160xf64>
          %6 = affine.apply #map2(%arg8)
          %7 = affine.load %arg5[%6] : memref<?xf64>
          affine.store %7, %arg3[%arg6, %arg7, %6] : memref<?x140x160xf64>
        }
        affine.for %arg8 = #map10()[%1] to #map11()[%1] step 8 {
          %3 = affine.load %arg5[%arg8] : memref<?xf64>
          affine.store %3, %arg3[%arg6, %arg7, %arg8] : memref<?x140x160xf64>
          %4 = affine.apply #map1(%arg8)
          %5 = affine.load %arg5[%4] : memref<?xf64>
          affine.store %5, %arg3[%arg6, %arg7, %4] : memref<?x140x160xf64>
          %6 = affine.apply #map2(%arg8)
          %7 = affine.load %arg5[%6] : memref<?xf64>
          affine.store %7, %arg3[%arg6, %arg7, %6] : memref<?x140x160xf64>
          %8 = affine.apply #map3(%arg8)
          %9 = affine.load %arg5[%8] : memref<?xf64>
          affine.store %9, %arg3[%arg6, %arg7, %8] : memref<?x140x160xf64>
          %10 = affine.apply #map12(%arg8)
          %11 = affine.load %arg5[%10] : memref<?xf64>
          affine.store %11, %arg3[%arg6, %arg7, %10] : memref<?x140x160xf64>
          %12 = affine.apply #map13(%arg8)
          %13 = affine.load %arg5[%12] : memref<?xf64>
          affine.store %13, %arg3[%arg6, %arg7, %12] : memref<?x140x160xf64>
          %14 = affine.apply #map4(%arg8)
          %15 = affine.load %arg5[%14] : memref<?xf64>
          affine.store %15, %arg3[%arg6, %arg7, %14] : memref<?x140x160xf64>
          %16 = affine.apply #map14(%arg8)
          %17 = affine.load %arg5[%16] : memref<?xf64>
          affine.store %17, %arg3[%arg6, %arg7, %16] : memref<?x140x160xf64>
        }
        affine.for %arg8 = #map11()[%1] to %1 {
          %3 = affine.load %arg5[%arg8] : memref<?xf64>
          affine.store %3, %arg3[%arg6, %arg7, %arg8] : memref<?x140x160xf64>
        }
      }
    }
    return
  }
}

