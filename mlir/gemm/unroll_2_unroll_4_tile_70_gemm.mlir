#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 70, s0)>
#map2 = affine_map<()[s0] -> (((s0 floordiv 4) floordiv 2) * 8)>
#map3 = affine_map<(d0) -> (d0 + 1)>
#map4 = affine_map<(d0) -> (d0 + 2)>
#map5 = affine_map<(d0) -> (d0 + 3)>
#map6 = affine_map<(d0) -> (d0 + 4)>
#map7 = affine_map<()[s0] -> ((s0 floordiv 4) * 4)>
#map8 = affine_map<()[s0] -> ((s0 floordiv 2) * 2)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_gemm(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: f64, %arg4: f64, %arg5: memref<?x1100xf64>, %arg6: memref<?x1200xf64>, %arg7: memref<?x1100xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg2 : i32 to index
    %2 = arith.index_cast %arg0 : i32 to index
    affine.for %arg8 = 0 to %2 step 70 {
      affine.for %arg9 = #map(%arg8) to min #map1(%arg8)[%2] {
        affine.for %arg10 = 0 to #map2()[%0] step 8 {
          %3 = affine.load %arg5[%arg9, %arg10] : memref<?x1100xf64>
          %4 = arith.mulf %3, %arg4 : f64
          affine.store %4, %arg5[%arg9, %arg10] : memref<?x1100xf64>
          %5 = affine.apply #map3(%arg10)
          %6 = affine.load %arg5[%arg9, %5] : memref<?x1100xf64>
          %7 = arith.mulf %6, %arg4 : f64
          affine.store %7, %arg5[%arg9, %5] : memref<?x1100xf64>
          %8 = affine.apply #map4(%arg10)
          %9 = affine.load %arg5[%arg9, %8] : memref<?x1100xf64>
          %10 = arith.mulf %9, %arg4 : f64
          affine.store %10, %arg5[%arg9, %8] : memref<?x1100xf64>
          %11 = affine.apply #map5(%arg10)
          %12 = affine.load %arg5[%arg9, %11] : memref<?x1100xf64>
          %13 = arith.mulf %12, %arg4 : f64
          affine.store %13, %arg5[%arg9, %11] : memref<?x1100xf64>
          %14 = affine.apply #map6(%arg10)
          %15 = affine.load %arg5[%arg9, %14] : memref<?x1100xf64>
          %16 = arith.mulf %15, %arg4 : f64
          affine.store %16, %arg5[%arg9, %14] : memref<?x1100xf64>
          %17 = affine.apply #map3(%14)
          %18 = affine.load %arg5[%arg9, %17] : memref<?x1100xf64>
          %19 = arith.mulf %18, %arg4 : f64
          affine.store %19, %arg5[%arg9, %17] : memref<?x1100xf64>
          %20 = affine.apply #map4(%14)
          %21 = affine.load %arg5[%arg9, %20] : memref<?x1100xf64>
          %22 = arith.mulf %21, %arg4 : f64
          affine.store %22, %arg5[%arg9, %20] : memref<?x1100xf64>
          %23 = affine.apply #map5(%14)
          %24 = affine.load %arg5[%arg9, %23] : memref<?x1100xf64>
          %25 = arith.mulf %24, %arg4 : f64
          affine.store %25, %arg5[%arg9, %23] : memref<?x1100xf64>
        }
        affine.for %arg10 = #map2()[%0] to #map7()[%0] step 4 {
          %3 = affine.load %arg5[%arg9, %arg10] : memref<?x1100xf64>
          %4 = arith.mulf %3, %arg4 : f64
          affine.store %4, %arg5[%arg9, %arg10] : memref<?x1100xf64>
          %5 = affine.apply #map3(%arg10)
          %6 = affine.load %arg5[%arg9, %5] : memref<?x1100xf64>
          %7 = arith.mulf %6, %arg4 : f64
          affine.store %7, %arg5[%arg9, %5] : memref<?x1100xf64>
          %8 = affine.apply #map4(%arg10)
          %9 = affine.load %arg5[%arg9, %8] : memref<?x1100xf64>
          %10 = arith.mulf %9, %arg4 : f64
          affine.store %10, %arg5[%arg9, %8] : memref<?x1100xf64>
          %11 = affine.apply #map5(%arg10)
          %12 = affine.load %arg5[%arg9, %11] : memref<?x1100xf64>
          %13 = arith.mulf %12, %arg4 : f64
          affine.store %13, %arg5[%arg9, %11] : memref<?x1100xf64>
        }
        affine.for %arg10 = #map7()[%0] to #map8()[%0] step 2 {
          %3 = affine.load %arg5[%arg9, %arg10] : memref<?x1100xf64>
          %4 = arith.mulf %3, %arg4 : f64
          affine.store %4, %arg5[%arg9, %arg10] : memref<?x1100xf64>
          %5 = affine.apply #map3(%arg10)
          %6 = affine.load %arg5[%arg9, %5] : memref<?x1100xf64>
          %7 = arith.mulf %6, %arg4 : f64
          affine.store %7, %arg5[%arg9, %5] : memref<?x1100xf64>
        }
        affine.for %arg10 = #map8()[%0] to %0 {
          %3 = affine.load %arg5[%arg9, %arg10] : memref<?x1100xf64>
          %4 = arith.mulf %3, %arg4 : f64
          affine.store %4, %arg5[%arg9, %arg10] : memref<?x1100xf64>
        }
        affine.for %arg10 = 0 to %1 {
          affine.for %arg11 = 0 to #map2()[%0] step 8 {
            %3 = affine.load %arg6[%arg9, %arg10] : memref<?x1200xf64>
            %4 = arith.mulf %arg3, %3 : f64
            %5 = affine.load %arg7[%arg10, %arg11] : memref<?x1100xf64>
            %6 = arith.mulf %4, %5 : f64
            %7 = affine.load %arg5[%arg9, %arg11] : memref<?x1100xf64>
            %8 = arith.addf %7, %6 : f64
            affine.store %8, %arg5[%arg9, %arg11] : memref<?x1100xf64>
            %9 = affine.apply #map3(%arg11)
            %10 = affine.load %arg6[%arg9, %arg10] : memref<?x1200xf64>
            %11 = arith.mulf %arg3, %10 : f64
            %12 = affine.load %arg7[%arg10, %9] : memref<?x1100xf64>
            %13 = arith.mulf %11, %12 : f64
            %14 = affine.load %arg5[%arg9, %9] : memref<?x1100xf64>
            %15 = arith.addf %14, %13 : f64
            affine.store %15, %arg5[%arg9, %9] : memref<?x1100xf64>
            %16 = affine.apply #map4(%arg11)
            %17 = affine.load %arg6[%arg9, %arg10] : memref<?x1200xf64>
            %18 = arith.mulf %arg3, %17 : f64
            %19 = affine.load %arg7[%arg10, %16] : memref<?x1100xf64>
            %20 = arith.mulf %18, %19 : f64
            %21 = affine.load %arg5[%arg9, %16] : memref<?x1100xf64>
            %22 = arith.addf %21, %20 : f64
            affine.store %22, %arg5[%arg9, %16] : memref<?x1100xf64>
            %23 = affine.apply #map5(%arg11)
            %24 = affine.load %arg6[%arg9, %arg10] : memref<?x1200xf64>
            %25 = arith.mulf %arg3, %24 : f64
            %26 = affine.load %arg7[%arg10, %23] : memref<?x1100xf64>
            %27 = arith.mulf %25, %26 : f64
            %28 = affine.load %arg5[%arg9, %23] : memref<?x1100xf64>
            %29 = arith.addf %28, %27 : f64
            affine.store %29, %arg5[%arg9, %23] : memref<?x1100xf64>
            %30 = affine.apply #map6(%arg11)
            %31 = affine.load %arg6[%arg9, %arg10] : memref<?x1200xf64>
            %32 = arith.mulf %arg3, %31 : f64
            %33 = affine.load %arg7[%arg10, %30] : memref<?x1100xf64>
            %34 = arith.mulf %32, %33 : f64
            %35 = affine.load %arg5[%arg9, %30] : memref<?x1100xf64>
            %36 = arith.addf %35, %34 : f64
            affine.store %36, %arg5[%arg9, %30] : memref<?x1100xf64>
            %37 = affine.apply #map3(%30)
            %38 = affine.load %arg6[%arg9, %arg10] : memref<?x1200xf64>
            %39 = arith.mulf %arg3, %38 : f64
            %40 = affine.load %arg7[%arg10, %37] : memref<?x1100xf64>
            %41 = arith.mulf %39, %40 : f64
            %42 = affine.load %arg5[%arg9, %37] : memref<?x1100xf64>
            %43 = arith.addf %42, %41 : f64
            affine.store %43, %arg5[%arg9, %37] : memref<?x1100xf64>
            %44 = affine.apply #map4(%30)
            %45 = affine.load %arg6[%arg9, %arg10] : memref<?x1200xf64>
            %46 = arith.mulf %arg3, %45 : f64
            %47 = affine.load %arg7[%arg10, %44] : memref<?x1100xf64>
            %48 = arith.mulf %46, %47 : f64
            %49 = affine.load %arg5[%arg9, %44] : memref<?x1100xf64>
            %50 = arith.addf %49, %48 : f64
            affine.store %50, %arg5[%arg9, %44] : memref<?x1100xf64>
            %51 = affine.apply #map5(%30)
            %52 = affine.load %arg6[%arg9, %arg10] : memref<?x1200xf64>
            %53 = arith.mulf %arg3, %52 : f64
            %54 = affine.load %arg7[%arg10, %51] : memref<?x1100xf64>
            %55 = arith.mulf %53, %54 : f64
            %56 = affine.load %arg5[%arg9, %51] : memref<?x1100xf64>
            %57 = arith.addf %56, %55 : f64
            affine.store %57, %arg5[%arg9, %51] : memref<?x1100xf64>
          }
          affine.for %arg11 = #map2()[%0] to #map7()[%0] step 4 {
            %3 = affine.load %arg6[%arg9, %arg10] : memref<?x1200xf64>
            %4 = arith.mulf %arg3, %3 : f64
            %5 = affine.load %arg7[%arg10, %arg11] : memref<?x1100xf64>
            %6 = arith.mulf %4, %5 : f64
            %7 = affine.load %arg5[%arg9, %arg11] : memref<?x1100xf64>
            %8 = arith.addf %7, %6 : f64
            affine.store %8, %arg5[%arg9, %arg11] : memref<?x1100xf64>
            %9 = affine.apply #map3(%arg11)
            %10 = affine.load %arg6[%arg9, %arg10] : memref<?x1200xf64>
            %11 = arith.mulf %arg3, %10 : f64
            %12 = affine.load %arg7[%arg10, %9] : memref<?x1100xf64>
            %13 = arith.mulf %11, %12 : f64
            %14 = affine.load %arg5[%arg9, %9] : memref<?x1100xf64>
            %15 = arith.addf %14, %13 : f64
            affine.store %15, %arg5[%arg9, %9] : memref<?x1100xf64>
            %16 = affine.apply #map4(%arg11)
            %17 = affine.load %arg6[%arg9, %arg10] : memref<?x1200xf64>
            %18 = arith.mulf %arg3, %17 : f64
            %19 = affine.load %arg7[%arg10, %16] : memref<?x1100xf64>
            %20 = arith.mulf %18, %19 : f64
            %21 = affine.load %arg5[%arg9, %16] : memref<?x1100xf64>
            %22 = arith.addf %21, %20 : f64
            affine.store %22, %arg5[%arg9, %16] : memref<?x1100xf64>
            %23 = affine.apply #map5(%arg11)
            %24 = affine.load %arg6[%arg9, %arg10] : memref<?x1200xf64>
            %25 = arith.mulf %arg3, %24 : f64
            %26 = affine.load %arg7[%arg10, %23] : memref<?x1100xf64>
            %27 = arith.mulf %25, %26 : f64
            %28 = affine.load %arg5[%arg9, %23] : memref<?x1100xf64>
            %29 = arith.addf %28, %27 : f64
            affine.store %29, %arg5[%arg9, %23] : memref<?x1100xf64>
          }
          affine.for %arg11 = #map7()[%0] to #map8()[%0] step 2 {
            %3 = affine.load %arg6[%arg9, %arg10] : memref<?x1200xf64>
            %4 = arith.mulf %arg3, %3 : f64
            %5 = affine.load %arg7[%arg10, %arg11] : memref<?x1100xf64>
            %6 = arith.mulf %4, %5 : f64
            %7 = affine.load %arg5[%arg9, %arg11] : memref<?x1100xf64>
            %8 = arith.addf %7, %6 : f64
            affine.store %8, %arg5[%arg9, %arg11] : memref<?x1100xf64>
            %9 = affine.apply #map3(%arg11)
            %10 = affine.load %arg6[%arg9, %arg10] : memref<?x1200xf64>
            %11 = arith.mulf %arg3, %10 : f64
            %12 = affine.load %arg7[%arg10, %9] : memref<?x1100xf64>
            %13 = arith.mulf %11, %12 : f64
            %14 = affine.load %arg5[%arg9, %9] : memref<?x1100xf64>
            %15 = arith.addf %14, %13 : f64
            affine.store %15, %arg5[%arg9, %9] : memref<?x1100xf64>
          }
          affine.for %arg11 = #map8()[%0] to %0 {
            %3 = affine.load %arg6[%arg9, %arg10] : memref<?x1200xf64>
            %4 = arith.mulf %arg3, %3 : f64
            %5 = affine.load %arg7[%arg10, %arg11] : memref<?x1100xf64>
            %6 = arith.mulf %4, %5 : f64
            %7 = affine.load %arg5[%arg9, %arg11] : memref<?x1100xf64>
            %8 = arith.addf %7, %6 : f64
            affine.store %8, %arg5[%arg9, %arg11] : memref<?x1100xf64>
          }
        }
      }
    }
    return
  }
}

