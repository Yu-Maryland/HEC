#map = affine_map<()[s0] -> (((s0 floordiv 4) floordiv 5) * 20)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0 + 3)>
#map4 = affine_map<(d0) -> (d0 + 4)>
#map5 = affine_map<(d0) -> (d0 + 8)>
#map6 = affine_map<(d0) -> (d0 + 12)>
#map7 = affine_map<(d0) -> (d0 + 16)>
#map8 = affine_map<()[s0] -> ((s0 floordiv 4) * 4)>
#map9 = affine_map<()[s0] -> ((s0 floordiv 4) * 4 + ((s0 mod 4) floordiv 5) * 5)>
#map10 = affine_map<(d0) -> (d0)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_covariance(%arg0: i32, %arg1: i32, %arg2: f64, %arg3: memref<?x1200xf64>, %arg4: memref<?x1200xf64>, %arg5: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 0.000000e+00 : f64
    %cst_0 = arith.constant 1.000000e+00 : f64
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg0 : i32 to index
    affine.for %arg6 = 0 to %1 {
      affine.store %cst, %arg5[%arg6] : memref<?xf64>
      affine.for %arg7 = 0 to #map()[%0] step 20 {
        %5 = affine.load %arg3[%arg7, %arg6] : memref<?x1200xf64>
        %6 = affine.load %arg5[%arg6] : memref<?xf64>
        %7 = arith.addf %6, %5 : f64
        affine.store %7, %arg5[%arg6] : memref<?xf64>
        %8 = affine.apply #map1(%arg7)
        %9 = affine.load %arg3[%8, %arg6] : memref<?x1200xf64>
        %10 = affine.load %arg5[%arg6] : memref<?xf64>
        %11 = arith.addf %10, %9 : f64
        affine.store %11, %arg5[%arg6] : memref<?xf64>
        %12 = affine.apply #map2(%arg7)
        %13 = affine.load %arg3[%12, %arg6] : memref<?x1200xf64>
        %14 = affine.load %arg5[%arg6] : memref<?xf64>
        %15 = arith.addf %14, %13 : f64
        affine.store %15, %arg5[%arg6] : memref<?xf64>
        %16 = affine.apply #map3(%arg7)
        %17 = affine.load %arg3[%16, %arg6] : memref<?x1200xf64>
        %18 = affine.load %arg5[%arg6] : memref<?xf64>
        %19 = arith.addf %18, %17 : f64
        affine.store %19, %arg5[%arg6] : memref<?xf64>
        %20 = affine.apply #map4(%arg7)
        %21 = affine.load %arg3[%20, %arg6] : memref<?x1200xf64>
        %22 = affine.load %arg5[%arg6] : memref<?xf64>
        %23 = arith.addf %22, %21 : f64
        affine.store %23, %arg5[%arg6] : memref<?xf64>
        %24 = affine.apply #map1(%20)
        %25 = affine.load %arg3[%24, %arg6] : memref<?x1200xf64>
        %26 = affine.load %arg5[%arg6] : memref<?xf64>
        %27 = arith.addf %26, %25 : f64
        affine.store %27, %arg5[%arg6] : memref<?xf64>
        %28 = affine.apply #map2(%20)
        %29 = affine.load %arg3[%28, %arg6] : memref<?x1200xf64>
        %30 = affine.load %arg5[%arg6] : memref<?xf64>
        %31 = arith.addf %30, %29 : f64
        affine.store %31, %arg5[%arg6] : memref<?xf64>
        %32 = affine.apply #map3(%20)
        %33 = affine.load %arg3[%32, %arg6] : memref<?x1200xf64>
        %34 = affine.load %arg5[%arg6] : memref<?xf64>
        %35 = arith.addf %34, %33 : f64
        affine.store %35, %arg5[%arg6] : memref<?xf64>
        %36 = affine.apply #map5(%arg7)
        %37 = affine.load %arg3[%36, %arg6] : memref<?x1200xf64>
        %38 = affine.load %arg5[%arg6] : memref<?xf64>
        %39 = arith.addf %38, %37 : f64
        affine.store %39, %arg5[%arg6] : memref<?xf64>
        %40 = affine.apply #map1(%36)
        %41 = affine.load %arg3[%40, %arg6] : memref<?x1200xf64>
        %42 = affine.load %arg5[%arg6] : memref<?xf64>
        %43 = arith.addf %42, %41 : f64
        affine.store %43, %arg5[%arg6] : memref<?xf64>
        %44 = affine.apply #map2(%36)
        %45 = affine.load %arg3[%44, %arg6] : memref<?x1200xf64>
        %46 = affine.load %arg5[%arg6] : memref<?xf64>
        %47 = arith.addf %46, %45 : f64
        affine.store %47, %arg5[%arg6] : memref<?xf64>
        %48 = affine.apply #map3(%36)
        %49 = affine.load %arg3[%48, %arg6] : memref<?x1200xf64>
        %50 = affine.load %arg5[%arg6] : memref<?xf64>
        %51 = arith.addf %50, %49 : f64
        affine.store %51, %arg5[%arg6] : memref<?xf64>
        %52 = affine.apply #map6(%arg7)
        %53 = affine.load %arg3[%52, %arg6] : memref<?x1200xf64>
        %54 = affine.load %arg5[%arg6] : memref<?xf64>
        %55 = arith.addf %54, %53 : f64
        affine.store %55, %arg5[%arg6] : memref<?xf64>
        %56 = affine.apply #map1(%52)
        %57 = affine.load %arg3[%56, %arg6] : memref<?x1200xf64>
        %58 = affine.load %arg5[%arg6] : memref<?xf64>
        %59 = arith.addf %58, %57 : f64
        affine.store %59, %arg5[%arg6] : memref<?xf64>
        %60 = affine.apply #map2(%52)
        %61 = affine.load %arg3[%60, %arg6] : memref<?x1200xf64>
        %62 = affine.load %arg5[%arg6] : memref<?xf64>
        %63 = arith.addf %62, %61 : f64
        affine.store %63, %arg5[%arg6] : memref<?xf64>
        %64 = affine.apply #map3(%52)
        %65 = affine.load %arg3[%64, %arg6] : memref<?x1200xf64>
        %66 = affine.load %arg5[%arg6] : memref<?xf64>
        %67 = arith.addf %66, %65 : f64
        affine.store %67, %arg5[%arg6] : memref<?xf64>
        %68 = affine.apply #map7(%arg7)
        %69 = affine.load %arg3[%68, %arg6] : memref<?x1200xf64>
        %70 = affine.load %arg5[%arg6] : memref<?xf64>
        %71 = arith.addf %70, %69 : f64
        affine.store %71, %arg5[%arg6] : memref<?xf64>
        %72 = affine.apply #map1(%68)
        %73 = affine.load %arg3[%72, %arg6] : memref<?x1200xf64>
        %74 = affine.load %arg5[%arg6] : memref<?xf64>
        %75 = arith.addf %74, %73 : f64
        affine.store %75, %arg5[%arg6] : memref<?xf64>
        %76 = affine.apply #map2(%68)
        %77 = affine.load %arg3[%76, %arg6] : memref<?x1200xf64>
        %78 = affine.load %arg5[%arg6] : memref<?xf64>
        %79 = arith.addf %78, %77 : f64
        affine.store %79, %arg5[%arg6] : memref<?xf64>
        %80 = affine.apply #map3(%68)
        %81 = affine.load %arg3[%80, %arg6] : memref<?x1200xf64>
        %82 = affine.load %arg5[%arg6] : memref<?xf64>
        %83 = arith.addf %82, %81 : f64
        affine.store %83, %arg5[%arg6] : memref<?xf64>
      }
      affine.for %arg7 = #map()[%0] to #map8()[%0] step 4 {
        %5 = affine.load %arg3[%arg7, %arg6] : memref<?x1200xf64>
        %6 = affine.load %arg5[%arg6] : memref<?xf64>
        %7 = arith.addf %6, %5 : f64
        affine.store %7, %arg5[%arg6] : memref<?xf64>
        %8 = affine.apply #map1(%arg7)
        %9 = affine.load %arg3[%8, %arg6] : memref<?x1200xf64>
        %10 = affine.load %arg5[%arg6] : memref<?xf64>
        %11 = arith.addf %10, %9 : f64
        affine.store %11, %arg5[%arg6] : memref<?xf64>
        %12 = affine.apply #map2(%arg7)
        %13 = affine.load %arg3[%12, %arg6] : memref<?x1200xf64>
        %14 = affine.load %arg5[%arg6] : memref<?xf64>
        %15 = arith.addf %14, %13 : f64
        affine.store %15, %arg5[%arg6] : memref<?xf64>
        %16 = affine.apply #map3(%arg7)
        %17 = affine.load %arg3[%16, %arg6] : memref<?x1200xf64>
        %18 = affine.load %arg5[%arg6] : memref<?xf64>
        %19 = arith.addf %18, %17 : f64
        affine.store %19, %arg5[%arg6] : memref<?xf64>
      }
      affine.for %arg7 = #map8()[%0] to #map9()[%0] step 5 {
        %5 = affine.load %arg3[%arg7, %arg6] : memref<?x1200xf64>
        %6 = affine.load %arg5[%arg6] : memref<?xf64>
        %7 = arith.addf %6, %5 : f64
        affine.store %7, %arg5[%arg6] : memref<?xf64>
        %8 = affine.apply #map1(%arg7)
        %9 = affine.load %arg3[%8, %arg6] : memref<?x1200xf64>
        %10 = affine.load %arg5[%arg6] : memref<?xf64>
        %11 = arith.addf %10, %9 : f64
        affine.store %11, %arg5[%arg6] : memref<?xf64>
        %12 = affine.apply #map2(%arg7)
        %13 = affine.load %arg3[%12, %arg6] : memref<?x1200xf64>
        %14 = affine.load %arg5[%arg6] : memref<?xf64>
        %15 = arith.addf %14, %13 : f64
        affine.store %15, %arg5[%arg6] : memref<?xf64>
        %16 = affine.apply #map3(%arg7)
        %17 = affine.load %arg3[%16, %arg6] : memref<?x1200xf64>
        %18 = affine.load %arg5[%arg6] : memref<?xf64>
        %19 = arith.addf %18, %17 : f64
        affine.store %19, %arg5[%arg6] : memref<?xf64>
        %20 = affine.apply #map4(%arg7)
        %21 = affine.load %arg3[%20, %arg6] : memref<?x1200xf64>
        %22 = affine.load %arg5[%arg6] : memref<?xf64>
        %23 = arith.addf %22, %21 : f64
        affine.store %23, %arg5[%arg6] : memref<?xf64>
      }
      affine.for %arg7 = #map9()[%0] to %0 {
        %5 = affine.load %arg3[%arg7, %arg6] : memref<?x1200xf64>
        %6 = affine.load %arg5[%arg6] : memref<?xf64>
        %7 = arith.addf %6, %5 : f64
        affine.store %7, %arg5[%arg6] : memref<?xf64>
      }
      %3 = affine.load %arg5[%arg6] : memref<?xf64>
      %4 = arith.divf %3, %arg2 : f64
      affine.store %4, %arg5[%arg6] : memref<?xf64>
    }
    affine.for %arg6 = 0 to %0 {
      affine.for %arg7 = 0 to #map()[%1] step 20 {
        %3 = affine.load %arg5[%arg7] : memref<?xf64>
        %4 = affine.load %arg3[%arg6, %arg7] : memref<?x1200xf64>
        %5 = arith.subf %4, %3 : f64
        affine.store %5, %arg3[%arg6, %arg7] : memref<?x1200xf64>
        %6 = affine.apply #map1(%arg7)
        %7 = affine.load %arg5[%6] : memref<?xf64>
        %8 = affine.load %arg3[%arg6, %6] : memref<?x1200xf64>
        %9 = arith.subf %8, %7 : f64
        affine.store %9, %arg3[%arg6, %6] : memref<?x1200xf64>
        %10 = affine.apply #map2(%arg7)
        %11 = affine.load %arg5[%10] : memref<?xf64>
        %12 = affine.load %arg3[%arg6, %10] : memref<?x1200xf64>
        %13 = arith.subf %12, %11 : f64
        affine.store %13, %arg3[%arg6, %10] : memref<?x1200xf64>
        %14 = affine.apply #map3(%arg7)
        %15 = affine.load %arg5[%14] : memref<?xf64>
        %16 = affine.load %arg3[%arg6, %14] : memref<?x1200xf64>
        %17 = arith.subf %16, %15 : f64
        affine.store %17, %arg3[%arg6, %14] : memref<?x1200xf64>
        %18 = affine.apply #map4(%arg7)
        %19 = affine.load %arg5[%18] : memref<?xf64>
        %20 = affine.load %arg3[%arg6, %18] : memref<?x1200xf64>
        %21 = arith.subf %20, %19 : f64
        affine.store %21, %arg3[%arg6, %18] : memref<?x1200xf64>
        %22 = affine.apply #map1(%18)
        %23 = affine.load %arg5[%22] : memref<?xf64>
        %24 = affine.load %arg3[%arg6, %22] : memref<?x1200xf64>
        %25 = arith.subf %24, %23 : f64
        affine.store %25, %arg3[%arg6, %22] : memref<?x1200xf64>
        %26 = affine.apply #map2(%18)
        %27 = affine.load %arg5[%26] : memref<?xf64>
        %28 = affine.load %arg3[%arg6, %26] : memref<?x1200xf64>
        %29 = arith.subf %28, %27 : f64
        affine.store %29, %arg3[%arg6, %26] : memref<?x1200xf64>
        %30 = affine.apply #map3(%18)
        %31 = affine.load %arg5[%30] : memref<?xf64>
        %32 = affine.load %arg3[%arg6, %30] : memref<?x1200xf64>
        %33 = arith.subf %32, %31 : f64
        affine.store %33, %arg3[%arg6, %30] : memref<?x1200xf64>
        %34 = affine.apply #map5(%arg7)
        %35 = affine.load %arg5[%34] : memref<?xf64>
        %36 = affine.load %arg3[%arg6, %34] : memref<?x1200xf64>
        %37 = arith.subf %36, %35 : f64
        affine.store %37, %arg3[%arg6, %34] : memref<?x1200xf64>
        %38 = affine.apply #map1(%34)
        %39 = affine.load %arg5[%38] : memref<?xf64>
        %40 = affine.load %arg3[%arg6, %38] : memref<?x1200xf64>
        %41 = arith.subf %40, %39 : f64
        affine.store %41, %arg3[%arg6, %38] : memref<?x1200xf64>
        %42 = affine.apply #map2(%34)
        %43 = affine.load %arg5[%42] : memref<?xf64>
        %44 = affine.load %arg3[%arg6, %42] : memref<?x1200xf64>
        %45 = arith.subf %44, %43 : f64
        affine.store %45, %arg3[%arg6, %42] : memref<?x1200xf64>
        %46 = affine.apply #map3(%34)
        %47 = affine.load %arg5[%46] : memref<?xf64>
        %48 = affine.load %arg3[%arg6, %46] : memref<?x1200xf64>
        %49 = arith.subf %48, %47 : f64
        affine.store %49, %arg3[%arg6, %46] : memref<?x1200xf64>
        %50 = affine.apply #map6(%arg7)
        %51 = affine.load %arg5[%50] : memref<?xf64>
        %52 = affine.load %arg3[%arg6, %50] : memref<?x1200xf64>
        %53 = arith.subf %52, %51 : f64
        affine.store %53, %arg3[%arg6, %50] : memref<?x1200xf64>
        %54 = affine.apply #map1(%50)
        %55 = affine.load %arg5[%54] : memref<?xf64>
        %56 = affine.load %arg3[%arg6, %54] : memref<?x1200xf64>
        %57 = arith.subf %56, %55 : f64
        affine.store %57, %arg3[%arg6, %54] : memref<?x1200xf64>
        %58 = affine.apply #map2(%50)
        %59 = affine.load %arg5[%58] : memref<?xf64>
        %60 = affine.load %arg3[%arg6, %58] : memref<?x1200xf64>
        %61 = arith.subf %60, %59 : f64
        affine.store %61, %arg3[%arg6, %58] : memref<?x1200xf64>
        %62 = affine.apply #map3(%50)
        %63 = affine.load %arg5[%62] : memref<?xf64>
        %64 = affine.load %arg3[%arg6, %62] : memref<?x1200xf64>
        %65 = arith.subf %64, %63 : f64
        affine.store %65, %arg3[%arg6, %62] : memref<?x1200xf64>
        %66 = affine.apply #map7(%arg7)
        %67 = affine.load %arg5[%66] : memref<?xf64>
        %68 = affine.load %arg3[%arg6, %66] : memref<?x1200xf64>
        %69 = arith.subf %68, %67 : f64
        affine.store %69, %arg3[%arg6, %66] : memref<?x1200xf64>
        %70 = affine.apply #map1(%66)
        %71 = affine.load %arg5[%70] : memref<?xf64>
        %72 = affine.load %arg3[%arg6, %70] : memref<?x1200xf64>
        %73 = arith.subf %72, %71 : f64
        affine.store %73, %arg3[%arg6, %70] : memref<?x1200xf64>
        %74 = affine.apply #map2(%66)
        %75 = affine.load %arg5[%74] : memref<?xf64>
        %76 = affine.load %arg3[%arg6, %74] : memref<?x1200xf64>
        %77 = arith.subf %76, %75 : f64
        affine.store %77, %arg3[%arg6, %74] : memref<?x1200xf64>
        %78 = affine.apply #map3(%66)
        %79 = affine.load %arg5[%78] : memref<?xf64>
        %80 = affine.load %arg3[%arg6, %78] : memref<?x1200xf64>
        %81 = arith.subf %80, %79 : f64
        affine.store %81, %arg3[%arg6, %78] : memref<?x1200xf64>
      }
      affine.for %arg7 = #map()[%1] to #map8()[%1] step 4 {
        %3 = affine.load %arg5[%arg7] : memref<?xf64>
        %4 = affine.load %arg3[%arg6, %arg7] : memref<?x1200xf64>
        %5 = arith.subf %4, %3 : f64
        affine.store %5, %arg3[%arg6, %arg7] : memref<?x1200xf64>
        %6 = affine.apply #map1(%arg7)
        %7 = affine.load %arg5[%6] : memref<?xf64>
        %8 = affine.load %arg3[%arg6, %6] : memref<?x1200xf64>
        %9 = arith.subf %8, %7 : f64
        affine.store %9, %arg3[%arg6, %6] : memref<?x1200xf64>
        %10 = affine.apply #map2(%arg7)
        %11 = affine.load %arg5[%10] : memref<?xf64>
        %12 = affine.load %arg3[%arg6, %10] : memref<?x1200xf64>
        %13 = arith.subf %12, %11 : f64
        affine.store %13, %arg3[%arg6, %10] : memref<?x1200xf64>
        %14 = affine.apply #map3(%arg7)
        %15 = affine.load %arg5[%14] : memref<?xf64>
        %16 = affine.load %arg3[%arg6, %14] : memref<?x1200xf64>
        %17 = arith.subf %16, %15 : f64
        affine.store %17, %arg3[%arg6, %14] : memref<?x1200xf64>
      }
      affine.for %arg7 = #map8()[%1] to #map9()[%1] step 5 {
        %3 = affine.load %arg5[%arg7] : memref<?xf64>
        %4 = affine.load %arg3[%arg6, %arg7] : memref<?x1200xf64>
        %5 = arith.subf %4, %3 : f64
        affine.store %5, %arg3[%arg6, %arg7] : memref<?x1200xf64>
        %6 = affine.apply #map1(%arg7)
        %7 = affine.load %arg5[%6] : memref<?xf64>
        %8 = affine.load %arg3[%arg6, %6] : memref<?x1200xf64>
        %9 = arith.subf %8, %7 : f64
        affine.store %9, %arg3[%arg6, %6] : memref<?x1200xf64>
        %10 = affine.apply #map2(%arg7)
        %11 = affine.load %arg5[%10] : memref<?xf64>
        %12 = affine.load %arg3[%arg6, %10] : memref<?x1200xf64>
        %13 = arith.subf %12, %11 : f64
        affine.store %13, %arg3[%arg6, %10] : memref<?x1200xf64>
        %14 = affine.apply #map3(%arg7)
        %15 = affine.load %arg5[%14] : memref<?xf64>
        %16 = affine.load %arg3[%arg6, %14] : memref<?x1200xf64>
        %17 = arith.subf %16, %15 : f64
        affine.store %17, %arg3[%arg6, %14] : memref<?x1200xf64>
        %18 = affine.apply #map4(%arg7)
        %19 = affine.load %arg5[%18] : memref<?xf64>
        %20 = affine.load %arg3[%arg6, %18] : memref<?x1200xf64>
        %21 = arith.subf %20, %19 : f64
        affine.store %21, %arg3[%arg6, %18] : memref<?x1200xf64>
      }
      affine.for %arg7 = #map9()[%1] to %1 {
        %3 = affine.load %arg5[%arg7] : memref<?xf64>
        %4 = affine.load %arg3[%arg6, %arg7] : memref<?x1200xf64>
        %5 = arith.subf %4, %3 : f64
        affine.store %5, %arg3[%arg6, %arg7] : memref<?x1200xf64>
      }
    }
    %2 = arith.subf %arg2, %cst_0 : f64
    affine.for %arg6 = 0 to %1 {
      affine.for %arg7 = #map10(%arg6) to %1 {
        affine.store %cst, %arg4[%arg6, %arg7] : memref<?x1200xf64>
        affine.for %arg8 = 0 to #map()[%0] step 20 {
          %5 = affine.load %arg3[%arg8, %arg6] : memref<?x1200xf64>
          %6 = affine.load %arg3[%arg8, %arg7] : memref<?x1200xf64>
          %7 = arith.mulf %5, %6 : f64
          %8 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %9 = arith.addf %8, %7 : f64
          affine.store %9, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %10 = affine.apply #map1(%arg8)
          %11 = affine.load %arg3[%10, %arg6] : memref<?x1200xf64>
          %12 = affine.load %arg3[%10, %arg7] : memref<?x1200xf64>
          %13 = arith.mulf %11, %12 : f64
          %14 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %15 = arith.addf %14, %13 : f64
          affine.store %15, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %16 = affine.apply #map2(%arg8)
          %17 = affine.load %arg3[%16, %arg6] : memref<?x1200xf64>
          %18 = affine.load %arg3[%16, %arg7] : memref<?x1200xf64>
          %19 = arith.mulf %17, %18 : f64
          %20 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %21 = arith.addf %20, %19 : f64
          affine.store %21, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %22 = affine.apply #map3(%arg8)
          %23 = affine.load %arg3[%22, %arg6] : memref<?x1200xf64>
          %24 = affine.load %arg3[%22, %arg7] : memref<?x1200xf64>
          %25 = arith.mulf %23, %24 : f64
          %26 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %27 = arith.addf %26, %25 : f64
          affine.store %27, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %28 = affine.apply #map4(%arg8)
          %29 = affine.load %arg3[%28, %arg6] : memref<?x1200xf64>
          %30 = affine.load %arg3[%28, %arg7] : memref<?x1200xf64>
          %31 = arith.mulf %29, %30 : f64
          %32 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %33 = arith.addf %32, %31 : f64
          affine.store %33, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %34 = affine.apply #map1(%28)
          %35 = affine.load %arg3[%34, %arg6] : memref<?x1200xf64>
          %36 = affine.load %arg3[%34, %arg7] : memref<?x1200xf64>
          %37 = arith.mulf %35, %36 : f64
          %38 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %39 = arith.addf %38, %37 : f64
          affine.store %39, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %40 = affine.apply #map2(%28)
          %41 = affine.load %arg3[%40, %arg6] : memref<?x1200xf64>
          %42 = affine.load %arg3[%40, %arg7] : memref<?x1200xf64>
          %43 = arith.mulf %41, %42 : f64
          %44 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %45 = arith.addf %44, %43 : f64
          affine.store %45, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %46 = affine.apply #map3(%28)
          %47 = affine.load %arg3[%46, %arg6] : memref<?x1200xf64>
          %48 = affine.load %arg3[%46, %arg7] : memref<?x1200xf64>
          %49 = arith.mulf %47, %48 : f64
          %50 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %51 = arith.addf %50, %49 : f64
          affine.store %51, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %52 = affine.apply #map5(%arg8)
          %53 = affine.load %arg3[%52, %arg6] : memref<?x1200xf64>
          %54 = affine.load %arg3[%52, %arg7] : memref<?x1200xf64>
          %55 = arith.mulf %53, %54 : f64
          %56 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %57 = arith.addf %56, %55 : f64
          affine.store %57, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %58 = affine.apply #map1(%52)
          %59 = affine.load %arg3[%58, %arg6] : memref<?x1200xf64>
          %60 = affine.load %arg3[%58, %arg7] : memref<?x1200xf64>
          %61 = arith.mulf %59, %60 : f64
          %62 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %63 = arith.addf %62, %61 : f64
          affine.store %63, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %64 = affine.apply #map2(%52)
          %65 = affine.load %arg3[%64, %arg6] : memref<?x1200xf64>
          %66 = affine.load %arg3[%64, %arg7] : memref<?x1200xf64>
          %67 = arith.mulf %65, %66 : f64
          %68 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %69 = arith.addf %68, %67 : f64
          affine.store %69, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %70 = affine.apply #map3(%52)
          %71 = affine.load %arg3[%70, %arg6] : memref<?x1200xf64>
          %72 = affine.load %arg3[%70, %arg7] : memref<?x1200xf64>
          %73 = arith.mulf %71, %72 : f64
          %74 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %75 = arith.addf %74, %73 : f64
          affine.store %75, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %76 = affine.apply #map6(%arg8)
          %77 = affine.load %arg3[%76, %arg6] : memref<?x1200xf64>
          %78 = affine.load %arg3[%76, %arg7] : memref<?x1200xf64>
          %79 = arith.mulf %77, %78 : f64
          %80 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %81 = arith.addf %80, %79 : f64
          affine.store %81, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %82 = affine.apply #map1(%76)
          %83 = affine.load %arg3[%82, %arg6] : memref<?x1200xf64>
          %84 = affine.load %arg3[%82, %arg7] : memref<?x1200xf64>
          %85 = arith.mulf %83, %84 : f64
          %86 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %87 = arith.addf %86, %85 : f64
          affine.store %87, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %88 = affine.apply #map2(%76)
          %89 = affine.load %arg3[%88, %arg6] : memref<?x1200xf64>
          %90 = affine.load %arg3[%88, %arg7] : memref<?x1200xf64>
          %91 = arith.mulf %89, %90 : f64
          %92 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %93 = arith.addf %92, %91 : f64
          affine.store %93, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %94 = affine.apply #map3(%76)
          %95 = affine.load %arg3[%94, %arg6] : memref<?x1200xf64>
          %96 = affine.load %arg3[%94, %arg7] : memref<?x1200xf64>
          %97 = arith.mulf %95, %96 : f64
          %98 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %99 = arith.addf %98, %97 : f64
          affine.store %99, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %100 = affine.apply #map7(%arg8)
          %101 = affine.load %arg3[%100, %arg6] : memref<?x1200xf64>
          %102 = affine.load %arg3[%100, %arg7] : memref<?x1200xf64>
          %103 = arith.mulf %101, %102 : f64
          %104 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %105 = arith.addf %104, %103 : f64
          affine.store %105, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %106 = affine.apply #map1(%100)
          %107 = affine.load %arg3[%106, %arg6] : memref<?x1200xf64>
          %108 = affine.load %arg3[%106, %arg7] : memref<?x1200xf64>
          %109 = arith.mulf %107, %108 : f64
          %110 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %111 = arith.addf %110, %109 : f64
          affine.store %111, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %112 = affine.apply #map2(%100)
          %113 = affine.load %arg3[%112, %arg6] : memref<?x1200xf64>
          %114 = affine.load %arg3[%112, %arg7] : memref<?x1200xf64>
          %115 = arith.mulf %113, %114 : f64
          %116 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %117 = arith.addf %116, %115 : f64
          affine.store %117, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %118 = affine.apply #map3(%100)
          %119 = affine.load %arg3[%118, %arg6] : memref<?x1200xf64>
          %120 = affine.load %arg3[%118, %arg7] : memref<?x1200xf64>
          %121 = arith.mulf %119, %120 : f64
          %122 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %123 = arith.addf %122, %121 : f64
          affine.store %123, %arg4[%arg6, %arg7] : memref<?x1200xf64>
        }
        affine.for %arg8 = #map()[%0] to #map8()[%0] step 4 {
          %5 = affine.load %arg3[%arg8, %arg6] : memref<?x1200xf64>
          %6 = affine.load %arg3[%arg8, %arg7] : memref<?x1200xf64>
          %7 = arith.mulf %5, %6 : f64
          %8 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %9 = arith.addf %8, %7 : f64
          affine.store %9, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %10 = affine.apply #map1(%arg8)
          %11 = affine.load %arg3[%10, %arg6] : memref<?x1200xf64>
          %12 = affine.load %arg3[%10, %arg7] : memref<?x1200xf64>
          %13 = arith.mulf %11, %12 : f64
          %14 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %15 = arith.addf %14, %13 : f64
          affine.store %15, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %16 = affine.apply #map2(%arg8)
          %17 = affine.load %arg3[%16, %arg6] : memref<?x1200xf64>
          %18 = affine.load %arg3[%16, %arg7] : memref<?x1200xf64>
          %19 = arith.mulf %17, %18 : f64
          %20 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %21 = arith.addf %20, %19 : f64
          affine.store %21, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %22 = affine.apply #map3(%arg8)
          %23 = affine.load %arg3[%22, %arg6] : memref<?x1200xf64>
          %24 = affine.load %arg3[%22, %arg7] : memref<?x1200xf64>
          %25 = arith.mulf %23, %24 : f64
          %26 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %27 = arith.addf %26, %25 : f64
          affine.store %27, %arg4[%arg6, %arg7] : memref<?x1200xf64>
        }
        affine.for %arg8 = #map8()[%0] to #map9()[%0] step 5 {
          %5 = affine.load %arg3[%arg8, %arg6] : memref<?x1200xf64>
          %6 = affine.load %arg3[%arg8, %arg7] : memref<?x1200xf64>
          %7 = arith.mulf %5, %6 : f64
          %8 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %9 = arith.addf %8, %7 : f64
          affine.store %9, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %10 = affine.apply #map1(%arg8)
          %11 = affine.load %arg3[%10, %arg6] : memref<?x1200xf64>
          %12 = affine.load %arg3[%10, %arg7] : memref<?x1200xf64>
          %13 = arith.mulf %11, %12 : f64
          %14 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %15 = arith.addf %14, %13 : f64
          affine.store %15, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %16 = affine.apply #map2(%arg8)
          %17 = affine.load %arg3[%16, %arg6] : memref<?x1200xf64>
          %18 = affine.load %arg3[%16, %arg7] : memref<?x1200xf64>
          %19 = arith.mulf %17, %18 : f64
          %20 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %21 = arith.addf %20, %19 : f64
          affine.store %21, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %22 = affine.apply #map3(%arg8)
          %23 = affine.load %arg3[%22, %arg6] : memref<?x1200xf64>
          %24 = affine.load %arg3[%22, %arg7] : memref<?x1200xf64>
          %25 = arith.mulf %23, %24 : f64
          %26 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %27 = arith.addf %26, %25 : f64
          affine.store %27, %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %28 = affine.apply #map4(%arg8)
          %29 = affine.load %arg3[%28, %arg6] : memref<?x1200xf64>
          %30 = affine.load %arg3[%28, %arg7] : memref<?x1200xf64>
          %31 = arith.mulf %29, %30 : f64
          %32 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %33 = arith.addf %32, %31 : f64
          affine.store %33, %arg4[%arg6, %arg7] : memref<?x1200xf64>
        }
        affine.for %arg8 = #map9()[%0] to %0 {
          %5 = affine.load %arg3[%arg8, %arg6] : memref<?x1200xf64>
          %6 = affine.load %arg3[%arg8, %arg7] : memref<?x1200xf64>
          %7 = arith.mulf %5, %6 : f64
          %8 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
          %9 = arith.addf %8, %7 : f64
          affine.store %9, %arg4[%arg6, %arg7] : memref<?x1200xf64>
        }
        %3 = affine.load %arg4[%arg6, %arg7] : memref<?x1200xf64>
        %4 = arith.divf %3, %2 : f64
        affine.store %4, %arg4[%arg6, %arg7] : memref<?x1200xf64>
        affine.store %4, %arg4[%arg7, %arg6] : memref<?x1200xf64>
      }
    }
    return
  }
}

