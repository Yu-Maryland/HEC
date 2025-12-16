#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 40, s0)>
#map2 = affine_map<()[s0] -> (s0 - 1)>
#map3 = affine_map<()[s0] -> ((((s0 - 2) floordiv 4) floordiv 3) * 12 + 1)>
#map4 = affine_map<(d0) -> (d0 + 1)>
#map5 = affine_map<(d0) -> (d0 + 2)>
#map6 = affine_map<(d0) -> (d0 + 3)>
#map7 = affine_map<(d0) -> (d0 + 4)>
#map8 = affine_map<(d0) -> (d0 + 8)>
#map9 = affine_map<()[s0] -> (((s0 - 2) floordiv 4) * 4 + 1)>
#map10 = affine_map<()[s0] -> (((s0 - 2) floordiv 4) * 4 + ((s0 - ((s0 - 2) floordiv 4) * 4 - 2) floordiv 3) * 3 + 1)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_jacobi_2d(%arg0: i32, %arg1: i32, %arg2: memref<?x1300xf64>, %arg3: memref<?x1300xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 2.000000e-01 : f64
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg0 : i32 to index
    affine.for %arg4 = 0 to %1 step 40 {
      affine.for %arg5 = #map(%arg4) to min #map1(%arg4)[%1] {
        affine.for %arg6 = 1 to #map2()[%0] {
          affine.for %arg7 = 1 to #map3()[%0] step 12 {
            %2 = affine.load %arg2[%arg6, %arg7] : memref<?x1300xf64>
            %3 = affine.load %arg2[%arg6, %arg7 - 1] : memref<?x1300xf64>
            %4 = arith.addf %2, %3 : f64
            %5 = affine.load %arg2[%arg6, %arg7 + 1] : memref<?x1300xf64>
            %6 = arith.addf %4, %5 : f64
            %7 = affine.load %arg2[%arg6 + 1, %arg7] : memref<?x1300xf64>
            %8 = arith.addf %6, %7 : f64
            %9 = affine.load %arg2[%arg6 - 1, %arg7] : memref<?x1300xf64>
            %10 = arith.addf %8, %9 : f64
            %11 = arith.mulf %10, %cst : f64
            affine.store %11, %arg3[%arg6, %arg7] : memref<?x1300xf64>
            %12 = affine.apply #map4(%arg7)
            %13 = affine.load %arg2[%arg6, %12] : memref<?x1300xf64>
            %14 = affine.load %arg2[%arg6, %12 - 1] : memref<?x1300xf64>
            %15 = arith.addf %13, %14 : f64
            %16 = affine.load %arg2[%arg6, %12 + 1] : memref<?x1300xf64>
            %17 = arith.addf %15, %16 : f64
            %18 = affine.load %arg2[%arg6 + 1, %12] : memref<?x1300xf64>
            %19 = arith.addf %17, %18 : f64
            %20 = affine.load %arg2[%arg6 - 1, %12] : memref<?x1300xf64>
            %21 = arith.addf %19, %20 : f64
            %22 = arith.mulf %21, %cst : f64
            affine.store %22, %arg3[%arg6, %12] : memref<?x1300xf64>
            %23 = affine.apply #map5(%arg7)
            %24 = affine.load %arg2[%arg6, %23] : memref<?x1300xf64>
            %25 = affine.load %arg2[%arg6, %23 - 1] : memref<?x1300xf64>
            %26 = arith.addf %24, %25 : f64
            %27 = affine.load %arg2[%arg6, %23 + 1] : memref<?x1300xf64>
            %28 = arith.addf %26, %27 : f64
            %29 = affine.load %arg2[%arg6 + 1, %23] : memref<?x1300xf64>
            %30 = arith.addf %28, %29 : f64
            %31 = affine.load %arg2[%arg6 - 1, %23] : memref<?x1300xf64>
            %32 = arith.addf %30, %31 : f64
            %33 = arith.mulf %32, %cst : f64
            affine.store %33, %arg3[%arg6, %23] : memref<?x1300xf64>
            %34 = affine.apply #map6(%arg7)
            %35 = affine.load %arg2[%arg6, %34] : memref<?x1300xf64>
            %36 = affine.load %arg2[%arg6, %34 - 1] : memref<?x1300xf64>
            %37 = arith.addf %35, %36 : f64
            %38 = affine.load %arg2[%arg6, %34 + 1] : memref<?x1300xf64>
            %39 = arith.addf %37, %38 : f64
            %40 = affine.load %arg2[%arg6 + 1, %34] : memref<?x1300xf64>
            %41 = arith.addf %39, %40 : f64
            %42 = affine.load %arg2[%arg6 - 1, %34] : memref<?x1300xf64>
            %43 = arith.addf %41, %42 : f64
            %44 = arith.mulf %43, %cst : f64
            affine.store %44, %arg3[%arg6, %34] : memref<?x1300xf64>
            %45 = affine.apply #map7(%arg7)
            %46 = affine.load %arg2[%arg6, %45] : memref<?x1300xf64>
            %47 = affine.load %arg2[%arg6, %45 - 1] : memref<?x1300xf64>
            %48 = arith.addf %46, %47 : f64
            %49 = affine.load %arg2[%arg6, %45 + 1] : memref<?x1300xf64>
            %50 = arith.addf %48, %49 : f64
            %51 = affine.load %arg2[%arg6 + 1, %45] : memref<?x1300xf64>
            %52 = arith.addf %50, %51 : f64
            %53 = affine.load %arg2[%arg6 - 1, %45] : memref<?x1300xf64>
            %54 = arith.addf %52, %53 : f64
            %55 = arith.mulf %54, %cst : f64
            affine.store %55, %arg3[%arg6, %45] : memref<?x1300xf64>
            %56 = affine.apply #map4(%45)
            %57 = affine.load %arg2[%arg6, %56] : memref<?x1300xf64>
            %58 = affine.load %arg2[%arg6, %56 - 1] : memref<?x1300xf64>
            %59 = arith.addf %57, %58 : f64
            %60 = affine.load %arg2[%arg6, %56 + 1] : memref<?x1300xf64>
            %61 = arith.addf %59, %60 : f64
            %62 = affine.load %arg2[%arg6 + 1, %56] : memref<?x1300xf64>
            %63 = arith.addf %61, %62 : f64
            %64 = affine.load %arg2[%arg6 - 1, %56] : memref<?x1300xf64>
            %65 = arith.addf %63, %64 : f64
            %66 = arith.mulf %65, %cst : f64
            affine.store %66, %arg3[%arg6, %56] : memref<?x1300xf64>
            %67 = affine.apply #map5(%45)
            %68 = affine.load %arg2[%arg6, %67] : memref<?x1300xf64>
            %69 = affine.load %arg2[%arg6, %67 - 1] : memref<?x1300xf64>
            %70 = arith.addf %68, %69 : f64
            %71 = affine.load %arg2[%arg6, %67 + 1] : memref<?x1300xf64>
            %72 = arith.addf %70, %71 : f64
            %73 = affine.load %arg2[%arg6 + 1, %67] : memref<?x1300xf64>
            %74 = arith.addf %72, %73 : f64
            %75 = affine.load %arg2[%arg6 - 1, %67] : memref<?x1300xf64>
            %76 = arith.addf %74, %75 : f64
            %77 = arith.mulf %76, %cst : f64
            affine.store %77, %arg3[%arg6, %67] : memref<?x1300xf64>
            %78 = affine.apply #map6(%45)
            %79 = affine.load %arg2[%arg6, %78] : memref<?x1300xf64>
            %80 = affine.load %arg2[%arg6, %78 - 1] : memref<?x1300xf64>
            %81 = arith.addf %79, %80 : f64
            %82 = affine.load %arg2[%arg6, %78 + 1] : memref<?x1300xf64>
            %83 = arith.addf %81, %82 : f64
            %84 = affine.load %arg2[%arg6 + 1, %78] : memref<?x1300xf64>
            %85 = arith.addf %83, %84 : f64
            %86 = affine.load %arg2[%arg6 - 1, %78] : memref<?x1300xf64>
            %87 = arith.addf %85, %86 : f64
            %88 = arith.mulf %87, %cst : f64
            affine.store %88, %arg3[%arg6, %78] : memref<?x1300xf64>
            %89 = affine.apply #map8(%arg7)
            %90 = affine.load %arg2[%arg6, %89] : memref<?x1300xf64>
            %91 = affine.load %arg2[%arg6, %89 - 1] : memref<?x1300xf64>
            %92 = arith.addf %90, %91 : f64
            %93 = affine.load %arg2[%arg6, %89 + 1] : memref<?x1300xf64>
            %94 = arith.addf %92, %93 : f64
            %95 = affine.load %arg2[%arg6 + 1, %89] : memref<?x1300xf64>
            %96 = arith.addf %94, %95 : f64
            %97 = affine.load %arg2[%arg6 - 1, %89] : memref<?x1300xf64>
            %98 = arith.addf %96, %97 : f64
            %99 = arith.mulf %98, %cst : f64
            affine.store %99, %arg3[%arg6, %89] : memref<?x1300xf64>
            %100 = affine.apply #map4(%89)
            %101 = affine.load %arg2[%arg6, %100] : memref<?x1300xf64>
            %102 = affine.load %arg2[%arg6, %100 - 1] : memref<?x1300xf64>
            %103 = arith.addf %101, %102 : f64
            %104 = affine.load %arg2[%arg6, %100 + 1] : memref<?x1300xf64>
            %105 = arith.addf %103, %104 : f64
            %106 = affine.load %arg2[%arg6 + 1, %100] : memref<?x1300xf64>
            %107 = arith.addf %105, %106 : f64
            %108 = affine.load %arg2[%arg6 - 1, %100] : memref<?x1300xf64>
            %109 = arith.addf %107, %108 : f64
            %110 = arith.mulf %109, %cst : f64
            affine.store %110, %arg3[%arg6, %100] : memref<?x1300xf64>
            %111 = affine.apply #map5(%89)
            %112 = affine.load %arg2[%arg6, %111] : memref<?x1300xf64>
            %113 = affine.load %arg2[%arg6, %111 - 1] : memref<?x1300xf64>
            %114 = arith.addf %112, %113 : f64
            %115 = affine.load %arg2[%arg6, %111 + 1] : memref<?x1300xf64>
            %116 = arith.addf %114, %115 : f64
            %117 = affine.load %arg2[%arg6 + 1, %111] : memref<?x1300xf64>
            %118 = arith.addf %116, %117 : f64
            %119 = affine.load %arg2[%arg6 - 1, %111] : memref<?x1300xf64>
            %120 = arith.addf %118, %119 : f64
            %121 = arith.mulf %120, %cst : f64
            affine.store %121, %arg3[%arg6, %111] : memref<?x1300xf64>
            %122 = affine.apply #map6(%89)
            %123 = affine.load %arg2[%arg6, %122] : memref<?x1300xf64>
            %124 = affine.load %arg2[%arg6, %122 - 1] : memref<?x1300xf64>
            %125 = arith.addf %123, %124 : f64
            %126 = affine.load %arg2[%arg6, %122 + 1] : memref<?x1300xf64>
            %127 = arith.addf %125, %126 : f64
            %128 = affine.load %arg2[%arg6 + 1, %122] : memref<?x1300xf64>
            %129 = arith.addf %127, %128 : f64
            %130 = affine.load %arg2[%arg6 - 1, %122] : memref<?x1300xf64>
            %131 = arith.addf %129, %130 : f64
            %132 = arith.mulf %131, %cst : f64
            affine.store %132, %arg3[%arg6, %122] : memref<?x1300xf64>
          }
          affine.for %arg7 = #map3()[%0] to #map9()[%0] step 4 {
            %2 = affine.load %arg2[%arg6, %arg7] : memref<?x1300xf64>
            %3 = affine.load %arg2[%arg6, %arg7 - 1] : memref<?x1300xf64>
            %4 = arith.addf %2, %3 : f64
            %5 = affine.load %arg2[%arg6, %arg7 + 1] : memref<?x1300xf64>
            %6 = arith.addf %4, %5 : f64
            %7 = affine.load %arg2[%arg6 + 1, %arg7] : memref<?x1300xf64>
            %8 = arith.addf %6, %7 : f64
            %9 = affine.load %arg2[%arg6 - 1, %arg7] : memref<?x1300xf64>
            %10 = arith.addf %8, %9 : f64
            %11 = arith.mulf %10, %cst : f64
            affine.store %11, %arg3[%arg6, %arg7] : memref<?x1300xf64>
            %12 = affine.apply #map4(%arg7)
            %13 = affine.load %arg2[%arg6, %12] : memref<?x1300xf64>
            %14 = affine.load %arg2[%arg6, %12 - 1] : memref<?x1300xf64>
            %15 = arith.addf %13, %14 : f64
            %16 = affine.load %arg2[%arg6, %12 + 1] : memref<?x1300xf64>
            %17 = arith.addf %15, %16 : f64
            %18 = affine.load %arg2[%arg6 + 1, %12] : memref<?x1300xf64>
            %19 = arith.addf %17, %18 : f64
            %20 = affine.load %arg2[%arg6 - 1, %12] : memref<?x1300xf64>
            %21 = arith.addf %19, %20 : f64
            %22 = arith.mulf %21, %cst : f64
            affine.store %22, %arg3[%arg6, %12] : memref<?x1300xf64>
            %23 = affine.apply #map5(%arg7)
            %24 = affine.load %arg2[%arg6, %23] : memref<?x1300xf64>
            %25 = affine.load %arg2[%arg6, %23 - 1] : memref<?x1300xf64>
            %26 = arith.addf %24, %25 : f64
            %27 = affine.load %arg2[%arg6, %23 + 1] : memref<?x1300xf64>
            %28 = arith.addf %26, %27 : f64
            %29 = affine.load %arg2[%arg6 + 1, %23] : memref<?x1300xf64>
            %30 = arith.addf %28, %29 : f64
            %31 = affine.load %arg2[%arg6 - 1, %23] : memref<?x1300xf64>
            %32 = arith.addf %30, %31 : f64
            %33 = arith.mulf %32, %cst : f64
            affine.store %33, %arg3[%arg6, %23] : memref<?x1300xf64>
            %34 = affine.apply #map6(%arg7)
            %35 = affine.load %arg2[%arg6, %34] : memref<?x1300xf64>
            %36 = affine.load %arg2[%arg6, %34 - 1] : memref<?x1300xf64>
            %37 = arith.addf %35, %36 : f64
            %38 = affine.load %arg2[%arg6, %34 + 1] : memref<?x1300xf64>
            %39 = arith.addf %37, %38 : f64
            %40 = affine.load %arg2[%arg6 + 1, %34] : memref<?x1300xf64>
            %41 = arith.addf %39, %40 : f64
            %42 = affine.load %arg2[%arg6 - 1, %34] : memref<?x1300xf64>
            %43 = arith.addf %41, %42 : f64
            %44 = arith.mulf %43, %cst : f64
            affine.store %44, %arg3[%arg6, %34] : memref<?x1300xf64>
          }
          affine.for %arg7 = #map9()[%0] to #map10()[%0] step 3 {
            %2 = affine.load %arg2[%arg6, %arg7] : memref<?x1300xf64>
            %3 = affine.load %arg2[%arg6, %arg7 - 1] : memref<?x1300xf64>
            %4 = arith.addf %2, %3 : f64
            %5 = affine.load %arg2[%arg6, %arg7 + 1] : memref<?x1300xf64>
            %6 = arith.addf %4, %5 : f64
            %7 = affine.load %arg2[%arg6 + 1, %arg7] : memref<?x1300xf64>
            %8 = arith.addf %6, %7 : f64
            %9 = affine.load %arg2[%arg6 - 1, %arg7] : memref<?x1300xf64>
            %10 = arith.addf %8, %9 : f64
            %11 = arith.mulf %10, %cst : f64
            affine.store %11, %arg3[%arg6, %arg7] : memref<?x1300xf64>
            %12 = affine.apply #map4(%arg7)
            %13 = affine.load %arg2[%arg6, %12] : memref<?x1300xf64>
            %14 = affine.load %arg2[%arg6, %12 - 1] : memref<?x1300xf64>
            %15 = arith.addf %13, %14 : f64
            %16 = affine.load %arg2[%arg6, %12 + 1] : memref<?x1300xf64>
            %17 = arith.addf %15, %16 : f64
            %18 = affine.load %arg2[%arg6 + 1, %12] : memref<?x1300xf64>
            %19 = arith.addf %17, %18 : f64
            %20 = affine.load %arg2[%arg6 - 1, %12] : memref<?x1300xf64>
            %21 = arith.addf %19, %20 : f64
            %22 = arith.mulf %21, %cst : f64
            affine.store %22, %arg3[%arg6, %12] : memref<?x1300xf64>
            %23 = affine.apply #map5(%arg7)
            %24 = affine.load %arg2[%arg6, %23] : memref<?x1300xf64>
            %25 = affine.load %arg2[%arg6, %23 - 1] : memref<?x1300xf64>
            %26 = arith.addf %24, %25 : f64
            %27 = affine.load %arg2[%arg6, %23 + 1] : memref<?x1300xf64>
            %28 = arith.addf %26, %27 : f64
            %29 = affine.load %arg2[%arg6 + 1, %23] : memref<?x1300xf64>
            %30 = arith.addf %28, %29 : f64
            %31 = affine.load %arg2[%arg6 - 1, %23] : memref<?x1300xf64>
            %32 = arith.addf %30, %31 : f64
            %33 = arith.mulf %32, %cst : f64
            affine.store %33, %arg3[%arg6, %23] : memref<?x1300xf64>
          }
          affine.for %arg7 = #map10()[%0] to #map2()[%0] {
            %2 = affine.load %arg2[%arg6, %arg7] : memref<?x1300xf64>
            %3 = affine.load %arg2[%arg6, %arg7 - 1] : memref<?x1300xf64>
            %4 = arith.addf %2, %3 : f64
            %5 = affine.load %arg2[%arg6, %arg7 + 1] : memref<?x1300xf64>
            %6 = arith.addf %4, %5 : f64
            %7 = affine.load %arg2[%arg6 + 1, %arg7] : memref<?x1300xf64>
            %8 = arith.addf %6, %7 : f64
            %9 = affine.load %arg2[%arg6 - 1, %arg7] : memref<?x1300xf64>
            %10 = arith.addf %8, %9 : f64
            %11 = arith.mulf %10, %cst : f64
            affine.store %11, %arg3[%arg6, %arg7] : memref<?x1300xf64>
          }
        }
        affine.for %arg6 = 1 to #map2()[%0] {
          affine.for %arg7 = 1 to #map3()[%0] step 12 {
            %2 = affine.load %arg3[%arg6, %arg7] : memref<?x1300xf64>
            %3 = affine.load %arg3[%arg6, %arg7 - 1] : memref<?x1300xf64>
            %4 = arith.addf %2, %3 : f64
            %5 = affine.load %arg3[%arg6, %arg7 + 1] : memref<?x1300xf64>
            %6 = arith.addf %4, %5 : f64
            %7 = affine.load %arg3[%arg6 + 1, %arg7] : memref<?x1300xf64>
            %8 = arith.addf %6, %7 : f64
            %9 = affine.load %arg3[%arg6 - 1, %arg7] : memref<?x1300xf64>
            %10 = arith.addf %8, %9 : f64
            %11 = arith.mulf %10, %cst : f64
            affine.store %11, %arg2[%arg6, %arg7] : memref<?x1300xf64>
            %12 = affine.apply #map4(%arg7)
            %13 = affine.load %arg3[%arg6, %12] : memref<?x1300xf64>
            %14 = affine.load %arg3[%arg6, %12 - 1] : memref<?x1300xf64>
            %15 = arith.addf %13, %14 : f64
            %16 = affine.load %arg3[%arg6, %12 + 1] : memref<?x1300xf64>
            %17 = arith.addf %15, %16 : f64
            %18 = affine.load %arg3[%arg6 + 1, %12] : memref<?x1300xf64>
            %19 = arith.addf %17, %18 : f64
            %20 = affine.load %arg3[%arg6 - 1, %12] : memref<?x1300xf64>
            %21 = arith.addf %19, %20 : f64
            %22 = arith.mulf %21, %cst : f64
            affine.store %22, %arg2[%arg6, %12] : memref<?x1300xf64>
            %23 = affine.apply #map5(%arg7)
            %24 = affine.load %arg3[%arg6, %23] : memref<?x1300xf64>
            %25 = affine.load %arg3[%arg6, %23 - 1] : memref<?x1300xf64>
            %26 = arith.addf %24, %25 : f64
            %27 = affine.load %arg3[%arg6, %23 + 1] : memref<?x1300xf64>
            %28 = arith.addf %26, %27 : f64
            %29 = affine.load %arg3[%arg6 + 1, %23] : memref<?x1300xf64>
            %30 = arith.addf %28, %29 : f64
            %31 = affine.load %arg3[%arg6 - 1, %23] : memref<?x1300xf64>
            %32 = arith.addf %30, %31 : f64
            %33 = arith.mulf %32, %cst : f64
            affine.store %33, %arg2[%arg6, %23] : memref<?x1300xf64>
            %34 = affine.apply #map6(%arg7)
            %35 = affine.load %arg3[%arg6, %34] : memref<?x1300xf64>
            %36 = affine.load %arg3[%arg6, %34 - 1] : memref<?x1300xf64>
            %37 = arith.addf %35, %36 : f64
            %38 = affine.load %arg3[%arg6, %34 + 1] : memref<?x1300xf64>
            %39 = arith.addf %37, %38 : f64
            %40 = affine.load %arg3[%arg6 + 1, %34] : memref<?x1300xf64>
            %41 = arith.addf %39, %40 : f64
            %42 = affine.load %arg3[%arg6 - 1, %34] : memref<?x1300xf64>
            %43 = arith.addf %41, %42 : f64
            %44 = arith.mulf %43, %cst : f64
            affine.store %44, %arg2[%arg6, %34] : memref<?x1300xf64>
            %45 = affine.apply #map7(%arg7)
            %46 = affine.load %arg3[%arg6, %45] : memref<?x1300xf64>
            %47 = affine.load %arg3[%arg6, %45 - 1] : memref<?x1300xf64>
            %48 = arith.addf %46, %47 : f64
            %49 = affine.load %arg3[%arg6, %45 + 1] : memref<?x1300xf64>
            %50 = arith.addf %48, %49 : f64
            %51 = affine.load %arg3[%arg6 + 1, %45] : memref<?x1300xf64>
            %52 = arith.addf %50, %51 : f64
            %53 = affine.load %arg3[%arg6 - 1, %45] : memref<?x1300xf64>
            %54 = arith.addf %52, %53 : f64
            %55 = arith.mulf %54, %cst : f64
            affine.store %55, %arg2[%arg6, %45] : memref<?x1300xf64>
            %56 = affine.apply #map4(%45)
            %57 = affine.load %arg3[%arg6, %56] : memref<?x1300xf64>
            %58 = affine.load %arg3[%arg6, %56 - 1] : memref<?x1300xf64>
            %59 = arith.addf %57, %58 : f64
            %60 = affine.load %arg3[%arg6, %56 + 1] : memref<?x1300xf64>
            %61 = arith.addf %59, %60 : f64
            %62 = affine.load %arg3[%arg6 + 1, %56] : memref<?x1300xf64>
            %63 = arith.addf %61, %62 : f64
            %64 = affine.load %arg3[%arg6 - 1, %56] : memref<?x1300xf64>
            %65 = arith.addf %63, %64 : f64
            %66 = arith.mulf %65, %cst : f64
            affine.store %66, %arg2[%arg6, %56] : memref<?x1300xf64>
            %67 = affine.apply #map5(%45)
            %68 = affine.load %arg3[%arg6, %67] : memref<?x1300xf64>
            %69 = affine.load %arg3[%arg6, %67 - 1] : memref<?x1300xf64>
            %70 = arith.addf %68, %69 : f64
            %71 = affine.load %arg3[%arg6, %67 + 1] : memref<?x1300xf64>
            %72 = arith.addf %70, %71 : f64
            %73 = affine.load %arg3[%arg6 + 1, %67] : memref<?x1300xf64>
            %74 = arith.addf %72, %73 : f64
            %75 = affine.load %arg3[%arg6 - 1, %67] : memref<?x1300xf64>
            %76 = arith.addf %74, %75 : f64
            %77 = arith.mulf %76, %cst : f64
            affine.store %77, %arg2[%arg6, %67] : memref<?x1300xf64>
            %78 = affine.apply #map6(%45)
            %79 = affine.load %arg3[%arg6, %78] : memref<?x1300xf64>
            %80 = affine.load %arg3[%arg6, %78 - 1] : memref<?x1300xf64>
            %81 = arith.addf %79, %80 : f64
            %82 = affine.load %arg3[%arg6, %78 + 1] : memref<?x1300xf64>
            %83 = arith.addf %81, %82 : f64
            %84 = affine.load %arg3[%arg6 + 1, %78] : memref<?x1300xf64>
            %85 = arith.addf %83, %84 : f64
            %86 = affine.load %arg3[%arg6 - 1, %78] : memref<?x1300xf64>
            %87 = arith.addf %85, %86 : f64
            %88 = arith.mulf %87, %cst : f64
            affine.store %88, %arg2[%arg6, %78] : memref<?x1300xf64>
            %89 = affine.apply #map8(%arg7)
            %90 = affine.load %arg3[%arg6, %89] : memref<?x1300xf64>
            %91 = affine.load %arg3[%arg6, %89 - 1] : memref<?x1300xf64>
            %92 = arith.addf %90, %91 : f64
            %93 = affine.load %arg3[%arg6, %89 + 1] : memref<?x1300xf64>
            %94 = arith.addf %92, %93 : f64
            %95 = affine.load %arg3[%arg6 + 1, %89] : memref<?x1300xf64>
            %96 = arith.addf %94, %95 : f64
            %97 = affine.load %arg3[%arg6 - 1, %89] : memref<?x1300xf64>
            %98 = arith.addf %96, %97 : f64
            %99 = arith.mulf %98, %cst : f64
            affine.store %99, %arg2[%arg6, %89] : memref<?x1300xf64>
            %100 = affine.apply #map4(%89)
            %101 = affine.load %arg3[%arg6, %100] : memref<?x1300xf64>
            %102 = affine.load %arg3[%arg6, %100 - 1] : memref<?x1300xf64>
            %103 = arith.addf %101, %102 : f64
            %104 = affine.load %arg3[%arg6, %100 + 1] : memref<?x1300xf64>
            %105 = arith.addf %103, %104 : f64
            %106 = affine.load %arg3[%arg6 + 1, %100] : memref<?x1300xf64>
            %107 = arith.addf %105, %106 : f64
            %108 = affine.load %arg3[%arg6 - 1, %100] : memref<?x1300xf64>
            %109 = arith.addf %107, %108 : f64
            %110 = arith.mulf %109, %cst : f64
            affine.store %110, %arg2[%arg6, %100] : memref<?x1300xf64>
            %111 = affine.apply #map5(%89)
            %112 = affine.load %arg3[%arg6, %111] : memref<?x1300xf64>
            %113 = affine.load %arg3[%arg6, %111 - 1] : memref<?x1300xf64>
            %114 = arith.addf %112, %113 : f64
            %115 = affine.load %arg3[%arg6, %111 + 1] : memref<?x1300xf64>
            %116 = arith.addf %114, %115 : f64
            %117 = affine.load %arg3[%arg6 + 1, %111] : memref<?x1300xf64>
            %118 = arith.addf %116, %117 : f64
            %119 = affine.load %arg3[%arg6 - 1, %111] : memref<?x1300xf64>
            %120 = arith.addf %118, %119 : f64
            %121 = arith.mulf %120, %cst : f64
            affine.store %121, %arg2[%arg6, %111] : memref<?x1300xf64>
            %122 = affine.apply #map6(%89)
            %123 = affine.load %arg3[%arg6, %122] : memref<?x1300xf64>
            %124 = affine.load %arg3[%arg6, %122 - 1] : memref<?x1300xf64>
            %125 = arith.addf %123, %124 : f64
            %126 = affine.load %arg3[%arg6, %122 + 1] : memref<?x1300xf64>
            %127 = arith.addf %125, %126 : f64
            %128 = affine.load %arg3[%arg6 + 1, %122] : memref<?x1300xf64>
            %129 = arith.addf %127, %128 : f64
            %130 = affine.load %arg3[%arg6 - 1, %122] : memref<?x1300xf64>
            %131 = arith.addf %129, %130 : f64
            %132 = arith.mulf %131, %cst : f64
            affine.store %132, %arg2[%arg6, %122] : memref<?x1300xf64>
          }
          affine.for %arg7 = #map3()[%0] to #map9()[%0] step 4 {
            %2 = affine.load %arg3[%arg6, %arg7] : memref<?x1300xf64>
            %3 = affine.load %arg3[%arg6, %arg7 - 1] : memref<?x1300xf64>
            %4 = arith.addf %2, %3 : f64
            %5 = affine.load %arg3[%arg6, %arg7 + 1] : memref<?x1300xf64>
            %6 = arith.addf %4, %5 : f64
            %7 = affine.load %arg3[%arg6 + 1, %arg7] : memref<?x1300xf64>
            %8 = arith.addf %6, %7 : f64
            %9 = affine.load %arg3[%arg6 - 1, %arg7] : memref<?x1300xf64>
            %10 = arith.addf %8, %9 : f64
            %11 = arith.mulf %10, %cst : f64
            affine.store %11, %arg2[%arg6, %arg7] : memref<?x1300xf64>
            %12 = affine.apply #map4(%arg7)
            %13 = affine.load %arg3[%arg6, %12] : memref<?x1300xf64>
            %14 = affine.load %arg3[%arg6, %12 - 1] : memref<?x1300xf64>
            %15 = arith.addf %13, %14 : f64
            %16 = affine.load %arg3[%arg6, %12 + 1] : memref<?x1300xf64>
            %17 = arith.addf %15, %16 : f64
            %18 = affine.load %arg3[%arg6 + 1, %12] : memref<?x1300xf64>
            %19 = arith.addf %17, %18 : f64
            %20 = affine.load %arg3[%arg6 - 1, %12] : memref<?x1300xf64>
            %21 = arith.addf %19, %20 : f64
            %22 = arith.mulf %21, %cst : f64
            affine.store %22, %arg2[%arg6, %12] : memref<?x1300xf64>
            %23 = affine.apply #map5(%arg7)
            %24 = affine.load %arg3[%arg6, %23] : memref<?x1300xf64>
            %25 = affine.load %arg3[%arg6, %23 - 1] : memref<?x1300xf64>
            %26 = arith.addf %24, %25 : f64
            %27 = affine.load %arg3[%arg6, %23 + 1] : memref<?x1300xf64>
            %28 = arith.addf %26, %27 : f64
            %29 = affine.load %arg3[%arg6 + 1, %23] : memref<?x1300xf64>
            %30 = arith.addf %28, %29 : f64
            %31 = affine.load %arg3[%arg6 - 1, %23] : memref<?x1300xf64>
            %32 = arith.addf %30, %31 : f64
            %33 = arith.mulf %32, %cst : f64
            affine.store %33, %arg2[%arg6, %23] : memref<?x1300xf64>
            %34 = affine.apply #map6(%arg7)
            %35 = affine.load %arg3[%arg6, %34] : memref<?x1300xf64>
            %36 = affine.load %arg3[%arg6, %34 - 1] : memref<?x1300xf64>
            %37 = arith.addf %35, %36 : f64
            %38 = affine.load %arg3[%arg6, %34 + 1] : memref<?x1300xf64>
            %39 = arith.addf %37, %38 : f64
            %40 = affine.load %arg3[%arg6 + 1, %34] : memref<?x1300xf64>
            %41 = arith.addf %39, %40 : f64
            %42 = affine.load %arg3[%arg6 - 1, %34] : memref<?x1300xf64>
            %43 = arith.addf %41, %42 : f64
            %44 = arith.mulf %43, %cst : f64
            affine.store %44, %arg2[%arg6, %34] : memref<?x1300xf64>
          }
          affine.for %arg7 = #map9()[%0] to #map10()[%0] step 3 {
            %2 = affine.load %arg3[%arg6, %arg7] : memref<?x1300xf64>
            %3 = affine.load %arg3[%arg6, %arg7 - 1] : memref<?x1300xf64>
            %4 = arith.addf %2, %3 : f64
            %5 = affine.load %arg3[%arg6, %arg7 + 1] : memref<?x1300xf64>
            %6 = arith.addf %4, %5 : f64
            %7 = affine.load %arg3[%arg6 + 1, %arg7] : memref<?x1300xf64>
            %8 = arith.addf %6, %7 : f64
            %9 = affine.load %arg3[%arg6 - 1, %arg7] : memref<?x1300xf64>
            %10 = arith.addf %8, %9 : f64
            %11 = arith.mulf %10, %cst : f64
            affine.store %11, %arg2[%arg6, %arg7] : memref<?x1300xf64>
            %12 = affine.apply #map4(%arg7)
            %13 = affine.load %arg3[%arg6, %12] : memref<?x1300xf64>
            %14 = affine.load %arg3[%arg6, %12 - 1] : memref<?x1300xf64>
            %15 = arith.addf %13, %14 : f64
            %16 = affine.load %arg3[%arg6, %12 + 1] : memref<?x1300xf64>
            %17 = arith.addf %15, %16 : f64
            %18 = affine.load %arg3[%arg6 + 1, %12] : memref<?x1300xf64>
            %19 = arith.addf %17, %18 : f64
            %20 = affine.load %arg3[%arg6 - 1, %12] : memref<?x1300xf64>
            %21 = arith.addf %19, %20 : f64
            %22 = arith.mulf %21, %cst : f64
            affine.store %22, %arg2[%arg6, %12] : memref<?x1300xf64>
            %23 = affine.apply #map5(%arg7)
            %24 = affine.load %arg3[%arg6, %23] : memref<?x1300xf64>
            %25 = affine.load %arg3[%arg6, %23 - 1] : memref<?x1300xf64>
            %26 = arith.addf %24, %25 : f64
            %27 = affine.load %arg3[%arg6, %23 + 1] : memref<?x1300xf64>
            %28 = arith.addf %26, %27 : f64
            %29 = affine.load %arg3[%arg6 + 1, %23] : memref<?x1300xf64>
            %30 = arith.addf %28, %29 : f64
            %31 = affine.load %arg3[%arg6 - 1, %23] : memref<?x1300xf64>
            %32 = arith.addf %30, %31 : f64
            %33 = arith.mulf %32, %cst : f64
            affine.store %33, %arg2[%arg6, %23] : memref<?x1300xf64>
          }
          affine.for %arg7 = #map10()[%0] to #map2()[%0] {
            %2 = affine.load %arg3[%arg6, %arg7] : memref<?x1300xf64>
            %3 = affine.load %arg3[%arg6, %arg7 - 1] : memref<?x1300xf64>
            %4 = arith.addf %2, %3 : f64
            %5 = affine.load %arg3[%arg6, %arg7 + 1] : memref<?x1300xf64>
            %6 = arith.addf %4, %5 : f64
            %7 = affine.load %arg3[%arg6 + 1, %arg7] : memref<?x1300xf64>
            %8 = arith.addf %6, %7 : f64
            %9 = affine.load %arg3[%arg6 - 1, %arg7] : memref<?x1300xf64>
            %10 = arith.addf %8, %9 : f64
            %11 = arith.mulf %10, %cst : f64
            affine.store %11, %arg2[%arg6, %arg7] : memref<?x1300xf64>
          }
        }
      }
    }
    return
  }
}

