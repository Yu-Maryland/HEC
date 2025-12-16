#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 40, s0)>
#map2 = affine_map<()[s0] -> (((s0 floordiv 3) floordiv 3) * 9)>
#map3 = affine_map<(d0) -> (d0 + 1)>
#map4 = affine_map<(d0) -> (d0 + 2)>
#map5 = affine_map<(d0) -> (d0 + 3)>
#map6 = affine_map<(d0) -> (d0 + 6)>
#map7 = affine_map<()[s0] -> ((s0 floordiv 3) * 3)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_bicg(%arg0: i32, %arg1: i32, %arg2: memref<?x1900xf64>, %arg3: memref<?xf64>, %arg4: memref<?xf64>, %arg5: memref<?xf64>, %arg6: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 0.000000e+00 : f64
    %0 = arith.index_cast %arg0 : i32 to index
    affine.for %arg7 = 0 to %0 step 40 {
      affine.for %arg8 = #map(%arg7) to min #map1(%arg7)[%0] {
        affine.store %cst, %arg3[%arg8] : memref<?xf64>
      }
    }
    %1 = arith.index_cast %arg1 : i32 to index
    affine.for %arg7 = 0 to %1 step 40 {
      affine.for %arg8 = #map(%arg7) to min #map1(%arg7)[%1] {
        affine.store %cst, %arg4[%arg8] : memref<?xf64>
        affine.for %arg9 = 0 to #map2()[%0] step 9 {
          %2 = affine.load %arg3[%arg9] : memref<?xf64>
          %3 = affine.load %arg6[%arg8] : memref<?xf64>
          %4 = affine.load %arg2[%arg8, %arg9] : memref<?x1900xf64>
          %5 = arith.mulf %3, %4 : f64
          %6 = arith.addf %2, %5 : f64
          affine.store %6, %arg3[%arg9] : memref<?xf64>
          %7 = affine.load %arg4[%arg8] : memref<?xf64>
          %8 = affine.load %arg2[%arg8, %arg9] : memref<?x1900xf64>
          %9 = affine.load %arg5[%arg9] : memref<?xf64>
          %10 = arith.mulf %8, %9 : f64
          %11 = arith.addf %7, %10 : f64
          affine.store %11, %arg4[%arg8] : memref<?xf64>
          %12 = affine.apply #map3(%arg9)
          %13 = affine.load %arg3[%12] : memref<?xf64>
          %14 = affine.load %arg6[%arg8] : memref<?xf64>
          %15 = affine.load %arg2[%arg8, %12] : memref<?x1900xf64>
          %16 = arith.mulf %14, %15 : f64
          %17 = arith.addf %13, %16 : f64
          affine.store %17, %arg3[%12] : memref<?xf64>
          %18 = affine.load %arg4[%arg8] : memref<?xf64>
          %19 = affine.load %arg2[%arg8, %12] : memref<?x1900xf64>
          %20 = affine.load %arg5[%12] : memref<?xf64>
          %21 = arith.mulf %19, %20 : f64
          %22 = arith.addf %18, %21 : f64
          affine.store %22, %arg4[%arg8] : memref<?xf64>
          %23 = affine.apply #map4(%arg9)
          %24 = affine.load %arg3[%23] : memref<?xf64>
          %25 = affine.load %arg6[%arg8] : memref<?xf64>
          %26 = affine.load %arg2[%arg8, %23] : memref<?x1900xf64>
          %27 = arith.mulf %25, %26 : f64
          %28 = arith.addf %24, %27 : f64
          affine.store %28, %arg3[%23] : memref<?xf64>
          %29 = affine.load %arg4[%arg8] : memref<?xf64>
          %30 = affine.load %arg2[%arg8, %23] : memref<?x1900xf64>
          %31 = affine.load %arg5[%23] : memref<?xf64>
          %32 = arith.mulf %30, %31 : f64
          %33 = arith.addf %29, %32 : f64
          affine.store %33, %arg4[%arg8] : memref<?xf64>
          %34 = affine.apply #map5(%arg9)
          %35 = affine.load %arg3[%34] : memref<?xf64>
          %36 = affine.load %arg6[%arg8] : memref<?xf64>
          %37 = affine.load %arg2[%arg8, %34] : memref<?x1900xf64>
          %38 = arith.mulf %36, %37 : f64
          %39 = arith.addf %35, %38 : f64
          affine.store %39, %arg3[%34] : memref<?xf64>
          %40 = affine.load %arg4[%arg8] : memref<?xf64>
          %41 = affine.load %arg2[%arg8, %34] : memref<?x1900xf64>
          %42 = affine.load %arg5[%34] : memref<?xf64>
          %43 = arith.mulf %41, %42 : f64
          %44 = arith.addf %40, %43 : f64
          affine.store %44, %arg4[%arg8] : memref<?xf64>
          %45 = affine.apply #map3(%34)
          %46 = affine.load %arg3[%45] : memref<?xf64>
          %47 = affine.load %arg6[%arg8] : memref<?xf64>
          %48 = affine.load %arg2[%arg8, %45] : memref<?x1900xf64>
          %49 = arith.mulf %47, %48 : f64
          %50 = arith.addf %46, %49 : f64
          affine.store %50, %arg3[%45] : memref<?xf64>
          %51 = affine.load %arg4[%arg8] : memref<?xf64>
          %52 = affine.load %arg2[%arg8, %45] : memref<?x1900xf64>
          %53 = affine.load %arg5[%45] : memref<?xf64>
          %54 = arith.mulf %52, %53 : f64
          %55 = arith.addf %51, %54 : f64
          affine.store %55, %arg4[%arg8] : memref<?xf64>
          %56 = affine.apply #map4(%34)
          %57 = affine.load %arg3[%56] : memref<?xf64>
          %58 = affine.load %arg6[%arg8] : memref<?xf64>
          %59 = affine.load %arg2[%arg8, %56] : memref<?x1900xf64>
          %60 = arith.mulf %58, %59 : f64
          %61 = arith.addf %57, %60 : f64
          affine.store %61, %arg3[%56] : memref<?xf64>
          %62 = affine.load %arg4[%arg8] : memref<?xf64>
          %63 = affine.load %arg2[%arg8, %56] : memref<?x1900xf64>
          %64 = affine.load %arg5[%56] : memref<?xf64>
          %65 = arith.mulf %63, %64 : f64
          %66 = arith.addf %62, %65 : f64
          affine.store %66, %arg4[%arg8] : memref<?xf64>
          %67 = affine.apply #map6(%arg9)
          %68 = affine.load %arg3[%67] : memref<?xf64>
          %69 = affine.load %arg6[%arg8] : memref<?xf64>
          %70 = affine.load %arg2[%arg8, %67] : memref<?x1900xf64>
          %71 = arith.mulf %69, %70 : f64
          %72 = arith.addf %68, %71 : f64
          affine.store %72, %arg3[%67] : memref<?xf64>
          %73 = affine.load %arg4[%arg8] : memref<?xf64>
          %74 = affine.load %arg2[%arg8, %67] : memref<?x1900xf64>
          %75 = affine.load %arg5[%67] : memref<?xf64>
          %76 = arith.mulf %74, %75 : f64
          %77 = arith.addf %73, %76 : f64
          affine.store %77, %arg4[%arg8] : memref<?xf64>
          %78 = affine.apply #map3(%67)
          %79 = affine.load %arg3[%78] : memref<?xf64>
          %80 = affine.load %arg6[%arg8] : memref<?xf64>
          %81 = affine.load %arg2[%arg8, %78] : memref<?x1900xf64>
          %82 = arith.mulf %80, %81 : f64
          %83 = arith.addf %79, %82 : f64
          affine.store %83, %arg3[%78] : memref<?xf64>
          %84 = affine.load %arg4[%arg8] : memref<?xf64>
          %85 = affine.load %arg2[%arg8, %78] : memref<?x1900xf64>
          %86 = affine.load %arg5[%78] : memref<?xf64>
          %87 = arith.mulf %85, %86 : f64
          %88 = arith.addf %84, %87 : f64
          affine.store %88, %arg4[%arg8] : memref<?xf64>
          %89 = affine.apply #map4(%67)
          %90 = affine.load %arg3[%89] : memref<?xf64>
          %91 = affine.load %arg6[%arg8] : memref<?xf64>
          %92 = affine.load %arg2[%arg8, %89] : memref<?x1900xf64>
          %93 = arith.mulf %91, %92 : f64
          %94 = arith.addf %90, %93 : f64
          affine.store %94, %arg3[%89] : memref<?xf64>
          %95 = affine.load %arg4[%arg8] : memref<?xf64>
          %96 = affine.load %arg2[%arg8, %89] : memref<?x1900xf64>
          %97 = affine.load %arg5[%89] : memref<?xf64>
          %98 = arith.mulf %96, %97 : f64
          %99 = arith.addf %95, %98 : f64
          affine.store %99, %arg4[%arg8] : memref<?xf64>
        }
        affine.for %arg9 = #map2()[%0] to #map7()[%0] step 3 {
          %2 = affine.load %arg3[%arg9] : memref<?xf64>
          %3 = affine.load %arg6[%arg8] : memref<?xf64>
          %4 = affine.load %arg2[%arg8, %arg9] : memref<?x1900xf64>
          %5 = arith.mulf %3, %4 : f64
          %6 = arith.addf %2, %5 : f64
          affine.store %6, %arg3[%arg9] : memref<?xf64>
          %7 = affine.load %arg4[%arg8] : memref<?xf64>
          %8 = affine.load %arg2[%arg8, %arg9] : memref<?x1900xf64>
          %9 = affine.load %arg5[%arg9] : memref<?xf64>
          %10 = arith.mulf %8, %9 : f64
          %11 = arith.addf %7, %10 : f64
          affine.store %11, %arg4[%arg8] : memref<?xf64>
          %12 = affine.apply #map3(%arg9)
          %13 = affine.load %arg3[%12] : memref<?xf64>
          %14 = affine.load %arg6[%arg8] : memref<?xf64>
          %15 = affine.load %arg2[%arg8, %12] : memref<?x1900xf64>
          %16 = arith.mulf %14, %15 : f64
          %17 = arith.addf %13, %16 : f64
          affine.store %17, %arg3[%12] : memref<?xf64>
          %18 = affine.load %arg4[%arg8] : memref<?xf64>
          %19 = affine.load %arg2[%arg8, %12] : memref<?x1900xf64>
          %20 = affine.load %arg5[%12] : memref<?xf64>
          %21 = arith.mulf %19, %20 : f64
          %22 = arith.addf %18, %21 : f64
          affine.store %22, %arg4[%arg8] : memref<?xf64>
          %23 = affine.apply #map4(%arg9)
          %24 = affine.load %arg3[%23] : memref<?xf64>
          %25 = affine.load %arg6[%arg8] : memref<?xf64>
          %26 = affine.load %arg2[%arg8, %23] : memref<?x1900xf64>
          %27 = arith.mulf %25, %26 : f64
          %28 = arith.addf %24, %27 : f64
          affine.store %28, %arg3[%23] : memref<?xf64>
          %29 = affine.load %arg4[%arg8] : memref<?xf64>
          %30 = affine.load %arg2[%arg8, %23] : memref<?x1900xf64>
          %31 = affine.load %arg5[%23] : memref<?xf64>
          %32 = arith.mulf %30, %31 : f64
          %33 = arith.addf %29, %32 : f64
          affine.store %33, %arg4[%arg8] : memref<?xf64>
        }
        affine.for %arg9 = #map7()[%0] to #map7()[%0] step 3 {
          %2 = affine.load %arg3[%arg9] : memref<?xf64>
          %3 = affine.load %arg6[%arg8] : memref<?xf64>
          %4 = affine.load %arg2[%arg8, %arg9] : memref<?x1900xf64>
          %5 = arith.mulf %3, %4 : f64
          %6 = arith.addf %2, %5 : f64
          affine.store %6, %arg3[%arg9] : memref<?xf64>
          %7 = affine.load %arg4[%arg8] : memref<?xf64>
          %8 = affine.load %arg2[%arg8, %arg9] : memref<?x1900xf64>
          %9 = affine.load %arg5[%arg9] : memref<?xf64>
          %10 = arith.mulf %8, %9 : f64
          %11 = arith.addf %7, %10 : f64
          affine.store %11, %arg4[%arg8] : memref<?xf64>
          %12 = affine.apply #map3(%arg9)
          %13 = affine.load %arg3[%12] : memref<?xf64>
          %14 = affine.load %arg6[%arg8] : memref<?xf64>
          %15 = affine.load %arg2[%arg8, %12] : memref<?x1900xf64>
          %16 = arith.mulf %14, %15 : f64
          %17 = arith.addf %13, %16 : f64
          affine.store %17, %arg3[%12] : memref<?xf64>
          %18 = affine.load %arg4[%arg8] : memref<?xf64>
          %19 = affine.load %arg2[%arg8, %12] : memref<?x1900xf64>
          %20 = affine.load %arg5[%12] : memref<?xf64>
          %21 = arith.mulf %19, %20 : f64
          %22 = arith.addf %18, %21 : f64
          affine.store %22, %arg4[%arg8] : memref<?xf64>
          %23 = affine.apply #map4(%arg9)
          %24 = affine.load %arg3[%23] : memref<?xf64>
          %25 = affine.load %arg6[%arg8] : memref<?xf64>
          %26 = affine.load %arg2[%arg8, %23] : memref<?x1900xf64>
          %27 = arith.mulf %25, %26 : f64
          %28 = arith.addf %24, %27 : f64
          affine.store %28, %arg3[%23] : memref<?xf64>
          %29 = affine.load %arg4[%arg8] : memref<?xf64>
          %30 = affine.load %arg2[%arg8, %23] : memref<?x1900xf64>
          %31 = affine.load %arg5[%23] : memref<?xf64>
          %32 = arith.mulf %30, %31 : f64
          %33 = arith.addf %29, %32 : f64
          affine.store %33, %arg4[%arg8] : memref<?xf64>
        }
        affine.for %arg9 = #map7()[%0] to %0 {
          %2 = affine.load %arg3[%arg9] : memref<?xf64>
          %3 = affine.load %arg6[%arg8] : memref<?xf64>
          %4 = affine.load %arg2[%arg8, %arg9] : memref<?x1900xf64>
          %5 = arith.mulf %3, %4 : f64
          %6 = arith.addf %2, %5 : f64
          affine.store %6, %arg3[%arg9] : memref<?xf64>
          %7 = affine.load %arg4[%arg8] : memref<?xf64>
          %8 = affine.load %arg2[%arg8, %arg9] : memref<?x1900xf64>
          %9 = affine.load %arg5[%arg9] : memref<?xf64>
          %10 = arith.mulf %8, %9 : f64
          %11 = arith.addf %7, %10 : f64
          affine.store %11, %arg4[%arg8] : memref<?xf64>
        }
      }
    }
    return
  }
}

