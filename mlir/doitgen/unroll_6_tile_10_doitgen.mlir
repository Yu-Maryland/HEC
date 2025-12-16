#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 10, s0)>
#map2 = affine_map<()[s0] -> ((s0 floordiv 6) * 6)>
#map3 = affine_map<(d0) -> (d0 + 1)>
#map4 = affine_map<(d0) -> (d0 + 2)>
#map5 = affine_map<(d0) -> (d0 + 3)>
#map6 = affine_map<(d0) -> (d0 + 4)>
#map7 = affine_map<(d0) -> (d0 + 5)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>, #dlti.dl_entry<"dlti.endianness", "little">>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_doitgen(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: memref<?x140x160xf64>, %arg4: memref<?x160xf64>, %arg5: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 0.000000e+00 : f64
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg2 : i32 to index
    %2 = arith.index_cast %arg0 : i32 to index
    affine.for %arg6 = 0 to %2 step 10 {
      affine.for %arg7 = 0 to %0 step 10 {
        affine.for %arg8 = #map(%arg6) to min #map1(%arg6)[%2] {
          affine.for %arg9 = #map(%arg7) to min #map1(%arg7)[%0] {
            affine.for %arg10 = 0 to %1 {
              affine.store %cst, %arg5[%arg10] : memref<?xf64>
              affine.for %arg11 = 0 to #map2()[%1] step 6 {
                %3 = affine.load %arg3[%arg8, %arg9, %arg11] : memref<?x140x160xf64>
                %4 = affine.load %arg4[%arg11, %arg10] : memref<?x160xf64>
                %5 = arith.mulf %3, %4 : f64
                %6 = affine.load %arg5[%arg10] : memref<?xf64>
                %7 = arith.addf %6, %5 : f64
                affine.store %7, %arg5[%arg10] : memref<?xf64>
                %8 = affine.apply #map3(%arg11)
                %9 = affine.load %arg3[%arg8, %arg9, %8] : memref<?x140x160xf64>
                %10 = affine.load %arg4[%8, %arg10] : memref<?x160xf64>
                %11 = arith.mulf %9, %10 : f64
                %12 = affine.load %arg5[%arg10] : memref<?xf64>
                %13 = arith.addf %12, %11 : f64
                affine.store %13, %arg5[%arg10] : memref<?xf64>
                %14 = affine.apply #map4(%arg11)
                %15 = affine.load %arg3[%arg8, %arg9, %14] : memref<?x140x160xf64>
                %16 = affine.load %arg4[%14, %arg10] : memref<?x160xf64>
                %17 = arith.mulf %15, %16 : f64
                %18 = affine.load %arg5[%arg10] : memref<?xf64>
                %19 = arith.addf %18, %17 : f64
                affine.store %19, %arg5[%arg10] : memref<?xf64>
                %20 = affine.apply #map5(%arg11)
                %21 = affine.load %arg3[%arg8, %arg9, %20] : memref<?x140x160xf64>
                %22 = affine.load %arg4[%20, %arg10] : memref<?x160xf64>
                %23 = arith.mulf %21, %22 : f64
                %24 = affine.load %arg5[%arg10] : memref<?xf64>
                %25 = arith.addf %24, %23 : f64
                affine.store %25, %arg5[%arg10] : memref<?xf64>
                %26 = affine.apply #map6(%arg11)
                %27 = affine.load %arg3[%arg8, %arg9, %26] : memref<?x140x160xf64>
                %28 = affine.load %arg4[%26, %arg10] : memref<?x160xf64>
                %29 = arith.mulf %27, %28 : f64
                %30 = affine.load %arg5[%arg10] : memref<?xf64>
                %31 = arith.addf %30, %29 : f64
                affine.store %31, %arg5[%arg10] : memref<?xf64>
                %32 = affine.apply #map7(%arg11)
                %33 = affine.load %arg3[%arg8, %arg9, %32] : memref<?x140x160xf64>
                %34 = affine.load %arg4[%32, %arg10] : memref<?x160xf64>
                %35 = arith.mulf %33, %34 : f64
                %36 = affine.load %arg5[%arg10] : memref<?xf64>
                %37 = arith.addf %36, %35 : f64
                affine.store %37, %arg5[%arg10] : memref<?xf64>
              }
              affine.for %arg11 = #map2()[%1] to %1 {
                %3 = affine.load %arg3[%arg8, %arg9, %arg11] : memref<?x140x160xf64>
                %4 = affine.load %arg4[%arg11, %arg10] : memref<?x160xf64>
                %5 = arith.mulf %3, %4 : f64
                %6 = affine.load %arg5[%arg10] : memref<?xf64>
                %7 = arith.addf %6, %5 : f64
                affine.store %7, %arg5[%arg10] : memref<?xf64>
              }
            }
            affine.for %arg10 = 0 to #map2()[%1] step 6 {
              %3 = affine.load %arg5[%arg10] : memref<?xf64>
              affine.store %3, %arg3[%arg8, %arg9, %arg10] : memref<?x140x160xf64>
              %4 = affine.apply #map3(%arg10)
              %5 = affine.load %arg5[%4] : memref<?xf64>
              affine.store %5, %arg3[%arg8, %arg9, %4] : memref<?x140x160xf64>
              %6 = affine.apply #map4(%arg10)
              %7 = affine.load %arg5[%6] : memref<?xf64>
              affine.store %7, %arg3[%arg8, %arg9, %6] : memref<?x140x160xf64>
              %8 = affine.apply #map5(%arg10)
              %9 = affine.load %arg5[%8] : memref<?xf64>
              affine.store %9, %arg3[%arg8, %arg9, %8] : memref<?x140x160xf64>
              %10 = affine.apply #map6(%arg10)
              %11 = affine.load %arg5[%10] : memref<?xf64>
              affine.store %11, %arg3[%arg8, %arg9, %10] : memref<?x140x160xf64>
              %12 = affine.apply #map7(%arg10)
              %13 = affine.load %arg5[%12] : memref<?xf64>
              affine.store %13, %arg3[%arg8, %arg9, %12] : memref<?x140x160xf64>
            }
            affine.for %arg10 = #map2()[%1] to %1 {
              %3 = affine.load %arg5[%arg10] : memref<?xf64>
              affine.store %3, %arg3[%arg8, %arg9, %arg10] : memref<?x140x160xf64>
            }
          }
        }
      }
    }
    return
  }
}

