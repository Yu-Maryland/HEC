#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 70, s0)>
#map2 = affine_map<()[s0] -> ((((s0 - 2) floordiv 3) floordiv 4) * 12 + 1)>
#map3 = affine_map<(d0) -> (d0 + 1)>
#map4 = affine_map<(d0) -> (d0 + 2)>
#map5 = affine_map<(d0) -> (d0 + 3)>
#map6 = affine_map<(d0) -> (d0 + 6)>
#map7 = affine_map<(d0) -> (d0 + 9)>
#map8 = affine_map<()[s0] -> (((s0 - 2) floordiv 3) * 3 + 1)>
#map9 = affine_map<()[s0] -> (((s0 - 2) floordiv 3) * 3 + ((s0 - ((s0 - 2) floordiv 3) * 3 - 2) floordiv 4) * 4 + 1)>
#map10 = affine_map<()[s0] -> (s0 - 1)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>, #dlti.dl_entry<"dlti.endianness", "little">>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_jacobi_1d(%arg0: i32, %arg1: i32, %arg2: memref<?xf64>, %arg3: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 3.333300e-01 : f64
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg0 : i32 to index
    affine.for %arg4 = 0 to %1 step 70 {
      affine.for %arg5 = #map(%arg4) to min #map1(%arg4)[%1] {
        affine.for %arg6 = 1 to #map2()[%0] step 12 {
          %2 = affine.load %arg2[%arg6 - 1] : memref<?xf64>
          %3 = affine.load %arg2[%arg6] : memref<?xf64>
          %4 = arith.addf %2, %3 : f64
          %5 = affine.load %arg2[%arg6 + 1] : memref<?xf64>
          %6 = arith.addf %4, %5 : f64
          %7 = arith.mulf %6, %cst : f64
          affine.store %7, %arg3[%arg6] : memref<?xf64>
          %8 = affine.apply #map3(%arg6)
          %9 = affine.load %arg2[%8 - 1] : memref<?xf64>
          %10 = affine.load %arg2[%8] : memref<?xf64>
          %11 = arith.addf %9, %10 : f64
          %12 = affine.load %arg2[%8 + 1] : memref<?xf64>
          %13 = arith.addf %11, %12 : f64
          %14 = arith.mulf %13, %cst : f64
          affine.store %14, %arg3[%8] : memref<?xf64>
          %15 = affine.apply #map4(%arg6)
          %16 = affine.load %arg2[%15 - 1] : memref<?xf64>
          %17 = affine.load %arg2[%15] : memref<?xf64>
          %18 = arith.addf %16, %17 : f64
          %19 = affine.load %arg2[%15 + 1] : memref<?xf64>
          %20 = arith.addf %18, %19 : f64
          %21 = arith.mulf %20, %cst : f64
          affine.store %21, %arg3[%15] : memref<?xf64>
          %22 = affine.apply #map5(%arg6)
          %23 = affine.load %arg2[%22 - 1] : memref<?xf64>
          %24 = affine.load %arg2[%22] : memref<?xf64>
          %25 = arith.addf %23, %24 : f64
          %26 = affine.load %arg2[%22 + 1] : memref<?xf64>
          %27 = arith.addf %25, %26 : f64
          %28 = arith.mulf %27, %cst : f64
          affine.store %28, %arg3[%22] : memref<?xf64>
          %29 = affine.apply #map3(%22)
          %30 = affine.load %arg2[%29 - 1] : memref<?xf64>
          %31 = affine.load %arg2[%29] : memref<?xf64>
          %32 = arith.addf %30, %31 : f64
          %33 = affine.load %arg2[%29 + 1] : memref<?xf64>
          %34 = arith.addf %32, %33 : f64
          %35 = arith.mulf %34, %cst : f64
          affine.store %35, %arg3[%29] : memref<?xf64>
          %36 = affine.apply #map4(%22)
          %37 = affine.load %arg2[%36 - 1] : memref<?xf64>
          %38 = affine.load %arg2[%36] : memref<?xf64>
          %39 = arith.addf %37, %38 : f64
          %40 = affine.load %arg2[%36 + 1] : memref<?xf64>
          %41 = arith.addf %39, %40 : f64
          %42 = arith.mulf %41, %cst : f64
          affine.store %42, %arg3[%36] : memref<?xf64>
          %43 = affine.apply #map6(%arg6)
          %44 = affine.load %arg2[%43 - 1] : memref<?xf64>
          %45 = affine.load %arg2[%43] : memref<?xf64>
          %46 = arith.addf %44, %45 : f64
          %47 = affine.load %arg2[%43 + 1] : memref<?xf64>
          %48 = arith.addf %46, %47 : f64
          %49 = arith.mulf %48, %cst : f64
          affine.store %49, %arg3[%43] : memref<?xf64>
          %50 = affine.apply #map3(%43)
          %51 = affine.load %arg2[%50 - 1] : memref<?xf64>
          %52 = affine.load %arg2[%50] : memref<?xf64>
          %53 = arith.addf %51, %52 : f64
          %54 = affine.load %arg2[%50 + 1] : memref<?xf64>
          %55 = arith.addf %53, %54 : f64
          %56 = arith.mulf %55, %cst : f64
          affine.store %56, %arg3[%50] : memref<?xf64>
          %57 = affine.apply #map4(%43)
          %58 = affine.load %arg2[%57 - 1] : memref<?xf64>
          %59 = affine.load %arg2[%57] : memref<?xf64>
          %60 = arith.addf %58, %59 : f64
          %61 = affine.load %arg2[%57 + 1] : memref<?xf64>
          %62 = arith.addf %60, %61 : f64
          %63 = arith.mulf %62, %cst : f64
          affine.store %63, %arg3[%57] : memref<?xf64>
          %64 = affine.apply #map7(%arg6)
          %65 = affine.load %arg2[%64 - 1] : memref<?xf64>
          %66 = affine.load %arg2[%64] : memref<?xf64>
          %67 = arith.addf %65, %66 : f64
          %68 = affine.load %arg2[%64 + 1] : memref<?xf64>
          %69 = arith.addf %67, %68 : f64
          %70 = arith.mulf %69, %cst : f64
          affine.store %70, %arg3[%64] : memref<?xf64>
          %71 = affine.apply #map3(%64)
          %72 = affine.load %arg2[%71 - 1] : memref<?xf64>
          %73 = affine.load %arg2[%71] : memref<?xf64>
          %74 = arith.addf %72, %73 : f64
          %75 = affine.load %arg2[%71 + 1] : memref<?xf64>
          %76 = arith.addf %74, %75 : f64
          %77 = arith.mulf %76, %cst : f64
          affine.store %77, %arg3[%71] : memref<?xf64>
          %78 = affine.apply #map4(%64)
          %79 = affine.load %arg2[%78 - 1] : memref<?xf64>
          %80 = affine.load %arg2[%78] : memref<?xf64>
          %81 = arith.addf %79, %80 : f64
          %82 = affine.load %arg2[%78 + 1] : memref<?xf64>
          %83 = arith.addf %81, %82 : f64
          %84 = arith.mulf %83, %cst : f64
          affine.store %84, %arg3[%78] : memref<?xf64>
        }
        affine.for %arg6 = #map2()[%0] to #map8()[%0] step 3 {
          %2 = affine.load %arg2[%arg6 - 1] : memref<?xf64>
          %3 = affine.load %arg2[%arg6] : memref<?xf64>
          %4 = arith.addf %2, %3 : f64
          %5 = affine.load %arg2[%arg6 + 1] : memref<?xf64>
          %6 = arith.addf %4, %5 : f64
          %7 = arith.mulf %6, %cst : f64
          affine.store %7, %arg3[%arg6] : memref<?xf64>
          %8 = affine.apply #map3(%arg6)
          %9 = affine.load %arg2[%8 - 1] : memref<?xf64>
          %10 = affine.load %arg2[%8] : memref<?xf64>
          %11 = arith.addf %9, %10 : f64
          %12 = affine.load %arg2[%8 + 1] : memref<?xf64>
          %13 = arith.addf %11, %12 : f64
          %14 = arith.mulf %13, %cst : f64
          affine.store %14, %arg3[%8] : memref<?xf64>
          %15 = affine.apply #map4(%arg6)
          %16 = affine.load %arg2[%15 - 1] : memref<?xf64>
          %17 = affine.load %arg2[%15] : memref<?xf64>
          %18 = arith.addf %16, %17 : f64
          %19 = affine.load %arg2[%15 + 1] : memref<?xf64>
          %20 = arith.addf %18, %19 : f64
          %21 = arith.mulf %20, %cst : f64
          affine.store %21, %arg3[%15] : memref<?xf64>
        }
        affine.for %arg6 = #map8()[%0] to #map9()[%0] step 4 {
          %2 = affine.load %arg2[%arg6 - 1] : memref<?xf64>
          %3 = affine.load %arg2[%arg6] : memref<?xf64>
          %4 = arith.addf %2, %3 : f64
          %5 = affine.load %arg2[%arg6 + 1] : memref<?xf64>
          %6 = arith.addf %4, %5 : f64
          %7 = arith.mulf %6, %cst : f64
          affine.store %7, %arg3[%arg6] : memref<?xf64>
          %8 = affine.apply #map3(%arg6)
          %9 = affine.load %arg2[%8 - 1] : memref<?xf64>
          %10 = affine.load %arg2[%8] : memref<?xf64>
          %11 = arith.addf %9, %10 : f64
          %12 = affine.load %arg2[%8 + 1] : memref<?xf64>
          %13 = arith.addf %11, %12 : f64
          %14 = arith.mulf %13, %cst : f64
          affine.store %14, %arg3[%8] : memref<?xf64>
          %15 = affine.apply #map4(%arg6)
          %16 = affine.load %arg2[%15 - 1] : memref<?xf64>
          %17 = affine.load %arg2[%15] : memref<?xf64>
          %18 = arith.addf %16, %17 : f64
          %19 = affine.load %arg2[%15 + 1] : memref<?xf64>
          %20 = arith.addf %18, %19 : f64
          %21 = arith.mulf %20, %cst : f64
          affine.store %21, %arg3[%15] : memref<?xf64>
          %22 = affine.apply #map5(%arg6)
          %23 = affine.load %arg2[%22 - 1] : memref<?xf64>
          %24 = affine.load %arg2[%22] : memref<?xf64>
          %25 = arith.addf %23, %24 : f64
          %26 = affine.load %arg2[%22 + 1] : memref<?xf64>
          %27 = arith.addf %25, %26 : f64
          %28 = arith.mulf %27, %cst : f64
          affine.store %28, %arg3[%22] : memref<?xf64>
        }
        affine.for %arg6 = #map9()[%0] to #map10()[%0] {
          %2 = affine.load %arg2[%arg6 - 1] : memref<?xf64>
          %3 = affine.load %arg2[%arg6] : memref<?xf64>
          %4 = arith.addf %2, %3 : f64
          %5 = affine.load %arg2[%arg6 + 1] : memref<?xf64>
          %6 = arith.addf %4, %5 : f64
          %7 = arith.mulf %6, %cst : f64
          affine.store %7, %arg3[%arg6] : memref<?xf64>
        }
        affine.for %arg6 = 1 to #map2()[%0] step 12 {
          %2 = affine.load %arg3[%arg6 - 1] : memref<?xf64>
          %3 = affine.load %arg3[%arg6] : memref<?xf64>
          %4 = arith.addf %2, %3 : f64
          %5 = affine.load %arg3[%arg6 + 1] : memref<?xf64>
          %6 = arith.addf %4, %5 : f64
          %7 = arith.mulf %6, %cst : f64
          affine.store %7, %arg2[%arg6] : memref<?xf64>
          %8 = affine.apply #map3(%arg6)
          %9 = affine.load %arg3[%8 - 1] : memref<?xf64>
          %10 = affine.load %arg3[%8] : memref<?xf64>
          %11 = arith.addf %9, %10 : f64
          %12 = affine.load %arg3[%8 + 1] : memref<?xf64>
          %13 = arith.addf %11, %12 : f64
          %14 = arith.mulf %13, %cst : f64
          affine.store %14, %arg2[%8] : memref<?xf64>
          %15 = affine.apply #map4(%arg6)
          %16 = affine.load %arg3[%15 - 1] : memref<?xf64>
          %17 = affine.load %arg3[%15] : memref<?xf64>
          %18 = arith.addf %16, %17 : f64
          %19 = affine.load %arg3[%15 + 1] : memref<?xf64>
          %20 = arith.addf %18, %19 : f64
          %21 = arith.mulf %20, %cst : f64
          affine.store %21, %arg2[%15] : memref<?xf64>
          %22 = affine.apply #map5(%arg6)
          %23 = affine.load %arg3[%22 - 1] : memref<?xf64>
          %24 = affine.load %arg3[%22] : memref<?xf64>
          %25 = arith.addf %23, %24 : f64
          %26 = affine.load %arg3[%22 + 1] : memref<?xf64>
          %27 = arith.addf %25, %26 : f64
          %28 = arith.mulf %27, %cst : f64
          affine.store %28, %arg2[%22] : memref<?xf64>
          %29 = affine.apply #map3(%22)
          %30 = affine.load %arg3[%29 - 1] : memref<?xf64>
          %31 = affine.load %arg3[%29] : memref<?xf64>
          %32 = arith.addf %30, %31 : f64
          %33 = affine.load %arg3[%29 + 1] : memref<?xf64>
          %34 = arith.addf %32, %33 : f64
          %35 = arith.mulf %34, %cst : f64
          affine.store %35, %arg2[%29] : memref<?xf64>
          %36 = affine.apply #map4(%22)
          %37 = affine.load %arg3[%36 - 1] : memref<?xf64>
          %38 = affine.load %arg3[%36] : memref<?xf64>
          %39 = arith.addf %37, %38 : f64
          %40 = affine.load %arg3[%36 + 1] : memref<?xf64>
          %41 = arith.addf %39, %40 : f64
          %42 = arith.mulf %41, %cst : f64
          affine.store %42, %arg2[%36] : memref<?xf64>
          %43 = affine.apply #map6(%arg6)
          %44 = affine.load %arg3[%43 - 1] : memref<?xf64>
          %45 = affine.load %arg3[%43] : memref<?xf64>
          %46 = arith.addf %44, %45 : f64
          %47 = affine.load %arg3[%43 + 1] : memref<?xf64>
          %48 = arith.addf %46, %47 : f64
          %49 = arith.mulf %48, %cst : f64
          affine.store %49, %arg2[%43] : memref<?xf64>
          %50 = affine.apply #map3(%43)
          %51 = affine.load %arg3[%50 - 1] : memref<?xf64>
          %52 = affine.load %arg3[%50] : memref<?xf64>
          %53 = arith.addf %51, %52 : f64
          %54 = affine.load %arg3[%50 + 1] : memref<?xf64>
          %55 = arith.addf %53, %54 : f64
          %56 = arith.mulf %55, %cst : f64
          affine.store %56, %arg2[%50] : memref<?xf64>
          %57 = affine.apply #map4(%43)
          %58 = affine.load %arg3[%57 - 1] : memref<?xf64>
          %59 = affine.load %arg3[%57] : memref<?xf64>
          %60 = arith.addf %58, %59 : f64
          %61 = affine.load %arg3[%57 + 1] : memref<?xf64>
          %62 = arith.addf %60, %61 : f64
          %63 = arith.mulf %62, %cst : f64
          affine.store %63, %arg2[%57] : memref<?xf64>
          %64 = affine.apply #map7(%arg6)
          %65 = affine.load %arg3[%64 - 1] : memref<?xf64>
          %66 = affine.load %arg3[%64] : memref<?xf64>
          %67 = arith.addf %65, %66 : f64
          %68 = affine.load %arg3[%64 + 1] : memref<?xf64>
          %69 = arith.addf %67, %68 : f64
          %70 = arith.mulf %69, %cst : f64
          affine.store %70, %arg2[%64] : memref<?xf64>
          %71 = affine.apply #map3(%64)
          %72 = affine.load %arg3[%71 - 1] : memref<?xf64>
          %73 = affine.load %arg3[%71] : memref<?xf64>
          %74 = arith.addf %72, %73 : f64
          %75 = affine.load %arg3[%71 + 1] : memref<?xf64>
          %76 = arith.addf %74, %75 : f64
          %77 = arith.mulf %76, %cst : f64
          affine.store %77, %arg2[%71] : memref<?xf64>
          %78 = affine.apply #map4(%64)
          %79 = affine.load %arg3[%78 - 1] : memref<?xf64>
          %80 = affine.load %arg3[%78] : memref<?xf64>
          %81 = arith.addf %79, %80 : f64
          %82 = affine.load %arg3[%78 + 1] : memref<?xf64>
          %83 = arith.addf %81, %82 : f64
          %84 = arith.mulf %83, %cst : f64
          affine.store %84, %arg2[%78] : memref<?xf64>
        }
        affine.for %arg6 = #map2()[%0] to #map8()[%0] step 3 {
          %2 = affine.load %arg3[%arg6 - 1] : memref<?xf64>
          %3 = affine.load %arg3[%arg6] : memref<?xf64>
          %4 = arith.addf %2, %3 : f64
          %5 = affine.load %arg3[%arg6 + 1] : memref<?xf64>
          %6 = arith.addf %4, %5 : f64
          %7 = arith.mulf %6, %cst : f64
          affine.store %7, %arg2[%arg6] : memref<?xf64>
          %8 = affine.apply #map3(%arg6)
          %9 = affine.load %arg3[%8 - 1] : memref<?xf64>
          %10 = affine.load %arg3[%8] : memref<?xf64>
          %11 = arith.addf %9, %10 : f64
          %12 = affine.load %arg3[%8 + 1] : memref<?xf64>
          %13 = arith.addf %11, %12 : f64
          %14 = arith.mulf %13, %cst : f64
          affine.store %14, %arg2[%8] : memref<?xf64>
          %15 = affine.apply #map4(%arg6)
          %16 = affine.load %arg3[%15 - 1] : memref<?xf64>
          %17 = affine.load %arg3[%15] : memref<?xf64>
          %18 = arith.addf %16, %17 : f64
          %19 = affine.load %arg3[%15 + 1] : memref<?xf64>
          %20 = arith.addf %18, %19 : f64
          %21 = arith.mulf %20, %cst : f64
          affine.store %21, %arg2[%15] : memref<?xf64>
        }
        affine.for %arg6 = #map8()[%0] to #map9()[%0] step 4 {
          %2 = affine.load %arg3[%arg6 - 1] : memref<?xf64>
          %3 = affine.load %arg3[%arg6] : memref<?xf64>
          %4 = arith.addf %2, %3 : f64
          %5 = affine.load %arg3[%arg6 + 1] : memref<?xf64>
          %6 = arith.addf %4, %5 : f64
          %7 = arith.mulf %6, %cst : f64
          affine.store %7, %arg2[%arg6] : memref<?xf64>
          %8 = affine.apply #map3(%arg6)
          %9 = affine.load %arg3[%8 - 1] : memref<?xf64>
          %10 = affine.load %arg3[%8] : memref<?xf64>
          %11 = arith.addf %9, %10 : f64
          %12 = affine.load %arg3[%8 + 1] : memref<?xf64>
          %13 = arith.addf %11, %12 : f64
          %14 = arith.mulf %13, %cst : f64
          affine.store %14, %arg2[%8] : memref<?xf64>
          %15 = affine.apply #map4(%arg6)
          %16 = affine.load %arg3[%15 - 1] : memref<?xf64>
          %17 = affine.load %arg3[%15] : memref<?xf64>
          %18 = arith.addf %16, %17 : f64
          %19 = affine.load %arg3[%15 + 1] : memref<?xf64>
          %20 = arith.addf %18, %19 : f64
          %21 = arith.mulf %20, %cst : f64
          affine.store %21, %arg2[%15] : memref<?xf64>
          %22 = affine.apply #map5(%arg6)
          %23 = affine.load %arg3[%22 - 1] : memref<?xf64>
          %24 = affine.load %arg3[%22] : memref<?xf64>
          %25 = arith.addf %23, %24 : f64
          %26 = affine.load %arg3[%22 + 1] : memref<?xf64>
          %27 = arith.addf %25, %26 : f64
          %28 = arith.mulf %27, %cst : f64
          affine.store %28, %arg2[%22] : memref<?xf64>
        }
        affine.for %arg6 = #map9()[%0] to #map10()[%0] {
          %2 = affine.load %arg3[%arg6 - 1] : memref<?xf64>
          %3 = affine.load %arg3[%arg6] : memref<?xf64>
          %4 = arith.addf %2, %3 : f64
          %5 = affine.load %arg3[%arg6 + 1] : memref<?xf64>
          %6 = arith.addf %4, %5 : f64
          %7 = arith.mulf %6, %cst : f64
          affine.store %7, %arg2[%arg6] : memref<?xf64>
        }
      }
    }
    return
  }
}

