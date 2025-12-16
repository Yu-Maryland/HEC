#map = affine_map<()[s0] -> (((s0 floordiv 6) floordiv 2) * 12)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0 + 3)>
#map4 = affine_map<(d0) -> (d0 + 4)>
#map5 = affine_map<(d0) -> (d0 + 5)>
#map6 = affine_map<(d0) -> (d0 + 6)>
#map7 = affine_map<()[s0] -> ((s0 floordiv 6) * 6)>
#map8 = affine_map<()[s0] -> ((s0 floordiv 2) * 2)>
#map9 = affine_map<()[s0] -> ((((s0 - 1) floordiv 6) floordiv 2) * 12 + 1)>
#map10 = affine_map<()[s0] -> (((s0 - 1) floordiv 6) * 6 + 1)>
#map11 = affine_map<()[s0] -> (((s0 - 1) floordiv 6) * 6 + ((s0 - ((s0 - 1) floordiv 6) * 6 - 1) floordiv 2) * 2 + 1)>
#map12 = affine_map<()[s0] -> (s0 - 1)>
#map13 = affine_map<()[s0] -> ((((s0 - 1) floordiv 6) floordiv 2) * 12)>
#map14 = affine_map<()[s0] -> (((s0 - 1) floordiv 6) * 6)>
#map15 = affine_map<()[s0] -> (((s0 - 1) floordiv 6) * 6 + ((s0 - ((s0 - 1) floordiv 6) * 6 - 1) floordiv 2) * 2)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_fdtd_2d(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: memref<?x1200xf64>, %arg4: memref<?x1200xf64>, %arg5: memref<?x1200xf64>, %arg6: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 5.000000e-01 : f64
    %cst_0 = arith.constant 0.69999999999999996 : f64
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg2 : i32 to index
    %2 = arith.index_cast %arg0 : i32 to index
    affine.for %arg7 = 0 to %2 {
      affine.for %arg8 = 0 to #map()[%1] step 12 {
        %3 = affine.load %arg6[%arg7] : memref<?xf64>
        affine.store %3, %arg4[0, %arg8] : memref<?x1200xf64>
        %4 = affine.apply #map1(%arg8)
        %5 = affine.load %arg6[%arg7] : memref<?xf64>
        affine.store %5, %arg4[0, %4] : memref<?x1200xf64>
        %6 = affine.apply #map2(%arg8)
        %7 = affine.load %arg6[%arg7] : memref<?xf64>
        affine.store %7, %arg4[0, %6] : memref<?x1200xf64>
        %8 = affine.apply #map3(%arg8)
        %9 = affine.load %arg6[%arg7] : memref<?xf64>
        affine.store %9, %arg4[0, %8] : memref<?x1200xf64>
        %10 = affine.apply #map4(%arg8)
        %11 = affine.load %arg6[%arg7] : memref<?xf64>
        affine.store %11, %arg4[0, %10] : memref<?x1200xf64>
        %12 = affine.apply #map5(%arg8)
        %13 = affine.load %arg6[%arg7] : memref<?xf64>
        affine.store %13, %arg4[0, %12] : memref<?x1200xf64>
        %14 = affine.apply #map6(%arg8)
        %15 = affine.load %arg6[%arg7] : memref<?xf64>
        affine.store %15, %arg4[0, %14] : memref<?x1200xf64>
        %16 = affine.apply #map1(%14)
        %17 = affine.load %arg6[%arg7] : memref<?xf64>
        affine.store %17, %arg4[0, %16] : memref<?x1200xf64>
        %18 = affine.apply #map2(%14)
        %19 = affine.load %arg6[%arg7] : memref<?xf64>
        affine.store %19, %arg4[0, %18] : memref<?x1200xf64>
        %20 = affine.apply #map3(%14)
        %21 = affine.load %arg6[%arg7] : memref<?xf64>
        affine.store %21, %arg4[0, %20] : memref<?x1200xf64>
        %22 = affine.apply #map4(%14)
        %23 = affine.load %arg6[%arg7] : memref<?xf64>
        affine.store %23, %arg4[0, %22] : memref<?x1200xf64>
        %24 = affine.apply #map5(%14)
        %25 = affine.load %arg6[%arg7] : memref<?xf64>
        affine.store %25, %arg4[0, %24] : memref<?x1200xf64>
      }
      affine.for %arg8 = #map()[%1] to #map7()[%1] step 6 {
        %3 = affine.load %arg6[%arg7] : memref<?xf64>
        affine.store %3, %arg4[0, %arg8] : memref<?x1200xf64>
        %4 = affine.apply #map1(%arg8)
        %5 = affine.load %arg6[%arg7] : memref<?xf64>
        affine.store %5, %arg4[0, %4] : memref<?x1200xf64>
        %6 = affine.apply #map2(%arg8)
        %7 = affine.load %arg6[%arg7] : memref<?xf64>
        affine.store %7, %arg4[0, %6] : memref<?x1200xf64>
        %8 = affine.apply #map3(%arg8)
        %9 = affine.load %arg6[%arg7] : memref<?xf64>
        affine.store %9, %arg4[0, %8] : memref<?x1200xf64>
        %10 = affine.apply #map4(%arg8)
        %11 = affine.load %arg6[%arg7] : memref<?xf64>
        affine.store %11, %arg4[0, %10] : memref<?x1200xf64>
        %12 = affine.apply #map5(%arg8)
        %13 = affine.load %arg6[%arg7] : memref<?xf64>
        affine.store %13, %arg4[0, %12] : memref<?x1200xf64>
      }
      affine.for %arg8 = #map7()[%1] to #map8()[%1] step 2 {
        %3 = affine.load %arg6[%arg7] : memref<?xf64>
        affine.store %3, %arg4[0, %arg8] : memref<?x1200xf64>
        %4 = affine.apply #map1(%arg8)
        %5 = affine.load %arg6[%arg7] : memref<?xf64>
        affine.store %5, %arg4[0, %4] : memref<?x1200xf64>
      }
      affine.for %arg8 = #map8()[%1] to %1 {
        %3 = affine.load %arg6[%arg7] : memref<?xf64>
        affine.store %3, %arg4[0, %arg8] : memref<?x1200xf64>
      }
      affine.for %arg8 = 1 to %0 {
        affine.for %arg9 = 0 to #map()[%1] step 12 {
          %3 = affine.load %arg4[%arg8, %arg9] : memref<?x1200xf64>
          %4 = affine.load %arg5[%arg8, %arg9] : memref<?x1200xf64>
          %5 = affine.load %arg5[%arg8 - 1, %arg9] : memref<?x1200xf64>
          %6 = arith.subf %4, %5 : f64
          %7 = arith.mulf %6, %cst : f64
          %8 = arith.subf %3, %7 : f64
          affine.store %8, %arg4[%arg8, %arg9] : memref<?x1200xf64>
          %9 = affine.apply #map1(%arg9)
          %10 = affine.load %arg4[%arg8, %9] : memref<?x1200xf64>
          %11 = affine.load %arg5[%arg8, %9] : memref<?x1200xf64>
          %12 = affine.load %arg5[%arg8 - 1, %9] : memref<?x1200xf64>
          %13 = arith.subf %11, %12 : f64
          %14 = arith.mulf %13, %cst : f64
          %15 = arith.subf %10, %14 : f64
          affine.store %15, %arg4[%arg8, %9] : memref<?x1200xf64>
          %16 = affine.apply #map2(%arg9)
          %17 = affine.load %arg4[%arg8, %16] : memref<?x1200xf64>
          %18 = affine.load %arg5[%arg8, %16] : memref<?x1200xf64>
          %19 = affine.load %arg5[%arg8 - 1, %16] : memref<?x1200xf64>
          %20 = arith.subf %18, %19 : f64
          %21 = arith.mulf %20, %cst : f64
          %22 = arith.subf %17, %21 : f64
          affine.store %22, %arg4[%arg8, %16] : memref<?x1200xf64>
          %23 = affine.apply #map3(%arg9)
          %24 = affine.load %arg4[%arg8, %23] : memref<?x1200xf64>
          %25 = affine.load %arg5[%arg8, %23] : memref<?x1200xf64>
          %26 = affine.load %arg5[%arg8 - 1, %23] : memref<?x1200xf64>
          %27 = arith.subf %25, %26 : f64
          %28 = arith.mulf %27, %cst : f64
          %29 = arith.subf %24, %28 : f64
          affine.store %29, %arg4[%arg8, %23] : memref<?x1200xf64>
          %30 = affine.apply #map4(%arg9)
          %31 = affine.load %arg4[%arg8, %30] : memref<?x1200xf64>
          %32 = affine.load %arg5[%arg8, %30] : memref<?x1200xf64>
          %33 = affine.load %arg5[%arg8 - 1, %30] : memref<?x1200xf64>
          %34 = arith.subf %32, %33 : f64
          %35 = arith.mulf %34, %cst : f64
          %36 = arith.subf %31, %35 : f64
          affine.store %36, %arg4[%arg8, %30] : memref<?x1200xf64>
          %37 = affine.apply #map5(%arg9)
          %38 = affine.load %arg4[%arg8, %37] : memref<?x1200xf64>
          %39 = affine.load %arg5[%arg8, %37] : memref<?x1200xf64>
          %40 = affine.load %arg5[%arg8 - 1, %37] : memref<?x1200xf64>
          %41 = arith.subf %39, %40 : f64
          %42 = arith.mulf %41, %cst : f64
          %43 = arith.subf %38, %42 : f64
          affine.store %43, %arg4[%arg8, %37] : memref<?x1200xf64>
          %44 = affine.apply #map6(%arg9)
          %45 = affine.load %arg4[%arg8, %44] : memref<?x1200xf64>
          %46 = affine.load %arg5[%arg8, %44] : memref<?x1200xf64>
          %47 = affine.load %arg5[%arg8 - 1, %44] : memref<?x1200xf64>
          %48 = arith.subf %46, %47 : f64
          %49 = arith.mulf %48, %cst : f64
          %50 = arith.subf %45, %49 : f64
          affine.store %50, %arg4[%arg8, %44] : memref<?x1200xf64>
          %51 = affine.apply #map1(%44)
          %52 = affine.load %arg4[%arg8, %51] : memref<?x1200xf64>
          %53 = affine.load %arg5[%arg8, %51] : memref<?x1200xf64>
          %54 = affine.load %arg5[%arg8 - 1, %51] : memref<?x1200xf64>
          %55 = arith.subf %53, %54 : f64
          %56 = arith.mulf %55, %cst : f64
          %57 = arith.subf %52, %56 : f64
          affine.store %57, %arg4[%arg8, %51] : memref<?x1200xf64>
          %58 = affine.apply #map2(%44)
          %59 = affine.load %arg4[%arg8, %58] : memref<?x1200xf64>
          %60 = affine.load %arg5[%arg8, %58] : memref<?x1200xf64>
          %61 = affine.load %arg5[%arg8 - 1, %58] : memref<?x1200xf64>
          %62 = arith.subf %60, %61 : f64
          %63 = arith.mulf %62, %cst : f64
          %64 = arith.subf %59, %63 : f64
          affine.store %64, %arg4[%arg8, %58] : memref<?x1200xf64>
          %65 = affine.apply #map3(%44)
          %66 = affine.load %arg4[%arg8, %65] : memref<?x1200xf64>
          %67 = affine.load %arg5[%arg8, %65] : memref<?x1200xf64>
          %68 = affine.load %arg5[%arg8 - 1, %65] : memref<?x1200xf64>
          %69 = arith.subf %67, %68 : f64
          %70 = arith.mulf %69, %cst : f64
          %71 = arith.subf %66, %70 : f64
          affine.store %71, %arg4[%arg8, %65] : memref<?x1200xf64>
          %72 = affine.apply #map4(%44)
          %73 = affine.load %arg4[%arg8, %72] : memref<?x1200xf64>
          %74 = affine.load %arg5[%arg8, %72] : memref<?x1200xf64>
          %75 = affine.load %arg5[%arg8 - 1, %72] : memref<?x1200xf64>
          %76 = arith.subf %74, %75 : f64
          %77 = arith.mulf %76, %cst : f64
          %78 = arith.subf %73, %77 : f64
          affine.store %78, %arg4[%arg8, %72] : memref<?x1200xf64>
          %79 = affine.apply #map5(%44)
          %80 = affine.load %arg4[%arg8, %79] : memref<?x1200xf64>
          %81 = affine.load %arg5[%arg8, %79] : memref<?x1200xf64>
          %82 = affine.load %arg5[%arg8 - 1, %79] : memref<?x1200xf64>
          %83 = arith.subf %81, %82 : f64
          %84 = arith.mulf %83, %cst : f64
          %85 = arith.subf %80, %84 : f64
          affine.store %85, %arg4[%arg8, %79] : memref<?x1200xf64>
        }
        affine.for %arg9 = #map()[%1] to #map7()[%1] step 6 {
          %3 = affine.load %arg4[%arg8, %arg9] : memref<?x1200xf64>
          %4 = affine.load %arg5[%arg8, %arg9] : memref<?x1200xf64>
          %5 = affine.load %arg5[%arg8 - 1, %arg9] : memref<?x1200xf64>
          %6 = arith.subf %4, %5 : f64
          %7 = arith.mulf %6, %cst : f64
          %8 = arith.subf %3, %7 : f64
          affine.store %8, %arg4[%arg8, %arg9] : memref<?x1200xf64>
          %9 = affine.apply #map1(%arg9)
          %10 = affine.load %arg4[%arg8, %9] : memref<?x1200xf64>
          %11 = affine.load %arg5[%arg8, %9] : memref<?x1200xf64>
          %12 = affine.load %arg5[%arg8 - 1, %9] : memref<?x1200xf64>
          %13 = arith.subf %11, %12 : f64
          %14 = arith.mulf %13, %cst : f64
          %15 = arith.subf %10, %14 : f64
          affine.store %15, %arg4[%arg8, %9] : memref<?x1200xf64>
          %16 = affine.apply #map2(%arg9)
          %17 = affine.load %arg4[%arg8, %16] : memref<?x1200xf64>
          %18 = affine.load %arg5[%arg8, %16] : memref<?x1200xf64>
          %19 = affine.load %arg5[%arg8 - 1, %16] : memref<?x1200xf64>
          %20 = arith.subf %18, %19 : f64
          %21 = arith.mulf %20, %cst : f64
          %22 = arith.subf %17, %21 : f64
          affine.store %22, %arg4[%arg8, %16] : memref<?x1200xf64>
          %23 = affine.apply #map3(%arg9)
          %24 = affine.load %arg4[%arg8, %23] : memref<?x1200xf64>
          %25 = affine.load %arg5[%arg8, %23] : memref<?x1200xf64>
          %26 = affine.load %arg5[%arg8 - 1, %23] : memref<?x1200xf64>
          %27 = arith.subf %25, %26 : f64
          %28 = arith.mulf %27, %cst : f64
          %29 = arith.subf %24, %28 : f64
          affine.store %29, %arg4[%arg8, %23] : memref<?x1200xf64>
          %30 = affine.apply #map4(%arg9)
          %31 = affine.load %arg4[%arg8, %30] : memref<?x1200xf64>
          %32 = affine.load %arg5[%arg8, %30] : memref<?x1200xf64>
          %33 = affine.load %arg5[%arg8 - 1, %30] : memref<?x1200xf64>
          %34 = arith.subf %32, %33 : f64
          %35 = arith.mulf %34, %cst : f64
          %36 = arith.subf %31, %35 : f64
          affine.store %36, %arg4[%arg8, %30] : memref<?x1200xf64>
          %37 = affine.apply #map5(%arg9)
          %38 = affine.load %arg4[%arg8, %37] : memref<?x1200xf64>
          %39 = affine.load %arg5[%arg8, %37] : memref<?x1200xf64>
          %40 = affine.load %arg5[%arg8 - 1, %37] : memref<?x1200xf64>
          %41 = arith.subf %39, %40 : f64
          %42 = arith.mulf %41, %cst : f64
          %43 = arith.subf %38, %42 : f64
          affine.store %43, %arg4[%arg8, %37] : memref<?x1200xf64>
        }
        affine.for %arg9 = #map7()[%1] to #map8()[%1] step 2 {
          %3 = affine.load %arg4[%arg8, %arg9] : memref<?x1200xf64>
          %4 = affine.load %arg5[%arg8, %arg9] : memref<?x1200xf64>
          %5 = affine.load %arg5[%arg8 - 1, %arg9] : memref<?x1200xf64>
          %6 = arith.subf %4, %5 : f64
          %7 = arith.mulf %6, %cst : f64
          %8 = arith.subf %3, %7 : f64
          affine.store %8, %arg4[%arg8, %arg9] : memref<?x1200xf64>
          %9 = affine.apply #map1(%arg9)
          %10 = affine.load %arg4[%arg8, %9] : memref<?x1200xf64>
          %11 = affine.load %arg5[%arg8, %9] : memref<?x1200xf64>
          %12 = affine.load %arg5[%arg8 - 1, %9] : memref<?x1200xf64>
          %13 = arith.subf %11, %12 : f64
          %14 = arith.mulf %13, %cst : f64
          %15 = arith.subf %10, %14 : f64
          affine.store %15, %arg4[%arg8, %9] : memref<?x1200xf64>
        }
        affine.for %arg9 = #map8()[%1] to %1 {
          %3 = affine.load %arg4[%arg8, %arg9] : memref<?x1200xf64>
          %4 = affine.load %arg5[%arg8, %arg9] : memref<?x1200xf64>
          %5 = affine.load %arg5[%arg8 - 1, %arg9] : memref<?x1200xf64>
          %6 = arith.subf %4, %5 : f64
          %7 = arith.mulf %6, %cst : f64
          %8 = arith.subf %3, %7 : f64
          affine.store %8, %arg4[%arg8, %arg9] : memref<?x1200xf64>
        }
      }
      affine.for %arg8 = 0 to %0 {
        affine.for %arg9 = 1 to #map9()[%1] step 12 {
          %3 = affine.load %arg3[%arg8, %arg9] : memref<?x1200xf64>
          %4 = affine.load %arg5[%arg8, %arg9] : memref<?x1200xf64>
          %5 = affine.load %arg5[%arg8, %arg9 - 1] : memref<?x1200xf64>
          %6 = arith.subf %4, %5 : f64
          %7 = arith.mulf %6, %cst : f64
          %8 = arith.subf %3, %7 : f64
          affine.store %8, %arg3[%arg8, %arg9] : memref<?x1200xf64>
          %9 = affine.apply #map1(%arg9)
          %10 = affine.load %arg3[%arg8, %9] : memref<?x1200xf64>
          %11 = affine.load %arg5[%arg8, %9] : memref<?x1200xf64>
          %12 = affine.load %arg5[%arg8, %9 - 1] : memref<?x1200xf64>
          %13 = arith.subf %11, %12 : f64
          %14 = arith.mulf %13, %cst : f64
          %15 = arith.subf %10, %14 : f64
          affine.store %15, %arg3[%arg8, %9] : memref<?x1200xf64>
          %16 = affine.apply #map2(%arg9)
          %17 = affine.load %arg3[%arg8, %16] : memref<?x1200xf64>
          %18 = affine.load %arg5[%arg8, %16] : memref<?x1200xf64>
          %19 = affine.load %arg5[%arg8, %16 - 1] : memref<?x1200xf64>
          %20 = arith.subf %18, %19 : f64
          %21 = arith.mulf %20, %cst : f64
          %22 = arith.subf %17, %21 : f64
          affine.store %22, %arg3[%arg8, %16] : memref<?x1200xf64>
          %23 = affine.apply #map3(%arg9)
          %24 = affine.load %arg3[%arg8, %23] : memref<?x1200xf64>
          %25 = affine.load %arg5[%arg8, %23] : memref<?x1200xf64>
          %26 = affine.load %arg5[%arg8, %23 - 1] : memref<?x1200xf64>
          %27 = arith.subf %25, %26 : f64
          %28 = arith.mulf %27, %cst : f64
          %29 = arith.subf %24, %28 : f64
          affine.store %29, %arg3[%arg8, %23] : memref<?x1200xf64>
          %30 = affine.apply #map4(%arg9)
          %31 = affine.load %arg3[%arg8, %30] : memref<?x1200xf64>
          %32 = affine.load %arg5[%arg8, %30] : memref<?x1200xf64>
          %33 = affine.load %arg5[%arg8, %30 - 1] : memref<?x1200xf64>
          %34 = arith.subf %32, %33 : f64
          %35 = arith.mulf %34, %cst : f64
          %36 = arith.subf %31, %35 : f64
          affine.store %36, %arg3[%arg8, %30] : memref<?x1200xf64>
          %37 = affine.apply #map5(%arg9)
          %38 = affine.load %arg3[%arg8, %37] : memref<?x1200xf64>
          %39 = affine.load %arg5[%arg8, %37] : memref<?x1200xf64>
          %40 = affine.load %arg5[%arg8, %37 - 1] : memref<?x1200xf64>
          %41 = arith.subf %39, %40 : f64
          %42 = arith.mulf %41, %cst : f64
          %43 = arith.subf %38, %42 : f64
          affine.store %43, %arg3[%arg8, %37] : memref<?x1200xf64>
          %44 = affine.apply #map6(%arg9)
          %45 = affine.load %arg3[%arg8, %44] : memref<?x1200xf64>
          %46 = affine.load %arg5[%arg8, %44] : memref<?x1200xf64>
          %47 = affine.load %arg5[%arg8, %44 - 1] : memref<?x1200xf64>
          %48 = arith.subf %46, %47 : f64
          %49 = arith.mulf %48, %cst : f64
          %50 = arith.subf %45, %49 : f64
          affine.store %50, %arg3[%arg8, %44] : memref<?x1200xf64>
          %51 = affine.apply #map1(%44)
          %52 = affine.load %arg3[%arg8, %51] : memref<?x1200xf64>
          %53 = affine.load %arg5[%arg8, %51] : memref<?x1200xf64>
          %54 = affine.load %arg5[%arg8, %51 - 1] : memref<?x1200xf64>
          %55 = arith.subf %53, %54 : f64
          %56 = arith.mulf %55, %cst : f64
          %57 = arith.subf %52, %56 : f64
          affine.store %57, %arg3[%arg8, %51] : memref<?x1200xf64>
          %58 = affine.apply #map2(%44)
          %59 = affine.load %arg3[%arg8, %58] : memref<?x1200xf64>
          %60 = affine.load %arg5[%arg8, %58] : memref<?x1200xf64>
          %61 = affine.load %arg5[%arg8, %58 - 1] : memref<?x1200xf64>
          %62 = arith.subf %60, %61 : f64
          %63 = arith.mulf %62, %cst : f64
          %64 = arith.subf %59, %63 : f64
          affine.store %64, %arg3[%arg8, %58] : memref<?x1200xf64>
          %65 = affine.apply #map3(%44)
          %66 = affine.load %arg3[%arg8, %65] : memref<?x1200xf64>
          %67 = affine.load %arg5[%arg8, %65] : memref<?x1200xf64>
          %68 = affine.load %arg5[%arg8, %65 - 1] : memref<?x1200xf64>
          %69 = arith.subf %67, %68 : f64
          %70 = arith.mulf %69, %cst : f64
          %71 = arith.subf %66, %70 : f64
          affine.store %71, %arg3[%arg8, %65] : memref<?x1200xf64>
          %72 = affine.apply #map4(%44)
          %73 = affine.load %arg3[%arg8, %72] : memref<?x1200xf64>
          %74 = affine.load %arg5[%arg8, %72] : memref<?x1200xf64>
          %75 = affine.load %arg5[%arg8, %72 - 1] : memref<?x1200xf64>
          %76 = arith.subf %74, %75 : f64
          %77 = arith.mulf %76, %cst : f64
          %78 = arith.subf %73, %77 : f64
          affine.store %78, %arg3[%arg8, %72] : memref<?x1200xf64>
          %79 = affine.apply #map5(%44)
          %80 = affine.load %arg3[%arg8, %79] : memref<?x1200xf64>
          %81 = affine.load %arg5[%arg8, %79] : memref<?x1200xf64>
          %82 = affine.load %arg5[%arg8, %79 - 1] : memref<?x1200xf64>
          %83 = arith.subf %81, %82 : f64
          %84 = arith.mulf %83, %cst : f64
          %85 = arith.subf %80, %84 : f64
          affine.store %85, %arg3[%arg8, %79] : memref<?x1200xf64>
        }
        affine.for %arg9 = #map9()[%1] to #map10()[%1] step 6 {
          %3 = affine.load %arg3[%arg8, %arg9] : memref<?x1200xf64>
          %4 = affine.load %arg5[%arg8, %arg9] : memref<?x1200xf64>
          %5 = affine.load %arg5[%arg8, %arg9 - 1] : memref<?x1200xf64>
          %6 = arith.subf %4, %5 : f64
          %7 = arith.mulf %6, %cst : f64
          %8 = arith.subf %3, %7 : f64
          affine.store %8, %arg3[%arg8, %arg9] : memref<?x1200xf64>
          %9 = affine.apply #map1(%arg9)
          %10 = affine.load %arg3[%arg8, %9] : memref<?x1200xf64>
          %11 = affine.load %arg5[%arg8, %9] : memref<?x1200xf64>
          %12 = affine.load %arg5[%arg8, %9 - 1] : memref<?x1200xf64>
          %13 = arith.subf %11, %12 : f64
          %14 = arith.mulf %13, %cst : f64
          %15 = arith.subf %10, %14 : f64
          affine.store %15, %arg3[%arg8, %9] : memref<?x1200xf64>
          %16 = affine.apply #map2(%arg9)
          %17 = affine.load %arg3[%arg8, %16] : memref<?x1200xf64>
          %18 = affine.load %arg5[%arg8, %16] : memref<?x1200xf64>
          %19 = affine.load %arg5[%arg8, %16 - 1] : memref<?x1200xf64>
          %20 = arith.subf %18, %19 : f64
          %21 = arith.mulf %20, %cst : f64
          %22 = arith.subf %17, %21 : f64
          affine.store %22, %arg3[%arg8, %16] : memref<?x1200xf64>
          %23 = affine.apply #map3(%arg9)
          %24 = affine.load %arg3[%arg8, %23] : memref<?x1200xf64>
          %25 = affine.load %arg5[%arg8, %23] : memref<?x1200xf64>
          %26 = affine.load %arg5[%arg8, %23 - 1] : memref<?x1200xf64>
          %27 = arith.subf %25, %26 : f64
          %28 = arith.mulf %27, %cst : f64
          %29 = arith.subf %24, %28 : f64
          affine.store %29, %arg3[%arg8, %23] : memref<?x1200xf64>
          %30 = affine.apply #map4(%arg9)
          %31 = affine.load %arg3[%arg8, %30] : memref<?x1200xf64>
          %32 = affine.load %arg5[%arg8, %30] : memref<?x1200xf64>
          %33 = affine.load %arg5[%arg8, %30 - 1] : memref<?x1200xf64>
          %34 = arith.subf %32, %33 : f64
          %35 = arith.mulf %34, %cst : f64
          %36 = arith.subf %31, %35 : f64
          affine.store %36, %arg3[%arg8, %30] : memref<?x1200xf64>
          %37 = affine.apply #map5(%arg9)
          %38 = affine.load %arg3[%arg8, %37] : memref<?x1200xf64>
          %39 = affine.load %arg5[%arg8, %37] : memref<?x1200xf64>
          %40 = affine.load %arg5[%arg8, %37 - 1] : memref<?x1200xf64>
          %41 = arith.subf %39, %40 : f64
          %42 = arith.mulf %41, %cst : f64
          %43 = arith.subf %38, %42 : f64
          affine.store %43, %arg3[%arg8, %37] : memref<?x1200xf64>
        }
        affine.for %arg9 = #map10()[%1] to #map11()[%1] step 2 {
          %3 = affine.load %arg3[%arg8, %arg9] : memref<?x1200xf64>
          %4 = affine.load %arg5[%arg8, %arg9] : memref<?x1200xf64>
          %5 = affine.load %arg5[%arg8, %arg9 - 1] : memref<?x1200xf64>
          %6 = arith.subf %4, %5 : f64
          %7 = arith.mulf %6, %cst : f64
          %8 = arith.subf %3, %7 : f64
          affine.store %8, %arg3[%arg8, %arg9] : memref<?x1200xf64>
          %9 = affine.apply #map1(%arg9)
          %10 = affine.load %arg3[%arg8, %9] : memref<?x1200xf64>
          %11 = affine.load %arg5[%arg8, %9] : memref<?x1200xf64>
          %12 = affine.load %arg5[%arg8, %9 - 1] : memref<?x1200xf64>
          %13 = arith.subf %11, %12 : f64
          %14 = arith.mulf %13, %cst : f64
          %15 = arith.subf %10, %14 : f64
          affine.store %15, %arg3[%arg8, %9] : memref<?x1200xf64>
        }
        affine.for %arg9 = #map11()[%1] to %1 {
          %3 = affine.load %arg3[%arg8, %arg9] : memref<?x1200xf64>
          %4 = affine.load %arg5[%arg8, %arg9] : memref<?x1200xf64>
          %5 = affine.load %arg5[%arg8, %arg9 - 1] : memref<?x1200xf64>
          %6 = arith.subf %4, %5 : f64
          %7 = arith.mulf %6, %cst : f64
          %8 = arith.subf %3, %7 : f64
          affine.store %8, %arg3[%arg8, %arg9] : memref<?x1200xf64>
        }
      }
      affine.for %arg8 = 0 to #map12()[%0] {
        affine.for %arg9 = 0 to #map13()[%1] step 12 {
          %3 = affine.load %arg5[%arg8, %arg9] : memref<?x1200xf64>
          %4 = affine.load %arg3[%arg8, %arg9 + 1] : memref<?x1200xf64>
          %5 = affine.load %arg3[%arg8, %arg9] : memref<?x1200xf64>
          %6 = arith.subf %4, %5 : f64
          %7 = affine.load %arg4[%arg8 + 1, %arg9] : memref<?x1200xf64>
          %8 = arith.addf %6, %7 : f64
          %9 = affine.load %arg4[%arg8, %arg9] : memref<?x1200xf64>
          %10 = arith.subf %8, %9 : f64
          %11 = arith.mulf %10, %cst_0 : f64
          %12 = arith.subf %3, %11 : f64
          affine.store %12, %arg5[%arg8, %arg9] : memref<?x1200xf64>
          %13 = affine.apply #map1(%arg9)
          %14 = affine.load %arg5[%arg8, %13] : memref<?x1200xf64>
          %15 = affine.load %arg3[%arg8, %13 + 1] : memref<?x1200xf64>
          %16 = affine.load %arg3[%arg8, %13] : memref<?x1200xf64>
          %17 = arith.subf %15, %16 : f64
          %18 = affine.load %arg4[%arg8 + 1, %13] : memref<?x1200xf64>
          %19 = arith.addf %17, %18 : f64
          %20 = affine.load %arg4[%arg8, %13] : memref<?x1200xf64>
          %21 = arith.subf %19, %20 : f64
          %22 = arith.mulf %21, %cst_0 : f64
          %23 = arith.subf %14, %22 : f64
          affine.store %23, %arg5[%arg8, %13] : memref<?x1200xf64>
          %24 = affine.apply #map2(%arg9)
          %25 = affine.load %arg5[%arg8, %24] : memref<?x1200xf64>
          %26 = affine.load %arg3[%arg8, %24 + 1] : memref<?x1200xf64>
          %27 = affine.load %arg3[%arg8, %24] : memref<?x1200xf64>
          %28 = arith.subf %26, %27 : f64
          %29 = affine.load %arg4[%arg8 + 1, %24] : memref<?x1200xf64>
          %30 = arith.addf %28, %29 : f64
          %31 = affine.load %arg4[%arg8, %24] : memref<?x1200xf64>
          %32 = arith.subf %30, %31 : f64
          %33 = arith.mulf %32, %cst_0 : f64
          %34 = arith.subf %25, %33 : f64
          affine.store %34, %arg5[%arg8, %24] : memref<?x1200xf64>
          %35 = affine.apply #map3(%arg9)
          %36 = affine.load %arg5[%arg8, %35] : memref<?x1200xf64>
          %37 = affine.load %arg3[%arg8, %35 + 1] : memref<?x1200xf64>
          %38 = affine.load %arg3[%arg8, %35] : memref<?x1200xf64>
          %39 = arith.subf %37, %38 : f64
          %40 = affine.load %arg4[%arg8 + 1, %35] : memref<?x1200xf64>
          %41 = arith.addf %39, %40 : f64
          %42 = affine.load %arg4[%arg8, %35] : memref<?x1200xf64>
          %43 = arith.subf %41, %42 : f64
          %44 = arith.mulf %43, %cst_0 : f64
          %45 = arith.subf %36, %44 : f64
          affine.store %45, %arg5[%arg8, %35] : memref<?x1200xf64>
          %46 = affine.apply #map4(%arg9)
          %47 = affine.load %arg5[%arg8, %46] : memref<?x1200xf64>
          %48 = affine.load %arg3[%arg8, %46 + 1] : memref<?x1200xf64>
          %49 = affine.load %arg3[%arg8, %46] : memref<?x1200xf64>
          %50 = arith.subf %48, %49 : f64
          %51 = affine.load %arg4[%arg8 + 1, %46] : memref<?x1200xf64>
          %52 = arith.addf %50, %51 : f64
          %53 = affine.load %arg4[%arg8, %46] : memref<?x1200xf64>
          %54 = arith.subf %52, %53 : f64
          %55 = arith.mulf %54, %cst_0 : f64
          %56 = arith.subf %47, %55 : f64
          affine.store %56, %arg5[%arg8, %46] : memref<?x1200xf64>
          %57 = affine.apply #map5(%arg9)
          %58 = affine.load %arg5[%arg8, %57] : memref<?x1200xf64>
          %59 = affine.load %arg3[%arg8, %57 + 1] : memref<?x1200xf64>
          %60 = affine.load %arg3[%arg8, %57] : memref<?x1200xf64>
          %61 = arith.subf %59, %60 : f64
          %62 = affine.load %arg4[%arg8 + 1, %57] : memref<?x1200xf64>
          %63 = arith.addf %61, %62 : f64
          %64 = affine.load %arg4[%arg8, %57] : memref<?x1200xf64>
          %65 = arith.subf %63, %64 : f64
          %66 = arith.mulf %65, %cst_0 : f64
          %67 = arith.subf %58, %66 : f64
          affine.store %67, %arg5[%arg8, %57] : memref<?x1200xf64>
          %68 = affine.apply #map6(%arg9)
          %69 = affine.load %arg5[%arg8, %68] : memref<?x1200xf64>
          %70 = affine.load %arg3[%arg8, %68 + 1] : memref<?x1200xf64>
          %71 = affine.load %arg3[%arg8, %68] : memref<?x1200xf64>
          %72 = arith.subf %70, %71 : f64
          %73 = affine.load %arg4[%arg8 + 1, %68] : memref<?x1200xf64>
          %74 = arith.addf %72, %73 : f64
          %75 = affine.load %arg4[%arg8, %68] : memref<?x1200xf64>
          %76 = arith.subf %74, %75 : f64
          %77 = arith.mulf %76, %cst_0 : f64
          %78 = arith.subf %69, %77 : f64
          affine.store %78, %arg5[%arg8, %68] : memref<?x1200xf64>
          %79 = affine.apply #map1(%68)
          %80 = affine.load %arg5[%arg8, %79] : memref<?x1200xf64>
          %81 = affine.load %arg3[%arg8, %79 + 1] : memref<?x1200xf64>
          %82 = affine.load %arg3[%arg8, %79] : memref<?x1200xf64>
          %83 = arith.subf %81, %82 : f64
          %84 = affine.load %arg4[%arg8 + 1, %79] : memref<?x1200xf64>
          %85 = arith.addf %83, %84 : f64
          %86 = affine.load %arg4[%arg8, %79] : memref<?x1200xf64>
          %87 = arith.subf %85, %86 : f64
          %88 = arith.mulf %87, %cst_0 : f64
          %89 = arith.subf %80, %88 : f64
          affine.store %89, %arg5[%arg8, %79] : memref<?x1200xf64>
          %90 = affine.apply #map2(%68)
          %91 = affine.load %arg5[%arg8, %90] : memref<?x1200xf64>
          %92 = affine.load %arg3[%arg8, %90 + 1] : memref<?x1200xf64>
          %93 = affine.load %arg3[%arg8, %90] : memref<?x1200xf64>
          %94 = arith.subf %92, %93 : f64
          %95 = affine.load %arg4[%arg8 + 1, %90] : memref<?x1200xf64>
          %96 = arith.addf %94, %95 : f64
          %97 = affine.load %arg4[%arg8, %90] : memref<?x1200xf64>
          %98 = arith.subf %96, %97 : f64
          %99 = arith.mulf %98, %cst_0 : f64
          %100 = arith.subf %91, %99 : f64
          affine.store %100, %arg5[%arg8, %90] : memref<?x1200xf64>
          %101 = affine.apply #map3(%68)
          %102 = affine.load %arg5[%arg8, %101] : memref<?x1200xf64>
          %103 = affine.load %arg3[%arg8, %101 + 1] : memref<?x1200xf64>
          %104 = affine.load %arg3[%arg8, %101] : memref<?x1200xf64>
          %105 = arith.subf %103, %104 : f64
          %106 = affine.load %arg4[%arg8 + 1, %101] : memref<?x1200xf64>
          %107 = arith.addf %105, %106 : f64
          %108 = affine.load %arg4[%arg8, %101] : memref<?x1200xf64>
          %109 = arith.subf %107, %108 : f64
          %110 = arith.mulf %109, %cst_0 : f64
          %111 = arith.subf %102, %110 : f64
          affine.store %111, %arg5[%arg8, %101] : memref<?x1200xf64>
          %112 = affine.apply #map4(%68)
          %113 = affine.load %arg5[%arg8, %112] : memref<?x1200xf64>
          %114 = affine.load %arg3[%arg8, %112 + 1] : memref<?x1200xf64>
          %115 = affine.load %arg3[%arg8, %112] : memref<?x1200xf64>
          %116 = arith.subf %114, %115 : f64
          %117 = affine.load %arg4[%arg8 + 1, %112] : memref<?x1200xf64>
          %118 = arith.addf %116, %117 : f64
          %119 = affine.load %arg4[%arg8, %112] : memref<?x1200xf64>
          %120 = arith.subf %118, %119 : f64
          %121 = arith.mulf %120, %cst_0 : f64
          %122 = arith.subf %113, %121 : f64
          affine.store %122, %arg5[%arg8, %112] : memref<?x1200xf64>
          %123 = affine.apply #map5(%68)
          %124 = affine.load %arg5[%arg8, %123] : memref<?x1200xf64>
          %125 = affine.load %arg3[%arg8, %123 + 1] : memref<?x1200xf64>
          %126 = affine.load %arg3[%arg8, %123] : memref<?x1200xf64>
          %127 = arith.subf %125, %126 : f64
          %128 = affine.load %arg4[%arg8 + 1, %123] : memref<?x1200xf64>
          %129 = arith.addf %127, %128 : f64
          %130 = affine.load %arg4[%arg8, %123] : memref<?x1200xf64>
          %131 = arith.subf %129, %130 : f64
          %132 = arith.mulf %131, %cst_0 : f64
          %133 = arith.subf %124, %132 : f64
          affine.store %133, %arg5[%arg8, %123] : memref<?x1200xf64>
        }
        affine.for %arg9 = #map13()[%1] to #map14()[%1] step 6 {
          %3 = affine.load %arg5[%arg8, %arg9] : memref<?x1200xf64>
          %4 = affine.load %arg3[%arg8, %arg9 + 1] : memref<?x1200xf64>
          %5 = affine.load %arg3[%arg8, %arg9] : memref<?x1200xf64>
          %6 = arith.subf %4, %5 : f64
          %7 = affine.load %arg4[%arg8 + 1, %arg9] : memref<?x1200xf64>
          %8 = arith.addf %6, %7 : f64
          %9 = affine.load %arg4[%arg8, %arg9] : memref<?x1200xf64>
          %10 = arith.subf %8, %9 : f64
          %11 = arith.mulf %10, %cst_0 : f64
          %12 = arith.subf %3, %11 : f64
          affine.store %12, %arg5[%arg8, %arg9] : memref<?x1200xf64>
          %13 = affine.apply #map1(%arg9)
          %14 = affine.load %arg5[%arg8, %13] : memref<?x1200xf64>
          %15 = affine.load %arg3[%arg8, %13 + 1] : memref<?x1200xf64>
          %16 = affine.load %arg3[%arg8, %13] : memref<?x1200xf64>
          %17 = arith.subf %15, %16 : f64
          %18 = affine.load %arg4[%arg8 + 1, %13] : memref<?x1200xf64>
          %19 = arith.addf %17, %18 : f64
          %20 = affine.load %arg4[%arg8, %13] : memref<?x1200xf64>
          %21 = arith.subf %19, %20 : f64
          %22 = arith.mulf %21, %cst_0 : f64
          %23 = arith.subf %14, %22 : f64
          affine.store %23, %arg5[%arg8, %13] : memref<?x1200xf64>
          %24 = affine.apply #map2(%arg9)
          %25 = affine.load %arg5[%arg8, %24] : memref<?x1200xf64>
          %26 = affine.load %arg3[%arg8, %24 + 1] : memref<?x1200xf64>
          %27 = affine.load %arg3[%arg8, %24] : memref<?x1200xf64>
          %28 = arith.subf %26, %27 : f64
          %29 = affine.load %arg4[%arg8 + 1, %24] : memref<?x1200xf64>
          %30 = arith.addf %28, %29 : f64
          %31 = affine.load %arg4[%arg8, %24] : memref<?x1200xf64>
          %32 = arith.subf %30, %31 : f64
          %33 = arith.mulf %32, %cst_0 : f64
          %34 = arith.subf %25, %33 : f64
          affine.store %34, %arg5[%arg8, %24] : memref<?x1200xf64>
          %35 = affine.apply #map3(%arg9)
          %36 = affine.load %arg5[%arg8, %35] : memref<?x1200xf64>
          %37 = affine.load %arg3[%arg8, %35 + 1] : memref<?x1200xf64>
          %38 = affine.load %arg3[%arg8, %35] : memref<?x1200xf64>
          %39 = arith.subf %37, %38 : f64
          %40 = affine.load %arg4[%arg8 + 1, %35] : memref<?x1200xf64>
          %41 = arith.addf %39, %40 : f64
          %42 = affine.load %arg4[%arg8, %35] : memref<?x1200xf64>
          %43 = arith.subf %41, %42 : f64
          %44 = arith.mulf %43, %cst_0 : f64
          %45 = arith.subf %36, %44 : f64
          affine.store %45, %arg5[%arg8, %35] : memref<?x1200xf64>
          %46 = affine.apply #map4(%arg9)
          %47 = affine.load %arg5[%arg8, %46] : memref<?x1200xf64>
          %48 = affine.load %arg3[%arg8, %46 + 1] : memref<?x1200xf64>
          %49 = affine.load %arg3[%arg8, %46] : memref<?x1200xf64>
          %50 = arith.subf %48, %49 : f64
          %51 = affine.load %arg4[%arg8 + 1, %46] : memref<?x1200xf64>
          %52 = arith.addf %50, %51 : f64
          %53 = affine.load %arg4[%arg8, %46] : memref<?x1200xf64>
          %54 = arith.subf %52, %53 : f64
          %55 = arith.mulf %54, %cst_0 : f64
          %56 = arith.subf %47, %55 : f64
          affine.store %56, %arg5[%arg8, %46] : memref<?x1200xf64>
          %57 = affine.apply #map5(%arg9)
          %58 = affine.load %arg5[%arg8, %57] : memref<?x1200xf64>
          %59 = affine.load %arg3[%arg8, %57 + 1] : memref<?x1200xf64>
          %60 = affine.load %arg3[%arg8, %57] : memref<?x1200xf64>
          %61 = arith.subf %59, %60 : f64
          %62 = affine.load %arg4[%arg8 + 1, %57] : memref<?x1200xf64>
          %63 = arith.addf %61, %62 : f64
          %64 = affine.load %arg4[%arg8, %57] : memref<?x1200xf64>
          %65 = arith.subf %63, %64 : f64
          %66 = arith.mulf %65, %cst_0 : f64
          %67 = arith.subf %58, %66 : f64
          affine.store %67, %arg5[%arg8, %57] : memref<?x1200xf64>
        }
        affine.for %arg9 = #map14()[%1] to #map15()[%1] step 2 {
          %3 = affine.load %arg5[%arg8, %arg9] : memref<?x1200xf64>
          %4 = affine.load %arg3[%arg8, %arg9 + 1] : memref<?x1200xf64>
          %5 = affine.load %arg3[%arg8, %arg9] : memref<?x1200xf64>
          %6 = arith.subf %4, %5 : f64
          %7 = affine.load %arg4[%arg8 + 1, %arg9] : memref<?x1200xf64>
          %8 = arith.addf %6, %7 : f64
          %9 = affine.load %arg4[%arg8, %arg9] : memref<?x1200xf64>
          %10 = arith.subf %8, %9 : f64
          %11 = arith.mulf %10, %cst_0 : f64
          %12 = arith.subf %3, %11 : f64
          affine.store %12, %arg5[%arg8, %arg9] : memref<?x1200xf64>
          %13 = affine.apply #map1(%arg9)
          %14 = affine.load %arg5[%arg8, %13] : memref<?x1200xf64>
          %15 = affine.load %arg3[%arg8, %13 + 1] : memref<?x1200xf64>
          %16 = affine.load %arg3[%arg8, %13] : memref<?x1200xf64>
          %17 = arith.subf %15, %16 : f64
          %18 = affine.load %arg4[%arg8 + 1, %13] : memref<?x1200xf64>
          %19 = arith.addf %17, %18 : f64
          %20 = affine.load %arg4[%arg8, %13] : memref<?x1200xf64>
          %21 = arith.subf %19, %20 : f64
          %22 = arith.mulf %21, %cst_0 : f64
          %23 = arith.subf %14, %22 : f64
          affine.store %23, %arg5[%arg8, %13] : memref<?x1200xf64>
        }
        affine.for %arg9 = #map15()[%1] to #map12()[%1] {
          %3 = affine.load %arg5[%arg8, %arg9] : memref<?x1200xf64>
          %4 = affine.load %arg3[%arg8, %arg9 + 1] : memref<?x1200xf64>
          %5 = affine.load %arg3[%arg8, %arg9] : memref<?x1200xf64>
          %6 = arith.subf %4, %5 : f64
          %7 = affine.load %arg4[%arg8 + 1, %arg9] : memref<?x1200xf64>
          %8 = arith.addf %6, %7 : f64
          %9 = affine.load %arg4[%arg8, %arg9] : memref<?x1200xf64>
          %10 = arith.subf %8, %9 : f64
          %11 = arith.mulf %10, %cst_0 : f64
          %12 = arith.subf %3, %11 : f64
          affine.store %12, %arg5[%arg8, %arg9] : memref<?x1200xf64>
        }
      }
    }
    return
  }
}

