#map = affine_map<()[s0] -> (((s0 floordiv 2) floordiv 3) * 6)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0 + 4)>
#map4 = affine_map<()[s0] -> ((s0 floordiv 2) * 2)>
#map5 = affine_map<()[s0] -> ((s0 floordiv 2) * 2 + ((s0 mod 2) floordiv 3) * 3)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_gemver(%arg0: i32, %arg1: f64, %arg2: f64, %arg3: memref<?x2000xf64>, %arg4: memref<?xf64>, %arg5: memref<?xf64>, %arg6: memref<?xf64>, %arg7: memref<?xf64>, %arg8: memref<?xf64>, %arg9: memref<?xf64>, %arg10: memref<?xf64>, %arg11: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg0 : i32 to index
    affine.for %arg12 = 0 to %0 {
      affine.for %arg13 = 0 to #map()[%0] step 6 {
        %1 = affine.load %arg3[%arg12, %arg13] : memref<?x2000xf64>
        %2 = affine.load %arg4[%arg12] : memref<?xf64>
        %3 = affine.load %arg5[%arg13] : memref<?xf64>
        %4 = arith.mulf %2, %3 : f64
        %5 = arith.addf %1, %4 : f64
        %6 = affine.load %arg6[%arg12] : memref<?xf64>
        %7 = affine.load %arg7[%arg13] : memref<?xf64>
        %8 = arith.mulf %6, %7 : f64
        %9 = arith.addf %5, %8 : f64
        affine.store %9, %arg3[%arg12, %arg13] : memref<?x2000xf64>
        %10 = affine.apply #map1(%arg13)
        %11 = affine.load %arg3[%arg12, %10] : memref<?x2000xf64>
        %12 = affine.load %arg4[%arg12] : memref<?xf64>
        %13 = affine.load %arg5[%10] : memref<?xf64>
        %14 = arith.mulf %12, %13 : f64
        %15 = arith.addf %11, %14 : f64
        %16 = affine.load %arg6[%arg12] : memref<?xf64>
        %17 = affine.load %arg7[%10] : memref<?xf64>
        %18 = arith.mulf %16, %17 : f64
        %19 = arith.addf %15, %18 : f64
        affine.store %19, %arg3[%arg12, %10] : memref<?x2000xf64>
        %20 = affine.apply #map2(%arg13)
        %21 = affine.load %arg3[%arg12, %20] : memref<?x2000xf64>
        %22 = affine.load %arg4[%arg12] : memref<?xf64>
        %23 = affine.load %arg5[%20] : memref<?xf64>
        %24 = arith.mulf %22, %23 : f64
        %25 = arith.addf %21, %24 : f64
        %26 = affine.load %arg6[%arg12] : memref<?xf64>
        %27 = affine.load %arg7[%20] : memref<?xf64>
        %28 = arith.mulf %26, %27 : f64
        %29 = arith.addf %25, %28 : f64
        affine.store %29, %arg3[%arg12, %20] : memref<?x2000xf64>
        %30 = affine.apply #map1(%20)
        %31 = affine.load %arg3[%arg12, %30] : memref<?x2000xf64>
        %32 = affine.load %arg4[%arg12] : memref<?xf64>
        %33 = affine.load %arg5[%30] : memref<?xf64>
        %34 = arith.mulf %32, %33 : f64
        %35 = arith.addf %31, %34 : f64
        %36 = affine.load %arg6[%arg12] : memref<?xf64>
        %37 = affine.load %arg7[%30] : memref<?xf64>
        %38 = arith.mulf %36, %37 : f64
        %39 = arith.addf %35, %38 : f64
        affine.store %39, %arg3[%arg12, %30] : memref<?x2000xf64>
        %40 = affine.apply #map3(%arg13)
        %41 = affine.load %arg3[%arg12, %40] : memref<?x2000xf64>
        %42 = affine.load %arg4[%arg12] : memref<?xf64>
        %43 = affine.load %arg5[%40] : memref<?xf64>
        %44 = arith.mulf %42, %43 : f64
        %45 = arith.addf %41, %44 : f64
        %46 = affine.load %arg6[%arg12] : memref<?xf64>
        %47 = affine.load %arg7[%40] : memref<?xf64>
        %48 = arith.mulf %46, %47 : f64
        %49 = arith.addf %45, %48 : f64
        affine.store %49, %arg3[%arg12, %40] : memref<?x2000xf64>
        %50 = affine.apply #map1(%40)
        %51 = affine.load %arg3[%arg12, %50] : memref<?x2000xf64>
        %52 = affine.load %arg4[%arg12] : memref<?xf64>
        %53 = affine.load %arg5[%50] : memref<?xf64>
        %54 = arith.mulf %52, %53 : f64
        %55 = arith.addf %51, %54 : f64
        %56 = affine.load %arg6[%arg12] : memref<?xf64>
        %57 = affine.load %arg7[%50] : memref<?xf64>
        %58 = arith.mulf %56, %57 : f64
        %59 = arith.addf %55, %58 : f64
        affine.store %59, %arg3[%arg12, %50] : memref<?x2000xf64>
      }
      affine.for %arg13 = #map()[%0] to #map4()[%0] step 2 {
        %1 = affine.load %arg3[%arg12, %arg13] : memref<?x2000xf64>
        %2 = affine.load %arg4[%arg12] : memref<?xf64>
        %3 = affine.load %arg5[%arg13] : memref<?xf64>
        %4 = arith.mulf %2, %3 : f64
        %5 = arith.addf %1, %4 : f64
        %6 = affine.load %arg6[%arg12] : memref<?xf64>
        %7 = affine.load %arg7[%arg13] : memref<?xf64>
        %8 = arith.mulf %6, %7 : f64
        %9 = arith.addf %5, %8 : f64
        affine.store %9, %arg3[%arg12, %arg13] : memref<?x2000xf64>
        %10 = affine.apply #map1(%arg13)
        %11 = affine.load %arg3[%arg12, %10] : memref<?x2000xf64>
        %12 = affine.load %arg4[%arg12] : memref<?xf64>
        %13 = affine.load %arg5[%10] : memref<?xf64>
        %14 = arith.mulf %12, %13 : f64
        %15 = arith.addf %11, %14 : f64
        %16 = affine.load %arg6[%arg12] : memref<?xf64>
        %17 = affine.load %arg7[%10] : memref<?xf64>
        %18 = arith.mulf %16, %17 : f64
        %19 = arith.addf %15, %18 : f64
        affine.store %19, %arg3[%arg12, %10] : memref<?x2000xf64>
      }
      affine.for %arg13 = #map4()[%0] to #map5()[%0] step 3 {
        %1 = affine.load %arg3[%arg12, %arg13] : memref<?x2000xf64>
        %2 = affine.load %arg4[%arg12] : memref<?xf64>
        %3 = affine.load %arg5[%arg13] : memref<?xf64>
        %4 = arith.mulf %2, %3 : f64
        %5 = arith.addf %1, %4 : f64
        %6 = affine.load %arg6[%arg12] : memref<?xf64>
        %7 = affine.load %arg7[%arg13] : memref<?xf64>
        %8 = arith.mulf %6, %7 : f64
        %9 = arith.addf %5, %8 : f64
        affine.store %9, %arg3[%arg12, %arg13] : memref<?x2000xf64>
        %10 = affine.apply #map1(%arg13)
        %11 = affine.load %arg3[%arg12, %10] : memref<?x2000xf64>
        %12 = affine.load %arg4[%arg12] : memref<?xf64>
        %13 = affine.load %arg5[%10] : memref<?xf64>
        %14 = arith.mulf %12, %13 : f64
        %15 = arith.addf %11, %14 : f64
        %16 = affine.load %arg6[%arg12] : memref<?xf64>
        %17 = affine.load %arg7[%10] : memref<?xf64>
        %18 = arith.mulf %16, %17 : f64
        %19 = arith.addf %15, %18 : f64
        affine.store %19, %arg3[%arg12, %10] : memref<?x2000xf64>
        %20 = affine.apply #map2(%arg13)
        %21 = affine.load %arg3[%arg12, %20] : memref<?x2000xf64>
        %22 = affine.load %arg4[%arg12] : memref<?xf64>
        %23 = affine.load %arg5[%20] : memref<?xf64>
        %24 = arith.mulf %22, %23 : f64
        %25 = arith.addf %21, %24 : f64
        %26 = affine.load %arg6[%arg12] : memref<?xf64>
        %27 = affine.load %arg7[%20] : memref<?xf64>
        %28 = arith.mulf %26, %27 : f64
        %29 = arith.addf %25, %28 : f64
        affine.store %29, %arg3[%arg12, %20] : memref<?x2000xf64>
      }
      affine.for %arg13 = #map5()[%0] to %0 {
        %1 = affine.load %arg3[%arg12, %arg13] : memref<?x2000xf64>
        %2 = affine.load %arg4[%arg12] : memref<?xf64>
        %3 = affine.load %arg5[%arg13] : memref<?xf64>
        %4 = arith.mulf %2, %3 : f64
        %5 = arith.addf %1, %4 : f64
        %6 = affine.load %arg6[%arg12] : memref<?xf64>
        %7 = affine.load %arg7[%arg13] : memref<?xf64>
        %8 = arith.mulf %6, %7 : f64
        %9 = arith.addf %5, %8 : f64
        affine.store %9, %arg3[%arg12, %arg13] : memref<?x2000xf64>
      }
    }
    affine.for %arg12 = 0 to %0 {
      affine.for %arg13 = 0 to #map()[%0] step 6 {
        %1 = affine.load %arg9[%arg12] : memref<?xf64>
        %2 = affine.load %arg3[%arg13, %arg12] : memref<?x2000xf64>
        %3 = arith.mulf %arg2, %2 : f64
        %4 = affine.load %arg10[%arg13] : memref<?xf64>
        %5 = arith.mulf %3, %4 : f64
        %6 = arith.addf %1, %5 : f64
        affine.store %6, %arg9[%arg12] : memref<?xf64>
        %7 = affine.apply #map1(%arg13)
        %8 = affine.load %arg9[%arg12] : memref<?xf64>
        %9 = affine.load %arg3[%7, %arg12] : memref<?x2000xf64>
        %10 = arith.mulf %arg2, %9 : f64
        %11 = affine.load %arg10[%7] : memref<?xf64>
        %12 = arith.mulf %10, %11 : f64
        %13 = arith.addf %8, %12 : f64
        affine.store %13, %arg9[%arg12] : memref<?xf64>
        %14 = affine.apply #map2(%arg13)
        %15 = affine.load %arg9[%arg12] : memref<?xf64>
        %16 = affine.load %arg3[%14, %arg12] : memref<?x2000xf64>
        %17 = arith.mulf %arg2, %16 : f64
        %18 = affine.load %arg10[%14] : memref<?xf64>
        %19 = arith.mulf %17, %18 : f64
        %20 = arith.addf %15, %19 : f64
        affine.store %20, %arg9[%arg12] : memref<?xf64>
        %21 = affine.apply #map1(%14)
        %22 = affine.load %arg9[%arg12] : memref<?xf64>
        %23 = affine.load %arg3[%21, %arg12] : memref<?x2000xf64>
        %24 = arith.mulf %arg2, %23 : f64
        %25 = affine.load %arg10[%21] : memref<?xf64>
        %26 = arith.mulf %24, %25 : f64
        %27 = arith.addf %22, %26 : f64
        affine.store %27, %arg9[%arg12] : memref<?xf64>
        %28 = affine.apply #map3(%arg13)
        %29 = affine.load %arg9[%arg12] : memref<?xf64>
        %30 = affine.load %arg3[%28, %arg12] : memref<?x2000xf64>
        %31 = arith.mulf %arg2, %30 : f64
        %32 = affine.load %arg10[%28] : memref<?xf64>
        %33 = arith.mulf %31, %32 : f64
        %34 = arith.addf %29, %33 : f64
        affine.store %34, %arg9[%arg12] : memref<?xf64>
        %35 = affine.apply #map1(%28)
        %36 = affine.load %arg9[%arg12] : memref<?xf64>
        %37 = affine.load %arg3[%35, %arg12] : memref<?x2000xf64>
        %38 = arith.mulf %arg2, %37 : f64
        %39 = affine.load %arg10[%35] : memref<?xf64>
        %40 = arith.mulf %38, %39 : f64
        %41 = arith.addf %36, %40 : f64
        affine.store %41, %arg9[%arg12] : memref<?xf64>
      }
      affine.for %arg13 = #map()[%0] to #map4()[%0] step 2 {
        %1 = affine.load %arg9[%arg12] : memref<?xf64>
        %2 = affine.load %arg3[%arg13, %arg12] : memref<?x2000xf64>
        %3 = arith.mulf %arg2, %2 : f64
        %4 = affine.load %arg10[%arg13] : memref<?xf64>
        %5 = arith.mulf %3, %4 : f64
        %6 = arith.addf %1, %5 : f64
        affine.store %6, %arg9[%arg12] : memref<?xf64>
        %7 = affine.apply #map1(%arg13)
        %8 = affine.load %arg9[%arg12] : memref<?xf64>
        %9 = affine.load %arg3[%7, %arg12] : memref<?x2000xf64>
        %10 = arith.mulf %arg2, %9 : f64
        %11 = affine.load %arg10[%7] : memref<?xf64>
        %12 = arith.mulf %10, %11 : f64
        %13 = arith.addf %8, %12 : f64
        affine.store %13, %arg9[%arg12] : memref<?xf64>
      }
      affine.for %arg13 = #map4()[%0] to #map5()[%0] step 3 {
        %1 = affine.load %arg9[%arg12] : memref<?xf64>
        %2 = affine.load %arg3[%arg13, %arg12] : memref<?x2000xf64>
        %3 = arith.mulf %arg2, %2 : f64
        %4 = affine.load %arg10[%arg13] : memref<?xf64>
        %5 = arith.mulf %3, %4 : f64
        %6 = arith.addf %1, %5 : f64
        affine.store %6, %arg9[%arg12] : memref<?xf64>
        %7 = affine.apply #map1(%arg13)
        %8 = affine.load %arg9[%arg12] : memref<?xf64>
        %9 = affine.load %arg3[%7, %arg12] : memref<?x2000xf64>
        %10 = arith.mulf %arg2, %9 : f64
        %11 = affine.load %arg10[%7] : memref<?xf64>
        %12 = arith.mulf %10, %11 : f64
        %13 = arith.addf %8, %12 : f64
        affine.store %13, %arg9[%arg12] : memref<?xf64>
        %14 = affine.apply #map2(%arg13)
        %15 = affine.load %arg9[%arg12] : memref<?xf64>
        %16 = affine.load %arg3[%14, %arg12] : memref<?x2000xf64>
        %17 = arith.mulf %arg2, %16 : f64
        %18 = affine.load %arg10[%14] : memref<?xf64>
        %19 = arith.mulf %17, %18 : f64
        %20 = arith.addf %15, %19 : f64
        affine.store %20, %arg9[%arg12] : memref<?xf64>
      }
      affine.for %arg13 = #map5()[%0] to %0 {
        %1 = affine.load %arg9[%arg12] : memref<?xf64>
        %2 = affine.load %arg3[%arg13, %arg12] : memref<?x2000xf64>
        %3 = arith.mulf %arg2, %2 : f64
        %4 = affine.load %arg10[%arg13] : memref<?xf64>
        %5 = arith.mulf %3, %4 : f64
        %6 = arith.addf %1, %5 : f64
        affine.store %6, %arg9[%arg12] : memref<?xf64>
      }
    }
    affine.for %arg12 = 0 to #map()[%0] step 6 {
      %1 = affine.load %arg9[%arg12] : memref<?xf64>
      %2 = affine.load %arg11[%arg12] : memref<?xf64>
      %3 = arith.addf %1, %2 : f64
      affine.store %3, %arg9[%arg12] : memref<?xf64>
      %4 = affine.apply #map1(%arg12)
      %5 = affine.load %arg9[%4] : memref<?xf64>
      %6 = affine.load %arg11[%4] : memref<?xf64>
      %7 = arith.addf %5, %6 : f64
      affine.store %7, %arg9[%4] : memref<?xf64>
      %8 = affine.apply #map2(%arg12)
      %9 = affine.load %arg9[%8] : memref<?xf64>
      %10 = affine.load %arg11[%8] : memref<?xf64>
      %11 = arith.addf %9, %10 : f64
      affine.store %11, %arg9[%8] : memref<?xf64>
      %12 = affine.apply #map1(%8)
      %13 = affine.load %arg9[%12] : memref<?xf64>
      %14 = affine.load %arg11[%12] : memref<?xf64>
      %15 = arith.addf %13, %14 : f64
      affine.store %15, %arg9[%12] : memref<?xf64>
      %16 = affine.apply #map3(%arg12)
      %17 = affine.load %arg9[%16] : memref<?xf64>
      %18 = affine.load %arg11[%16] : memref<?xf64>
      %19 = arith.addf %17, %18 : f64
      affine.store %19, %arg9[%16] : memref<?xf64>
      %20 = affine.apply #map1(%16)
      %21 = affine.load %arg9[%20] : memref<?xf64>
      %22 = affine.load %arg11[%20] : memref<?xf64>
      %23 = arith.addf %21, %22 : f64
      affine.store %23, %arg9[%20] : memref<?xf64>
    }
    affine.for %arg12 = #map()[%0] to #map4()[%0] step 2 {
      %1 = affine.load %arg9[%arg12] : memref<?xf64>
      %2 = affine.load %arg11[%arg12] : memref<?xf64>
      %3 = arith.addf %1, %2 : f64
      affine.store %3, %arg9[%arg12] : memref<?xf64>
      %4 = affine.apply #map1(%arg12)
      %5 = affine.load %arg9[%4] : memref<?xf64>
      %6 = affine.load %arg11[%4] : memref<?xf64>
      %7 = arith.addf %5, %6 : f64
      affine.store %7, %arg9[%4] : memref<?xf64>
    }
    affine.for %arg12 = #map4()[%0] to #map5()[%0] step 3 {
      %1 = affine.load %arg9[%arg12] : memref<?xf64>
      %2 = affine.load %arg11[%arg12] : memref<?xf64>
      %3 = arith.addf %1, %2 : f64
      affine.store %3, %arg9[%arg12] : memref<?xf64>
      %4 = affine.apply #map1(%arg12)
      %5 = affine.load %arg9[%4] : memref<?xf64>
      %6 = affine.load %arg11[%4] : memref<?xf64>
      %7 = arith.addf %5, %6 : f64
      affine.store %7, %arg9[%4] : memref<?xf64>
      %8 = affine.apply #map2(%arg12)
      %9 = affine.load %arg9[%8] : memref<?xf64>
      %10 = affine.load %arg11[%8] : memref<?xf64>
      %11 = arith.addf %9, %10 : f64
      affine.store %11, %arg9[%8] : memref<?xf64>
    }
    affine.for %arg12 = #map5()[%0] to %0 {
      %1 = affine.load %arg9[%arg12] : memref<?xf64>
      %2 = affine.load %arg11[%arg12] : memref<?xf64>
      %3 = arith.addf %1, %2 : f64
      affine.store %3, %arg9[%arg12] : memref<?xf64>
    }
    affine.for %arg12 = 0 to %0 {
      affine.for %arg13 = 0 to #map()[%0] step 6 {
        %1 = affine.load %arg8[%arg12] : memref<?xf64>
        %2 = affine.load %arg3[%arg12, %arg13] : memref<?x2000xf64>
        %3 = arith.mulf %arg1, %2 : f64
        %4 = affine.load %arg9[%arg13] : memref<?xf64>
        %5 = arith.mulf %3, %4 : f64
        %6 = arith.addf %1, %5 : f64
        affine.store %6, %arg8[%arg12] : memref<?xf64>
        %7 = affine.apply #map1(%arg13)
        %8 = affine.load %arg8[%arg12] : memref<?xf64>
        %9 = affine.load %arg3[%arg12, %7] : memref<?x2000xf64>
        %10 = arith.mulf %arg1, %9 : f64
        %11 = affine.load %arg9[%7] : memref<?xf64>
        %12 = arith.mulf %10, %11 : f64
        %13 = arith.addf %8, %12 : f64
        affine.store %13, %arg8[%arg12] : memref<?xf64>
        %14 = affine.apply #map2(%arg13)
        %15 = affine.load %arg8[%arg12] : memref<?xf64>
        %16 = affine.load %arg3[%arg12, %14] : memref<?x2000xf64>
        %17 = arith.mulf %arg1, %16 : f64
        %18 = affine.load %arg9[%14] : memref<?xf64>
        %19 = arith.mulf %17, %18 : f64
        %20 = arith.addf %15, %19 : f64
        affine.store %20, %arg8[%arg12] : memref<?xf64>
        %21 = affine.apply #map1(%14)
        %22 = affine.load %arg8[%arg12] : memref<?xf64>
        %23 = affine.load %arg3[%arg12, %21] : memref<?x2000xf64>
        %24 = arith.mulf %arg1, %23 : f64
        %25 = affine.load %arg9[%21] : memref<?xf64>
        %26 = arith.mulf %24, %25 : f64
        %27 = arith.addf %22, %26 : f64
        affine.store %27, %arg8[%arg12] : memref<?xf64>
        %28 = affine.apply #map3(%arg13)
        %29 = affine.load %arg8[%arg12] : memref<?xf64>
        %30 = affine.load %arg3[%arg12, %28] : memref<?x2000xf64>
        %31 = arith.mulf %arg1, %30 : f64
        %32 = affine.load %arg9[%28] : memref<?xf64>
        %33 = arith.mulf %31, %32 : f64
        %34 = arith.addf %29, %33 : f64
        affine.store %34, %arg8[%arg12] : memref<?xf64>
        %35 = affine.apply #map1(%28)
        %36 = affine.load %arg8[%arg12] : memref<?xf64>
        %37 = affine.load %arg3[%arg12, %35] : memref<?x2000xf64>
        %38 = arith.mulf %arg1, %37 : f64
        %39 = affine.load %arg9[%35] : memref<?xf64>
        %40 = arith.mulf %38, %39 : f64
        %41 = arith.addf %36, %40 : f64
        affine.store %41, %arg8[%arg12] : memref<?xf64>
      }
      affine.for %arg13 = #map()[%0] to #map4()[%0] step 2 {
        %1 = affine.load %arg8[%arg12] : memref<?xf64>
        %2 = affine.load %arg3[%arg12, %arg13] : memref<?x2000xf64>
        %3 = arith.mulf %arg1, %2 : f64
        %4 = affine.load %arg9[%arg13] : memref<?xf64>
        %5 = arith.mulf %3, %4 : f64
        %6 = arith.addf %1, %5 : f64
        affine.store %6, %arg8[%arg12] : memref<?xf64>
        %7 = affine.apply #map1(%arg13)
        %8 = affine.load %arg8[%arg12] : memref<?xf64>
        %9 = affine.load %arg3[%arg12, %7] : memref<?x2000xf64>
        %10 = arith.mulf %arg1, %9 : f64
        %11 = affine.load %arg9[%7] : memref<?xf64>
        %12 = arith.mulf %10, %11 : f64
        %13 = arith.addf %8, %12 : f64
        affine.store %13, %arg8[%arg12] : memref<?xf64>
      }
      affine.for %arg13 = #map4()[%0] to #map5()[%0] step 3 {
        %1 = affine.load %arg8[%arg12] : memref<?xf64>
        %2 = affine.load %arg3[%arg12, %arg13] : memref<?x2000xf64>
        %3 = arith.mulf %arg1, %2 : f64
        %4 = affine.load %arg9[%arg13] : memref<?xf64>
        %5 = arith.mulf %3, %4 : f64
        %6 = arith.addf %1, %5 : f64
        affine.store %6, %arg8[%arg12] : memref<?xf64>
        %7 = affine.apply #map1(%arg13)
        %8 = affine.load %arg8[%arg12] : memref<?xf64>
        %9 = affine.load %arg3[%arg12, %7] : memref<?x2000xf64>
        %10 = arith.mulf %arg1, %9 : f64
        %11 = affine.load %arg9[%7] : memref<?xf64>
        %12 = arith.mulf %10, %11 : f64
        %13 = arith.addf %8, %12 : f64
        affine.store %13, %arg8[%arg12] : memref<?xf64>
        %14 = affine.apply #map2(%arg13)
        %15 = affine.load %arg8[%arg12] : memref<?xf64>
        %16 = affine.load %arg3[%arg12, %14] : memref<?x2000xf64>
        %17 = arith.mulf %arg1, %16 : f64
        %18 = affine.load %arg9[%14] : memref<?xf64>
        %19 = arith.mulf %17, %18 : f64
        %20 = arith.addf %15, %19 : f64
        affine.store %20, %arg8[%arg12] : memref<?xf64>
      }
      affine.for %arg13 = #map5()[%0] to %0 {
        %1 = affine.load %arg8[%arg12] : memref<?xf64>
        %2 = affine.load %arg3[%arg12, %arg13] : memref<?x2000xf64>
        %3 = arith.mulf %arg1, %2 : f64
        %4 = affine.load %arg9[%arg13] : memref<?xf64>
        %5 = arith.mulf %3, %4 : f64
        %6 = arith.addf %1, %5 : f64
        affine.store %6, %arg8[%arg12] : memref<?xf64>
      }
    }
    return
  }
}

