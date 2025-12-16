#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 40, s0)>
#map2 = affine_map<()[s0] -> (((s0 floordiv 7) floordiv 2) * 14)>
#map3 = affine_map<(d0) -> (d0 + 1)>
#map4 = affine_map<(d0) -> (d0 + 2)>
#map5 = affine_map<(d0) -> (d0 + 3)>
#map6 = affine_map<(d0) -> (d0 + 4)>
#map7 = affine_map<(d0) -> (d0 + 5)>
#map8 = affine_map<(d0) -> (d0 + 6)>
#map9 = affine_map<(d0) -> (d0 + 7)>
#map10 = affine_map<()[s0] -> ((s0 floordiv 7) * 7)>
#map11 = affine_map<()[s0] -> ((s0 floordiv 7) * 7 + ((s0 mod 7) floordiv 2) * 2)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_atax(%arg0: i32, %arg1: i32, %arg2: memref<?x2100xf64>, %arg3: memref<?xf64>, %arg4: memref<?xf64>, %arg5: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 0.000000e+00 : f64
    %0 = arith.index_cast %arg1 : i32 to index
    affine.for %arg6 = 0 to %0 step 40 {
      affine.for %arg7 = #map(%arg6) to min #map1(%arg6)[%0] {
        affine.store %cst, %arg4[%arg7] : memref<?xf64>
      }
    }
    %1 = arith.index_cast %arg0 : i32 to index
    affine.for %arg6 = 0 to %1 step 40 {
      affine.for %arg7 = #map(%arg6) to min #map1(%arg6)[%1] {
        affine.store %cst, %arg5[%arg7] : memref<?xf64>
        affine.for %arg8 = 0 to #map2()[%0] step 14 {
          %2 = affine.load %arg5[%arg7] : memref<?xf64>
          %3 = affine.load %arg2[%arg7, %arg8] : memref<?x2100xf64>
          %4 = affine.load %arg3[%arg8] : memref<?xf64>
          %5 = arith.mulf %3, %4 : f64
          %6 = arith.addf %2, %5 : f64
          affine.store %6, %arg5[%arg7] : memref<?xf64>
          %7 = affine.apply #map3(%arg8)
          %8 = affine.load %arg5[%arg7] : memref<?xf64>
          %9 = affine.load %arg2[%arg7, %7] : memref<?x2100xf64>
          %10 = affine.load %arg3[%7] : memref<?xf64>
          %11 = arith.mulf %9, %10 : f64
          %12 = arith.addf %8, %11 : f64
          affine.store %12, %arg5[%arg7] : memref<?xf64>
          %13 = affine.apply #map4(%arg8)
          %14 = affine.load %arg5[%arg7] : memref<?xf64>
          %15 = affine.load %arg2[%arg7, %13] : memref<?x2100xf64>
          %16 = affine.load %arg3[%13] : memref<?xf64>
          %17 = arith.mulf %15, %16 : f64
          %18 = arith.addf %14, %17 : f64
          affine.store %18, %arg5[%arg7] : memref<?xf64>
          %19 = affine.apply #map5(%arg8)
          %20 = affine.load %arg5[%arg7] : memref<?xf64>
          %21 = affine.load %arg2[%arg7, %19] : memref<?x2100xf64>
          %22 = affine.load %arg3[%19] : memref<?xf64>
          %23 = arith.mulf %21, %22 : f64
          %24 = arith.addf %20, %23 : f64
          affine.store %24, %arg5[%arg7] : memref<?xf64>
          %25 = affine.apply #map6(%arg8)
          %26 = affine.load %arg5[%arg7] : memref<?xf64>
          %27 = affine.load %arg2[%arg7, %25] : memref<?x2100xf64>
          %28 = affine.load %arg3[%25] : memref<?xf64>
          %29 = arith.mulf %27, %28 : f64
          %30 = arith.addf %26, %29 : f64
          affine.store %30, %arg5[%arg7] : memref<?xf64>
          %31 = affine.apply #map7(%arg8)
          %32 = affine.load %arg5[%arg7] : memref<?xf64>
          %33 = affine.load %arg2[%arg7, %31] : memref<?x2100xf64>
          %34 = affine.load %arg3[%31] : memref<?xf64>
          %35 = arith.mulf %33, %34 : f64
          %36 = arith.addf %32, %35 : f64
          affine.store %36, %arg5[%arg7] : memref<?xf64>
          %37 = affine.apply #map8(%arg8)
          %38 = affine.load %arg5[%arg7] : memref<?xf64>
          %39 = affine.load %arg2[%arg7, %37] : memref<?x2100xf64>
          %40 = affine.load %arg3[%37] : memref<?xf64>
          %41 = arith.mulf %39, %40 : f64
          %42 = arith.addf %38, %41 : f64
          affine.store %42, %arg5[%arg7] : memref<?xf64>
          %43 = affine.apply #map9(%arg8)
          %44 = affine.load %arg5[%arg7] : memref<?xf64>
          %45 = affine.load %arg2[%arg7, %43] : memref<?x2100xf64>
          %46 = affine.load %arg3[%43] : memref<?xf64>
          %47 = arith.mulf %45, %46 : f64
          %48 = arith.addf %44, %47 : f64
          affine.store %48, %arg5[%arg7] : memref<?xf64>
          %49 = affine.apply #map3(%43)
          %50 = affine.load %arg5[%arg7] : memref<?xf64>
          %51 = affine.load %arg2[%arg7, %49] : memref<?x2100xf64>
          %52 = affine.load %arg3[%49] : memref<?xf64>
          %53 = arith.mulf %51, %52 : f64
          %54 = arith.addf %50, %53 : f64
          affine.store %54, %arg5[%arg7] : memref<?xf64>
          %55 = affine.apply #map4(%43)
          %56 = affine.load %arg5[%arg7] : memref<?xf64>
          %57 = affine.load %arg2[%arg7, %55] : memref<?x2100xf64>
          %58 = affine.load %arg3[%55] : memref<?xf64>
          %59 = arith.mulf %57, %58 : f64
          %60 = arith.addf %56, %59 : f64
          affine.store %60, %arg5[%arg7] : memref<?xf64>
          %61 = affine.apply #map5(%43)
          %62 = affine.load %arg5[%arg7] : memref<?xf64>
          %63 = affine.load %arg2[%arg7, %61] : memref<?x2100xf64>
          %64 = affine.load %arg3[%61] : memref<?xf64>
          %65 = arith.mulf %63, %64 : f64
          %66 = arith.addf %62, %65 : f64
          affine.store %66, %arg5[%arg7] : memref<?xf64>
          %67 = affine.apply #map6(%43)
          %68 = affine.load %arg5[%arg7] : memref<?xf64>
          %69 = affine.load %arg2[%arg7, %67] : memref<?x2100xf64>
          %70 = affine.load %arg3[%67] : memref<?xf64>
          %71 = arith.mulf %69, %70 : f64
          %72 = arith.addf %68, %71 : f64
          affine.store %72, %arg5[%arg7] : memref<?xf64>
          %73 = affine.apply #map7(%43)
          %74 = affine.load %arg5[%arg7] : memref<?xf64>
          %75 = affine.load %arg2[%arg7, %73] : memref<?x2100xf64>
          %76 = affine.load %arg3[%73] : memref<?xf64>
          %77 = arith.mulf %75, %76 : f64
          %78 = arith.addf %74, %77 : f64
          affine.store %78, %arg5[%arg7] : memref<?xf64>
          %79 = affine.apply #map8(%43)
          %80 = affine.load %arg5[%arg7] : memref<?xf64>
          %81 = affine.load %arg2[%arg7, %79] : memref<?x2100xf64>
          %82 = affine.load %arg3[%79] : memref<?xf64>
          %83 = arith.mulf %81, %82 : f64
          %84 = arith.addf %80, %83 : f64
          affine.store %84, %arg5[%arg7] : memref<?xf64>
        }
        affine.for %arg8 = #map2()[%0] to #map10()[%0] step 7 {
          %2 = affine.load %arg5[%arg7] : memref<?xf64>
          %3 = affine.load %arg2[%arg7, %arg8] : memref<?x2100xf64>
          %4 = affine.load %arg3[%arg8] : memref<?xf64>
          %5 = arith.mulf %3, %4 : f64
          %6 = arith.addf %2, %5 : f64
          affine.store %6, %arg5[%arg7] : memref<?xf64>
          %7 = affine.apply #map3(%arg8)
          %8 = affine.load %arg5[%arg7] : memref<?xf64>
          %9 = affine.load %arg2[%arg7, %7] : memref<?x2100xf64>
          %10 = affine.load %arg3[%7] : memref<?xf64>
          %11 = arith.mulf %9, %10 : f64
          %12 = arith.addf %8, %11 : f64
          affine.store %12, %arg5[%arg7] : memref<?xf64>
          %13 = affine.apply #map4(%arg8)
          %14 = affine.load %arg5[%arg7] : memref<?xf64>
          %15 = affine.load %arg2[%arg7, %13] : memref<?x2100xf64>
          %16 = affine.load %arg3[%13] : memref<?xf64>
          %17 = arith.mulf %15, %16 : f64
          %18 = arith.addf %14, %17 : f64
          affine.store %18, %arg5[%arg7] : memref<?xf64>
          %19 = affine.apply #map5(%arg8)
          %20 = affine.load %arg5[%arg7] : memref<?xf64>
          %21 = affine.load %arg2[%arg7, %19] : memref<?x2100xf64>
          %22 = affine.load %arg3[%19] : memref<?xf64>
          %23 = arith.mulf %21, %22 : f64
          %24 = arith.addf %20, %23 : f64
          affine.store %24, %arg5[%arg7] : memref<?xf64>
          %25 = affine.apply #map6(%arg8)
          %26 = affine.load %arg5[%arg7] : memref<?xf64>
          %27 = affine.load %arg2[%arg7, %25] : memref<?x2100xf64>
          %28 = affine.load %arg3[%25] : memref<?xf64>
          %29 = arith.mulf %27, %28 : f64
          %30 = arith.addf %26, %29 : f64
          affine.store %30, %arg5[%arg7] : memref<?xf64>
          %31 = affine.apply #map7(%arg8)
          %32 = affine.load %arg5[%arg7] : memref<?xf64>
          %33 = affine.load %arg2[%arg7, %31] : memref<?x2100xf64>
          %34 = affine.load %arg3[%31] : memref<?xf64>
          %35 = arith.mulf %33, %34 : f64
          %36 = arith.addf %32, %35 : f64
          affine.store %36, %arg5[%arg7] : memref<?xf64>
          %37 = affine.apply #map8(%arg8)
          %38 = affine.load %arg5[%arg7] : memref<?xf64>
          %39 = affine.load %arg2[%arg7, %37] : memref<?x2100xf64>
          %40 = affine.load %arg3[%37] : memref<?xf64>
          %41 = arith.mulf %39, %40 : f64
          %42 = arith.addf %38, %41 : f64
          affine.store %42, %arg5[%arg7] : memref<?xf64>
        }
        affine.for %arg8 = #map10()[%0] to #map11()[%0] step 2 {
          %2 = affine.load %arg5[%arg7] : memref<?xf64>
          %3 = affine.load %arg2[%arg7, %arg8] : memref<?x2100xf64>
          %4 = affine.load %arg3[%arg8] : memref<?xf64>
          %5 = arith.mulf %3, %4 : f64
          %6 = arith.addf %2, %5 : f64
          affine.store %6, %arg5[%arg7] : memref<?xf64>
          %7 = affine.apply #map3(%arg8)
          %8 = affine.load %arg5[%arg7] : memref<?xf64>
          %9 = affine.load %arg2[%arg7, %7] : memref<?x2100xf64>
          %10 = affine.load %arg3[%7] : memref<?xf64>
          %11 = arith.mulf %9, %10 : f64
          %12 = arith.addf %8, %11 : f64
          affine.store %12, %arg5[%arg7] : memref<?xf64>
        }
        affine.for %arg8 = #map11()[%0] to %0 {
          %2 = affine.load %arg5[%arg7] : memref<?xf64>
          %3 = affine.load %arg2[%arg7, %arg8] : memref<?x2100xf64>
          %4 = affine.load %arg3[%arg8] : memref<?xf64>
          %5 = arith.mulf %3, %4 : f64
          %6 = arith.addf %2, %5 : f64
          affine.store %6, %arg5[%arg7] : memref<?xf64>
        }
        affine.for %arg8 = 0 to #map2()[%0] step 14 {
          %2 = affine.load %arg4[%arg8] : memref<?xf64>
          %3 = affine.load %arg2[%arg7, %arg8] : memref<?x2100xf64>
          %4 = affine.load %arg5[%arg7] : memref<?xf64>
          %5 = arith.mulf %3, %4 : f64
          %6 = arith.addf %2, %5 : f64
          affine.store %6, %arg4[%arg8] : memref<?xf64>
          %7 = affine.apply #map3(%arg8)
          %8 = affine.load %arg4[%7] : memref<?xf64>
          %9 = affine.load %arg2[%arg7, %7] : memref<?x2100xf64>
          %10 = affine.load %arg5[%arg7] : memref<?xf64>
          %11 = arith.mulf %9, %10 : f64
          %12 = arith.addf %8, %11 : f64
          affine.store %12, %arg4[%7] : memref<?xf64>
          %13 = affine.apply #map4(%arg8)
          %14 = affine.load %arg4[%13] : memref<?xf64>
          %15 = affine.load %arg2[%arg7, %13] : memref<?x2100xf64>
          %16 = affine.load %arg5[%arg7] : memref<?xf64>
          %17 = arith.mulf %15, %16 : f64
          %18 = arith.addf %14, %17 : f64
          affine.store %18, %arg4[%13] : memref<?xf64>
          %19 = affine.apply #map5(%arg8)
          %20 = affine.load %arg4[%19] : memref<?xf64>
          %21 = affine.load %arg2[%arg7, %19] : memref<?x2100xf64>
          %22 = affine.load %arg5[%arg7] : memref<?xf64>
          %23 = arith.mulf %21, %22 : f64
          %24 = arith.addf %20, %23 : f64
          affine.store %24, %arg4[%19] : memref<?xf64>
          %25 = affine.apply #map6(%arg8)
          %26 = affine.load %arg4[%25] : memref<?xf64>
          %27 = affine.load %arg2[%arg7, %25] : memref<?x2100xf64>
          %28 = affine.load %arg5[%arg7] : memref<?xf64>
          %29 = arith.mulf %27, %28 : f64
          %30 = arith.addf %26, %29 : f64
          affine.store %30, %arg4[%25] : memref<?xf64>
          %31 = affine.apply #map7(%arg8)
          %32 = affine.load %arg4[%31] : memref<?xf64>
          %33 = affine.load %arg2[%arg7, %31] : memref<?x2100xf64>
          %34 = affine.load %arg5[%arg7] : memref<?xf64>
          %35 = arith.mulf %33, %34 : f64
          %36 = arith.addf %32, %35 : f64
          affine.store %36, %arg4[%31] : memref<?xf64>
          %37 = affine.apply #map8(%arg8)
          %38 = affine.load %arg4[%37] : memref<?xf64>
          %39 = affine.load %arg2[%arg7, %37] : memref<?x2100xf64>
          %40 = affine.load %arg5[%arg7] : memref<?xf64>
          %41 = arith.mulf %39, %40 : f64
          %42 = arith.addf %38, %41 : f64
          affine.store %42, %arg4[%37] : memref<?xf64>
          %43 = affine.apply #map9(%arg8)
          %44 = affine.load %arg4[%43] : memref<?xf64>
          %45 = affine.load %arg2[%arg7, %43] : memref<?x2100xf64>
          %46 = affine.load %arg5[%arg7] : memref<?xf64>
          %47 = arith.mulf %45, %46 : f64
          %48 = arith.addf %44, %47 : f64
          affine.store %48, %arg4[%43] : memref<?xf64>
          %49 = affine.apply #map3(%43)
          %50 = affine.load %arg4[%49] : memref<?xf64>
          %51 = affine.load %arg2[%arg7, %49] : memref<?x2100xf64>
          %52 = affine.load %arg5[%arg7] : memref<?xf64>
          %53 = arith.mulf %51, %52 : f64
          %54 = arith.addf %50, %53 : f64
          affine.store %54, %arg4[%49] : memref<?xf64>
          %55 = affine.apply #map4(%43)
          %56 = affine.load %arg4[%55] : memref<?xf64>
          %57 = affine.load %arg2[%arg7, %55] : memref<?x2100xf64>
          %58 = affine.load %arg5[%arg7] : memref<?xf64>
          %59 = arith.mulf %57, %58 : f64
          %60 = arith.addf %56, %59 : f64
          affine.store %60, %arg4[%55] : memref<?xf64>
          %61 = affine.apply #map5(%43)
          %62 = affine.load %arg4[%61] : memref<?xf64>
          %63 = affine.load %arg2[%arg7, %61] : memref<?x2100xf64>
          %64 = affine.load %arg5[%arg7] : memref<?xf64>
          %65 = arith.mulf %63, %64 : f64
          %66 = arith.addf %62, %65 : f64
          affine.store %66, %arg4[%61] : memref<?xf64>
          %67 = affine.apply #map6(%43)
          %68 = affine.load %arg4[%67] : memref<?xf64>
          %69 = affine.load %arg2[%arg7, %67] : memref<?x2100xf64>
          %70 = affine.load %arg5[%arg7] : memref<?xf64>
          %71 = arith.mulf %69, %70 : f64
          %72 = arith.addf %68, %71 : f64
          affine.store %72, %arg4[%67] : memref<?xf64>
          %73 = affine.apply #map7(%43)
          %74 = affine.load %arg4[%73] : memref<?xf64>
          %75 = affine.load %arg2[%arg7, %73] : memref<?x2100xf64>
          %76 = affine.load %arg5[%arg7] : memref<?xf64>
          %77 = arith.mulf %75, %76 : f64
          %78 = arith.addf %74, %77 : f64
          affine.store %78, %arg4[%73] : memref<?xf64>
          %79 = affine.apply #map8(%43)
          %80 = affine.load %arg4[%79] : memref<?xf64>
          %81 = affine.load %arg2[%arg7, %79] : memref<?x2100xf64>
          %82 = affine.load %arg5[%arg7] : memref<?xf64>
          %83 = arith.mulf %81, %82 : f64
          %84 = arith.addf %80, %83 : f64
          affine.store %84, %arg4[%79] : memref<?xf64>
        }
        affine.for %arg8 = #map2()[%0] to #map10()[%0] step 7 {
          %2 = affine.load %arg4[%arg8] : memref<?xf64>
          %3 = affine.load %arg2[%arg7, %arg8] : memref<?x2100xf64>
          %4 = affine.load %arg5[%arg7] : memref<?xf64>
          %5 = arith.mulf %3, %4 : f64
          %6 = arith.addf %2, %5 : f64
          affine.store %6, %arg4[%arg8] : memref<?xf64>
          %7 = affine.apply #map3(%arg8)
          %8 = affine.load %arg4[%7] : memref<?xf64>
          %9 = affine.load %arg2[%arg7, %7] : memref<?x2100xf64>
          %10 = affine.load %arg5[%arg7] : memref<?xf64>
          %11 = arith.mulf %9, %10 : f64
          %12 = arith.addf %8, %11 : f64
          affine.store %12, %arg4[%7] : memref<?xf64>
          %13 = affine.apply #map4(%arg8)
          %14 = affine.load %arg4[%13] : memref<?xf64>
          %15 = affine.load %arg2[%arg7, %13] : memref<?x2100xf64>
          %16 = affine.load %arg5[%arg7] : memref<?xf64>
          %17 = arith.mulf %15, %16 : f64
          %18 = arith.addf %14, %17 : f64
          affine.store %18, %arg4[%13] : memref<?xf64>
          %19 = affine.apply #map5(%arg8)
          %20 = affine.load %arg4[%19] : memref<?xf64>
          %21 = affine.load %arg2[%arg7, %19] : memref<?x2100xf64>
          %22 = affine.load %arg5[%arg7] : memref<?xf64>
          %23 = arith.mulf %21, %22 : f64
          %24 = arith.addf %20, %23 : f64
          affine.store %24, %arg4[%19] : memref<?xf64>
          %25 = affine.apply #map6(%arg8)
          %26 = affine.load %arg4[%25] : memref<?xf64>
          %27 = affine.load %arg2[%arg7, %25] : memref<?x2100xf64>
          %28 = affine.load %arg5[%arg7] : memref<?xf64>
          %29 = arith.mulf %27, %28 : f64
          %30 = arith.addf %26, %29 : f64
          affine.store %30, %arg4[%25] : memref<?xf64>
          %31 = affine.apply #map7(%arg8)
          %32 = affine.load %arg4[%31] : memref<?xf64>
          %33 = affine.load %arg2[%arg7, %31] : memref<?x2100xf64>
          %34 = affine.load %arg5[%arg7] : memref<?xf64>
          %35 = arith.mulf %33, %34 : f64
          %36 = arith.addf %32, %35 : f64
          affine.store %36, %arg4[%31] : memref<?xf64>
          %37 = affine.apply #map8(%arg8)
          %38 = affine.load %arg4[%37] : memref<?xf64>
          %39 = affine.load %arg2[%arg7, %37] : memref<?x2100xf64>
          %40 = affine.load %arg5[%arg7] : memref<?xf64>
          %41 = arith.mulf %39, %40 : f64
          %42 = arith.addf %38, %41 : f64
          affine.store %42, %arg4[%37] : memref<?xf64>
        }
        affine.for %arg8 = #map10()[%0] to #map11()[%0] step 2 {
          %2 = affine.load %arg4[%arg8] : memref<?xf64>
          %3 = affine.load %arg2[%arg7, %arg8] : memref<?x2100xf64>
          %4 = affine.load %arg5[%arg7] : memref<?xf64>
          %5 = arith.mulf %3, %4 : f64
          %6 = arith.addf %2, %5 : f64
          affine.store %6, %arg4[%arg8] : memref<?xf64>
          %7 = affine.apply #map3(%arg8)
          %8 = affine.load %arg4[%7] : memref<?xf64>
          %9 = affine.load %arg2[%arg7, %7] : memref<?x2100xf64>
          %10 = affine.load %arg5[%arg7] : memref<?xf64>
          %11 = arith.mulf %9, %10 : f64
          %12 = arith.addf %8, %11 : f64
          affine.store %12, %arg4[%7] : memref<?xf64>
        }
        affine.for %arg8 = #map11()[%0] to %0 {
          %2 = affine.load %arg4[%arg8] : memref<?xf64>
          %3 = affine.load %arg2[%arg7, %arg8] : memref<?x2100xf64>
          %4 = affine.load %arg5[%arg7] : memref<?xf64>
          %5 = arith.mulf %3, %4 : f64
          %6 = arith.addf %2, %5 : f64
          affine.store %6, %arg4[%arg8] : memref<?xf64>
        }
      }
    }
    return
  }
}

