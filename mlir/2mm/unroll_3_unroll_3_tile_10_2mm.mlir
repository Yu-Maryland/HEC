#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 10, s0)>
#map2 = affine_map<()[s0] -> (((s0 floordiv 3) floordiv 3) * 9)>
#map3 = affine_map<(d0) -> (d0 + 1)>
#map4 = affine_map<(d0) -> (d0 + 2)>
#map5 = affine_map<(d0) -> (d0 + 3)>
#map6 = affine_map<(d0) -> (d0 + 6)>
#map7 = affine_map<()[s0] -> ((s0 floordiv 3) * 3)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>, #dlti.dl_entry<"dlti.endianness", "little">>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_2mm(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: f64, %arg5: f64, %arg6: memref<?x900xf64>, %arg7: memref<?x1100xf64>, %arg8: memref<?x900xf64>, %arg9: memref<?x1200xf64>, %arg10: memref<?x1200xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 0.000000e+00 : f64
    %0 = arith.index_cast %arg2 : i32 to index
    %1 = arith.index_cast %arg3 : i32 to index
    %2 = arith.index_cast %arg1 : i32 to index
    %3 = arith.index_cast %arg0 : i32 to index
    affine.for %arg11 = 0 to %3 step 10 {
      affine.for %arg12 = 0 to %2 step 10 {
        affine.for %arg13 = #map(%arg11) to min #map1(%arg11)[%3] {
          affine.for %arg14 = #map(%arg12) to min #map1(%arg12)[%2] {
            affine.store %cst, %arg6[%arg13, %arg14] : memref<?x900xf64>
            affine.for %arg15 = 0 to #map2()[%0] step 9 {
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
              %31 = affine.apply #map3(%24)
              %32 = affine.load %arg7[%arg13, %31] : memref<?x1100xf64>
              %33 = arith.mulf %arg4, %32 : f64
              %34 = affine.load %arg8[%31, %arg14] : memref<?x900xf64>
              %35 = arith.mulf %33, %34 : f64
              %36 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %37 = arith.addf %36, %35 : f64
              affine.store %37, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %38 = affine.apply #map4(%24)
              %39 = affine.load %arg7[%arg13, %38] : memref<?x1100xf64>
              %40 = arith.mulf %arg4, %39 : f64
              %41 = affine.load %arg8[%38, %arg14] : memref<?x900xf64>
              %42 = arith.mulf %40, %41 : f64
              %43 = affine.load %arg6[%arg13, %arg14] : memref<?x900xf64>
              %44 = arith.addf %43, %42 : f64
              affine.store %44, %arg6[%arg13, %arg14] : memref<?x900xf64>
              %45 = affine.apply #map6(%arg15)
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
            }
            affine.for %arg15 = #map2()[%0] to #map7()[%0] step 3 {
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
            affine.for %arg15 = #map7()[%0] to #map7()[%0] step 3 {
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
            affine.for %arg15 = #map7()[%0] to %0 {
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
    affine.for %arg11 = 0 to %3 step 10 {
      affine.for %arg12 = 0 to %1 step 10 {
        affine.for %arg13 = #map(%arg11) to min #map1(%arg11)[%3] {
          affine.for %arg14 = #map(%arg12) to min #map1(%arg12)[%1] {
            %4 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
            %5 = arith.mulf %4, %arg5 : f64
            affine.store %5, %arg10[%arg13, %arg14] : memref<?x1200xf64>
            affine.for %arg15 = 0 to #map2()[%2] step 9 {
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
              %29 = affine.apply #map3(%23)
              %30 = affine.load %arg6[%arg13, %29] : memref<?x900xf64>
              %31 = affine.load %arg9[%29, %arg14] : memref<?x1200xf64>
              %32 = arith.mulf %30, %31 : f64
              %33 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %34 = arith.addf %33, %32 : f64
              affine.store %34, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %35 = affine.apply #map4(%23)
              %36 = affine.load %arg6[%arg13, %35] : memref<?x900xf64>
              %37 = affine.load %arg9[%35, %arg14] : memref<?x1200xf64>
              %38 = arith.mulf %36, %37 : f64
              %39 = affine.load %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %40 = arith.addf %39, %38 : f64
              affine.store %40, %arg10[%arg13, %arg14] : memref<?x1200xf64>
              %41 = affine.apply #map6(%arg15)
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
            }
            affine.for %arg15 = #map2()[%2] to #map7()[%2] step 3 {
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
            affine.for %arg15 = #map7()[%2] to #map7()[%2] step 3 {
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
            affine.for %arg15 = #map7()[%2] to %2 {
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

