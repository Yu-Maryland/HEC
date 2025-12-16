#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 70, s0)>
#map2 = affine_map<(d0) -> (d0 + 1)>
#map3 = affine_map<(d0)[s0] -> (d0 + (((-d0 + s0 - 1) floordiv 5) floordiv 2) * 10 + 1)>
#map4 = affine_map<(d0) -> (d0 + 2)>
#map5 = affine_map<(d0) -> (d0 + 3)>
#map6 = affine_map<(d0) -> (d0 + 4)>
#map7 = affine_map<(d0) -> (d0 + 5)>
#map8 = affine_map<(d0)[s0] -> (d0 + ((-d0 + s0 - 1) floordiv 5) * 5 + 1)>
#map9 = affine_map<(d0)[s0] -> (d0 + ((-d0 + s0 - 1) floordiv 5) * 5 + ((-d0 + s0 - ((-d0 + s0 - 1) floordiv 5) * 5 - 1) floordiv 2) * 2 + 1)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_trmm(%arg0: i32, %arg1: i32, %arg2: f64, %arg3: memref<?x1000xf64>, %arg4: memref<?x1200xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg0 : i32 to index
    affine.for %arg5 = 0 to %1 step 70 {
      affine.for %arg6 = 0 to %0 step 70 {
        affine.for %arg7 = #map(%arg5) to min #map1(%arg5)[%1] {
          affine.for %arg8 = #map(%arg6) to min #map1(%arg6)[%0] {
            affine.for %arg9 = #map2(%arg7) to #map3(%arg7)[%1] step 10 {
              %4 = affine.load %arg3[%arg9, %arg7] : memref<?x1000xf64>
              %5 = affine.load %arg4[%arg9, %arg8] : memref<?x1200xf64>
              %6 = arith.mulf %4, %5 : f64
              %7 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %8 = arith.addf %7, %6 : f64
              affine.store %8, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %9 = affine.apply #map2(%arg9)
              %10 = affine.load %arg3[%9, %arg7] : memref<?x1000xf64>
              %11 = affine.load %arg4[%9, %arg8] : memref<?x1200xf64>
              %12 = arith.mulf %10, %11 : f64
              %13 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %14 = arith.addf %13, %12 : f64
              affine.store %14, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %15 = affine.apply #map4(%arg9)
              %16 = affine.load %arg3[%15, %arg7] : memref<?x1000xf64>
              %17 = affine.load %arg4[%15, %arg8] : memref<?x1200xf64>
              %18 = arith.mulf %16, %17 : f64
              %19 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %20 = arith.addf %19, %18 : f64
              affine.store %20, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %21 = affine.apply #map5(%arg9)
              %22 = affine.load %arg3[%21, %arg7] : memref<?x1000xf64>
              %23 = affine.load %arg4[%21, %arg8] : memref<?x1200xf64>
              %24 = arith.mulf %22, %23 : f64
              %25 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %26 = arith.addf %25, %24 : f64
              affine.store %26, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %27 = affine.apply #map6(%arg9)
              %28 = affine.load %arg3[%27, %arg7] : memref<?x1000xf64>
              %29 = affine.load %arg4[%27, %arg8] : memref<?x1200xf64>
              %30 = arith.mulf %28, %29 : f64
              %31 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %32 = arith.addf %31, %30 : f64
              affine.store %32, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %33 = affine.apply #map7(%arg9)
              %34 = affine.load %arg3[%33, %arg7] : memref<?x1000xf64>
              %35 = affine.load %arg4[%33, %arg8] : memref<?x1200xf64>
              %36 = arith.mulf %34, %35 : f64
              %37 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %38 = arith.addf %37, %36 : f64
              affine.store %38, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %39 = affine.apply #map2(%33)
              %40 = affine.load %arg3[%39, %arg7] : memref<?x1000xf64>
              %41 = affine.load %arg4[%39, %arg8] : memref<?x1200xf64>
              %42 = arith.mulf %40, %41 : f64
              %43 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %44 = arith.addf %43, %42 : f64
              affine.store %44, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %45 = affine.apply #map4(%33)
              %46 = affine.load %arg3[%45, %arg7] : memref<?x1000xf64>
              %47 = affine.load %arg4[%45, %arg8] : memref<?x1200xf64>
              %48 = arith.mulf %46, %47 : f64
              %49 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %50 = arith.addf %49, %48 : f64
              affine.store %50, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %51 = affine.apply #map5(%33)
              %52 = affine.load %arg3[%51, %arg7] : memref<?x1000xf64>
              %53 = affine.load %arg4[%51, %arg8] : memref<?x1200xf64>
              %54 = arith.mulf %52, %53 : f64
              %55 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %56 = arith.addf %55, %54 : f64
              affine.store %56, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %57 = affine.apply #map6(%33)
              %58 = affine.load %arg3[%57, %arg7] : memref<?x1000xf64>
              %59 = affine.load %arg4[%57, %arg8] : memref<?x1200xf64>
              %60 = arith.mulf %58, %59 : f64
              %61 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %62 = arith.addf %61, %60 : f64
              affine.store %62, %arg4[%arg7, %arg8] : memref<?x1200xf64>
            }
            affine.for %arg9 = #map3(%arg7)[%1] to #map8(%arg7)[%1] step 5 {
              %4 = affine.load %arg3[%arg9, %arg7] : memref<?x1000xf64>
              %5 = affine.load %arg4[%arg9, %arg8] : memref<?x1200xf64>
              %6 = arith.mulf %4, %5 : f64
              %7 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %8 = arith.addf %7, %6 : f64
              affine.store %8, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %9 = affine.apply #map2(%arg9)
              %10 = affine.load %arg3[%9, %arg7] : memref<?x1000xf64>
              %11 = affine.load %arg4[%9, %arg8] : memref<?x1200xf64>
              %12 = arith.mulf %10, %11 : f64
              %13 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %14 = arith.addf %13, %12 : f64
              affine.store %14, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %15 = affine.apply #map4(%arg9)
              %16 = affine.load %arg3[%15, %arg7] : memref<?x1000xf64>
              %17 = affine.load %arg4[%15, %arg8] : memref<?x1200xf64>
              %18 = arith.mulf %16, %17 : f64
              %19 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %20 = arith.addf %19, %18 : f64
              affine.store %20, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %21 = affine.apply #map5(%arg9)
              %22 = affine.load %arg3[%21, %arg7] : memref<?x1000xf64>
              %23 = affine.load %arg4[%21, %arg8] : memref<?x1200xf64>
              %24 = arith.mulf %22, %23 : f64
              %25 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %26 = arith.addf %25, %24 : f64
              affine.store %26, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %27 = affine.apply #map6(%arg9)
              %28 = affine.load %arg3[%27, %arg7] : memref<?x1000xf64>
              %29 = affine.load %arg4[%27, %arg8] : memref<?x1200xf64>
              %30 = arith.mulf %28, %29 : f64
              %31 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %32 = arith.addf %31, %30 : f64
              affine.store %32, %arg4[%arg7, %arg8] : memref<?x1200xf64>
            }
            affine.for %arg9 = #map8(%arg7)[%1] to #map9(%arg7)[%1] step 2 {
              %4 = affine.load %arg3[%arg9, %arg7] : memref<?x1000xf64>
              %5 = affine.load %arg4[%arg9, %arg8] : memref<?x1200xf64>
              %6 = arith.mulf %4, %5 : f64
              %7 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %8 = arith.addf %7, %6 : f64
              affine.store %8, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %9 = affine.apply #map2(%arg9)
              %10 = affine.load %arg3[%9, %arg7] : memref<?x1000xf64>
              %11 = affine.load %arg4[%9, %arg8] : memref<?x1200xf64>
              %12 = arith.mulf %10, %11 : f64
              %13 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %14 = arith.addf %13, %12 : f64
              affine.store %14, %arg4[%arg7, %arg8] : memref<?x1200xf64>
            }
            affine.for %arg9 = #map9(%arg7)[%1] to %1 {
              %4 = affine.load %arg3[%arg9, %arg7] : memref<?x1000xf64>
              %5 = affine.load %arg4[%arg9, %arg8] : memref<?x1200xf64>
              %6 = arith.mulf %4, %5 : f64
              %7 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %8 = arith.addf %7, %6 : f64
              affine.store %8, %arg4[%arg7, %arg8] : memref<?x1200xf64>
            }
            %2 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
            %3 = arith.mulf %arg2, %2 : f64
            affine.store %3, %arg4[%arg7, %arg8] : memref<?x1200xf64>
          }
        }
      }
    }
    return
  }
}

