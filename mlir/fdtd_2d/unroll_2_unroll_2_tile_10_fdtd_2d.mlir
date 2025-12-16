#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 10, s0)>
#map2 = affine_map<()[s0] -> (((s0 floordiv 2) floordiv 2) * 4)>
#map3 = affine_map<(d0) -> (d0 + 1)>
#map4 = affine_map<(d0) -> (d0 + 2)>
#map5 = affine_map<()[s0] -> ((s0 floordiv 2) * 2)>
#map6 = affine_map<()[s0] -> ((((s0 - 1) floordiv 2) floordiv 2) * 4 + 1)>
#map7 = affine_map<()[s0] -> (((s0 - 1) floordiv 2) * 2 + 1)>
#map8 = affine_map<()[s0] -> (((s0 - 1) floordiv 2) * 2 + ((s0 - ((s0 - 1) floordiv 2) * 2 - 1) floordiv 2) * 2 + 1)>
#map9 = affine_map<()[s0] -> (s0 - 1)>
#map10 = affine_map<()[s0] -> ((((s0 - 1) floordiv 2) floordiv 2) * 4)>
#map11 = affine_map<()[s0] -> (((s0 - 1) floordiv 2) * 2)>
#map12 = affine_map<()[s0] -> (((s0 - 1) floordiv 2) * 2 + ((s0 - ((s0 - 1) floordiv 2) * 2 - 1) floordiv 2) * 2)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_fdtd_2d(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: memref<?x1200xf64>, %arg4: memref<?x1200xf64>, %arg5: memref<?x1200xf64>, %arg6: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 5.000000e-01 : f64
    %cst_0 = arith.constant 0.69999999999999996 : f64
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg2 : i32 to index
    %2 = arith.index_cast %arg0 : i32 to index
    affine.for %arg7 = 0 to %2 step 10 {
      affine.for %arg8 = #map(%arg7) to min #map1(%arg7)[%2] {
        affine.for %arg9 = 0 to #map2()[%1] step 4 {
          %3 = affine.load %arg6[%arg8] : memref<?xf64>
          affine.store %3, %arg4[0, %arg9] : memref<?x1200xf64>
          %4 = affine.apply #map3(%arg9)
          %5 = affine.load %arg6[%arg8] : memref<?xf64>
          affine.store %5, %arg4[0, %4] : memref<?x1200xf64>
          %6 = affine.apply #map4(%arg9)
          %7 = affine.load %arg6[%arg8] : memref<?xf64>
          affine.store %7, %arg4[0, %6] : memref<?x1200xf64>
          %8 = affine.apply #map3(%6)
          %9 = affine.load %arg6[%arg8] : memref<?xf64>
          affine.store %9, %arg4[0, %8] : memref<?x1200xf64>
        }
        affine.for %arg9 = #map2()[%1] to #map5()[%1] step 2 {
          %3 = affine.load %arg6[%arg8] : memref<?xf64>
          affine.store %3, %arg4[0, %arg9] : memref<?x1200xf64>
          %4 = affine.apply #map3(%arg9)
          %5 = affine.load %arg6[%arg8] : memref<?xf64>
          affine.store %5, %arg4[0, %4] : memref<?x1200xf64>
        }
        affine.for %arg9 = #map5()[%1] to #map5()[%1] step 2 {
          %3 = affine.load %arg6[%arg8] : memref<?xf64>
          affine.store %3, %arg4[0, %arg9] : memref<?x1200xf64>
          %4 = affine.apply #map3(%arg9)
          %5 = affine.load %arg6[%arg8] : memref<?xf64>
          affine.store %5, %arg4[0, %4] : memref<?x1200xf64>
        }
        affine.for %arg9 = #map5()[%1] to %1 {
          %3 = affine.load %arg6[%arg8] : memref<?xf64>
          affine.store %3, %arg4[0, %arg9] : memref<?x1200xf64>
        }
        affine.for %arg9 = 1 to %0 {
          affine.for %arg10 = 0 to #map2()[%1] step 4 {
            %3 = affine.load %arg4[%arg9, %arg10] : memref<?x1200xf64>
            %4 = affine.load %arg5[%arg9, %arg10] : memref<?x1200xf64>
            %5 = affine.load %arg5[%arg9 - 1, %arg10] : memref<?x1200xf64>
            %6 = arith.subf %4, %5 : f64
            %7 = arith.mulf %6, %cst : f64
            %8 = arith.subf %3, %7 : f64
            affine.store %8, %arg4[%arg9, %arg10] : memref<?x1200xf64>
            %9 = affine.apply #map3(%arg10)
            %10 = affine.load %arg4[%arg9, %9] : memref<?x1200xf64>
            %11 = affine.load %arg5[%arg9, %9] : memref<?x1200xf64>
            %12 = affine.load %arg5[%arg9 - 1, %9] : memref<?x1200xf64>
            %13 = arith.subf %11, %12 : f64
            %14 = arith.mulf %13, %cst : f64
            %15 = arith.subf %10, %14 : f64
            affine.store %15, %arg4[%arg9, %9] : memref<?x1200xf64>
            %16 = affine.apply #map4(%arg10)
            %17 = affine.load %arg4[%arg9, %16] : memref<?x1200xf64>
            %18 = affine.load %arg5[%arg9, %16] : memref<?x1200xf64>
            %19 = affine.load %arg5[%arg9 - 1, %16] : memref<?x1200xf64>
            %20 = arith.subf %18, %19 : f64
            %21 = arith.mulf %20, %cst : f64
            %22 = arith.subf %17, %21 : f64
            affine.store %22, %arg4[%arg9, %16] : memref<?x1200xf64>
            %23 = affine.apply #map3(%16)
            %24 = affine.load %arg4[%arg9, %23] : memref<?x1200xf64>
            %25 = affine.load %arg5[%arg9, %23] : memref<?x1200xf64>
            %26 = affine.load %arg5[%arg9 - 1, %23] : memref<?x1200xf64>
            %27 = arith.subf %25, %26 : f64
            %28 = arith.mulf %27, %cst : f64
            %29 = arith.subf %24, %28 : f64
            affine.store %29, %arg4[%arg9, %23] : memref<?x1200xf64>
          }
          affine.for %arg10 = #map2()[%1] to #map5()[%1] step 2 {
            %3 = affine.load %arg4[%arg9, %arg10] : memref<?x1200xf64>
            %4 = affine.load %arg5[%arg9, %arg10] : memref<?x1200xf64>
            %5 = affine.load %arg5[%arg9 - 1, %arg10] : memref<?x1200xf64>
            %6 = arith.subf %4, %5 : f64
            %7 = arith.mulf %6, %cst : f64
            %8 = arith.subf %3, %7 : f64
            affine.store %8, %arg4[%arg9, %arg10] : memref<?x1200xf64>
            %9 = affine.apply #map3(%arg10)
            %10 = affine.load %arg4[%arg9, %9] : memref<?x1200xf64>
            %11 = affine.load %arg5[%arg9, %9] : memref<?x1200xf64>
            %12 = affine.load %arg5[%arg9 - 1, %9] : memref<?x1200xf64>
            %13 = arith.subf %11, %12 : f64
            %14 = arith.mulf %13, %cst : f64
            %15 = arith.subf %10, %14 : f64
            affine.store %15, %arg4[%arg9, %9] : memref<?x1200xf64>
          }
          affine.for %arg10 = #map5()[%1] to #map5()[%1] step 2 {
            %3 = affine.load %arg4[%arg9, %arg10] : memref<?x1200xf64>
            %4 = affine.load %arg5[%arg9, %arg10] : memref<?x1200xf64>
            %5 = affine.load %arg5[%arg9 - 1, %arg10] : memref<?x1200xf64>
            %6 = arith.subf %4, %5 : f64
            %7 = arith.mulf %6, %cst : f64
            %8 = arith.subf %3, %7 : f64
            affine.store %8, %arg4[%arg9, %arg10] : memref<?x1200xf64>
            %9 = affine.apply #map3(%arg10)
            %10 = affine.load %arg4[%arg9, %9] : memref<?x1200xf64>
            %11 = affine.load %arg5[%arg9, %9] : memref<?x1200xf64>
            %12 = affine.load %arg5[%arg9 - 1, %9] : memref<?x1200xf64>
            %13 = arith.subf %11, %12 : f64
            %14 = arith.mulf %13, %cst : f64
            %15 = arith.subf %10, %14 : f64
            affine.store %15, %arg4[%arg9, %9] : memref<?x1200xf64>
          }
          affine.for %arg10 = #map5()[%1] to %1 {
            %3 = affine.load %arg4[%arg9, %arg10] : memref<?x1200xf64>
            %4 = affine.load %arg5[%arg9, %arg10] : memref<?x1200xf64>
            %5 = affine.load %arg5[%arg9 - 1, %arg10] : memref<?x1200xf64>
            %6 = arith.subf %4, %5 : f64
            %7 = arith.mulf %6, %cst : f64
            %8 = arith.subf %3, %7 : f64
            affine.store %8, %arg4[%arg9, %arg10] : memref<?x1200xf64>
          }
        }
        affine.for %arg9 = 0 to %0 {
          affine.for %arg10 = 1 to #map6()[%1] step 4 {
            %3 = affine.load %arg3[%arg9, %arg10] : memref<?x1200xf64>
            %4 = affine.load %arg5[%arg9, %arg10] : memref<?x1200xf64>
            %5 = affine.load %arg5[%arg9, %arg10 - 1] : memref<?x1200xf64>
            %6 = arith.subf %4, %5 : f64
            %7 = arith.mulf %6, %cst : f64
            %8 = arith.subf %3, %7 : f64
            affine.store %8, %arg3[%arg9, %arg10] : memref<?x1200xf64>
            %9 = affine.apply #map3(%arg10)
            %10 = affine.load %arg3[%arg9, %9] : memref<?x1200xf64>
            %11 = affine.load %arg5[%arg9, %9] : memref<?x1200xf64>
            %12 = affine.load %arg5[%arg9, %9 - 1] : memref<?x1200xf64>
            %13 = arith.subf %11, %12 : f64
            %14 = arith.mulf %13, %cst : f64
            %15 = arith.subf %10, %14 : f64
            affine.store %15, %arg3[%arg9, %9] : memref<?x1200xf64>
            %16 = affine.apply #map4(%arg10)
            %17 = affine.load %arg3[%arg9, %16] : memref<?x1200xf64>
            %18 = affine.load %arg5[%arg9, %16] : memref<?x1200xf64>
            %19 = affine.load %arg5[%arg9, %16 - 1] : memref<?x1200xf64>
            %20 = arith.subf %18, %19 : f64
            %21 = arith.mulf %20, %cst : f64
            %22 = arith.subf %17, %21 : f64
            affine.store %22, %arg3[%arg9, %16] : memref<?x1200xf64>
            %23 = affine.apply #map3(%16)
            %24 = affine.load %arg3[%arg9, %23] : memref<?x1200xf64>
            %25 = affine.load %arg5[%arg9, %23] : memref<?x1200xf64>
            %26 = affine.load %arg5[%arg9, %23 - 1] : memref<?x1200xf64>
            %27 = arith.subf %25, %26 : f64
            %28 = arith.mulf %27, %cst : f64
            %29 = arith.subf %24, %28 : f64
            affine.store %29, %arg3[%arg9, %23] : memref<?x1200xf64>
          }
          affine.for %arg10 = #map6()[%1] to #map7()[%1] step 2 {
            %3 = affine.load %arg3[%arg9, %arg10] : memref<?x1200xf64>
            %4 = affine.load %arg5[%arg9, %arg10] : memref<?x1200xf64>
            %5 = affine.load %arg5[%arg9, %arg10 - 1] : memref<?x1200xf64>
            %6 = arith.subf %4, %5 : f64
            %7 = arith.mulf %6, %cst : f64
            %8 = arith.subf %3, %7 : f64
            affine.store %8, %arg3[%arg9, %arg10] : memref<?x1200xf64>
            %9 = affine.apply #map3(%arg10)
            %10 = affine.load %arg3[%arg9, %9] : memref<?x1200xf64>
            %11 = affine.load %arg5[%arg9, %9] : memref<?x1200xf64>
            %12 = affine.load %arg5[%arg9, %9 - 1] : memref<?x1200xf64>
            %13 = arith.subf %11, %12 : f64
            %14 = arith.mulf %13, %cst : f64
            %15 = arith.subf %10, %14 : f64
            affine.store %15, %arg3[%arg9, %9] : memref<?x1200xf64>
          }
          affine.for %arg10 = #map7()[%1] to #map8()[%1] step 2 {
            %3 = affine.load %arg3[%arg9, %arg10] : memref<?x1200xf64>
            %4 = affine.load %arg5[%arg9, %arg10] : memref<?x1200xf64>
            %5 = affine.load %arg5[%arg9, %arg10 - 1] : memref<?x1200xf64>
            %6 = arith.subf %4, %5 : f64
            %7 = arith.mulf %6, %cst : f64
            %8 = arith.subf %3, %7 : f64
            affine.store %8, %arg3[%arg9, %arg10] : memref<?x1200xf64>
            %9 = affine.apply #map3(%arg10)
            %10 = affine.load %arg3[%arg9, %9] : memref<?x1200xf64>
            %11 = affine.load %arg5[%arg9, %9] : memref<?x1200xf64>
            %12 = affine.load %arg5[%arg9, %9 - 1] : memref<?x1200xf64>
            %13 = arith.subf %11, %12 : f64
            %14 = arith.mulf %13, %cst : f64
            %15 = arith.subf %10, %14 : f64
            affine.store %15, %arg3[%arg9, %9] : memref<?x1200xf64>
          }
          affine.for %arg10 = #map8()[%1] to %1 {
            %3 = affine.load %arg3[%arg9, %arg10] : memref<?x1200xf64>
            %4 = affine.load %arg5[%arg9, %arg10] : memref<?x1200xf64>
            %5 = affine.load %arg5[%arg9, %arg10 - 1] : memref<?x1200xf64>
            %6 = arith.subf %4, %5 : f64
            %7 = arith.mulf %6, %cst : f64
            %8 = arith.subf %3, %7 : f64
            affine.store %8, %arg3[%arg9, %arg10] : memref<?x1200xf64>
          }
        }
        affine.for %arg9 = 0 to #map9()[%0] {
          affine.for %arg10 = 0 to #map10()[%1] step 4 {
            %3 = affine.load %arg5[%arg9, %arg10] : memref<?x1200xf64>
            %4 = affine.load %arg3[%arg9, %arg10 + 1] : memref<?x1200xf64>
            %5 = affine.load %arg3[%arg9, %arg10] : memref<?x1200xf64>
            %6 = arith.subf %4, %5 : f64
            %7 = affine.load %arg4[%arg9 + 1, %arg10] : memref<?x1200xf64>
            %8 = arith.addf %6, %7 : f64
            %9 = affine.load %arg4[%arg9, %arg10] : memref<?x1200xf64>
            %10 = arith.subf %8, %9 : f64
            %11 = arith.mulf %10, %cst_0 : f64
            %12 = arith.subf %3, %11 : f64
            affine.store %12, %arg5[%arg9, %arg10] : memref<?x1200xf64>
            %13 = affine.apply #map3(%arg10)
            %14 = affine.load %arg5[%arg9, %13] : memref<?x1200xf64>
            %15 = affine.load %arg3[%arg9, %13 + 1] : memref<?x1200xf64>
            %16 = affine.load %arg3[%arg9, %13] : memref<?x1200xf64>
            %17 = arith.subf %15, %16 : f64
            %18 = affine.load %arg4[%arg9 + 1, %13] : memref<?x1200xf64>
            %19 = arith.addf %17, %18 : f64
            %20 = affine.load %arg4[%arg9, %13] : memref<?x1200xf64>
            %21 = arith.subf %19, %20 : f64
            %22 = arith.mulf %21, %cst_0 : f64
            %23 = arith.subf %14, %22 : f64
            affine.store %23, %arg5[%arg9, %13] : memref<?x1200xf64>
            %24 = affine.apply #map4(%arg10)
            %25 = affine.load %arg5[%arg9, %24] : memref<?x1200xf64>
            %26 = affine.load %arg3[%arg9, %24 + 1] : memref<?x1200xf64>
            %27 = affine.load %arg3[%arg9, %24] : memref<?x1200xf64>
            %28 = arith.subf %26, %27 : f64
            %29 = affine.load %arg4[%arg9 + 1, %24] : memref<?x1200xf64>
            %30 = arith.addf %28, %29 : f64
            %31 = affine.load %arg4[%arg9, %24] : memref<?x1200xf64>
            %32 = arith.subf %30, %31 : f64
            %33 = arith.mulf %32, %cst_0 : f64
            %34 = arith.subf %25, %33 : f64
            affine.store %34, %arg5[%arg9, %24] : memref<?x1200xf64>
            %35 = affine.apply #map3(%24)
            %36 = affine.load %arg5[%arg9, %35] : memref<?x1200xf64>
            %37 = affine.load %arg3[%arg9, %35 + 1] : memref<?x1200xf64>
            %38 = affine.load %arg3[%arg9, %35] : memref<?x1200xf64>
            %39 = arith.subf %37, %38 : f64
            %40 = affine.load %arg4[%arg9 + 1, %35] : memref<?x1200xf64>
            %41 = arith.addf %39, %40 : f64
            %42 = affine.load %arg4[%arg9, %35] : memref<?x1200xf64>
            %43 = arith.subf %41, %42 : f64
            %44 = arith.mulf %43, %cst_0 : f64
            %45 = arith.subf %36, %44 : f64
            affine.store %45, %arg5[%arg9, %35] : memref<?x1200xf64>
          }
          affine.for %arg10 = #map10()[%1] to #map11()[%1] step 2 {
            %3 = affine.load %arg5[%arg9, %arg10] : memref<?x1200xf64>
            %4 = affine.load %arg3[%arg9, %arg10 + 1] : memref<?x1200xf64>
            %5 = affine.load %arg3[%arg9, %arg10] : memref<?x1200xf64>
            %6 = arith.subf %4, %5 : f64
            %7 = affine.load %arg4[%arg9 + 1, %arg10] : memref<?x1200xf64>
            %8 = arith.addf %6, %7 : f64
            %9 = affine.load %arg4[%arg9, %arg10] : memref<?x1200xf64>
            %10 = arith.subf %8, %9 : f64
            %11 = arith.mulf %10, %cst_0 : f64
            %12 = arith.subf %3, %11 : f64
            affine.store %12, %arg5[%arg9, %arg10] : memref<?x1200xf64>
            %13 = affine.apply #map3(%arg10)
            %14 = affine.load %arg5[%arg9, %13] : memref<?x1200xf64>
            %15 = affine.load %arg3[%arg9, %13 + 1] : memref<?x1200xf64>
            %16 = affine.load %arg3[%arg9, %13] : memref<?x1200xf64>
            %17 = arith.subf %15, %16 : f64
            %18 = affine.load %arg4[%arg9 + 1, %13] : memref<?x1200xf64>
            %19 = arith.addf %17, %18 : f64
            %20 = affine.load %arg4[%arg9, %13] : memref<?x1200xf64>
            %21 = arith.subf %19, %20 : f64
            %22 = arith.mulf %21, %cst_0 : f64
            %23 = arith.subf %14, %22 : f64
            affine.store %23, %arg5[%arg9, %13] : memref<?x1200xf64>
          }
          affine.for %arg10 = #map11()[%1] to #map12()[%1] step 2 {
            %3 = affine.load %arg5[%arg9, %arg10] : memref<?x1200xf64>
            %4 = affine.load %arg3[%arg9, %arg10 + 1] : memref<?x1200xf64>
            %5 = affine.load %arg3[%arg9, %arg10] : memref<?x1200xf64>
            %6 = arith.subf %4, %5 : f64
            %7 = affine.load %arg4[%arg9 + 1, %arg10] : memref<?x1200xf64>
            %8 = arith.addf %6, %7 : f64
            %9 = affine.load %arg4[%arg9, %arg10] : memref<?x1200xf64>
            %10 = arith.subf %8, %9 : f64
            %11 = arith.mulf %10, %cst_0 : f64
            %12 = arith.subf %3, %11 : f64
            affine.store %12, %arg5[%arg9, %arg10] : memref<?x1200xf64>
            %13 = affine.apply #map3(%arg10)
            %14 = affine.load %arg5[%arg9, %13] : memref<?x1200xf64>
            %15 = affine.load %arg3[%arg9, %13 + 1] : memref<?x1200xf64>
            %16 = affine.load %arg3[%arg9, %13] : memref<?x1200xf64>
            %17 = arith.subf %15, %16 : f64
            %18 = affine.load %arg4[%arg9 + 1, %13] : memref<?x1200xf64>
            %19 = arith.addf %17, %18 : f64
            %20 = affine.load %arg4[%arg9, %13] : memref<?x1200xf64>
            %21 = arith.subf %19, %20 : f64
            %22 = arith.mulf %21, %cst_0 : f64
            %23 = arith.subf %14, %22 : f64
            affine.store %23, %arg5[%arg9, %13] : memref<?x1200xf64>
          }
          affine.for %arg10 = #map12()[%1] to #map9()[%1] {
            %3 = affine.load %arg5[%arg9, %arg10] : memref<?x1200xf64>
            %4 = affine.load %arg3[%arg9, %arg10 + 1] : memref<?x1200xf64>
            %5 = affine.load %arg3[%arg9, %arg10] : memref<?x1200xf64>
            %6 = arith.subf %4, %5 : f64
            %7 = affine.load %arg4[%arg9 + 1, %arg10] : memref<?x1200xf64>
            %8 = arith.addf %6, %7 : f64
            %9 = affine.load %arg4[%arg9, %arg10] : memref<?x1200xf64>
            %10 = arith.subf %8, %9 : f64
            %11 = arith.mulf %10, %cst_0 : f64
            %12 = arith.subf %3, %11 : f64
            affine.store %12, %arg5[%arg9, %arg10] : memref<?x1200xf64>
          }
        }
      }
    }
    return
  }
}

