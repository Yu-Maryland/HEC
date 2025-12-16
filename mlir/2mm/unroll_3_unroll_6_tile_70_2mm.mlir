#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 70, s0)>
#map2 = affine_map<()[s0] -> (((s0 floordiv 6) floordiv 3) * 18)>
#map3 = affine_map<(d0) -> (d0 + 1)>
#map4 = affine_map<(d0) -> (d0 + 2)>
#map5 = affine_map<(d0) -> (d0 + 3)>
#map6 = affine_map<(d0) -> (d0 + 4)>
#map7 = affine_map<(d0) -> (d0 + 5)>
#map8 = affine_map<(d0) -> (d0 + 6)>
#map9 = affine_map<(d0) -> (d0 + 12)>
#map10 = affine_map<()[s0] -> ((s0 floordiv 6) * 6)>
#map11 = affine_map<()[s0] -> ((s0 floordiv 3) * 3)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>, #dlti.dl_entry<"dlti.endianness", "little">>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_2mm(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: f64, %arg5: f64, %arg6: memref<?x900xf64>, %arg7: memref<?x1100xf64>, %arg8: memref<?x900xf64>, %arg9: memref<?x1200xf64>, %arg10: memref<?x1200xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 0.000000e+00 : f64
    %0 = arith.index_cast %arg2 : i32 to index
    %1 = arith.index_cast %arg3 : i32 to index
    %2 = arith.index_cast %arg1 : i32 to index
    %3 = arith.index_cast %arg0 : i32 to index
    affine.for %arg11 = 0 to %3 step 70 {
      affine.for %arg12 = 0 to %2 step 70 {
        affine.for %arg13 = #map(%arg11) to min #map1(%arg11)[%3] {
          affine.for %arg14 = #map(%arg12) to min #map1(%arg12)[%2] {
            affine.store %cst, %arg6[%arg13, %arg14] : memref<?x900xf64>
            affine.for %arg15 = 0 to #map2()[%0] step 18 {
              %4 = affine.load %arg7[%arg13, %arg15] : memref<?x1100xf64>
              %5 = arith.mulf %arg4, %4 : f64
              %6 = affine.load %arg8[%arg15, %arg14] : memref<?x900xf64>
              %7 = arith.mulf %5, %6 : f64
              %8 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %9 = arith.addf %8, %7 : f64
              affine.store %9, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %10 = affine.apply #map3(%arg15)
              %11 = affine.load %arg7[%arg13, %10] : memref<?x1100xf64>
              %12 = arith.mulf %arg4, %11 : f64
              %13 = affine.load %arg8[%10, %arg14] : memref<?x900xf64>
              %14 = arith.mulf %12, %13 : f64
              %15 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %16 = arith.addf %15, %14 : f64
              affine.store %16, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %17 = affine.apply #map4(%arg15)
              %18 = affine.load %arg7[%arg13, %17] : memref<?x1100xf64>
              %19 = arith.mulf %arg4, %18 : f64
              %20 = affine.load %arg8[%17, %arg14] : memref<?x900xf64>
              %21 = arith.mulf %19, %20 : f64
              %22 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %23 = arith.addf %22, %21 : f64
              affine.store %23, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %24 = affine.apply #map5(%arg15)
              %25 = affine.load %arg7[%arg13, %24] : memref<?x1100xf64>
              %26 = arith.mulf %arg4, %25 : f64
              %27 = affine.load %arg8[%24, %arg14] : memref<?x900xf64>
              %28 = arith.mulf %26, %27 : f64
              %29 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %30 = arith.addf %29, %28 : f64
              affine.store %30, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %31 = affine.apply #map6(%arg15)
              %32 = affine.load %arg7[%arg13, %31] : memref<?x1100xf64>
              %33 = arith.mulf %arg4, %32 : f64
              %34 = affine.load %arg8[%31, %arg14] : memref<?x900xf64>
              %35 = arith.mulf %33, %34 : f64
              %36 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %37 = arith.addf %36, %35 : f64
              affine.store %37, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %38 = affine.apply #map7(%arg15)
              %39 = affine.load %arg7[%arg13, %38] : memref<?x1100xf64>
              %40 = arith.mulf %arg4, %39 : f64
              %41 = affine.load %arg8[%38, %arg14] : memref<?x900xf64>
              %42 = arith.mulf %40, %41 : f64
              %43 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %44 = arith.addf %43, %42 : f64
              affine.store %44, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %45 = affine.apply #map8(%arg15)
              %46 = affine.load %arg7[%arg13, %45] : memref<?x1100xf64>
              %47 = arith.mulf %arg4, %46 : f64
              %48 = affine.load %arg8[%45, %arg14] : memref<?x900xf64>
              %49 = arith.mulf %47, %48 : f64
              %50 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %51 = arith.addf %50, %49 : f64
              affine.store %51, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %52 = affine.apply #map3(%45)
              %53 = affine.load %arg7[%arg13, %52] : memref<?x1100xf64>
              %54 = arith.mulf %arg4, %53 : f64
              %55 = affine.load %arg8[%52, %arg14] : memref<?x900xf64>
              %56 = arith.mulf %54, %55 : f64
              %57 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %58 = arith.addf %57, %56 : f64
              affine.store %58, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %59 = affine.apply #map4(%45)
              %60 = affine.load %arg7[%arg13, %59] : memref<?x1100xf64>
              %61 = arith.mulf %arg4, %60 : f64
              %62 = affine.load %arg8[%59, %arg14] : memref<?x900xf64>
              %63 = arith.mulf %61, %62 : f64
              %64 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %65 = arith.addf %64, %63 : f64
              affine.store %65, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %66 = affine.apply #map5(%45)
              %67 = affine.load %arg7[%arg13, %66] : memref<?x1100xf64>
              %68 = arith.mulf %arg4, %67 : f64
              %69 = affine.load %arg8[%66, %arg14] : memref<?x900xf64>
              %70 = arith.mulf %68, %69 : f64
              %71 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %72 = arith.addf %71, %70 : f64
              affine.store %72, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %73 = affine.apply #map6(%45)
              %74 = affine.load %arg7[%arg13, %73] : memref<?x1100xf64>
              %75 = arith.mulf %arg4, %74 : f64
              %76 = affine.load %arg8[%73, %arg14] : memref<?x900xf64>
              %77 = arith.mulf %75, %76 : f64
              %78 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %79 = arith.addf %78, %77 : f64
              affine.store %79, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %80 = affine.apply #map7(%45)
              %81 = affine.load %arg7[%arg13, %80] : memref<?x1100xf64>
              %82 = arith.mulf %arg4, %81 : f64
              %83 = affine.load %arg8[%80, %arg14] : memref<?x900xf64>
              %84 = arith.mulf %82, %83 : f64
              %85 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %86 = arith.addf %85, %84 : f64
              affine.store %86, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %87 = affine.apply #map9(%arg15)
              %88 = affine.load %arg7[%arg13, %87] : memref<?x1100xf64>
              %89 = arith.mulf %arg4, %88 : f64
              %90 = affine.load %arg8[%87, %arg14] : memref<?x900xf64>
              %91 = arith.mulf %89, %90 : f64
              %92 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %93 = arith.addf %92, %91 : f64
              affine.store %93, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %94 = affine.apply #map3(%87)
              %95 = affine.load %arg7[%arg13, %94] : memref<?x1100xf64>
              %96 = arith.mulf %arg4, %95 : f64
              %97 = affine.load %arg8[%94, %arg14] : memref<?x900xf64>
              %98 = arith.mulf %96, %97 : f64
              %99 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %100 = arith.addf %99, %98 : f64
              affine.store %100, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %101 = affine.apply #map4(%87)
              %102 = affine.load %arg7[%arg13, %101] : memref<?x1100xf64>
              %103 = arith.mulf %arg4, %102 : f64
              %104 = affine.load %arg8[%101, %arg14] : memref<?x900xf64>
              %105 = arith.mulf %103, %104 : f64
              %106 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %107 = arith.addf %106, %105 : f64
              affine.store %107, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %108 = affine.apply #map5(%87)
              %109 = affine.load %arg7[%arg13, %108] : memref<?x1100xf64>
              %110 = arith.mulf %arg4, %109 : f64
              %111 = affine.load %arg8[%108, %arg14] : memref<?x900xf64>
              %112 = arith.mulf %110, %111 : f64
              %113 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %114 = arith.addf %113, %112 : f64
              affine.store %114, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %115 = affine.apply #map6(%87)
              %116 = affine.load %arg7[%arg13, %115] : memref<?x1100xf64>
              %117 = arith.mulf %arg4, %116 : f64
              %118 = affine.load %arg8[%115, %arg14] : memref<?x900xf64>
              %119 = arith.mulf %117, %118 : f64
              %120 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %121 = arith.addf %120, %119 : f64
              affine.store %121, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %122 = affine.apply #map7(%87)
              %123 = affine.load %arg7[%arg13, %122] : memref<?x1100xf64>
              %124 = arith.mulf %arg4, %123 : f64
              %125 = affine.load %arg8[%122, %arg14] : memref<?x900xf64>
              %126 = arith.mulf %124, %125 : f64
              %127 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %128 = arith.addf %127, %126 : f64
              affine.store %128, %arg6[%arg13, %arg14] : memref<?x900xf64>
            }
            affine.for %arg15 = #map2()[%0] to #map10()[%0] step 6 {
              %4 = affine.load %arg7[%arg13, %arg15] : memref<?x1100xf64>
              %5 = arith.mulf %arg4, %4 : f64
              %6 = affine.load %arg8[%arg15, %arg14] : memref<?x900xf64>
              %7 = arith.mulf %5, %6 : f64
              %8 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %9 = arith.addf %8, %7 : f64
              affine.store %9, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %10 = affine.apply #map3(%arg15)
              %11 = affine.load %arg7[%arg13, %10] : memref<?x1100xf64>
              %12 = arith.mulf %arg4, %11 : f64
              %13 = affine.load %arg8[%10, %arg14] : memref<?x900xf64>
              %14 = arith.mulf %12, %13 : f64
              %15 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %16 = arith.addf %15, %14 : f64
              affine.store %16, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %17 = affine.apply #map4(%arg15)
              %18 = affine.load %arg7[%arg13, %17] : memref<?x1100xf64>
              %19 = arith.mulf %arg4, %18 : f64
              %20 = affine.load %arg8[%17, %arg14] : memref<?x900xf64>
              %21 = arith.mulf %19, %20 : f64
              %22 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %23 = arith.addf %22, %21 : f64
              affine.store %23, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %24 = affine.apply #map5(%arg15)
              %25 = affine.load %arg7[%arg13, %24] : memref<?x1100xf64>
              %26 = arith.mulf %arg4, %25 : f64
              %27 = affine.load %arg8[%24, %arg14] : memref<?x900xf64>
              %28 = arith.mulf %26, %27 : f64
              %29 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %30 = arith.addf %29, %28 : f64
              affine.store %30, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %31 = affine.apply #map6(%arg15)
              %32 = affine.load %arg7[%arg13, %31] : memref<?x1100xf64>
              %33 = arith.mulf %arg4, %32 : f64
              %34 = affine.load %arg8[%31, %arg14] : memref<?x900xf64>
              %35 = arith.mulf %33, %34 : f64
              %36 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %37 = arith.addf %36, %35 : f64
              affine.store %37, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %38 = affine.apply #map7(%arg15)
              %39 = affine.load %arg7[%arg13, %38] : memref<?x1100xf64>
              %40 = arith.mulf %arg4, %39 : f64
              %41 = affine.load %arg8[%38, %arg14] : memref<?x900xf64>
              %42 = arith.mulf %40, %41 : f64
              %43 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %44 = arith.addf %43, %42 : f64
              affine.store %44, %arg6[%arg13, %arg14] : memref<?x900xf64>
            }
            affine.for %arg15 = #map10()[%0] to #map11()[%0] step 3 {
              %4 = affine.load %arg7[%arg13, %arg15] : memref<?x1100xf64>
              %5 = arith.mulf %arg4, %4 : f64
              %6 = affine.load %arg8[%arg15, %arg14] : memref<?x900xf64>
              %7 = arith.mulf %5, %6 : f64
              %8 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %9 = arith.addf %8, %7 : f64
              affine.store %9, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %10 = affine.apply #map3(%arg15)
              %11 = affine.load %arg7[%arg13, %10] : memref<?x1100xf64>
              %12 = arith.mulf %arg4, %11 : f64
              %13 = affine.load %arg8[%10, %arg14] : memref<?x900xf64>
              %14 = arith.mulf %12, %13 : f64
              %15 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %16 = arith.addf %15, %14 : f64
              affine.store %16, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %17 = affine.apply #map4(%arg15)
              %18 = affine.load %arg7[%arg13, %17] : memref<?x1100xf64>
              %19 = arith.mulf %arg4, %18 : f64
              %20 = affine.load %arg8[%17, %arg14] : memref<?x900xf64>
              %21 = arith.mulf %19, %20 : f64
              %22 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %23 = arith.addf %22, %21 : f64
              affine.store %23, %arg6[%arg13, %arg14] : memref<?x900xf64>
            }
            affine.for %arg15 = #map11()[%0] to %0 {
              %4 = affine.load %arg7[%arg13, %arg15] : memref<?x1100xf64>
              %5 = arith.mulf %arg4, %4 : f64
              %6 = affine.load %arg8[%arg15, %arg14] : memref<?x900xf64>
              %7 = arith.mulf %5, %6 : f64
              %8 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %9 = arith.addf %8, %7 : f64
              affine.store %9, %arg6[%arg13, %arg14] : memref<?x900xf64>
            }
          }
        }
      }
    }
    affine.for %arg11 = 0 to %3 step 70 {
      affine.for %arg12 = 0 to %1 step 70 {
        affine.for %arg13 = #map(%arg11) to min #map1(%arg11)[%3] {
          affine.for %arg14 = #map(%arg12) to min #map1(%arg12)[%1] {
            %4 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
            %5 = arith.mulf %4, %arg5 : f64
            affine.store %5, %arg10[%arg13, %arg14] : memref<?x1200xf64>
            affine.for %arg15 = 0 to #map2()[%2] step 18 {
              %6 = affine.load %arg6[%arg13, %arg15] : memref<?x900xf64>
              %7 = affine.load %arg9[%arg15, %arg14] : memref<?x1200xf64>
              %8 = arith.mulf %6, %7 : f64
              %9 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %10 = arith.addf %9, %8 : f64
              affine.store %10, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %11 = affine.apply #map3(%arg15)
              %12 = affine.load %arg6[%arg13, %11] : memref<?x900xf64>
              %13 = affine.load %arg9[%11, %arg14] : memref<?x1200xf64>
              %14 = arith.mulf %12, %13 : f64
              %15 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %16 = arith.addf %15, %14 : f64
              affine.store %16, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %17 = affine.apply #map4(%arg15)
              %18 = affine.load %arg6[%arg13, %17] : memref<?x900xf64>
              %19 = affine.load %arg9[%17, %arg14] : memref<?x1200xf64>
              %20 = arith.mulf %18, %19 : f64
              %21 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %22 = arith.addf %21, %20 : f64
              affine.store %22, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %23 = affine.apply #map5(%arg15)
              %24 = affine.load %arg6[%arg13, %23] : memref<?x900xf64>
              %25 = affine.load %arg9[%23, %arg14] : memref<?x1200xf64>
              %26 = arith.mulf %24, %25 : f64
              %27 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %28 = arith.addf %27, %26 : f64
              affine.store %28, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %29 = affine.apply #map6(%arg15)
              %30 = affine.load %arg6[%arg13, %29] : memref<?x900xf64>
              %31 = affine.load %arg9[%29, %arg14] : memref<?x1200xf64>
              %32 = arith.mulf %30, %31 : f64
              %33 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %34 = arith.addf %33, %32 : f64
              affine.store %34, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %35 = affine.apply #map7(%arg15)
              %36 = affine.load %arg6[%arg13, %35] : memref<?x900xf64>
              %37 = affine.load %arg9[%35, %arg14] : memref<?x1200xf64>
              %38 = arith.mulf %36, %37 : f64
              %39 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %40 = arith.addf %39, %38 : f64
              affine.store %40, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %41 = affine.apply #map8(%arg15)
              %42 = affine.load %arg6[%arg13, %41] : memref<?x900xf64>
              %43 = affine.load %arg9[%41, %arg14] : memref<?x1200xf64>
              %44 = arith.mulf %42, %43 : f64
              %45 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %46 = arith.addf %45, %44 : f64
              affine.store %46, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %47 = affine.apply #map3(%41)
              %48 = affine.load %arg6[%arg13, %47] : memref<?x900xf64>
              %49 = affine.load %arg9[%47, %arg14] : memref<?x1200xf64>
              %50 = arith.mulf %48, %49 : f64
              %51 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %52 = arith.addf %51, %50 : f64
              affine.store %52, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %53 = affine.apply #map4(%41)
              %54 = affine.load %arg6[%arg13, %53] : memref<?x900xf64>
              %55 = affine.load %arg9[%53, %arg14] : memref<?x1200xf64>
              %56 = arith.mulf %54, %55 : f64
              %57 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %58 = arith.addf %57, %56 : f64
              affine.store %58, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %59 = affine.apply #map5(%41)
              %60 = affine.load %arg6[%arg13, %59] : memref<?x900xf64>
              %61 = affine.load %arg9[%59, %arg14] : memref<?x1200xf64>
              %62 = arith.mulf %60, %61 : f64
              %63 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %64 = arith.addf %63, %62 : f64
              affine.store %64, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %65 = affine.apply #map6(%41)
              %66 = affine.load %arg6[%arg13, %65] : memref<?x900xf64>
              %67 = affine.load %arg9[%65, %arg14] : memref<?x1200xf64>
              %68 = arith.mulf %66, %67 : f64
              %69 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %70 = arith.addf %69, %68 : f64
              affine.store %70, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %71 = affine.apply #map7(%41)
              %72 = affine.load %arg6[%arg13, %71] : memref<?x900xf64>
              %73 = affine.load %arg9[%71, %arg14] : memref<?x1200xf64>
              %74 = arith.mulf %72, %73 : f64
              %75 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %76 = arith.addf %75, %74 : f64
              affine.store %76, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %77 = affine.apply #map9(%arg15)
              %78 = affine.load %arg6[%arg13, %77] : memref<?x900xf64>
              %79 = affine.load %arg9[%77, %arg14] : memref<?x1200xf64>
              %80 = arith.mulf %78, %79 : f64
              %81 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %82 = arith.addf %81, %80 : f64
              affine.store %82, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %83 = affine.apply #map3(%77)
              %84 = affine.load %arg6[%arg13, %83] : memref<?x900xf64>
              %85 = affine.load %arg9[%83, %arg14] : memref<?x1200xf64>
              %86 = arith.mulf %84, %85 : f64
              %87 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %88 = arith.addf %87, %86 : f64
              affine.store %88, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %89 = affine.apply #map4(%77)
              %90 = affine.load %arg6[%arg13, %89] : memref<?x900xf64>
              %91 = affine.load %arg9[%89, %arg14] : memref<?x1200xf64>
              %92 = arith.mulf %90, %91 : f64
              %93 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %94 = arith.addf %93, %92 : f64
              affine.store %94, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %95 = affine.apply #map5(%77)
              %96 = affine.load %arg6[%arg13, %95] : memref<?x900xf64>
              %97 = affine.load %arg9[%95, %arg14] : memref<?x1200xf64>
              %98 = arith.mulf %96, %97 : f64
              %99 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %100 = arith.addf %99, %98 : f64
              affine.store %100, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %101 = affine.apply #map6(%77)
              %102 = affine.load %arg6[%arg13, %101] : memref<?x900xf64>
              %103 = affine.load %arg9[%101, %arg14] : memref<?x1200xf64>
              %104 = arith.mulf %102, %103 : f64
              %105 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %106 = arith.addf %105, %104 : f64
              affine.store %106, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %107 = affine.apply #map7(%77)
              %108 = affine.load %arg6[%arg13, %107] : memref<?x900xf64>
              %109 = affine.load %arg9[%107, %arg14] : memref<?x1200xf64>
              %110 = arith.mulf %108, %109 : f64
              %111 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %112 = arith.addf %111, %110 : f64
              affine.store %112, %arg10[%arg13, %arg14] : memref<?x1200xf64>
            }
            affine.for %arg15 = #map2()[%2] to #map10()[%2] step 6 {
              %6 = affine.load %arg6[%arg13, %arg15] : memref<?x900xf64>
              %7 = affine.load %arg9[%arg15, %arg14] : memref<?x1200xf64>
              %8 = arith.mulf %6, %7 : f64
              %9 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %10 = arith.addf %9, %8 : f64
              affine.store %10, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %11 = affine.apply #map3(%arg15)
              %12 = affine.load %arg6[%arg13, %11] : memref<?x900xf64>
              %13 = affine.load %arg9[%11, %arg14] : memref<?x1200xf64>
              %14 = arith.mulf %12, %13 : f64
              %15 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %16 = arith.addf %15, %14 : f64
              affine.store %16, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %17 = affine.apply #map4(%arg15)
              %18 = affine.load %arg6[%arg13, %17] : memref<?x900xf64>
              %19 = affine.load %arg9[%17, %arg14] : memref<?x1200xf64>
              %20 = arith.mulf %18, %19 : f64
              %21 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %22 = arith.addf %21, %20 : f64
              affine.store %22, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %23 = affine.apply #map5(%arg15)
              %24 = affine.load %arg6[%arg13, %23] : memref<?x900xf64>
              %25 = affine.load %arg9[%23, %arg14] : memref<?x1200xf64>
              %26 = arith.mulf %24, %25 : f64
              %27 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %28 = arith.addf %27, %26 : f64
              affine.store %28, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %29 = affine.apply #map6(%arg15)
              %30 = affine.load %arg6[%arg13, %29] : memref<?x900xf64>
              %31 = affine.load %arg9[%29, %arg14] : memref<?x1200xf64>
              %32 = arith.mulf %30, %31 : f64
              %33 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %34 = arith.addf %33, %32 : f64
              affine.store %34, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %35 = affine.apply #map7(%arg15)
              %36 = affine.load %arg6[%arg13, %35] : memref<?x900xf64>
              %37 = affine.load %arg9[%35, %arg14] : memref<?x1200xf64>
              %38 = arith.mulf %36, %37 : f64
              %39 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %40 = arith.addf %39, %38 : f64
              affine.store %40, %arg10[%arg13, %arg14] : memref<?x1200xf64>
            }
            affine.for %arg15 = #map10()[%2] to #map11()[%2] step 3 {
              %6 = affine.load %arg6[%arg13, %arg15] : memref<?x900xf64>
              %7 = affine.load %arg9[%arg15, %arg14] : memref<?x1200xf64>
              %8 = arith.mulf %6, %7 : f64
              %9 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %10 = arith.addf %9, %8 : f64
              affine.store %10, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %11 = affine.apply #map3(%arg15)
              %12 = affine.load %arg6[%arg13, %11] : memref<?x900xf64>
              %13 = affine.load %arg9[%11, %arg14] : memref<?x1200xf64>
              %14 = arith.mulf %12, %13 : f64
              %15 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %16 = arith.addf %15, %14 : f64
              affine.store %16, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %17 = affine.apply #map4(%arg15)
              %18 = affine.load %arg6[%arg13, %17] : memref<?x900xf64>
              %19 = affine.load %arg9[%17, %arg14] : memref<?x1200xf64>
              %20 = arith.mulf %18, %19 : f64
              %21 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %22 = arith.addf %21, %20 : f64
              affine.store %22, %arg10[%arg13, %arg14] : memref<?x1200xf64>
            }
            affine.for %arg15 = #map11()[%2] to %2 {
              %6 = affine.load %arg6[%arg13, %arg15] : memref<?x900xf64>
              %7 = affine.load %arg9[%arg15, %arg14] : memref<?x1200xf64>
              %8 = arith.mulf %6, %7 : f64
              %9 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %10 = arith.addf %9, %8 : f64
              affine.store %10, %arg10[%arg13, %arg14] : memref<?x1200xf64>
            }
          }
        }
      }
    }
    return
  }
}

