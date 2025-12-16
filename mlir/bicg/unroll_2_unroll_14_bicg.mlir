#map = affine_map<()[s0] -> (((s0 floordiv 14) floordiv 2) * 28)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0 + 3)>
#map4 = affine_map<(d0) -> (d0 + 4)>
#map5 = affine_map<(d0) -> (d0 + 5)>
#map6 = affine_map<(d0) -> (d0 + 6)>
#map7 = affine_map<(d0) -> (d0 + 7)>
#map8 = affine_map<(d0) -> (d0 + 8)>
#map9 = affine_map<(d0) -> (d0 + 9)>
#map10 = affine_map<(d0) -> (d0 + 10)>
#map11 = affine_map<(d0) -> (d0 + 11)>
#map12 = affine_map<(d0) -> (d0 + 12)>
#map13 = affine_map<(d0) -> (d0 + 13)>
#map14 = affine_map<(d0) -> (d0 + 14)>
#map15 = affine_map<()[s0] -> ((s0 floordiv 14) * 14)>
#map16 = affine_map<()[s0] -> ((s0 floordiv 2) * 2)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_bicg(%arg0: i32, %arg1: i32, %arg2: memref<?x1900xf64>, %arg3: memref<?xf64>, %arg4: memref<?xf64>, %arg5: memref<?xf64>, %arg6: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 0.000000e+00 : f64
    %0 = arith.index_cast %arg0 : i32 to index
    affine.for %arg7 = 0 to #map()[%0] step 28 {
      affine.store %cst, %arg3[%arg7] : memref<?xf64>
      %2 = affine.apply #map1(%arg7)
      affine.store %cst, %arg3[%2] : memref<?xf64>
      %3 = affine.apply #map2(%arg7)
      affine.store %cst, %arg3[%3] : memref<?xf64>
      %4 = affine.apply #map3(%arg7)
      affine.store %cst, %arg3[%4] : memref<?xf64>
      %5 = affine.apply #map4(%arg7)
      affine.store %cst, %arg3[%5] : memref<?xf64>
      %6 = affine.apply #map5(%arg7)
      affine.store %cst, %arg3[%6] : memref<?xf64>
      %7 = affine.apply #map6(%arg7)
      affine.store %cst, %arg3[%7] : memref<?xf64>
      %8 = affine.apply #map7(%arg7)
      affine.store %cst, %arg3[%8] : memref<?xf64>
      %9 = affine.apply #map8(%arg7)
      affine.store %cst, %arg3[%9] : memref<?xf64>
      %10 = affine.apply #map9(%arg7)
      affine.store %cst, %arg3[%10] : memref<?xf64>
      %11 = affine.apply #map10(%arg7)
      affine.store %cst, %arg3[%11] : memref<?xf64>
      %12 = affine.apply #map11(%arg7)
      affine.store %cst, %arg3[%12] : memref<?xf64>
      %13 = affine.apply #map12(%arg7)
      affine.store %cst, %arg3[%13] : memref<?xf64>
      %14 = affine.apply #map13(%arg7)
      affine.store %cst, %arg3[%14] : memref<?xf64>
      %15 = affine.apply #map14(%arg7)
      affine.store %cst, %arg3[%15] : memref<?xf64>
      %16 = affine.apply #map1(%15)
      affine.store %cst, %arg3[%16] : memref<?xf64>
      %17 = affine.apply #map2(%15)
      affine.store %cst, %arg3[%17] : memref<?xf64>
      %18 = affine.apply #map3(%15)
      affine.store %cst, %arg3[%18] : memref<?xf64>
      %19 = affine.apply #map4(%15)
      affine.store %cst, %arg3[%19] : memref<?xf64>
      %20 = affine.apply #map5(%15)
      affine.store %cst, %arg3[%20] : memref<?xf64>
      %21 = affine.apply #map6(%15)
      affine.store %cst, %arg3[%21] : memref<?xf64>
      %22 = affine.apply #map7(%15)
      affine.store %cst, %arg3[%22] : memref<?xf64>
      %23 = affine.apply #map8(%15)
      affine.store %cst, %arg3[%23] : memref<?xf64>
      %24 = affine.apply #map9(%15)
      affine.store %cst, %arg3[%24] : memref<?xf64>
      %25 = affine.apply #map10(%15)
      affine.store %cst, %arg3[%25] : memref<?xf64>
      %26 = affine.apply #map11(%15)
      affine.store %cst, %arg3[%26] : memref<?xf64>
      %27 = affine.apply #map12(%15)
      affine.store %cst, %arg3[%27] : memref<?xf64>
      %28 = affine.apply #map13(%15)
      affine.store %cst, %arg3[%28] : memref<?xf64>
    }
    affine.for %arg7 = #map()[%0] to #map15()[%0] step 14 {
      affine.store %cst, %arg3[%arg7] : memref<?xf64>
      %2 = affine.apply #map1(%arg7)
      affine.store %cst, %arg3[%2] : memref<?xf64>
      %3 = affine.apply #map2(%arg7)
      affine.store %cst, %arg3[%3] : memref<?xf64>
      %4 = affine.apply #map3(%arg7)
      affine.store %cst, %arg3[%4] : memref<?xf64>
      %5 = affine.apply #map4(%arg7)
      affine.store %cst, %arg3[%5] : memref<?xf64>
      %6 = affine.apply #map5(%arg7)
      affine.store %cst, %arg3[%6] : memref<?xf64>
      %7 = affine.apply #map6(%arg7)
      affine.store %cst, %arg3[%7] : memref<?xf64>
      %8 = affine.apply #map7(%arg7)
      affine.store %cst, %arg3[%8] : memref<?xf64>
      %9 = affine.apply #map8(%arg7)
      affine.store %cst, %arg3[%9] : memref<?xf64>
      %10 = affine.apply #map9(%arg7)
      affine.store %cst, %arg3[%10] : memref<?xf64>
      %11 = affine.apply #map10(%arg7)
      affine.store %cst, %arg3[%11] : memref<?xf64>
      %12 = affine.apply #map11(%arg7)
      affine.store %cst, %arg3[%12] : memref<?xf64>
      %13 = affine.apply #map12(%arg7)
      affine.store %cst, %arg3[%13] : memref<?xf64>
      %14 = affine.apply #map13(%arg7)
      affine.store %cst, %arg3[%14] : memref<?xf64>
    }
    affine.for %arg7 = #map15()[%0] to #map16()[%0] step 2 {
      affine.store %cst, %arg3[%arg7] : memref<?xf64>
      %2 = affine.apply #map1(%arg7)
      affine.store %cst, %arg3[%2] : memref<?xf64>
    }
    affine.for %arg7 = #map16()[%0] to %0 {
      affine.store %cst, %arg3[%arg7] : memref<?xf64>
    }
    %1 = arith.index_cast %arg1 : i32 to index
    affine.for %arg7 = 0 to %1 {
      affine.store %cst, %arg4[%arg7] : memref<?xf64>
      affine.for %arg8 = 0 to #map()[%0] step 28 {
        %2 = affine.load %arg3[%arg8] : memref<?xf64>
        %3 = affine.load %arg6[%arg7] : memref<?xf64>
        %4 = affine.load %arg2[%arg7, %arg8] : memref<?x1900xf64>
        %5 = arith.mulf %3, %4 : f64
        %6 = arith.addf %2, %5 : f64
        affine.store %6, %arg3[%arg8] : memref<?xf64>
        %7 = affine.load %arg4[%arg7] : memref<?xf64>
        %8 = affine.load %arg2[%arg7, %arg8] : memref<?x1900xf64>
        %9 = affine.load %arg5[%arg8] : memref<?xf64>
        %10 = arith.mulf %8, %9 : f64
        %11 = arith.addf %7, %10 : f64
        affine.store %11, %arg4[%arg7] : memref<?xf64>
        %12 = affine.apply #map1(%arg8)
        %13 = affine.load %arg3[%12] : memref<?xf64>
        %14 = affine.load %arg6[%arg7] : memref<?xf64>
        %15 = affine.load %arg2[%arg7, %12] : memref<?x1900xf64>
        %16 = arith.mulf %14, %15 : f64
        %17 = arith.addf %13, %16 : f64
        affine.store %17, %arg3[%12] : memref<?xf64>
        %18 = affine.load %arg4[%arg7] : memref<?xf64>
        %19 = affine.load %arg2[%arg7, %12] : memref<?x1900xf64>
        %20 = affine.load %arg5[%12] : memref<?xf64>
        %21 = arith.mulf %19, %20 : f64
        %22 = arith.addf %18, %21 : f64
        affine.store %22, %arg4[%arg7] : memref<?xf64>
        %23 = affine.apply #map2(%arg8)
        %24 = affine.load %arg3[%23] : memref<?xf64>
        %25 = affine.load %arg6[%arg7] : memref<?xf64>
        %26 = affine.load %arg2[%arg7, %23] : memref<?x1900xf64>
        %27 = arith.mulf %25, %26 : f64
        %28 = arith.addf %24, %27 : f64
        affine.store %28, %arg3[%23] : memref<?xf64>
        %29 = affine.load %arg4[%arg7] : memref<?xf64>
        %30 = affine.load %arg2[%arg7, %23] : memref<?x1900xf64>
        %31 = affine.load %arg5[%23] : memref<?xf64>
        %32 = arith.mulf %30, %31 : f64
        %33 = arith.addf %29, %32 : f64
        affine.store %33, %arg4[%arg7] : memref<?xf64>
        %34 = affine.apply #map3(%arg8)
        %35 = affine.load %arg3[%34] : memref<?xf64>
        %36 = affine.load %arg6[%arg7] : memref<?xf64>
        %37 = affine.load %arg2[%arg7, %34] : memref<?x1900xf64>
        %38 = arith.mulf %36, %37 : f64
        %39 = arith.addf %35, %38 : f64
        affine.store %39, %arg3[%34] : memref<?xf64>
        %40 = affine.load %arg4[%arg7] : memref<?xf64>
        %41 = affine.load %arg2[%arg7, %34] : memref<?x1900xf64>
        %42 = affine.load %arg5[%34] : memref<?xf64>
        %43 = arith.mulf %41, %42 : f64
        %44 = arith.addf %40, %43 : f64
        affine.store %44, %arg4[%arg7] : memref<?xf64>
        %45 = affine.apply #map4(%arg8)
        %46 = affine.load %arg3[%45] : memref<?xf64>
        %47 = affine.load %arg6[%arg7] : memref<?xf64>
        %48 = affine.load %arg2[%arg7, %45] : memref<?x1900xf64>
        %49 = arith.mulf %47, %48 : f64
        %50 = arith.addf %46, %49 : f64
        affine.store %50, %arg3[%45] : memref<?xf64>
        %51 = affine.load %arg4[%arg7] : memref<?xf64>
        %52 = affine.load %arg2[%arg7, %45] : memref<?x1900xf64>
        %53 = affine.load %arg5[%45] : memref<?xf64>
        %54 = arith.mulf %52, %53 : f64
        %55 = arith.addf %51, %54 : f64
        affine.store %55, %arg4[%arg7] : memref<?xf64>
        %56 = affine.apply #map5(%arg8)
        %57 = affine.load %arg3[%56] : memref<?xf64>
        %58 = affine.load %arg6[%arg7] : memref<?xf64>
        %59 = affine.load %arg2[%arg7, %56] : memref<?x1900xf64>
        %60 = arith.mulf %58, %59 : f64
        %61 = arith.addf %57, %60 : f64
        affine.store %61, %arg3[%56] : memref<?xf64>
        %62 = affine.load %arg4[%arg7] : memref<?xf64>
        %63 = affine.load %arg2[%arg7, %56] : memref<?x1900xf64>
        %64 = affine.load %arg5[%56] : memref<?xf64>
        %65 = arith.mulf %63, %64 : f64
        %66 = arith.addf %62, %65 : f64
        affine.store %66, %arg4[%arg7] : memref<?xf64>
        %67 = affine.apply #map6(%arg8)
        %68 = affine.load %arg3[%67] : memref<?xf64>
        %69 = affine.load %arg6[%arg7] : memref<?xf64>
        %70 = affine.load %arg2[%arg7, %67] : memref<?x1900xf64>
        %71 = arith.mulf %69, %70 : f64
        %72 = arith.addf %68, %71 : f64
        affine.store %72, %arg3[%67] : memref<?xf64>
        %73 = affine.load %arg4[%arg7] : memref<?xf64>
        %74 = affine.load %arg2[%arg7, %67] : memref<?x1900xf64>
        %75 = affine.load %arg5[%67] : memref<?xf64>
        %76 = arith.mulf %74, %75 : f64
        %77 = arith.addf %73, %76 : f64
        affine.store %77, %arg4[%arg7] : memref<?xf64>
        %78 = affine.apply #map7(%arg8)
        %79 = affine.load %arg3[%78] : memref<?xf64>
        %80 = affine.load %arg6[%arg7] : memref<?xf64>
        %81 = affine.load %arg2[%arg7, %78] : memref<?x1900xf64>
        %82 = arith.mulf %80, %81 : f64
        %83 = arith.addf %79, %82 : f64
        affine.store %83, %arg3[%78] : memref<?xf64>
        %84 = affine.load %arg4[%arg7] : memref<?xf64>
        %85 = affine.load %arg2[%arg7, %78] : memref<?x1900xf64>
        %86 = affine.load %arg5[%78] : memref<?xf64>
        %87 = arith.mulf %85, %86 : f64
        %88 = arith.addf %84, %87 : f64
        affine.store %88, %arg4[%arg7] : memref<?xf64>
        %89 = affine.apply #map8(%arg8)
        %90 = affine.load %arg3[%89] : memref<?xf64>
        %91 = affine.load %arg6[%arg7] : memref<?xf64>
        %92 = affine.load %arg2[%arg7, %89] : memref<?x1900xf64>
        %93 = arith.mulf %91, %92 : f64
        %94 = arith.addf %90, %93 : f64
        affine.store %94, %arg3[%89] : memref<?xf64>
        %95 = affine.load %arg4[%arg7] : memref<?xf64>
        %96 = affine.load %arg2[%arg7, %89] : memref<?x1900xf64>
        %97 = affine.load %arg5[%89] : memref<?xf64>
        %98 = arith.mulf %96, %97 : f64
        %99 = arith.addf %95, %98 : f64
        affine.store %99, %arg4[%arg7] : memref<?xf64>
        %100 = affine.apply #map9(%arg8)
        %101 = affine.load %arg3[%100] : memref<?xf64>
        %102 = affine.load %arg6[%arg7] : memref<?xf64>
        %103 = affine.load %arg2[%arg7, %100] : memref<?x1900xf64>
        %104 = arith.mulf %102, %103 : f64
        %105 = arith.addf %101, %104 : f64
        affine.store %105, %arg3[%100] : memref<?xf64>
        %106 = affine.load %arg4[%arg7] : memref<?xf64>
        %107 = affine.load %arg2[%arg7, %100] : memref<?x1900xf64>
        %108 = affine.load %arg5[%100] : memref<?xf64>
        %109 = arith.mulf %107, %108 : f64
        %110 = arith.addf %106, %109 : f64
        affine.store %110, %arg4[%arg7] : memref<?xf64>
        %111 = affine.apply #map10(%arg8)
        %112 = affine.load %arg3[%111] : memref<?xf64>
        %113 = affine.load %arg6[%arg7] : memref<?xf64>
        %114 = affine.load %arg2[%arg7, %111] : memref<?x1900xf64>
        %115 = arith.mulf %113, %114 : f64
        %116 = arith.addf %112, %115 : f64
        affine.store %116, %arg3[%111] : memref<?xf64>
        %117 = affine.load %arg4[%arg7] : memref<?xf64>
        %118 = affine.load %arg2[%arg7, %111] : memref<?x1900xf64>
        %119 = affine.load %arg5[%111] : memref<?xf64>
        %120 = arith.mulf %118, %119 : f64
        %121 = arith.addf %117, %120 : f64
        affine.store %121, %arg4[%arg7] : memref<?xf64>
        %122 = affine.apply #map11(%arg8)
        %123 = affine.load %arg3[%122] : memref<?xf64>
        %124 = affine.load %arg6[%arg7] : memref<?xf64>
        %125 = affine.load %arg2[%arg7, %122] : memref<?x1900xf64>
        %126 = arith.mulf %124, %125 : f64
        %127 = arith.addf %123, %126 : f64
        affine.store %127, %arg3[%122] : memref<?xf64>
        %128 = affine.load %arg4[%arg7] : memref<?xf64>
        %129 = affine.load %arg2[%arg7, %122] : memref<?x1900xf64>
        %130 = affine.load %arg5[%122] : memref<?xf64>
        %131 = arith.mulf %129, %130 : f64
        %132 = arith.addf %128, %131 : f64
        affine.store %132, %arg4[%arg7] : memref<?xf64>
        %133 = affine.apply #map12(%arg8)
        %134 = affine.load %arg3[%133] : memref<?xf64>
        %135 = affine.load %arg6[%arg7] : memref<?xf64>
        %136 = affine.load %arg2[%arg7, %133] : memref<?x1900xf64>
        %137 = arith.mulf %135, %136 : f64
        %138 = arith.addf %134, %137 : f64
        affine.store %138, %arg3[%133] : memref<?xf64>
        %139 = affine.load %arg4[%arg7] : memref<?xf64>
        %140 = affine.load %arg2[%arg7, %133] : memref<?x1900xf64>
        %141 = affine.load %arg5[%133] : memref<?xf64>
        %142 = arith.mulf %140, %141 : f64
        %143 = arith.addf %139, %142 : f64
        affine.store %143, %arg4[%arg7] : memref<?xf64>
        %144 = affine.apply #map13(%arg8)
        %145 = affine.load %arg3[%144] : memref<?xf64>
        %146 = affine.load %arg6[%arg7] : memref<?xf64>
        %147 = affine.load %arg2[%arg7, %144] : memref<?x1900xf64>
        %148 = arith.mulf %146, %147 : f64
        %149 = arith.addf %145, %148 : f64
        affine.store %149, %arg3[%144] : memref<?xf64>
        %150 = affine.load %arg4[%arg7] : memref<?xf64>
        %151 = affine.load %arg2[%arg7, %144] : memref<?x1900xf64>
        %152 = affine.load %arg5[%144] : memref<?xf64>
        %153 = arith.mulf %151, %152 : f64
        %154 = arith.addf %150, %153 : f64
        affine.store %154, %arg4[%arg7] : memref<?xf64>
        %155 = affine.apply #map14(%arg8)
        %156 = affine.load %arg3[%155] : memref<?xf64>
        %157 = affine.load %arg6[%arg7] : memref<?xf64>
        %158 = affine.load %arg2[%arg7, %155] : memref<?x1900xf64>
        %159 = arith.mulf %157, %158 : f64
        %160 = arith.addf %156, %159 : f64
        affine.store %160, %arg3[%155] : memref<?xf64>
        %161 = affine.load %arg4[%arg7] : memref<?xf64>
        %162 = affine.load %arg2[%arg7, %155] : memref<?x1900xf64>
        %163 = affine.load %arg5[%155] : memref<?xf64>
        %164 = arith.mulf %162, %163 : f64
        %165 = arith.addf %161, %164 : f64
        affine.store %165, %arg4[%arg7] : memref<?xf64>
        %166 = affine.apply #map1(%155)
        %167 = affine.load %arg3[%166] : memref<?xf64>
        %168 = affine.load %arg6[%arg7] : memref<?xf64>
        %169 = affine.load %arg2[%arg7, %166] : memref<?x1900xf64>
        %170 = arith.mulf %168, %169 : f64
        %171 = arith.addf %167, %170 : f64
        affine.store %171, %arg3[%166] : memref<?xf64>
        %172 = affine.load %arg4[%arg7] : memref<?xf64>
        %173 = affine.load %arg2[%arg7, %166] : memref<?x1900xf64>
        %174 = affine.load %arg5[%166] : memref<?xf64>
        %175 = arith.mulf %173, %174 : f64
        %176 = arith.addf %172, %175 : f64
        affine.store %176, %arg4[%arg7] : memref<?xf64>
        %177 = affine.apply #map2(%155)
        %178 = affine.load %arg3[%177] : memref<?xf64>
        %179 = affine.load %arg6[%arg7] : memref<?xf64>
        %180 = affine.load %arg2[%arg7, %177] : memref<?x1900xf64>
        %181 = arith.mulf %179, %180 : f64
        %182 = arith.addf %178, %181 : f64
        affine.store %182, %arg3[%177] : memref<?xf64>
        %183 = affine.load %arg4[%arg7] : memref<?xf64>
        %184 = affine.load %arg2[%arg7, %177] : memref<?x1900xf64>
        %185 = affine.load %arg5[%177] : memref<?xf64>
        %186 = arith.mulf %184, %185 : f64
        %187 = arith.addf %183, %186 : f64
        affine.store %187, %arg4[%arg7] : memref<?xf64>
        %188 = affine.apply #map3(%155)
        %189 = affine.load %arg3[%188] : memref<?xf64>
        %190 = affine.load %arg6[%arg7] : memref<?xf64>
        %191 = affine.load %arg2[%arg7, %188] : memref<?x1900xf64>
        %192 = arith.mulf %190, %191 : f64
        %193 = arith.addf %189, %192 : f64
        affine.store %193, %arg3[%188] : memref<?xf64>
        %194 = affine.load %arg4[%arg7] : memref<?xf64>
        %195 = affine.load %arg2[%arg7, %188] : memref<?x1900xf64>
        %196 = affine.load %arg5[%188] : memref<?xf64>
        %197 = arith.mulf %195, %196 : f64
        %198 = arith.addf %194, %197 : f64
        affine.store %198, %arg4[%arg7] : memref<?xf64>
        %199 = affine.apply #map4(%155)
        %200 = affine.load %arg3[%199] : memref<?xf64>
        %201 = affine.load %arg6[%arg7] : memref<?xf64>
        %202 = affine.load %arg2[%arg7, %199] : memref<?x1900xf64>
        %203 = arith.mulf %201, %202 : f64
        %204 = arith.addf %200, %203 : f64
        affine.store %204, %arg3[%199] : memref<?xf64>
        %205 = affine.load %arg4[%arg7] : memref<?xf64>
        %206 = affine.load %arg2[%arg7, %199] : memref<?x1900xf64>
        %207 = affine.load %arg5[%199] : memref<?xf64>
        %208 = arith.mulf %206, %207 : f64
        %209 = arith.addf %205, %208 : f64
        affine.store %209, %arg4[%arg7] : memref<?xf64>
        %210 = affine.apply #map5(%155)
        %211 = affine.load %arg3[%210] : memref<?xf64>
        %212 = affine.load %arg6[%arg7] : memref<?xf64>
        %213 = affine.load %arg2[%arg7, %210] : memref<?x1900xf64>
        %214 = arith.mulf %212, %213 : f64
        %215 = arith.addf %211, %214 : f64
        affine.store %215, %arg3[%210] : memref<?xf64>
        %216 = affine.load %arg4[%arg7] : memref<?xf64>
        %217 = affine.load %arg2[%arg7, %210] : memref<?x1900xf64>
        %218 = affine.load %arg5[%210] : memref<?xf64>
        %219 = arith.mulf %217, %218 : f64
        %220 = arith.addf %216, %219 : f64
        affine.store %220, %arg4[%arg7] : memref<?xf64>
        %221 = affine.apply #map6(%155)
        %222 = affine.load %arg3[%221] : memref<?xf64>
        %223 = affine.load %arg6[%arg7] : memref<?xf64>
        %224 = affine.load %arg2[%arg7, %221] : memref<?x1900xf64>
        %225 = arith.mulf %223, %224 : f64
        %226 = arith.addf %222, %225 : f64
        affine.store %226, %arg3[%221] : memref<?xf64>
        %227 = affine.load %arg4[%arg7] : memref<?xf64>
        %228 = affine.load %arg2[%arg7, %221] : memref<?x1900xf64>
        %229 = affine.load %arg5[%221] : memref<?xf64>
        %230 = arith.mulf %228, %229 : f64
        %231 = arith.addf %227, %230 : f64
        affine.store %231, %arg4[%arg7] : memref<?xf64>
        %232 = affine.apply #map7(%155)
        %233 = affine.load %arg3[%232] : memref<?xf64>
        %234 = affine.load %arg6[%arg7] : memref<?xf64>
        %235 = affine.load %arg2[%arg7, %232] : memref<?x1900xf64>
        %236 = arith.mulf %234, %235 : f64
        %237 = arith.addf %233, %236 : f64
        affine.store %237, %arg3[%232] : memref<?xf64>
        %238 = affine.load %arg4[%arg7] : memref<?xf64>
        %239 = affine.load %arg2[%arg7, %232] : memref<?x1900xf64>
        %240 = affine.load %arg5[%232] : memref<?xf64>
        %241 = arith.mulf %239, %240 : f64
        %242 = arith.addf %238, %241 : f64
        affine.store %242, %arg4[%arg7] : memref<?xf64>
        %243 = affine.apply #map8(%155)
        %244 = affine.load %arg3[%243] : memref<?xf64>
        %245 = affine.load %arg6[%arg7] : memref<?xf64>
        %246 = affine.load %arg2[%arg7, %243] : memref<?x1900xf64>
        %247 = arith.mulf %245, %246 : f64
        %248 = arith.addf %244, %247 : f64
        affine.store %248, %arg3[%243] : memref<?xf64>
        %249 = affine.load %arg4[%arg7] : memref<?xf64>
        %250 = affine.load %arg2[%arg7, %243] : memref<?x1900xf64>
        %251 = affine.load %arg5[%243] : memref<?xf64>
        %252 = arith.mulf %250, %251 : f64
        %253 = arith.addf %249, %252 : f64
        affine.store %253, %arg4[%arg7] : memref<?xf64>
        %254 = affine.apply #map9(%155)
        %255 = affine.load %arg3[%254] : memref<?xf64>
        %256 = affine.load %arg6[%arg7] : memref<?xf64>
        %257 = affine.load %arg2[%arg7, %254] : memref<?x1900xf64>
        %258 = arith.mulf %256, %257 : f64
        %259 = arith.addf %255, %258 : f64
        affine.store %259, %arg3[%254] : memref<?xf64>
        %260 = affine.load %arg4[%arg7] : memref<?xf64>
        %261 = affine.load %arg2[%arg7, %254] : memref<?x1900xf64>
        %262 = affine.load %arg5[%254] : memref<?xf64>
        %263 = arith.mulf %261, %262 : f64
        %264 = arith.addf %260, %263 : f64
        affine.store %264, %arg4[%arg7] : memref<?xf64>
        %265 = affine.apply #map10(%155)
        %266 = affine.load %arg3[%265] : memref<?xf64>
        %267 = affine.load %arg6[%arg7] : memref<?xf64>
        %268 = affine.load %arg2[%arg7, %265] : memref<?x1900xf64>
        %269 = arith.mulf %267, %268 : f64
        %270 = arith.addf %266, %269 : f64
        affine.store %270, %arg3[%265] : memref<?xf64>
        %271 = affine.load %arg4[%arg7] : memref<?xf64>
        %272 = affine.load %arg2[%arg7, %265] : memref<?x1900xf64>
        %273 = affine.load %arg5[%265] : memref<?xf64>
        %274 = arith.mulf %272, %273 : f64
        %275 = arith.addf %271, %274 : f64
        affine.store %275, %arg4[%arg7] : memref<?xf64>
        %276 = affine.apply #map11(%155)
        %277 = affine.load %arg3[%276] : memref<?xf64>
        %278 = affine.load %arg6[%arg7] : memref<?xf64>
        %279 = affine.load %arg2[%arg7, %276] : memref<?x1900xf64>
        %280 = arith.mulf %278, %279 : f64
        %281 = arith.addf %277, %280 : f64
        affine.store %281, %arg3[%276] : memref<?xf64>
        %282 = affine.load %arg4[%arg7] : memref<?xf64>
        %283 = affine.load %arg2[%arg7, %276] : memref<?x1900xf64>
        %284 = affine.load %arg5[%276] : memref<?xf64>
        %285 = arith.mulf %283, %284 : f64
        %286 = arith.addf %282, %285 : f64
        affine.store %286, %arg4[%arg7] : memref<?xf64>
        %287 = affine.apply #map12(%155)
        %288 = affine.load %arg3[%287] : memref<?xf64>
        %289 = affine.load %arg6[%arg7] : memref<?xf64>
        %290 = affine.load %arg2[%arg7, %287] : memref<?x1900xf64>
        %291 = arith.mulf %289, %290 : f64
        %292 = arith.addf %288, %291 : f64
        affine.store %292, %arg3[%287] : memref<?xf64>
        %293 = affine.load %arg4[%arg7] : memref<?xf64>
        %294 = affine.load %arg2[%arg7, %287] : memref<?x1900xf64>
        %295 = affine.load %arg5[%287] : memref<?xf64>
        %296 = arith.mulf %294, %295 : f64
        %297 = arith.addf %293, %296 : f64
        affine.store %297, %arg4[%arg7] : memref<?xf64>
        %298 = affine.apply #map13(%155)
        %299 = affine.load %arg3[%298] : memref<?xf64>
        %300 = affine.load %arg6[%arg7] : memref<?xf64>
        %301 = affine.load %arg2[%arg7, %298] : memref<?x1900xf64>
        %302 = arith.mulf %300, %301 : f64
        %303 = arith.addf %299, %302 : f64
        affine.store %303, %arg3[%298] : memref<?xf64>
        %304 = affine.load %arg4[%arg7] : memref<?xf64>
        %305 = affine.load %arg2[%arg7, %298] : memref<?x1900xf64>
        %306 = affine.load %arg5[%298] : memref<?xf64>
        %307 = arith.mulf %305, %306 : f64
        %308 = arith.addf %304, %307 : f64
        affine.store %308, %arg4[%arg7] : memref<?xf64>
      }
      affine.for %arg8 = #map()[%0] to #map15()[%0] step 14 {
        %2 = affine.load %arg3[%arg8] : memref<?xf64>
        %3 = affine.load %arg6[%arg7] : memref<?xf64>
        %4 = affine.load %arg2[%arg7, %arg8] : memref<?x1900xf64>
        %5 = arith.mulf %3, %4 : f64
        %6 = arith.addf %2, %5 : f64
        affine.store %6, %arg3[%arg8] : memref<?xf64>
        %7 = affine.load %arg4[%arg7] : memref<?xf64>
        %8 = affine.load %arg2[%arg7, %arg8] : memref<?x1900xf64>
        %9 = affine.load %arg5[%arg8] : memref<?xf64>
        %10 = arith.mulf %8, %9 : f64
        %11 = arith.addf %7, %10 : f64
        affine.store %11, %arg4[%arg7] : memref<?xf64>
        %12 = affine.apply #map1(%arg8)
        %13 = affine.load %arg3[%12] : memref<?xf64>
        %14 = affine.load %arg6[%arg7] : memref<?xf64>
        %15 = affine.load %arg2[%arg7, %12] : memref<?x1900xf64>
        %16 = arith.mulf %14, %15 : f64
        %17 = arith.addf %13, %16 : f64
        affine.store %17, %arg3[%12] : memref<?xf64>
        %18 = affine.load %arg4[%arg7] : memref<?xf64>
        %19 = affine.load %arg2[%arg7, %12] : memref<?x1900xf64>
        %20 = affine.load %arg5[%12] : memref<?xf64>
        %21 = arith.mulf %19, %20 : f64
        %22 = arith.addf %18, %21 : f64
        affine.store %22, %arg4[%arg7] : memref<?xf64>
        %23 = affine.apply #map2(%arg8)
        %24 = affine.load %arg3[%23] : memref<?xf64>
        %25 = affine.load %arg6[%arg7] : memref<?xf64>
        %26 = affine.load %arg2[%arg7, %23] : memref<?x1900xf64>
        %27 = arith.mulf %25, %26 : f64
        %28 = arith.addf %24, %27 : f64
        affine.store %28, %arg3[%23] : memref<?xf64>
        %29 = affine.load %arg4[%arg7] : memref<?xf64>
        %30 = affine.load %arg2[%arg7, %23] : memref<?x1900xf64>
        %31 = affine.load %arg5[%23] : memref<?xf64>
        %32 = arith.mulf %30, %31 : f64
        %33 = arith.addf %29, %32 : f64
        affine.store %33, %arg4[%arg7] : memref<?xf64>
        %34 = affine.apply #map3(%arg8)
        %35 = affine.load %arg3[%34] : memref<?xf64>
        %36 = affine.load %arg6[%arg7] : memref<?xf64>
        %37 = affine.load %arg2[%arg7, %34] : memref<?x1900xf64>
        %38 = arith.mulf %36, %37 : f64
        %39 = arith.addf %35, %38 : f64
        affine.store %39, %arg3[%34] : memref<?xf64>
        %40 = affine.load %arg4[%arg7] : memref<?xf64>
        %41 = affine.load %arg2[%arg7, %34] : memref<?x1900xf64>
        %42 = affine.load %arg5[%34] : memref<?xf64>
        %43 = arith.mulf %41, %42 : f64
        %44 = arith.addf %40, %43 : f64
        affine.store %44, %arg4[%arg7] : memref<?xf64>
        %45 = affine.apply #map4(%arg8)
        %46 = affine.load %arg3[%45] : memref<?xf64>
        %47 = affine.load %arg6[%arg7] : memref<?xf64>
        %48 = affine.load %arg2[%arg7, %45] : memref<?x1900xf64>
        %49 = arith.mulf %47, %48 : f64
        %50 = arith.addf %46, %49 : f64
        affine.store %50, %arg3[%45] : memref<?xf64>
        %51 = affine.load %arg4[%arg7] : memref<?xf64>
        %52 = affine.load %arg2[%arg7, %45] : memref<?x1900xf64>
        %53 = affine.load %arg5[%45] : memref<?xf64>
        %54 = arith.mulf %52, %53 : f64
        %55 = arith.addf %51, %54 : f64
        affine.store %55, %arg4[%arg7] : memref<?xf64>
        %56 = affine.apply #map5(%arg8)
        %57 = affine.load %arg3[%56] : memref<?xf64>
        %58 = affine.load %arg6[%arg7] : memref<?xf64>
        %59 = affine.load %arg2[%arg7, %56] : memref<?x1900xf64>
        %60 = arith.mulf %58, %59 : f64
        %61 = arith.addf %57, %60 : f64
        affine.store %61, %arg3[%56] : memref<?xf64>
        %62 = affine.load %arg4[%arg7] : memref<?xf64>
        %63 = affine.load %arg2[%arg7, %56] : memref<?x1900xf64>
        %64 = affine.load %arg5[%56] : memref<?xf64>
        %65 = arith.mulf %63, %64 : f64
        %66 = arith.addf %62, %65 : f64
        affine.store %66, %arg4[%arg7] : memref<?xf64>
        %67 = affine.apply #map6(%arg8)
        %68 = affine.load %arg3[%67] : memref<?xf64>
        %69 = affine.load %arg6[%arg7] : memref<?xf64>
        %70 = affine.load %arg2[%arg7, %67] : memref<?x1900xf64>
        %71 = arith.mulf %69, %70 : f64
        %72 = arith.addf %68, %71 : f64
        affine.store %72, %arg3[%67] : memref<?xf64>
        %73 = affine.load %arg4[%arg7] : memref<?xf64>
        %74 = affine.load %arg2[%arg7, %67] : memref<?x1900xf64>
        %75 = affine.load %arg5[%67] : memref<?xf64>
        %76 = arith.mulf %74, %75 : f64
        %77 = arith.addf %73, %76 : f64
        affine.store %77, %arg4[%arg7] : memref<?xf64>
        %78 = affine.apply #map7(%arg8)
        %79 = affine.load %arg3[%78] : memref<?xf64>
        %80 = affine.load %arg6[%arg7] : memref<?xf64>
        %81 = affine.load %arg2[%arg7, %78] : memref<?x1900xf64>
        %82 = arith.mulf %80, %81 : f64
        %83 = arith.addf %79, %82 : f64
        affine.store %83, %arg3[%78] : memref<?xf64>
        %84 = affine.load %arg4[%arg7] : memref<?xf64>
        %85 = affine.load %arg2[%arg7, %78] : memref<?x1900xf64>
        %86 = affine.load %arg5[%78] : memref<?xf64>
        %87 = arith.mulf %85, %86 : f64
        %88 = arith.addf %84, %87 : f64
        affine.store %88, %arg4[%arg7] : memref<?xf64>
        %89 = affine.apply #map8(%arg8)
        %90 = affine.load %arg3[%89] : memref<?xf64>
        %91 = affine.load %arg6[%arg7] : memref<?xf64>
        %92 = affine.load %arg2[%arg7, %89] : memref<?x1900xf64>
        %93 = arith.mulf %91, %92 : f64
        %94 = arith.addf %90, %93 : f64
        affine.store %94, %arg3[%89] : memref<?xf64>
        %95 = affine.load %arg4[%arg7] : memref<?xf64>
        %96 = affine.load %arg2[%arg7, %89] : memref<?x1900xf64>
        %97 = affine.load %arg5[%89] : memref<?xf64>
        %98 = arith.mulf %96, %97 : f64
        %99 = arith.addf %95, %98 : f64
        affine.store %99, %arg4[%arg7] : memref<?xf64>
        %100 = affine.apply #map9(%arg8)
        %101 = affine.load %arg3[%100] : memref<?xf64>
        %102 = affine.load %arg6[%arg7] : memref<?xf64>
        %103 = affine.load %arg2[%arg7, %100] : memref<?x1900xf64>
        %104 = arith.mulf %102, %103 : f64
        %105 = arith.addf %101, %104 : f64
        affine.store %105, %arg3[%100] : memref<?xf64>
        %106 = affine.load %arg4[%arg7] : memref<?xf64>
        %107 = affine.load %arg2[%arg7, %100] : memref<?x1900xf64>
        %108 = affine.load %arg5[%100] : memref<?xf64>
        %109 = arith.mulf %107, %108 : f64
        %110 = arith.addf %106, %109 : f64
        affine.store %110, %arg4[%arg7] : memref<?xf64>
        %111 = affine.apply #map10(%arg8)
        %112 = affine.load %arg3[%111] : memref<?xf64>
        %113 = affine.load %arg6[%arg7] : memref<?xf64>
        %114 = affine.load %arg2[%arg7, %111] : memref<?x1900xf64>
        %115 = arith.mulf %113, %114 : f64
        %116 = arith.addf %112, %115 : f64
        affine.store %116, %arg3[%111] : memref<?xf64>
        %117 = affine.load %arg4[%arg7] : memref<?xf64>
        %118 = affine.load %arg2[%arg7, %111] : memref<?x1900xf64>
        %119 = affine.load %arg5[%111] : memref<?xf64>
        %120 = arith.mulf %118, %119 : f64
        %121 = arith.addf %117, %120 : f64
        affine.store %121, %arg4[%arg7] : memref<?xf64>
        %122 = affine.apply #map11(%arg8)
        %123 = affine.load %arg3[%122] : memref<?xf64>
        %124 = affine.load %arg6[%arg7] : memref<?xf64>
        %125 = affine.load %arg2[%arg7, %122] : memref<?x1900xf64>
        %126 = arith.mulf %124, %125 : f64
        %127 = arith.addf %123, %126 : f64
        affine.store %127, %arg3[%122] : memref<?xf64>
        %128 = affine.load %arg4[%arg7] : memref<?xf64>
        %129 = affine.load %arg2[%arg7, %122] : memref<?x1900xf64>
        %130 = affine.load %arg5[%122] : memref<?xf64>
        %131 = arith.mulf %129, %130 : f64
        %132 = arith.addf %128, %131 : f64
        affine.store %132, %arg4[%arg7] : memref<?xf64>
        %133 = affine.apply #map12(%arg8)
        %134 = affine.load %arg3[%133] : memref<?xf64>
        %135 = affine.load %arg6[%arg7] : memref<?xf64>
        %136 = affine.load %arg2[%arg7, %133] : memref<?x1900xf64>
        %137 = arith.mulf %135, %136 : f64
        %138 = arith.addf %134, %137 : f64
        affine.store %138, %arg3[%133] : memref<?xf64>
        %139 = affine.load %arg4[%arg7] : memref<?xf64>
        %140 = affine.load %arg2[%arg7, %133] : memref<?x1900xf64>
        %141 = affine.load %arg5[%133] : memref<?xf64>
        %142 = arith.mulf %140, %141 : f64
        %143 = arith.addf %139, %142 : f64
        affine.store %143, %arg4[%arg7] : memref<?xf64>
        %144 = affine.apply #map13(%arg8)
        %145 = affine.load %arg3[%144] : memref<?xf64>
        %146 = affine.load %arg6[%arg7] : memref<?xf64>
        %147 = affine.load %arg2[%arg7, %144] : memref<?x1900xf64>
        %148 = arith.mulf %146, %147 : f64
        %149 = arith.addf %145, %148 : f64
        affine.store %149, %arg3[%144] : memref<?xf64>
        %150 = affine.load %arg4[%arg7] : memref<?xf64>
        %151 = affine.load %arg2[%arg7, %144] : memref<?x1900xf64>
        %152 = affine.load %arg5[%144] : memref<?xf64>
        %153 = arith.mulf %151, %152 : f64
        %154 = arith.addf %150, %153 : f64
        affine.store %154, %arg4[%arg7] : memref<?xf64>
      }
      affine.for %arg8 = #map15()[%0] to #map16()[%0] step 2 {
        %2 = affine.load %arg3[%arg8] : memref<?xf64>
        %3 = affine.load %arg6[%arg7] : memref<?xf64>
        %4 = affine.load %arg2[%arg7, %arg8] : memref<?x1900xf64>
        %5 = arith.mulf %3, %4 : f64
        %6 = arith.addf %2, %5 : f64
        affine.store %6, %arg3[%arg8] : memref<?xf64>
        %7 = affine.load %arg4[%arg7] : memref<?xf64>
        %8 = affine.load %arg2[%arg7, %arg8] : memref<?x1900xf64>
        %9 = affine.load %arg5[%arg8] : memref<?xf64>
        %10 = arith.mulf %8, %9 : f64
        %11 = arith.addf %7, %10 : f64
        affine.store %11, %arg4[%arg7] : memref<?xf64>
        %12 = affine.apply #map1(%arg8)
        %13 = affine.load %arg3[%12] : memref<?xf64>
        %14 = affine.load %arg6[%arg7] : memref<?xf64>
        %15 = affine.load %arg2[%arg7, %12] : memref<?x1900xf64>
        %16 = arith.mulf %14, %15 : f64
        %17 = arith.addf %13, %16 : f64
        affine.store %17, %arg3[%12] : memref<?xf64>
        %18 = affine.load %arg4[%arg7] : memref<?xf64>
        %19 = affine.load %arg2[%arg7, %12] : memref<?x1900xf64>
        %20 = affine.load %arg5[%12] : memref<?xf64>
        %21 = arith.mulf %19, %20 : f64
        %22 = arith.addf %18, %21 : f64
        affine.store %22, %arg4[%arg7] : memref<?xf64>
      }
      affine.for %arg8 = #map16()[%0] to %0 {
        %2 = affine.load %arg3[%arg8] : memref<?xf64>
        %3 = affine.load %arg6[%arg7] : memref<?xf64>
        %4 = affine.load %arg2[%arg7, %arg8] : memref<?x1900xf64>
        %5 = arith.mulf %3, %4 : f64
        %6 = arith.addf %2, %5 : f64
        affine.store %6, %arg3[%arg8] : memref<?xf64>
        %7 = affine.load %arg4[%arg7] : memref<?xf64>
        %8 = affine.load %arg2[%arg7, %arg8] : memref<?x1900xf64>
        %9 = affine.load %arg5[%arg8] : memref<?xf64>
        %10 = arith.mulf %8, %9 : f64
        %11 = arith.addf %7, %10 : f64
        affine.store %11, %arg4[%arg7] : memref<?xf64>
      }
    }
    return
  }
}

