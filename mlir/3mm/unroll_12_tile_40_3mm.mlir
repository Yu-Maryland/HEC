#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 40, s0)>
#map2 = affine_map<()[s0] -> ((s0 floordiv 12) * 12)>
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
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_3mm(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: memref<?x900xf64>, %arg6: memref<?x1000xf64>, %arg7: memref<?x900xf64>, %arg8: memref<?x1100xf64>, %arg9: memref<?x1200xf64>, %arg10: memref<?x1100xf64>, %arg11: memref<?x1100xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 0.000000e+00 : f64
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg2 : i32 to index
    %2 = arith.index_cast %arg4 : i32 to index
    %3 = arith.index_cast %arg3 : i32 to index
    %4 = arith.index_cast %arg0 : i32 to index
    affine.for %arg12 = 0 to %4 step 40 {
      affine.for %arg13 = 0 to %0 step 40 {
        affine.for %arg14 = #map(%arg12) to min #map1(%arg12)[%4] {
          affine.for %arg15 = #map(%arg13) to min #map1(%arg13)[%0] {
            affine.store %cst, %arg5[%arg14, %arg15] : memref<?x900xf64>
            affine.for %arg16 = 0 to #map2()[%1] step 12 {
              %5 = affine.load %arg6[%arg14, %arg16] : memref<?x1000xf64>
              %6 = affine.load %arg7[%arg16, %arg15] : memref<?x900xf64>
              %7 = arith.mulf %5, %6 : f64
              %8 = affine.load %arg5[%arg14, %arg15] : memref<?x900xf64>
              %9 = arith.addf %8, %7 : f64
              affine.store %9, %arg5[%arg14, %arg15] : memref<?x900xf64>
              %10 = affine.apply #map3(%arg16)
              %11 = affine.load %arg6[%arg14, %10] : memref<?x1000xf64>
              %12 = affine.load %arg7[%10, %arg15] : memref<?x900xf64>
              %13 = arith.mulf %11, %12 : f64
              %14 = affine.load %arg5[%arg14, %arg15] : memref<?x900xf64>
              %15 = arith.addf %14, %13 : f64
              affine.store %15, %arg5[%arg14, %arg15] : memref<?x900xf64>
              %16 = affine.apply #map4(%arg16)
              %17 = affine.load %arg6[%arg14, %16] : memref<?x1000xf64>
              %18 = affine.load %arg7[%16, %arg15] : memref<?x900xf64>
              %19 = arith.mulf %17, %18 : f64
              %20 = affine.load %arg5[%arg14, %arg15] : memref<?x900xf64>
              %21 = arith.addf %20, %19 : f64
              affine.store %21, %arg5[%arg14, %arg15] : memref<?x900xf64>
              %22 = affine.apply #map5(%arg16)
              %23 = affine.load %arg6[%arg14, %22] : memref<?x1000xf64>
              %24 = affine.load %arg7[%22, %arg15] : memref<?x900xf64>
              %25 = arith.mulf %23, %24 : f64
              %26 = affine.load %arg5[%arg14, %arg15] : memref<?x900xf64>
              %27 = arith.addf %26, %25 : f64
              affine.store %27, %arg5[%arg14, %arg15] : memref<?x900xf64>
              %28 = affine.apply #map6(%arg16)
              %29 = affine.load %arg6[%arg14, %28] : memref<?x1000xf64>
              %30 = affine.load %arg7[%28, %arg15] : memref<?x900xf64>
              %31 = arith.mulf %29, %30 : f64
              %32 = affine.load %arg5[%arg14, %arg15] : memref<?x900xf64>
              %33 = arith.addf %32, %31 : f64
              affine.store %33, %arg5[%arg14, %arg15] : memref<?x900xf64>
              %34 = affine.apply #map7(%arg16)
              %35 = affine.load %arg6[%arg14, %34] : memref<?x1000xf64>
              %36 = affine.load %arg7[%34, %arg15] : memref<?x900xf64>
              %37 = arith.mulf %35, %36 : f64
              %38 = affine.load %arg5[%arg14, %arg15] : memref<?x900xf64>
              %39 = arith.addf %38, %37 : f64
              affine.store %39, %arg5[%arg14, %arg15] : memref<?x900xf64>
              %40 = affine.apply #map8(%arg16)
              %41 = affine.load %arg6[%arg14, %40] : memref<?x1000xf64>
              %42 = affine.load %arg7[%40, %arg15] : memref<?x900xf64>
              %43 = arith.mulf %41, %42 : f64
              %44 = affine.load %arg5[%arg14, %arg15] : memref<?x900xf64>
              %45 = arith.addf %44, %43 : f64
              affine.store %45, %arg5[%arg14, %arg15] : memref<?x900xf64>
              %46 = affine.apply #map9(%arg16)
              %47 = affine.load %arg6[%arg14, %46] : memref<?x1000xf64>
              %48 = affine.load %arg7[%46, %arg15] : memref<?x900xf64>
              %49 = arith.mulf %47, %48 : f64
              %50 = affine.load %arg5[%arg14, %arg15] : memref<?x900xf64>
              %51 = arith.addf %50, %49 : f64
              affine.store %51, %arg5[%arg14, %arg15] : memref<?x900xf64>
              %52 = affine.apply #map10(%arg16)
              %53 = affine.load %arg6[%arg14, %52] : memref<?x1000xf64>
              %54 = affine.load %arg7[%52, %arg15] : memref<?x900xf64>
              %55 = arith.mulf %53, %54 : f64
              %56 = affine.load %arg5[%arg14, %arg15] : memref<?x900xf64>
              %57 = arith.addf %56, %55 : f64
              affine.store %57, %arg5[%arg14, %arg15] : memref<?x900xf64>
              %58 = affine.apply #map11(%arg16)
              %59 = affine.load %arg6[%arg14, %58] : memref<?x1000xf64>
              %60 = affine.load %arg7[%58, %arg15] : memref<?x900xf64>
              %61 = arith.mulf %59, %60 : f64
              %62 = affine.load %arg5[%arg14, %arg15] : memref<?x900xf64>
              %63 = arith.addf %62, %61 : f64
              affine.store %63, %arg5[%arg14, %arg15] : memref<?x900xf64>
              %64 = affine.apply #map12(%arg16)
              %65 = affine.load %arg6[%arg14, %64] : memref<?x1000xf64>
              %66 = affine.load %arg7[%64, %arg15] : memref<?x900xf64>
              %67 = arith.mulf %65, %66 : f64
              %68 = affine.load %arg5[%arg14, %arg15] : memref<?x900xf64>
              %69 = arith.addf %68, %67 : f64
              affine.store %69, %arg5[%arg14, %arg15] : memref<?x900xf64>
              %70 = affine.apply #map13(%arg16)
              %71 = affine.load %arg6[%arg14, %70] : memref<?x1000xf64>
              %72 = affine.load %arg7[%70, %arg15] : memref<?x900xf64>
              %73 = arith.mulf %71, %72 : f64
              %74 = affine.load %arg5[%arg14, %arg15] : memref<?x900xf64>
              %75 = arith.addf %74, %73 : f64
              affine.store %75, %arg5[%arg14, %arg15] : memref<?x900xf64>
            }
            affine.for %arg16 = #map2()[%1] to %1 {
              %5 = affine.load %arg6[%arg14, %arg16] : memref<?x1000xf64>
              %6 = affine.load %arg7[%arg16, %arg15] : memref<?x900xf64>
              %7 = arith.mulf %5, %6 : f64
              %8 = affine.load %arg5[%arg14, %arg15] : memref<?x900xf64>
              %9 = arith.addf %8, %7 : f64
              affine.store %9, %arg5[%arg14, %arg15] : memref<?x900xf64>
            }
          }
        }
      }
    }
    affine.for %arg12 = 0 to %0 step 40 {
      affine.for %arg13 = 0 to %3 step 40 {
        affine.for %arg14 = #map(%arg12) to min #map1(%arg12)[%0] {
          affine.for %arg15 = #map(%arg13) to min #map1(%arg13)[%3] {
            affine.store %cst, %arg8[%arg14, %arg15] : memref<?x1100xf64>
            affine.for %arg16 = 0 to #map2()[%2] step 12 {
              %5 = affine.load %arg9[%arg14, %arg16] : memref<?x1200xf64>
              %6 = affine.load %arg10[%arg16, %arg15] : memref<?x1100xf64>
              %7 = arith.mulf %5, %6 : f64
              %8 = affine.load %arg8[%arg14, %arg15] : memref<?x1100xf64>
              %9 = arith.addf %8, %7 : f64
              affine.store %9, %arg8[%arg14, %arg15] : memref<?x1100xf64>
              %10 = affine.apply #map3(%arg16)
              %11 = affine.load %arg9[%arg14, %10] : memref<?x1200xf64>
              %12 = affine.load %arg10[%10, %arg15] : memref<?x1100xf64>
              %13 = arith.mulf %11, %12 : f64
              %14 = affine.load %arg8[%arg14, %arg15] : memref<?x1100xf64>
              %15 = arith.addf %14, %13 : f64
              affine.store %15, %arg8[%arg14, %arg15] : memref<?x1100xf64>
              %16 = affine.apply #map4(%arg16)
              %17 = affine.load %arg9[%arg14, %16] : memref<?x1200xf64>
              %18 = affine.load %arg10[%16, %arg15] : memref<?x1100xf64>
              %19 = arith.mulf %17, %18 : f64
              %20 = affine.load %arg8[%arg14, %arg15] : memref<?x1100xf64>
              %21 = arith.addf %20, %19 : f64
              affine.store %21, %arg8[%arg14, %arg15] : memref<?x1100xf64>
              %22 = affine.apply #map5(%arg16)
              %23 = affine.load %arg9[%arg14, %22] : memref<?x1200xf64>
              %24 = affine.load %arg10[%22, %arg15] : memref<?x1100xf64>
              %25 = arith.mulf %23, %24 : f64
              %26 = affine.load %arg8[%arg14, %arg15] : memref<?x1100xf64>
              %27 = arith.addf %26, %25 : f64
              affine.store %27, %arg8[%arg14, %arg15] : memref<?x1100xf64>
              %28 = affine.apply #map6(%arg16)
              %29 = affine.load %arg9[%arg14, %28] : memref<?x1200xf64>
              %30 = affine.load %arg10[%28, %arg15] : memref<?x1100xf64>
              %31 = arith.mulf %29, %30 : f64
              %32 = affine.load %arg8[%arg14, %arg15] : memref<?x1100xf64>
              %33 = arith.addf %32, %31 : f64
              affine.store %33, %arg8[%arg14, %arg15] : memref<?x1100xf64>
              %34 = affine.apply #map7(%arg16)
              %35 = affine.load %arg9[%arg14, %34] : memref<?x1200xf64>
              %36 = affine.load %arg10[%34, %arg15] : memref<?x1100xf64>
              %37 = arith.mulf %35, %36 : f64
              %38 = affine.load %arg8[%arg14, %arg15] : memref<?x1100xf64>
              %39 = arith.addf %38, %37 : f64
              affine.store %39, %arg8[%arg14, %arg15] : memref<?x1100xf64>
              %40 = affine.apply #map8(%arg16)
              %41 = affine.load %arg9[%arg14, %40] : memref<?x1200xf64>
              %42 = affine.load %arg10[%40, %arg15] : memref<?x1100xf64>
              %43 = arith.mulf %41, %42 : f64
              %44 = affine.load %arg8[%arg14, %arg15] : memref<?x1100xf64>
              %45 = arith.addf %44, %43 : f64
              affine.store %45, %arg8[%arg14, %arg15] : memref<?x1100xf64>
              %46 = affine.apply #map9(%arg16)
              %47 = affine.load %arg9[%arg14, %46] : memref<?x1200xf64>
              %48 = affine.load %arg10[%46, %arg15] : memref<?x1100xf64>
              %49 = arith.mulf %47, %48 : f64
              %50 = affine.load %arg8[%arg14, %arg15] : memref<?x1100xf64>
              %51 = arith.addf %50, %49 : f64
              affine.store %51, %arg8[%arg14, %arg15] : memref<?x1100xf64>
              %52 = affine.apply #map10(%arg16)
              %53 = affine.load %arg9[%arg14, %52] : memref<?x1200xf64>
              %54 = affine.load %arg10[%52, %arg15] : memref<?x1100xf64>
              %55 = arith.mulf %53, %54 : f64
              %56 = affine.load %arg8[%arg14, %arg15] : memref<?x1100xf64>
              %57 = arith.addf %56, %55 : f64
              affine.store %57, %arg8[%arg14, %arg15] : memref<?x1100xf64>
              %58 = affine.apply #map11(%arg16)
              %59 = affine.load %arg9[%arg14, %58] : memref<?x1200xf64>
              %60 = affine.load %arg10[%58, %arg15] : memref<?x1100xf64>
              %61 = arith.mulf %59, %60 : f64
              %62 = affine.load %arg8[%arg14, %arg15] : memref<?x1100xf64>
              %63 = arith.addf %62, %61 : f64
              affine.store %63, %arg8[%arg14, %arg15] : memref<?x1100xf64>
              %64 = affine.apply #map12(%arg16)
              %65 = affine.load %arg9[%arg14, %64] : memref<?x1200xf64>
              %66 = affine.load %arg10[%64, %arg15] : memref<?x1100xf64>
              %67 = arith.mulf %65, %66 : f64
              %68 = affine.load %arg8[%arg14, %arg15] : memref<?x1100xf64>
              %69 = arith.addf %68, %67 : f64
              affine.store %69, %arg8[%arg14, %arg15] : memref<?x1100xf64>
              %70 = affine.apply #map13(%arg16)
              %71 = affine.load %arg9[%arg14, %70] : memref<?x1200xf64>
              %72 = affine.load %arg10[%70, %arg15] : memref<?x1100xf64>
              %73 = arith.mulf %71, %72 : f64
              %74 = affine.load %arg8[%arg14, %arg15] : memref<?x1100xf64>
              %75 = arith.addf %74, %73 : f64
              affine.store %75, %arg8[%arg14, %arg15] : memref<?x1100xf64>
            }
            affine.for %arg16 = #map2()[%2] to %2 {
              %5 = affine.load %arg9[%arg14, %arg16] : memref<?x1200xf64>
              %6 = affine.load %arg10[%arg16, %arg15] : memref<?x1100xf64>
              %7 = arith.mulf %5, %6 : f64
              %8 = affine.load %arg8[%arg14, %arg15] : memref<?x1100xf64>
              %9 = arith.addf %8, %7 : f64
              affine.store %9, %arg8[%arg14, %arg15] : memref<?x1100xf64>
            }
          }
        }
      }
    }
    affine.for %arg12 = 0 to %4 step 40 {
      affine.for %arg13 = 0 to %3 step 40 {
        affine.for %arg14 = #map(%arg12) to min #map1(%arg12)[%4] {
          affine.for %arg15 = #map(%arg13) to min #map1(%arg13)[%3] {
            affine.store %cst, %arg11[%arg14, %arg15] : memref<?x1100xf64>
            affine.for %arg16 = 0 to #map2()[%0] step 12 {
              %5 = affine.load %arg5[%arg14, %arg16] : memref<?x900xf64>
              %6 = affine.load %arg8[%arg16, %arg15] : memref<?x1100xf64>
              %7 = arith.mulf %5, %6 : f64
              %8 = affine.load %arg11[%arg14, %arg15] : memref<?x1100xf64>
              %9 = arith.addf %8, %7 : f64
              affine.store %9, %arg11[%arg14, %arg15] : memref<?x1100xf64>
              %10 = affine.apply #map3(%arg16)
              %11 = affine.load %arg5[%arg14, %10] : memref<?x900xf64>
              %12 = affine.load %arg8[%10, %arg15] : memref<?x1100xf64>
              %13 = arith.mulf %11, %12 : f64
              %14 = affine.load %arg11[%arg14, %arg15] : memref<?x1100xf64>
              %15 = arith.addf %14, %13 : f64
              affine.store %15, %arg11[%arg14, %arg15] : memref<?x1100xf64>
              %16 = affine.apply #map4(%arg16)
              %17 = affine.load %arg5[%arg14, %16] : memref<?x900xf64>
              %18 = affine.load %arg8[%16, %arg15] : memref<?x1100xf64>
              %19 = arith.mulf %17, %18 : f64
              %20 = affine.load %arg11[%arg14, %arg15] : memref<?x1100xf64>
              %21 = arith.addf %20, %19 : f64
              affine.store %21, %arg11[%arg14, %arg15] : memref<?x1100xf64>
              %22 = affine.apply #map5(%arg16)
              %23 = affine.load %arg5[%arg14, %22] : memref<?x900xf64>
              %24 = affine.load %arg8[%22, %arg15] : memref<?x1100xf64>
              %25 = arith.mulf %23, %24 : f64
              %26 = affine.load %arg11[%arg14, %arg15] : memref<?x1100xf64>
              %27 = arith.addf %26, %25 : f64
              affine.store %27, %arg11[%arg14, %arg15] : memref<?x1100xf64>
              %28 = affine.apply #map6(%arg16)
              %29 = affine.load %arg5[%arg14, %28] : memref<?x900xf64>
              %30 = affine.load %arg8[%28, %arg15] : memref<?x1100xf64>
              %31 = arith.mulf %29, %30 : f64
              %32 = affine.load %arg11[%arg14, %arg15] : memref<?x1100xf64>
              %33 = arith.addf %32, %31 : f64
              affine.store %33, %arg11[%arg14, %arg15] : memref<?x1100xf64>
              %34 = affine.apply #map7(%arg16)
              %35 = affine.load %arg5[%arg14, %34] : memref<?x900xf64>
              %36 = affine.load %arg8[%34, %arg15] : memref<?x1100xf64>
              %37 = arith.mulf %35, %36 : f64
              %38 = affine.load %arg11[%arg14, %arg15] : memref<?x1100xf64>
              %39 = arith.addf %38, %37 : f64
              affine.store %39, %arg11[%arg14, %arg15] : memref<?x1100xf64>
              %40 = affine.apply #map8(%arg16)
              %41 = affine.load %arg5[%arg14, %40] : memref<?x900xf64>
              %42 = affine.load %arg8[%40, %arg15] : memref<?x1100xf64>
              %43 = arith.mulf %41, %42 : f64
              %44 = affine.load %arg11[%arg14, %arg15] : memref<?x1100xf64>
              %45 = arith.addf %44, %43 : f64
              affine.store %45, %arg11[%arg14, %arg15] : memref<?x1100xf64>
              %46 = affine.apply #map9(%arg16)
              %47 = affine.load %arg5[%arg14, %46] : memref<?x900xf64>
              %48 = affine.load %arg8[%46, %arg15] : memref<?x1100xf64>
              %49 = arith.mulf %47, %48 : f64
              %50 = affine.load %arg11[%arg14, %arg15] : memref<?x1100xf64>
              %51 = arith.addf %50, %49 : f64
              affine.store %51, %arg11[%arg14, %arg15] : memref<?x1100xf64>
              %52 = affine.apply #map10(%arg16)
              %53 = affine.load %arg5[%arg14, %52] : memref<?x900xf64>
              %54 = affine.load %arg8[%52, %arg15] : memref<?x1100xf64>
              %55 = arith.mulf %53, %54 : f64
              %56 = affine.load %arg11[%arg14, %arg15] : memref<?x1100xf64>
              %57 = arith.addf %56, %55 : f64
              affine.store %57, %arg11[%arg14, %arg15] : memref<?x1100xf64>
              %58 = affine.apply #map11(%arg16)
              %59 = affine.load %arg5[%arg14, %58] : memref<?x900xf64>
              %60 = affine.load %arg8[%58, %arg15] : memref<?x1100xf64>
              %61 = arith.mulf %59, %60 : f64
              %62 = affine.load %arg11[%arg14, %arg15] : memref<?x1100xf64>
              %63 = arith.addf %62, %61 : f64
              affine.store %63, %arg11[%arg14, %arg15] : memref<?x1100xf64>
              %64 = affine.apply #map12(%arg16)
              %65 = affine.load %arg5[%arg14, %64] : memref<?x900xf64>
              %66 = affine.load %arg8[%64, %arg15] : memref<?x1100xf64>
              %67 = arith.mulf %65, %66 : f64
              %68 = affine.load %arg11[%arg14, %arg15] : memref<?x1100xf64>
              %69 = arith.addf %68, %67 : f64
              affine.store %69, %arg11[%arg14, %arg15] : memref<?x1100xf64>
              %70 = affine.apply #map13(%arg16)
              %71 = affine.load %arg5[%arg14, %70] : memref<?x900xf64>
              %72 = affine.load %arg8[%70, %arg15] : memref<?x1100xf64>
              %73 = arith.mulf %71, %72 : f64
              %74 = affine.load %arg11[%arg14, %arg15] : memref<?x1100xf64>
              %75 = arith.addf %74, %73 : f64
              affine.store %75, %arg11[%arg14, %arg15] : memref<?x1100xf64>
            }
            affine.for %arg16 = #map2()[%0] to %0 {
              %5 = affine.load %arg5[%arg14, %arg16] : memref<?x900xf64>
              %6 = affine.load %arg8[%arg16, %arg15] : memref<?x1100xf64>
              %7 = arith.mulf %5, %6 : f64
              %8 = affine.load %arg11[%arg14, %arg15] : memref<?x1100xf64>
              %9 = arith.addf %8, %7 : f64
              affine.store %9, %arg11[%arg14, %arg15] : memref<?x1100xf64>
            }
          }
        }
      }
    }
    return
  }
}

