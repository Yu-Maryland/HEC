#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 70, s0)>
#map2 = affine_map<(d0) -> (((d0 + 1) floordiv 3) * 3)>
#map3 = affine_map<(d0) -> (d0 + 1)>
#map4 = affine_map<(d0) -> (d0 + 2)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_syr2k(%arg0: i32, %arg1: i32, %arg2: f64, %arg3: f64, %arg4: memref<?x1200xf64>, %arg5: memref<?x1000xf64>, %arg6: memref<?x1000xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg0 : i32 to index
    affine.for %arg7 = 0 to %1 step 70 {
      affine.for %arg8 = #map(%arg7) to min #map1(%arg7)[%1] {
        affine.for %arg9 = 0 to #map2(%arg8) step 3 {
          %2 = affine.load %arg4[%arg8, %arg9] : memref<?x1200xf64>
          %3 = arith.mulf %2, %arg3 : f64
          affine.store %3, %arg4[%arg8, %arg9] : memref<?x1200xf64>
          %4 = affine.apply #map3(%arg9)
          %5 = affine.load %arg4[%arg8, %4] : memref<?x1200xf64>
          %6 = arith.mulf %5, %arg3 : f64
          affine.store %6, %arg4[%arg8, %4] : memref<?x1200xf64>
          %7 = affine.apply #map4(%arg9)
          %8 = affine.load %arg4[%arg8, %7] : memref<?x1200xf64>
          %9 = arith.mulf %8, %arg3 : f64
          affine.store %9, %arg4[%arg8, %7] : memref<?x1200xf64>
        }
        affine.for %arg9 = #map2(%arg8) to #map3(%arg8) {
          %2 = affine.load %arg4[%arg8, %arg9] : memref<?x1200xf64>
          %3 = arith.mulf %2, %arg3 : f64
          affine.store %3, %arg4[%arg8, %arg9] : memref<?x1200xf64>
        }
        affine.for %arg9 = 0 to %0 {
          affine.for %arg10 = 0 to #map2(%arg8) step 3 {
            %2 = affine.load %arg5[%arg10, %arg9] : memref<?x1000xf64>
            %3 = arith.mulf %2, %arg2 : f64
            %4 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %5 = arith.mulf %3, %4 : f64
            %6 = affine.load %arg6[%arg10, %arg9] : memref<?x1000xf64>
            %7 = arith.mulf %6, %arg2 : f64
            %8 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %9 = arith.mulf %7, %8 : f64
            %10 = arith.addf %5, %9 : f64
            %11 = affine.load %arg4[%arg8, %arg10] : memref<?x1200xf64>
            %12 = arith.addf %11, %10 : f64
            affine.store %12, %arg4[%arg8, %arg10] : memref<?x1200xf64>
            %13 = affine.apply #map3(%arg10)
            %14 = affine.load %arg5[%13, %arg9] : memref<?x1000xf64>
            %15 = arith.mulf %14, %arg2 : f64
            %16 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %17 = arith.mulf %15, %16 : f64
            %18 = affine.load %arg6[%13, %arg9] : memref<?x1000xf64>
            %19 = arith.mulf %18, %arg2 : f64
            %20 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %21 = arith.mulf %19, %20 : f64
            %22 = arith.addf %17, %21 : f64
            %23 = affine.load %arg4[%arg8, %13] : memref<?x1200xf64>
            %24 = arith.addf %23, %22 : f64
            affine.store %24, %arg4[%arg8, %13] : memref<?x1200xf64>
            %25 = affine.apply #map4(%arg10)
            %26 = affine.load %arg5[%25, %arg9] : memref<?x1000xf64>
            %27 = arith.mulf %26, %arg2 : f64
            %28 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %29 = arith.mulf %27, %28 : f64
            %30 = affine.load %arg6[%25, %arg9] : memref<?x1000xf64>
            %31 = arith.mulf %30, %arg2 : f64
            %32 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %33 = arith.mulf %31, %32 : f64
            %34 = arith.addf %29, %33 : f64
            %35 = affine.load %arg4[%arg8, %25] : memref<?x1200xf64>
            %36 = arith.addf %35, %34 : f64
            affine.store %36, %arg4[%arg8, %25] : memref<?x1200xf64>
          }
          affine.for %arg10 = #map2(%arg8) to #map3(%arg8) {
            %2 = affine.load %arg5[%arg10, %arg9] : memref<?x1000xf64>
            %3 = arith.mulf %2, %arg2 : f64
            %4 = affine.load %arg6[%arg8, %arg9] : memref<?x1000xf64>
            %5 = arith.mulf %3, %4 : f64
            %6 = affine.load %arg6[%arg10, %arg9] : memref<?x1000xf64>
            %7 = arith.mulf %6, %arg2 : f64
            %8 = affine.load %arg5[%arg8, %arg9] : memref<?x1000xf64>
            %9 = arith.mulf %7, %8 : f64
            %10 = arith.addf %5, %9 : f64
            %11 = affine.load %arg4[%arg8, %arg10] : memref<?x1200xf64>
            %12 = arith.addf %11, %10 : f64
            affine.store %12, %arg4[%arg8, %arg10] : memref<?x1200xf64>
          }
        }
      }
    }
    return
  }
}

