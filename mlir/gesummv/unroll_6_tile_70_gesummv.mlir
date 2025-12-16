#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 70, s0)>
#map2 = affine_map<()[s0] -> ((s0 floordiv 6) * 6)>
#map3 = affine_map<(d0) -> (d0 + 1)>
#map4 = affine_map<(d0) -> (d0 + 2)>
#map5 = affine_map<(d0) -> (d0 + 3)>
#map6 = affine_map<(d0) -> (d0 + 4)>
#map7 = affine_map<(d0) -> (d0 + 5)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_gesummv(%arg0: i32, %arg1: f64, %arg2: f64, %arg3: memref<?x1300xf64>, %arg4: memref<?x1300xf64>, %arg5: memref<?xf64>, %arg6: memref<?xf64>, %arg7: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 0.000000e+00 : f64
    %0 = arith.index_cast %arg0 : i32 to index
    affine.for %arg8 = 0 to %0 step 70 {
      affine.for %arg9 = #map(%arg8) to min #map1(%arg8)[%0] {
        affine.store %cst, %arg5[%arg9] : memref<?xf64>
        affine.store %cst, %arg7[%arg9] : memref<?xf64>
        affine.for %arg10 = 0 to #map2()[%0] step 6 {
          %6 = affine.load %arg3[%arg9, %arg10] : memref<?x1300xf64>
          %7 = affine.load %arg6[%arg10] : memref<?xf64>
          %8 = arith.mulf %6, %7 : f64
          %9 = affine.load %arg5[%arg9] : memref<?xf64>
          %10 = arith.addf %8, %9 : f64
          affine.store %10, %arg5[%arg9] : memref<?xf64>
          %11 = affine.load %arg4[%arg9, %arg10] : memref<?x1300xf64>
          %12 = affine.load %arg6[%arg10] : memref<?xf64>
          %13 = arith.mulf %11, %12 : f64
          %14 = affine.load %arg7[%arg9] : memref<?xf64>
          %15 = arith.addf %13, %14 : f64
          affine.store %15, %arg7[%arg9] : memref<?xf64>
          %16 = affine.apply #map3(%arg10)
          %17 = affine.load %arg3[%arg9, %16] : memref<?x1300xf64>
          %18 = affine.load %arg6[%16] : memref<?xf64>
          %19 = arith.mulf %17, %18 : f64
          %20 = affine.load %arg5[%arg9] : memref<?xf64>
          %21 = arith.addf %19, %20 : f64
          affine.store %21, %arg5[%arg9] : memref<?xf64>
          %22 = affine.load %arg4[%arg9, %16] : memref<?x1300xf64>
          %23 = affine.load %arg6[%16] : memref<?xf64>
          %24 = arith.mulf %22, %23 : f64
          %25 = affine.load %arg7[%arg9] : memref<?xf64>
          %26 = arith.addf %24, %25 : f64
          affine.store %26, %arg7[%arg9] : memref<?xf64>
          %27 = affine.apply #map4(%arg10)
          %28 = affine.load %arg3[%arg9, %27] : memref<?x1300xf64>
          %29 = affine.load %arg6[%27] : memref<?xf64>
          %30 = arith.mulf %28, %29 : f64
          %31 = affine.load %arg5[%arg9] : memref<?xf64>
          %32 = arith.addf %30, %31 : f64
          affine.store %32, %arg5[%arg9] : memref<?xf64>
          %33 = affine.load %arg4[%arg9, %27] : memref<?x1300xf64>
          %34 = affine.load %arg6[%27] : memref<?xf64>
          %35 = arith.mulf %33, %34 : f64
          %36 = affine.load %arg7[%arg9] : memref<?xf64>
          %37 = arith.addf %35, %36 : f64
          affine.store %37, %arg7[%arg9] : memref<?xf64>
          %38 = affine.apply #map5(%arg10)
          %39 = affine.load %arg3[%arg9, %38] : memref<?x1300xf64>
          %40 = affine.load %arg6[%38] : memref<?xf64>
          %41 = arith.mulf %39, %40 : f64
          %42 = affine.load %arg5[%arg9] : memref<?xf64>
          %43 = arith.addf %41, %42 : f64
          affine.store %43, %arg5[%arg9] : memref<?xf64>
          %44 = affine.load %arg4[%arg9, %38] : memref<?x1300xf64>
          %45 = affine.load %arg6[%38] : memref<?xf64>
          %46 = arith.mulf %44, %45 : f64
          %47 = affine.load %arg7[%arg9] : memref<?xf64>
          %48 = arith.addf %46, %47 : f64
          affine.store %48, %arg7[%arg9] : memref<?xf64>
          %49 = affine.apply #map6(%arg10)
          %50 = affine.load %arg3[%arg9, %49] : memref<?x1300xf64>
          %51 = affine.load %arg6[%49] : memref<?xf64>
          %52 = arith.mulf %50, %51 : f64
          %53 = affine.load %arg5[%arg9] : memref<?xf64>
          %54 = arith.addf %52, %53 : f64
          affine.store %54, %arg5[%arg9] : memref<?xf64>
          %55 = affine.load %arg4[%arg9, %49] : memref<?x1300xf64>
          %56 = affine.load %arg6[%49] : memref<?xf64>
          %57 = arith.mulf %55, %56 : f64
          %58 = affine.load %arg7[%arg9] : memref<?xf64>
          %59 = arith.addf %57, %58 : f64
          affine.store %59, %arg7[%arg9] : memref<?xf64>
          %60 = affine.apply #map7(%arg10)
          %61 = affine.load %arg3[%arg9, %60] : memref<?x1300xf64>
          %62 = affine.load %arg6[%60] : memref<?xf64>
          %63 = arith.mulf %61, %62 : f64
          %64 = affine.load %arg5[%arg9] : memref<?xf64>
          %65 = arith.addf %63, %64 : f64
          affine.store %65, %arg5[%arg9] : memref<?xf64>
          %66 = affine.load %arg4[%arg9, %60] : memref<?x1300xf64>
          %67 = affine.load %arg6[%60] : memref<?xf64>
          %68 = arith.mulf %66, %67 : f64
          %69 = affine.load %arg7[%arg9] : memref<?xf64>
          %70 = arith.addf %68, %69 : f64
          affine.store %70, %arg7[%arg9] : memref<?xf64>
        }
        affine.for %arg10 = #map2()[%0] to %0 {
          %6 = affine.load %arg3[%arg9, %arg10] : memref<?x1300xf64>
          %7 = affine.load %arg6[%arg10] : memref<?xf64>
          %8 = arith.mulf %6, %7 : f64
          %9 = affine.load %arg5[%arg9] : memref<?xf64>
          %10 = arith.addf %8, %9 : f64
          affine.store %10, %arg5[%arg9] : memref<?xf64>
          %11 = affine.load %arg4[%arg9, %arg10] : memref<?x1300xf64>
          %12 = affine.load %arg6[%arg10] : memref<?xf64>
          %13 = arith.mulf %11, %12 : f64
          %14 = affine.load %arg7[%arg9] : memref<?xf64>
          %15 = arith.addf %13, %14 : f64
          affine.store %15, %arg7[%arg9] : memref<?xf64>
        }
        %1 = affine.load %arg5[%arg9] : memref<?xf64>
        %2 = arith.mulf %arg1, %1 : f64
        %3 = affine.load %arg7[%arg9] : memref<?xf64>
        %4 = arith.mulf %arg2, %3 : f64
        %5 = arith.addf %2, %4 : f64
        affine.store %5, %arg7[%arg9] : memref<?xf64>
      }
    }
    return
  }
}

