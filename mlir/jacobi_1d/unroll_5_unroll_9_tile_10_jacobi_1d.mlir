#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 10, s0)>
#map2 = affine_map<()[s0] -> ((((s0 - 2) floordiv 9) floordiv 5) * 45 + 1)>
#map3 = affine_map<(d0) -> (d0 + 1)>
#map4 = affine_map<(d0) -> (d0 + 2)>
#map5 = affine_map<(d0) -> (d0 + 3)>
#map6 = affine_map<(d0) -> (d0 + 4)>
#map7 = affine_map<(d0) -> (d0 + 5)>
#map8 = affine_map<(d0) -> (d0 + 6)>
#map9 = affine_map<(d0) -> (d0 + 7)>
#map10 = affine_map<(d0) -> (d0 + 8)>
#map11 = affine_map<(d0) -> (d0 + 9)>
#map12 = affine_map<(d0) -> (d0 + 18)>
#map13 = affine_map<(d0) -> (d0 + 27)>
#map14 = affine_map<(d0) -> (d0 + 36)>
#map15 = affine_map<()[s0] -> (((s0 - 2) floordiv 9) * 9 + 1)>
#map16 = affine_map<()[s0] -> (((s0 - 2) floordiv 9) * 9 + ((s0 - ((s0 - 2) floordiv 9) * 9 - 2) floordiv 5) * 5 + 1)>
#map17 = affine_map<()[s0] -> (s0 - 1)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>, #dlti.dl_entry<"dlti.endianness", "little">>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_jacobi_1d(%arg0: i32, %arg1: i32, %arg2: memref<?xf64>, %arg3: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 3.333300e-01 : f64
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg0 : i32 to index
    affine.for %arg4 = 0 to %1 step 10 {
      affine.for %arg5 = #map(%arg4) to min #map1(%arg4)[%1] {
        affine.for %arg6 = 1 to #map2()[%0] step 45 {
          %2 = affine.load %arg2[%arg6 - 1] : memref<?xf64>
          %3 = affine.load %arg2[%arg6] : memref<?xf64>
          %4 = arith.addf %2, %3 : f64
          %5 = affine.load %arg2[%arg6 + 1] : memref<?xf64>
          %6 = arith.addf %4, %5 : f64
          %7 = arith.mulf %6, %cst : f64
          affine.store %7, %arg3[%arg6] : memref<?xf64>
          %8 = affine.apply #map3(%arg6)
          %9 = affine.load %arg2[%8 - 1] : memref<?xf64>
          %10 = affine.load %arg2[%8] : memref<?xf64>
          %11 = arith.addf %9, %10 : f64
          %12 = affine.load %arg2[%8 + 1] : memref<?xf64>
          %13 = arith.addf %11, %12 : f64
          %14 = arith.mulf %13, %cst : f64
          affine.store %14, %arg3[%8] : memref<?xf64>
          %15 = affine.apply #map4(%arg6)
          %16 = affine.load %arg2[%15 - 1] : memref<?xf64>
          %17 = affine.load %arg2[%15] : memref<?xf64>
          %18 = arith.addf %16, %17 : f64
          %19 = affine.load %arg2[%15 + 1] : memref<?xf64>
          %20 = arith.addf %18, %19 : f64
          %21 = arith.mulf %20, %cst : f64
          affine.store %21, %arg3[%15] : memref<?xf64>
          %22 = affine.apply #map5(%arg6)
          %23 = affine.load %arg2[%22 - 1] : memref<?xf64>
          %24 = affine.load %arg2[%22] : memref<?xf64>
          %25 = arith.addf %23, %24 : f64
          %26 = affine.load %arg2[%22 + 1] : memref<?xf64>
          %27 = arith.addf %25, %26 : f64
          %28 = arith.mulf %27, %cst : f64
          affine.store %28, %arg3[%22] : memref<?xf64>
          %29 = affine.apply #map6(%arg6)
          %30 = affine.load %arg2[%29 - 1] : memref<?xf64>
          %31 = affine.load %arg2[%29] : memref<?xf64>
          %32 = arith.addf %30, %31 : f64
          %33 = affine.load %arg2[%29 + 1] : memref<?xf64>
          %34 = arith.addf %32, %33 : f64
          %35 = arith.mulf %34, %cst : f64
          affine.store %35, %arg3[%29] : memref<?xf64>
          %36 = affine.apply #map7(%arg6)
          %37 = affine.load %arg2[%36 - 1] : memref<?xf64>
          %38 = affine.load %arg2[%36] : memref<?xf64>
          %39 = arith.addf %37, %38 : f64
          %40 = affine.load %arg2[%36 + 1] : memref<?xf64>
          %41 = arith.addf %39, %40 : f64
          %42 = arith.mulf %41, %cst : f64
          affine.store %42, %arg3[%36] : memref<?xf64>
          %43 = affine.apply #map8(%arg6)
          %44 = affine.load %arg2[%43 - 1] : memref<?xf64>
          %45 = affine.load %arg2[%43] : memref<?xf64>
          %46 = arith.addf %44, %45 : f64
          %47 = affine.load %arg2[%43 + 1] : memref<?xf64>
          %48 = arith.addf %46, %47 : f64
          %49 = arith.mulf %48, %cst : f64
          affine.store %49, %arg3[%43] : memref<?xf64>
          %50 = affine.apply #map9(%arg6)
          %51 = affine.load %arg2[%50 - 1] : memref<?xf64>
          %52 = affine.load %arg2[%50] : memref<?xf64>
          %53 = arith.addf %51, %52 : f64
          %54 = affine.load %arg2[%50 + 1] : memref<?xf64>
          %55 = arith.addf %53, %54 : f64
          %56 = arith.mulf %55, %cst : f64
          affine.store %56, %arg3[%50] : memref<?xf64>
          %57 = affine.apply #map10(%arg6)
          %58 = affine.load %arg2[%57 - 1] : memref<?xf64>
          %59 = affine.load %arg2[%57] : memref<?xf64>
          %60 = arith.addf %58, %59 : f64
          %61 = affine.load %arg2[%57 + 1] : memref<?xf64>
          %62 = arith.addf %60, %61 : f64
          %63 = arith.mulf %62, %cst : f64
          affine.store %63, %arg3[%57] : memref<?xf64>
          %64 = affine.apply #map11(%arg6)
          %65 = affine.load %arg2[%64 - 1] : memref<?xf64>
          %66 = affine.load %arg2[%64] : memref<?xf64>
          %67 = arith.addf %65, %66 : f64
          %68 = affine.load %arg2[%64 + 1] : memref<?xf64>
          %69 = arith.addf %67, %68 : f64
          %70 = arith.mulf %69, %cst : f64
          affine.store %70, %arg3[%64] : memref<?xf64>
          %71 = affine.apply #map3(%64)
          %72 = affine.load %arg2[%71 - 1] : memref<?xf64>
          %73 = affine.load %arg2[%71] : memref<?xf64>
          %74 = arith.addf %72, %73 : f64
          %75 = affine.load %arg2[%71 + 1] : memref<?xf64>
          %76 = arith.addf %74, %75 : f64
          %77 = arith.mulf %76, %cst : f64
          affine.store %77, %arg3[%71] : memref<?xf64>
          %78 = affine.apply #map4(%64)
          %79 = affine.load %arg2[%78 - 1] : memref<?xf64>
          %80 = affine.load %arg2[%78] : memref<?xf64>
          %81 = arith.addf %79, %80 : f64
          %82 = affine.load %arg2[%78 + 1] : memref<?xf64>
          %83 = arith.addf %81, %82 : f64
          %84 = arith.mulf %83, %cst : f64
          affine.store %84, %arg3[%78] : memref<?xf64>
          %85 = affine.apply #map5(%64)
          %86 = affine.load %arg2[%85 - 1] : memref<?xf64>
          %87 = affine.load %arg2[%85] : memref<?xf64>
          %88 = arith.addf %86, %87 : f64
          %89 = affine.load %arg2[%85 + 1] : memref<?xf64>
          %90 = arith.addf %88, %89 : f64
          %91 = arith.mulf %90, %cst : f64
          affine.store %91, %arg3[%85] : memref<?xf64>
          %92 = affine.apply #map6(%64)
          %93 = affine.load %arg2[%92 - 1] : memref<?xf64>
          %94 = affine.load %arg2[%92] : memref<?xf64>
          %95 = arith.addf %93, %94 : f64
          %96 = affine.load %arg2[%92 + 1] : memref<?xf64>
          %97 = arith.addf %95, %96 : f64
          %98 = arith.mulf %97, %cst : f64
          affine.store %98, %arg3[%92] : memref<?xf64>
          %99 = affine.apply #map7(%64)
          %100 = affine.load %arg2[%99 - 1] : memref<?xf64>
          %101 = affine.load %arg2[%99] : memref<?xf64>
          %102 = arith.addf %100, %101 : f64
          %103 = affine.load %arg2[%99 + 1] : memref<?xf64>
          %104 = arith.addf %102, %103 : f64
          %105 = arith.mulf %104, %cst : f64
          affine.store %105, %arg3[%99] : memref<?xf64>
          %106 = affine.apply #map8(%64)
          %107 = affine.load %arg2[%106 - 1] : memref<?xf64>
          %108 = affine.load %arg2[%106] : memref<?xf64>
          %109 = arith.addf %107, %108 : f64
          %110 = affine.load %arg2[%106 + 1] : memref<?xf64>
          %111 = arith.addf %109, %110 : f64
          %112 = arith.mulf %111, %cst : f64
          affine.store %112, %arg3[%106] : memref<?xf64>
          %113 = affine.apply #map9(%64)
          %114 = affine.load %arg2[%113 - 1] : memref<?xf64>
          %115 = affine.load %arg2[%113] : memref<?xf64>
          %116 = arith.addf %114, %115 : f64
          %117 = affine.load %arg2[%113 + 1] : memref<?xf64>
          %118 = arith.addf %116, %117 : f64
          %119 = arith.mulf %118, %cst : f64
          affine.store %119, %arg3[%113] : memref<?xf64>
          %120 = affine.apply #map10(%64)
          %121 = affine.load %arg2[%120 - 1] : memref<?xf64>
          %122 = affine.load %arg2[%120] : memref<?xf64>
          %123 = arith.addf %121, %122 : f64
          %124 = affine.load %arg2[%120 + 1] : memref<?xf64>
          %125 = arith.addf %123, %124 : f64
          %126 = arith.mulf %125, %cst : f64
          affine.store %126, %arg3[%120] : memref<?xf64>
          %127 = affine.apply #map12(%arg6)
          %128 = affine.load %arg2[%127 - 1] : memref<?xf64>
          %129 = affine.load %arg2[%127] : memref<?xf64>
          %130 = arith.addf %128, %129 : f64
          %131 = affine.load %arg2[%127 + 1] : memref<?xf64>
          %132 = arith.addf %130, %131 : f64
          %133 = arith.mulf %132, %cst : f64
          affine.store %133, %arg3[%127] : memref<?xf64>
          %134 = affine.apply #map3(%127)
          %135 = affine.load %arg2[%134 - 1] : memref<?xf64>
          %136 = affine.load %arg2[%134] : memref<?xf64>
          %137 = arith.addf %135, %136 : f64
          %138 = affine.load %arg2[%134 + 1] : memref<?xf64>
          %139 = arith.addf %137, %138 : f64
          %140 = arith.mulf %139, %cst : f64
          affine.store %140, %arg3[%134] : memref<?xf64>
          %141 = affine.apply #map4(%127)
          %142 = affine.load %arg2[%141 - 1] : memref<?xf64>
          %143 = affine.load %arg2[%141] : memref<?xf64>
          %144 = arith.addf %142, %143 : f64
          %145 = affine.load %arg2[%141 + 1] : memref<?xf64>
          %146 = arith.addf %144, %145 : f64
          %147 = arith.mulf %146, %cst : f64
          affine.store %147, %arg3[%141] : memref<?xf64>
          %148 = affine.apply #map5(%127)
          %149 = affine.load %arg2[%148 - 1] : memref<?xf64>
          %150 = affine.load %arg2[%148] : memref<?xf64>
          %151 = arith.addf %149, %150 : f64
          %152 = affine.load %arg2[%148 + 1] : memref<?xf64>
          %153 = arith.addf %151, %152 : f64
          %154 = arith.mulf %153, %cst : f64
          affine.store %154, %arg3[%148] : memref<?xf64>
          %155 = affine.apply #map6(%127)
          %156 = affine.load %arg2[%155 - 1] : memref<?xf64>
          %157 = affine.load %arg2[%155] : memref<?xf64>
          %158 = arith.addf %156, %157 : f64
          %159 = affine.load %arg2[%155 + 1] : memref<?xf64>
          %160 = arith.addf %158, %159 : f64
          %161 = arith.mulf %160, %cst : f64
          affine.store %161, %arg3[%155] : memref<?xf64>
          %162 = affine.apply #map7(%127)
          %163 = affine.load %arg2[%162 - 1] : memref<?xf64>
          %164 = affine.load %arg2[%162] : memref<?xf64>
          %165 = arith.addf %163, %164 : f64
          %166 = affine.load %arg2[%162 + 1] : memref<?xf64>
          %167 = arith.addf %165, %166 : f64
          %168 = arith.mulf %167, %cst : f64
          affine.store %168, %arg3[%162] : memref<?xf64>
          %169 = affine.apply #map8(%127)
          %170 = affine.load %arg2[%169 - 1] : memref<?xf64>
          %171 = affine.load %arg2[%169] : memref<?xf64>
          %172 = arith.addf %170, %171 : f64
          %173 = affine.load %arg2[%169 + 1] : memref<?xf64>
          %174 = arith.addf %172, %173 : f64
          %175 = arith.mulf %174, %cst : f64
          affine.store %175, %arg3[%169] : memref<?xf64>
          %176 = affine.apply #map9(%127)
          %177 = affine.load %arg2[%176 - 1] : memref<?xf64>
          %178 = affine.load %arg2[%176] : memref<?xf64>
          %179 = arith.addf %177, %178 : f64
          %180 = affine.load %arg2[%176 + 1] : memref<?xf64>
          %181 = arith.addf %179, %180 : f64
          %182 = arith.mulf %181, %cst : f64
          affine.store %182, %arg3[%176] : memref<?xf64>
          %183 = affine.apply #map10(%127)
          %184 = affine.load %arg2[%183 - 1] : memref<?xf64>
          %185 = affine.load %arg2[%183] : memref<?xf64>
          %186 = arith.addf %184, %185 : f64
          %187 = affine.load %arg2[%183 + 1] : memref<?xf64>
          %188 = arith.addf %186, %187 : f64
          %189 = arith.mulf %188, %cst : f64
          affine.store %189, %arg3[%183] : memref<?xf64>
          %190 = affine.apply #map13(%arg6)
          %191 = affine.load %arg2[%190 - 1] : memref<?xf64>
          %192 = affine.load %arg2[%190] : memref<?xf64>
          %193 = arith.addf %191, %192 : f64
          %194 = affine.load %arg2[%190 + 1] : memref<?xf64>
          %195 = arith.addf %193, %194 : f64
          %196 = arith.mulf %195, %cst : f64
          affine.store %196, %arg3[%190] : memref<?xf64>
          %197 = affine.apply #map3(%190)
          %198 = affine.load %arg2[%197 - 1] : memref<?xf64>
          %199 = affine.load %arg2[%197] : memref<?xf64>
          %200 = arith.addf %198, %199 : f64
          %201 = affine.load %arg2[%197 + 1] : memref<?xf64>
          %202 = arith.addf %200, %201 : f64
          %203 = arith.mulf %202, %cst : f64
          affine.store %203, %arg3[%197] : memref<?xf64>
          %204 = affine.apply #map4(%190)
          %205 = affine.load %arg2[%204 - 1] : memref<?xf64>
          %206 = affine.load %arg2[%204] : memref<?xf64>
          %207 = arith.addf %205, %206 : f64
          %208 = affine.load %arg2[%204 + 1] : memref<?xf64>
          %209 = arith.addf %207, %208 : f64
          %210 = arith.mulf %209, %cst : f64
          affine.store %210, %arg3[%204] : memref<?xf64>
          %211 = affine.apply #map5(%190)
          %212 = affine.load %arg2[%211 - 1] : memref<?xf64>
          %213 = affine.load %arg2[%211] : memref<?xf64>
          %214 = arith.addf %212, %213 : f64
          %215 = affine.load %arg2[%211 + 1] : memref<?xf64>
          %216 = arith.addf %214, %215 : f64
          %217 = arith.mulf %216, %cst : f64
          affine.store %217, %arg3[%211] : memref<?xf64>
          %218 = affine.apply #map6(%190)
          %219 = affine.load %arg2[%218 - 1] : memref<?xf64>
          %220 = affine.load %arg2[%218] : memref<?xf64>
          %221 = arith.addf %219, %220 : f64
          %222 = affine.load %arg2[%218 + 1] : memref<?xf64>
          %223 = arith.addf %221, %222 : f64
          %224 = arith.mulf %223, %cst : f64
          affine.store %224, %arg3[%218] : memref<?xf64>
          %225 = affine.apply #map7(%190)
          %226 = affine.load %arg2[%225 - 1] : memref<?xf64>
          %227 = affine.load %arg2[%225] : memref<?xf64>
          %228 = arith.addf %226, %227 : f64
          %229 = affine.load %arg2[%225 + 1] : memref<?xf64>
          %230 = arith.addf %228, %229 : f64
          %231 = arith.mulf %230, %cst : f64
          affine.store %231, %arg3[%225] : memref<?xf64>
          %232 = affine.apply #map8(%190)
          %233 = affine.load %arg2[%232 - 1] : memref<?xf64>
          %234 = affine.load %arg2[%232] : memref<?xf64>
          %235 = arith.addf %233, %234 : f64
          %236 = affine.load %arg2[%232 + 1] : memref<?xf64>
          %237 = arith.addf %235, %236 : f64
          %238 = arith.mulf %237, %cst : f64
          affine.store %238, %arg3[%232] : memref<?xf64>
          %239 = affine.apply #map9(%190)
          %240 = affine.load %arg2[%239 - 1] : memref<?xf64>
          %241 = affine.load %arg2[%239] : memref<?xf64>
          %242 = arith.addf %240, %241 : f64
          %243 = affine.load %arg2[%239 + 1] : memref<?xf64>
          %244 = arith.addf %242, %243 : f64
          %245 = arith.mulf %244, %cst : f64
          affine.store %245, %arg3[%239] : memref<?xf64>
          %246 = affine.apply #map10(%190)
          %247 = affine.load %arg2[%246 - 1] : memref<?xf64>
          %248 = affine.load %arg2[%246] : memref<?xf64>
          %249 = arith.addf %247, %248 : f64
          %250 = affine.load %arg2[%246 + 1] : memref<?xf64>
          %251 = arith.addf %249, %250 : f64
          %252 = arith.mulf %251, %cst : f64
          affine.store %252, %arg3[%246] : memref<?xf64>
          %253 = affine.apply #map14(%arg6)
          %254 = affine.load %arg2[%253 - 1] : memref<?xf64>
          %255 = affine.load %arg2[%253] : memref<?xf64>
          %256 = arith.addf %254, %255 : f64
          %257 = affine.load %arg2[%253 + 1] : memref<?xf64>
          %258 = arith.addf %256, %257 : f64
          %259 = arith.mulf %258, %cst : f64
          affine.store %259, %arg3[%253] : memref<?xf64>
          %260 = affine.apply #map3(%253)
          %261 = affine.load %arg2[%260 - 1] : memref<?xf64>
          %262 = affine.load %arg2[%260] : memref<?xf64>
          %263 = arith.addf %261, %262 : f64
          %264 = affine.load %arg2[%260 + 1] : memref<?xf64>
          %265 = arith.addf %263, %264 : f64
          %266 = arith.mulf %265, %cst : f64
          affine.store %266, %arg3[%260] : memref<?xf64>
          %267 = affine.apply #map4(%253)
          %268 = affine.load %arg2[%267 - 1] : memref<?xf64>
          %269 = affine.load %arg2[%267] : memref<?xf64>
          %270 = arith.addf %268, %269 : f64
          %271 = affine.load %arg2[%267 + 1] : memref<?xf64>
          %272 = arith.addf %270, %271 : f64
          %273 = arith.mulf %272, %cst : f64
          affine.store %273, %arg3[%267] : memref<?xf64>
          %274 = affine.apply #map5(%253)
          %275 = affine.load %arg2[%274 - 1] : memref<?xf64>
          %276 = affine.load %arg2[%274] : memref<?xf64>
          %277 = arith.addf %275, %276 : f64
          %278 = affine.load %arg2[%274 + 1] : memref<?xf64>
          %279 = arith.addf %277, %278 : f64
          %280 = arith.mulf %279, %cst : f64
          affine.store %280, %arg3[%274] : memref<?xf64>
          %281 = affine.apply #map6(%253)
          %282 = affine.load %arg2[%281 - 1] : memref<?xf64>
          %283 = affine.load %arg2[%281] : memref<?xf64>
          %284 = arith.addf %282, %283 : f64
          %285 = affine.load %arg2[%281 + 1] : memref<?xf64>
          %286 = arith.addf %284, %285 : f64
          %287 = arith.mulf %286, %cst : f64
          affine.store %287, %arg3[%281] : memref<?xf64>
          %288 = affine.apply #map7(%253)
          %289 = affine.load %arg2[%288 - 1] : memref<?xf64>
          %290 = affine.load %arg2[%288] : memref<?xf64>
          %291 = arith.addf %289, %290 : f64
          %292 = affine.load %arg2[%288 + 1] : memref<?xf64>
          %293 = arith.addf %291, %292 : f64
          %294 = arith.mulf %293, %cst : f64
          affine.store %294, %arg3[%288] : memref<?xf64>
          %295 = affine.apply #map8(%253)
          %296 = affine.load %arg2[%295 - 1] : memref<?xf64>
          %297 = affine.load %arg2[%295] : memref<?xf64>
          %298 = arith.addf %296, %297 : f64
          %299 = affine.load %arg2[%295 + 1] : memref<?xf64>
          %300 = arith.addf %298, %299 : f64
          %301 = arith.mulf %300, %cst : f64
          affine.store %301, %arg3[%295] : memref<?xf64>
          %302 = affine.apply #map9(%253)
          %303 = affine.load %arg2[%302 - 1] : memref<?xf64>
          %304 = affine.load %arg2[%302] : memref<?xf64>
          %305 = arith.addf %303, %304 : f64
          %306 = affine.load %arg2[%302 + 1] : memref<?xf64>
          %307 = arith.addf %305, %306 : f64
          %308 = arith.mulf %307, %cst : f64
          affine.store %308, %arg3[%302] : memref<?xf64>
          %309 = affine.apply #map10(%253)
          %310 = affine.load %arg2[%309 - 1] : memref<?xf64>
          %311 = affine.load %arg2[%309] : memref<?xf64>
          %312 = arith.addf %310, %311 : f64
          %313 = affine.load %arg2[%309 + 1] : memref<?xf64>
          %314 = arith.addf %312, %313 : f64
          %315 = arith.mulf %314, %cst : f64
          affine.store %315, %arg3[%309] : memref<?xf64>
        }
        affine.for %arg6 = #map2()[%0] to #map15()[%0] step 9 {
          %2 = affine.load %arg2[%arg6 - 1] : memref<?xf64>
          %3 = affine.load %arg2[%arg6] : memref<?xf64>
          %4 = arith.addf %2, %3 : f64
          %5 = affine.load %arg2[%arg6 + 1] : memref<?xf64>
          %6 = arith.addf %4, %5 : f64
          %7 = arith.mulf %6, %cst : f64
          affine.store %7, %arg3[%arg6] : memref<?xf64>
          %8 = affine.apply #map3(%arg6)
          %9 = affine.load %arg2[%8 - 1] : memref<?xf64>
          %10 = affine.load %arg2[%8] : memref<?xf64>
          %11 = arith.addf %9, %10 : f64
          %12 = affine.load %arg2[%8 + 1] : memref<?xf64>
          %13 = arith.addf %11, %12 : f64
          %14 = arith.mulf %13, %cst : f64
          affine.store %14, %arg3[%8] : memref<?xf64>
          %15 = affine.apply #map4(%arg6)
          %16 = affine.load %arg2[%15 - 1] : memref<?xf64>
          %17 = affine.load %arg2[%15] : memref<?xf64>
          %18 = arith.addf %16, %17 : f64
          %19 = affine.load %arg2[%15 + 1] : memref<?xf64>
          %20 = arith.addf %18, %19 : f64
          %21 = arith.mulf %20, %cst : f64
          affine.store %21, %arg3[%15] : memref<?xf64>
          %22 = affine.apply #map5(%arg6)
          %23 = affine.load %arg2[%22 - 1] : memref<?xf64>
          %24 = affine.load %arg2[%22] : memref<?xf64>
          %25 = arith.addf %23, %24 : f64
          %26 = affine.load %arg2[%22 + 1] : memref<?xf64>
          %27 = arith.addf %25, %26 : f64
          %28 = arith.mulf %27, %cst : f64
          affine.store %28, %arg3[%22] : memref<?xf64>
          %29 = affine.apply #map6(%arg6)
          %30 = affine.load %arg2[%29 - 1] : memref<?xf64>
          %31 = affine.load %arg2[%29] : memref<?xf64>
          %32 = arith.addf %30, %31 : f64
          %33 = affine.load %arg2[%29 + 1] : memref<?xf64>
          %34 = arith.addf %32, %33 : f64
          %35 = arith.mulf %34, %cst : f64
          affine.store %35, %arg3[%29] : memref<?xf64>
          %36 = affine.apply #map7(%arg6)
          %37 = affine.load %arg2[%36 - 1] : memref<?xf64>
          %38 = affine.load %arg2[%36] : memref<?xf64>
          %39 = arith.addf %37, %38 : f64
          %40 = affine.load %arg2[%36 + 1] : memref<?xf64>
          %41 = arith.addf %39, %40 : f64
          %42 = arith.mulf %41, %cst : f64
          affine.store %42, %arg3[%36] : memref<?xf64>
          %43 = affine.apply #map8(%arg6)
          %44 = affine.load %arg2[%43 - 1] : memref<?xf64>
          %45 = affine.load %arg2[%43] : memref<?xf64>
          %46 = arith.addf %44, %45 : f64
          %47 = affine.load %arg2[%43 + 1] : memref<?xf64>
          %48 = arith.addf %46, %47 : f64
          %49 = arith.mulf %48, %cst : f64
          affine.store %49, %arg3[%43] : memref<?xf64>
          %50 = affine.apply #map9(%arg6)
          %51 = affine.load %arg2[%50 - 1] : memref<?xf64>
          %52 = affine.load %arg2[%50] : memref<?xf64>
          %53 = arith.addf %51, %52 : f64
          %54 = affine.load %arg2[%50 + 1] : memref<?xf64>
          %55 = arith.addf %53, %54 : f64
          %56 = arith.mulf %55, %cst : f64
          affine.store %56, %arg3[%50] : memref<?xf64>
          %57 = affine.apply #map10(%arg6)
          %58 = affine.load %arg2[%57 - 1] : memref<?xf64>
          %59 = affine.load %arg2[%57] : memref<?xf64>
          %60 = arith.addf %58, %59 : f64
          %61 = affine.load %arg2[%57 + 1] : memref<?xf64>
          %62 = arith.addf %60, %61 : f64
          %63 = arith.mulf %62, %cst : f64
          affine.store %63, %arg3[%57] : memref<?xf64>
        }
        affine.for %arg6 = #map15()[%0] to #map16()[%0] step 5 {
          %2 = affine.load %arg2[%arg6 - 1] : memref<?xf64>
          %3 = affine.load %arg2[%arg6] : memref<?xf64>
          %4 = arith.addf %2, %3 : f64
          %5 = affine.load %arg2[%arg6 + 1] : memref<?xf64>
          %6 = arith.addf %4, %5 : f64
          %7 = arith.mulf %6, %cst : f64
          affine.store %7, %arg3[%arg6] : memref<?xf64>
          %8 = affine.apply #map3(%arg6)
          %9 = affine.load %arg2[%8 - 1] : memref<?xf64>
          %10 = affine.load %arg2[%8] : memref<?xf64>
          %11 = arith.addf %9, %10 : f64
          %12 = affine.load %arg2[%8 + 1] : memref<?xf64>
          %13 = arith.addf %11, %12 : f64
          %14 = arith.mulf %13, %cst : f64
          affine.store %14, %arg3[%8] : memref<?xf64>
          %15 = affine.apply #map4(%arg6)
          %16 = affine.load %arg2[%15 - 1] : memref<?xf64>
          %17 = affine.load %arg2[%15] : memref<?xf64>
          %18 = arith.addf %16, %17 : f64
          %19 = affine.load %arg2[%15 + 1] : memref<?xf64>
          %20 = arith.addf %18, %19 : f64
          %21 = arith.mulf %20, %cst : f64
          affine.store %21, %arg3[%15] : memref<?xf64>
          %22 = affine.apply #map5(%arg6)
          %23 = affine.load %arg2[%22 - 1] : memref<?xf64>
          %24 = affine.load %arg2[%22] : memref<?xf64>
          %25 = arith.addf %23, %24 : f64
          %26 = affine.load %arg2[%22 + 1] : memref<?xf64>
          %27 = arith.addf %25, %26 : f64
          %28 = arith.mulf %27, %cst : f64
          affine.store %28, %arg3[%22] : memref<?xf64>
          %29 = affine.apply #map6(%arg6)
          %30 = affine.load %arg2[%29 - 1] : memref<?xf64>
          %31 = affine.load %arg2[%29] : memref<?xf64>
          %32 = arith.addf %30, %31 : f64
          %33 = affine.load %arg2[%29 + 1] : memref<?xf64>
          %34 = arith.addf %32, %33 : f64
          %35 = arith.mulf %34, %cst : f64
          affine.store %35, %arg3[%29] : memref<?xf64>
        }
        affine.for %arg6 = #map16()[%0] to #map17()[%0] {
          %2 = affine.load %arg2[%arg6 - 1] : memref<?xf64>
          %3 = affine.load %arg2[%arg6] : memref<?xf64>
          %4 = arith.addf %2, %3 : f64
          %5 = affine.load %arg2[%arg6 + 1] : memref<?xf64>
          %6 = arith.addf %4, %5 : f64
          %7 = arith.mulf %6, %cst : f64
          affine.store %7, %arg3[%arg6] : memref<?xf64>
        }
        affine.for %arg6 = 1 to #map2()[%0] step 45 {
          %2 = affine.load %arg3[%arg6 - 1] : memref<?xf64>
          %3 = affine.load %arg3[%arg6] : memref<?xf64>
          %4 = arith.addf %2, %3 : f64
          %5 = affine.load %arg3[%arg6 + 1] : memref<?xf64>
          %6 = arith.addf %4, %5 : f64
          %7 = arith.mulf %6, %cst : f64
          affine.store %7, %arg2[%arg6] : memref<?xf64>
          %8 = affine.apply #map3(%arg6)
          %9 = affine.load %arg3[%8 - 1] : memref<?xf64>
          %10 = affine.load %arg3[%8] : memref<?xf64>
          %11 = arith.addf %9, %10 : f64
          %12 = affine.load %arg3[%8 + 1] : memref<?xf64>
          %13 = arith.addf %11, %12 : f64
          %14 = arith.mulf %13, %cst : f64
          affine.store %14, %arg2[%8] : memref<?xf64>
          %15 = affine.apply #map4(%arg6)
          %16 = affine.load %arg3[%15 - 1] : memref<?xf64>
          %17 = affine.load %arg3[%15] : memref<?xf64>
          %18 = arith.addf %16, %17 : f64
          %19 = affine.load %arg3[%15 + 1] : memref<?xf64>
          %20 = arith.addf %18, %19 : f64
          %21 = arith.mulf %20, %cst : f64
          affine.store %21, %arg2[%15] : memref<?xf64>
          %22 = affine.apply #map5(%arg6)
          %23 = affine.load %arg3[%22 - 1] : memref<?xf64>
          %24 = affine.load %arg3[%22] : memref<?xf64>
          %25 = arith.addf %23, %24 : f64
          %26 = affine.load %arg3[%22 + 1] : memref<?xf64>
          %27 = arith.addf %25, %26 : f64
          %28 = arith.mulf %27, %cst : f64
          affine.store %28, %arg2[%22] : memref<?xf64>
          %29 = affine.apply #map6(%arg6)
          %30 = affine.load %arg3[%29 - 1] : memref<?xf64>
          %31 = affine.load %arg3[%29] : memref<?xf64>
          %32 = arith.addf %30, %31 : f64
          %33 = affine.load %arg3[%29 + 1] : memref<?xf64>
          %34 = arith.addf %32, %33 : f64
          %35 = arith.mulf %34, %cst : f64
          affine.store %35, %arg2[%29] : memref<?xf64>
          %36 = affine.apply #map7(%arg6)
          %37 = affine.load %arg3[%36 - 1] : memref<?xf64>
          %38 = affine.load %arg3[%36] : memref<?xf64>
          %39 = arith.addf %37, %38 : f64
          %40 = affine.load %arg3[%36 + 1] : memref<?xf64>
          %41 = arith.addf %39, %40 : f64
          %42 = arith.mulf %41, %cst : f64
          affine.store %42, %arg2[%36] : memref<?xf64>
          %43 = affine.apply #map8(%arg6)
          %44 = affine.load %arg3[%43 - 1] : memref<?xf64>
          %45 = affine.load %arg3[%43] : memref<?xf64>
          %46 = arith.addf %44, %45 : f64
          %47 = affine.load %arg3[%43 + 1] : memref<?xf64>
          %48 = arith.addf %46, %47 : f64
          %49 = arith.mulf %48, %cst : f64
          affine.store %49, %arg2[%43] : memref<?xf64>
          %50 = affine.apply #map9(%arg6)
          %51 = affine.load %arg3[%50 - 1] : memref<?xf64>
          %52 = affine.load %arg3[%50] : memref<?xf64>
          %53 = arith.addf %51, %52 : f64
          %54 = affine.load %arg3[%50 + 1] : memref<?xf64>
          %55 = arith.addf %53, %54 : f64
          %56 = arith.mulf %55, %cst : f64
          affine.store %56, %arg2[%50] : memref<?xf64>
          %57 = affine.apply #map10(%arg6)
          %58 = affine.load %arg3[%57 - 1] : memref<?xf64>
          %59 = affine.load %arg3[%57] : memref<?xf64>
          %60 = arith.addf %58, %59 : f64
          %61 = affine.load %arg3[%57 + 1] : memref<?xf64>
          %62 = arith.addf %60, %61 : f64
          %63 = arith.mulf %62, %cst : f64
          affine.store %63, %arg2[%57] : memref<?xf64>
          %64 = affine.apply #map11(%arg6)
          %65 = affine.load %arg3[%64 - 1] : memref<?xf64>
          %66 = affine.load %arg3[%64] : memref<?xf64>
          %67 = arith.addf %65, %66 : f64
          %68 = affine.load %arg3[%64 + 1] : memref<?xf64>
          %69 = arith.addf %67, %68 : f64
          %70 = arith.mulf %69, %cst : f64
          affine.store %70, %arg2[%64] : memref<?xf64>
          %71 = affine.apply #map3(%64)
          %72 = affine.load %arg3[%71 - 1] : memref<?xf64>
          %73 = affine.load %arg3[%71] : memref<?xf64>
          %74 = arith.addf %72, %73 : f64
          %75 = affine.load %arg3[%71 + 1] : memref<?xf64>
          %76 = arith.addf %74, %75 : f64
          %77 = arith.mulf %76, %cst : f64
          affine.store %77, %arg2[%71] : memref<?xf64>
          %78 = affine.apply #map4(%64)
          %79 = affine.load %arg3[%78 - 1] : memref<?xf64>
          %80 = affine.load %arg3[%78] : memref<?xf64>
          %81 = arith.addf %79, %80 : f64
          %82 = affine.load %arg3[%78 + 1] : memref<?xf64>
          %83 = arith.addf %81, %82 : f64
          %84 = arith.mulf %83, %cst : f64
          affine.store %84, %arg2[%78] : memref<?xf64>
          %85 = affine.apply #map5(%64)
          %86 = affine.load %arg3[%85 - 1] : memref<?xf64>
          %87 = affine.load %arg3[%85] : memref<?xf64>
          %88 = arith.addf %86, %87 : f64
          %89 = affine.load %arg3[%85 + 1] : memref<?xf64>
          %90 = arith.addf %88, %89 : f64
          %91 = arith.mulf %90, %cst : f64
          affine.store %91, %arg2[%85] : memref<?xf64>
          %92 = affine.apply #map6(%64)
          %93 = affine.load %arg3[%92 - 1] : memref<?xf64>
          %94 = affine.load %arg3[%92] : memref<?xf64>
          %95 = arith.addf %93, %94 : f64
          %96 = affine.load %arg3[%92 + 1] : memref<?xf64>
          %97 = arith.addf %95, %96 : f64
          %98 = arith.mulf %97, %cst : f64
          affine.store %98, %arg2[%92] : memref<?xf64>
          %99 = affine.apply #map7(%64)
          %100 = affine.load %arg3[%99 - 1] : memref<?xf64>
          %101 = affine.load %arg3[%99] : memref<?xf64>
          %102 = arith.addf %100, %101 : f64
          %103 = affine.load %arg3[%99 + 1] : memref<?xf64>
          %104 = arith.addf %102, %103 : f64
          %105 = arith.mulf %104, %cst : f64
          affine.store %105, %arg2[%99] : memref<?xf64>
          %106 = affine.apply #map8(%64)
          %107 = affine.load %arg3[%106 - 1] : memref<?xf64>
          %108 = affine.load %arg3[%106] : memref<?xf64>
          %109 = arith.addf %107, %108 : f64
          %110 = affine.load %arg3[%106 + 1] : memref<?xf64>
          %111 = arith.addf %109, %110 : f64
          %112 = arith.mulf %111, %cst : f64
          affine.store %112, %arg2[%106] : memref<?xf64>
          %113 = affine.apply #map9(%64)
          %114 = affine.load %arg3[%113 - 1] : memref<?xf64>
          %115 = affine.load %arg3[%113] : memref<?xf64>
          %116 = arith.addf %114, %115 : f64
          %117 = affine.load %arg3[%113 + 1] : memref<?xf64>
          %118 = arith.addf %116, %117 : f64
          %119 = arith.mulf %118, %cst : f64
          affine.store %119, %arg2[%113] : memref<?xf64>
          %120 = affine.apply #map10(%64)
          %121 = affine.load %arg3[%120 - 1] : memref<?xf64>
          %122 = affine.load %arg3[%120] : memref<?xf64>
          %123 = arith.addf %121, %122 : f64
          %124 = affine.load %arg3[%120 + 1] : memref<?xf64>
          %125 = arith.addf %123, %124 : f64
          %126 = arith.mulf %125, %cst : f64
          affine.store %126, %arg2[%120] : memref<?xf64>
          %127 = affine.apply #map12(%arg6)
          %128 = affine.load %arg3[%127 - 1] : memref<?xf64>
          %129 = affine.load %arg3[%127] : memref<?xf64>
          %130 = arith.addf %128, %129 : f64
          %131 = affine.load %arg3[%127 + 1] : memref<?xf64>
          %132 = arith.addf %130, %131 : f64
          %133 = arith.mulf %132, %cst : f64
          affine.store %133, %arg2[%127] : memref<?xf64>
          %134 = affine.apply #map3(%127)
          %135 = affine.load %arg3[%134 - 1] : memref<?xf64>
          %136 = affine.load %arg3[%134] : memref<?xf64>
          %137 = arith.addf %135, %136 : f64
          %138 = affine.load %arg3[%134 + 1] : memref<?xf64>
          %139 = arith.addf %137, %138 : f64
          %140 = arith.mulf %139, %cst : f64
          affine.store %140, %arg2[%134] : memref<?xf64>
          %141 = affine.apply #map4(%127)
          %142 = affine.load %arg3[%141 - 1] : memref<?xf64>
          %143 = affine.load %arg3[%141] : memref<?xf64>
          %144 = arith.addf %142, %143 : f64
          %145 = affine.load %arg3[%141 + 1] : memref<?xf64>
          %146 = arith.addf %144, %145 : f64
          %147 = arith.mulf %146, %cst : f64
          affine.store %147, %arg2[%141] : memref<?xf64>
          %148 = affine.apply #map5(%127)
          %149 = affine.load %arg3[%148 - 1] : memref<?xf64>
          %150 = affine.load %arg3[%148] : memref<?xf64>
          %151 = arith.addf %149, %150 : f64
          %152 = affine.load %arg3[%148 + 1] : memref<?xf64>
          %153 = arith.addf %151, %152 : f64
          %154 = arith.mulf %153, %cst : f64
          affine.store %154, %arg2[%148] : memref<?xf64>
          %155 = affine.apply #map6(%127)
          %156 = affine.load %arg3[%155 - 1] : memref<?xf64>
          %157 = affine.load %arg3[%155] : memref<?xf64>
          %158 = arith.addf %156, %157 : f64
          %159 = affine.load %arg3[%155 + 1] : memref<?xf64>
          %160 = arith.addf %158, %159 : f64
          %161 = arith.mulf %160, %cst : f64
          affine.store %161, %arg2[%155] : memref<?xf64>
          %162 = affine.apply #map7(%127)
          %163 = affine.load %arg3[%162 - 1] : memref<?xf64>
          %164 = affine.load %arg3[%162] : memref<?xf64>
          %165 = arith.addf %163, %164 : f64
          %166 = affine.load %arg3[%162 + 1] : memref<?xf64>
          %167 = arith.addf %165, %166 : f64
          %168 = arith.mulf %167, %cst : f64
          affine.store %168, %arg2[%162] : memref<?xf64>
          %169 = affine.apply #map8(%127)
          %170 = affine.load %arg3[%169 - 1] : memref<?xf64>
          %171 = affine.load %arg3[%169] : memref<?xf64>
          %172 = arith.addf %170, %171 : f64
          %173 = affine.load %arg3[%169 + 1] : memref<?xf64>
          %174 = arith.addf %172, %173 : f64
          %175 = arith.mulf %174, %cst : f64
          affine.store %175, %arg2[%169] : memref<?xf64>
          %176 = affine.apply #map9(%127)
          %177 = affine.load %arg3[%176 - 1] : memref<?xf64>
          %178 = affine.load %arg3[%176] : memref<?xf64>
          %179 = arith.addf %177, %178 : f64
          %180 = affine.load %arg3[%176 + 1] : memref<?xf64>
          %181 = arith.addf %179, %180 : f64
          %182 = arith.mulf %181, %cst : f64
          affine.store %182, %arg2[%176] : memref<?xf64>
          %183 = affine.apply #map10(%127)
          %184 = affine.load %arg3[%183 - 1] : memref<?xf64>
          %185 = affine.load %arg3[%183] : memref<?xf64>
          %186 = arith.addf %184, %185 : f64
          %187 = affine.load %arg3[%183 + 1] : memref<?xf64>
          %188 = arith.addf %186, %187 : f64
          %189 = arith.mulf %188, %cst : f64
          affine.store %189, %arg2[%183] : memref<?xf64>
          %190 = affine.apply #map13(%arg6)
          %191 = affine.load %arg3[%190 - 1] : memref<?xf64>
          %192 = affine.load %arg3[%190] : memref<?xf64>
          %193 = arith.addf %191, %192 : f64
          %194 = affine.load %arg3[%190 + 1] : memref<?xf64>
          %195 = arith.addf %193, %194 : f64
          %196 = arith.mulf %195, %cst : f64
          affine.store %196, %arg2[%190] : memref<?xf64>
          %197 = affine.apply #map3(%190)
          %198 = affine.load %arg3[%197 - 1] : memref<?xf64>
          %199 = affine.load %arg3[%197] : memref<?xf64>
          %200 = arith.addf %198, %199 : f64
          %201 = affine.load %arg3[%197 + 1] : memref<?xf64>
          %202 = arith.addf %200, %201 : f64
          %203 = arith.mulf %202, %cst : f64
          affine.store %203, %arg2[%197] : memref<?xf64>
          %204 = affine.apply #map4(%190)
          %205 = affine.load %arg3[%204 - 1] : memref<?xf64>
          %206 = affine.load %arg3[%204] : memref<?xf64>
          %207 = arith.addf %205, %206 : f64
          %208 = affine.load %arg3[%204 + 1] : memref<?xf64>
          %209 = arith.addf %207, %208 : f64
          %210 = arith.mulf %209, %cst : f64
          affine.store %210, %arg2[%204] : memref<?xf64>
          %211 = affine.apply #map5(%190)
          %212 = affine.load %arg3[%211 - 1] : memref<?xf64>
          %213 = affine.load %arg3[%211] : memref<?xf64>
          %214 = arith.addf %212, %213 : f64
          %215 = affine.load %arg3[%211 + 1] : memref<?xf64>
          %216 = arith.addf %214, %215 : f64
          %217 = arith.mulf %216, %cst : f64
          affine.store %217, %arg2[%211] : memref<?xf64>
          %218 = affine.apply #map6(%190)
          %219 = affine.load %arg3[%218 - 1] : memref<?xf64>
          %220 = affine.load %arg3[%218] : memref<?xf64>
          %221 = arith.addf %219, %220 : f64
          %222 = affine.load %arg3[%218 + 1] : memref<?xf64>
          %223 = arith.addf %221, %222 : f64
          %224 = arith.mulf %223, %cst : f64
          affine.store %224, %arg2[%218] : memref<?xf64>
          %225 = affine.apply #map7(%190)
          %226 = affine.load %arg3[%225 - 1] : memref<?xf64>
          %227 = affine.load %arg3[%225] : memref<?xf64>
          %228 = arith.addf %226, %227 : f64
          %229 = affine.load %arg3[%225 + 1] : memref<?xf64>
          %230 = arith.addf %228, %229 : f64
          %231 = arith.mulf %230, %cst : f64
          affine.store %231, %arg2[%225] : memref<?xf64>
          %232 = affine.apply #map8(%190)
          %233 = affine.load %arg3[%232 - 1] : memref<?xf64>
          %234 = affine.load %arg3[%232] : memref<?xf64>
          %235 = arith.addf %233, %234 : f64
          %236 = affine.load %arg3[%232 + 1] : memref<?xf64>
          %237 = arith.addf %235, %236 : f64
          %238 = arith.mulf %237, %cst : f64
          affine.store %238, %arg2[%232] : memref<?xf64>
          %239 = affine.apply #map9(%190)
          %240 = affine.load %arg3[%239 - 1] : memref<?xf64>
          %241 = affine.load %arg3[%239] : memref<?xf64>
          %242 = arith.addf %240, %241 : f64
          %243 = affine.load %arg3[%239 + 1] : memref<?xf64>
          %244 = arith.addf %242, %243 : f64
          %245 = arith.mulf %244, %cst : f64
          affine.store %245, %arg2[%239] : memref<?xf64>
          %246 = affine.apply #map10(%190)
          %247 = affine.load %arg3[%246 - 1] : memref<?xf64>
          %248 = affine.load %arg3[%246] : memref<?xf64>
          %249 = arith.addf %247, %248 : f64
          %250 = affine.load %arg3[%246 + 1] : memref<?xf64>
          %251 = arith.addf %249, %250 : f64
          %252 = arith.mulf %251, %cst : f64
          affine.store %252, %arg2[%246] : memref<?xf64>
          %253 = affine.apply #map14(%arg6)
          %254 = affine.load %arg3[%253 - 1] : memref<?xf64>
          %255 = affine.load %arg3[%253] : memref<?xf64>
          %256 = arith.addf %254, %255 : f64
          %257 = affine.load %arg3[%253 + 1] : memref<?xf64>
          %258 = arith.addf %256, %257 : f64
          %259 = arith.mulf %258, %cst : f64
          affine.store %259, %arg2[%253] : memref<?xf64>
          %260 = affine.apply #map3(%253)
          %261 = affine.load %arg3[%260 - 1] : memref<?xf64>
          %262 = affine.load %arg3[%260] : memref<?xf64>
          %263 = arith.addf %261, %262 : f64
          %264 = affine.load %arg3[%260 + 1] : memref<?xf64>
          %265 = arith.addf %263, %264 : f64
          %266 = arith.mulf %265, %cst : f64
          affine.store %266, %arg2[%260] : memref<?xf64>
          %267 = affine.apply #map4(%253)
          %268 = affine.load %arg3[%267 - 1] : memref<?xf64>
          %269 = affine.load %arg3[%267] : memref<?xf64>
          %270 = arith.addf %268, %269 : f64
          %271 = affine.load %arg3[%267 + 1] : memref<?xf64>
          %272 = arith.addf %270, %271 : f64
          %273 = arith.mulf %272, %cst : f64
          affine.store %273, %arg2[%267] : memref<?xf64>
          %274 = affine.apply #map5(%253)
          %275 = affine.load %arg3[%274 - 1] : memref<?xf64>
          %276 = affine.load %arg3[%274] : memref<?xf64>
          %277 = arith.addf %275, %276 : f64
          %278 = affine.load %arg3[%274 + 1] : memref<?xf64>
          %279 = arith.addf %277, %278 : f64
          %280 = arith.mulf %279, %cst : f64
          affine.store %280, %arg2[%274] : memref<?xf64>
          %281 = affine.apply #map6(%253)
          %282 = affine.load %arg3[%281 - 1] : memref<?xf64>
          %283 = affine.load %arg3[%281] : memref<?xf64>
          %284 = arith.addf %282, %283 : f64
          %285 = affine.load %arg3[%281 + 1] : memref<?xf64>
          %286 = arith.addf %284, %285 : f64
          %287 = arith.mulf %286, %cst : f64
          affine.store %287, %arg2[%281] : memref<?xf64>
          %288 = affine.apply #map7(%253)
          %289 = affine.load %arg3[%288 - 1] : memref<?xf64>
          %290 = affine.load %arg3[%288] : memref<?xf64>
          %291 = arith.addf %289, %290 : f64
          %292 = affine.load %arg3[%288 + 1] : memref<?xf64>
          %293 = arith.addf %291, %292 : f64
          %294 = arith.mulf %293, %cst : f64
          affine.store %294, %arg2[%288] : memref<?xf64>
          %295 = affine.apply #map8(%253)
          %296 = affine.load %arg3[%295 - 1] : memref<?xf64>
          %297 = affine.load %arg3[%295] : memref<?xf64>
          %298 = arith.addf %296, %297 : f64
          %299 = affine.load %arg3[%295 + 1] : memref<?xf64>
          %300 = arith.addf %298, %299 : f64
          %301 = arith.mulf %300, %cst : f64
          affine.store %301, %arg2[%295] : memref<?xf64>
          %302 = affine.apply #map9(%253)
          %303 = affine.load %arg3[%302 - 1] : memref<?xf64>
          %304 = affine.load %arg3[%302] : memref<?xf64>
          %305 = arith.addf %303, %304 : f64
          %306 = affine.load %arg3[%302 + 1] : memref<?xf64>
          %307 = arith.addf %305, %306 : f64
          %308 = arith.mulf %307, %cst : f64
          affine.store %308, %arg2[%302] : memref<?xf64>
          %309 = affine.apply #map10(%253)
          %310 = affine.load %arg3[%309 - 1] : memref<?xf64>
          %311 = affine.load %arg3[%309] : memref<?xf64>
          %312 = arith.addf %310, %311 : f64
          %313 = affine.load %arg3[%309 + 1] : memref<?xf64>
          %314 = arith.addf %312, %313 : f64
          %315 = arith.mulf %314, %cst : f64
          affine.store %315, %arg2[%309] : memref<?xf64>
        }
        affine.for %arg6 = #map2()[%0] to #map15()[%0] step 9 {
          %2 = affine.load %arg3[%arg6 - 1] : memref<?xf64>
          %3 = affine.load %arg3[%arg6] : memref<?xf64>
          %4 = arith.addf %2, %3 : f64
          %5 = affine.load %arg3[%arg6 + 1] : memref<?xf64>
          %6 = arith.addf %4, %5 : f64
          %7 = arith.mulf %6, %cst : f64
          affine.store %7, %arg2[%arg6] : memref<?xf64>
          %8 = affine.apply #map3(%arg6)
          %9 = affine.load %arg3[%8 - 1] : memref<?xf64>
          %10 = affine.load %arg3[%8] : memref<?xf64>
          %11 = arith.addf %9, %10 : f64
          %12 = affine.load %arg3[%8 + 1] : memref<?xf64>
          %13 = arith.addf %11, %12 : f64
          %14 = arith.mulf %13, %cst : f64
          affine.store %14, %arg2[%8] : memref<?xf64>
          %15 = affine.apply #map4(%arg6)
          %16 = affine.load %arg3[%15 - 1] : memref<?xf64>
          %17 = affine.load %arg3[%15] : memref<?xf64>
          %18 = arith.addf %16, %17 : f64
          %19 = affine.load %arg3[%15 + 1] : memref<?xf64>
          %20 = arith.addf %18, %19 : f64
          %21 = arith.mulf %20, %cst : f64
          affine.store %21, %arg2[%15] : memref<?xf64>
          %22 = affine.apply #map5(%arg6)
          %23 = affine.load %arg3[%22 - 1] : memref<?xf64>
          %24 = affine.load %arg3[%22] : memref<?xf64>
          %25 = arith.addf %23, %24 : f64
          %26 = affine.load %arg3[%22 + 1] : memref<?xf64>
          %27 = arith.addf %25, %26 : f64
          %28 = arith.mulf %27, %cst : f64
          affine.store %28, %arg2[%22] : memref<?xf64>
          %29 = affine.apply #map6(%arg6)
          %30 = affine.load %arg3[%29 - 1] : memref<?xf64>
          %31 = affine.load %arg3[%29] : memref<?xf64>
          %32 = arith.addf %30, %31 : f64
          %33 = affine.load %arg3[%29 + 1] : memref<?xf64>
          %34 = arith.addf %32, %33 : f64
          %35 = arith.mulf %34, %cst : f64
          affine.store %35, %arg2[%29] : memref<?xf64>
          %36 = affine.apply #map7(%arg6)
          %37 = affine.load %arg3[%36 - 1] : memref<?xf64>
          %38 = affine.load %arg3[%36] : memref<?xf64>
          %39 = arith.addf %37, %38 : f64
          %40 = affine.load %arg3[%36 + 1] : memref<?xf64>
          %41 = arith.addf %39, %40 : f64
          %42 = arith.mulf %41, %cst : f64
          affine.store %42, %arg2[%36] : memref<?xf64>
          %43 = affine.apply #map8(%arg6)
          %44 = affine.load %arg3[%43 - 1] : memref<?xf64>
          %45 = affine.load %arg3[%43] : memref<?xf64>
          %46 = arith.addf %44, %45 : f64
          %47 = affine.load %arg3[%43 + 1] : memref<?xf64>
          %48 = arith.addf %46, %47 : f64
          %49 = arith.mulf %48, %cst : f64
          affine.store %49, %arg2[%43] : memref<?xf64>
          %50 = affine.apply #map9(%arg6)
          %51 = affine.load %arg3[%50 - 1] : memref<?xf64>
          %52 = affine.load %arg3[%50] : memref<?xf64>
          %53 = arith.addf %51, %52 : f64
          %54 = affine.load %arg3[%50 + 1] : memref<?xf64>
          %55 = arith.addf %53, %54 : f64
          %56 = arith.mulf %55, %cst : f64
          affine.store %56, %arg2[%50] : memref<?xf64>
          %57 = affine.apply #map10(%arg6)
          %58 = affine.load %arg3[%57 - 1] : memref<?xf64>
          %59 = affine.load %arg3[%57] : memref<?xf64>
          %60 = arith.addf %58, %59 : f64
          %61 = affine.load %arg3[%57 + 1] : memref<?xf64>
          %62 = arith.addf %60, %61 : f64
          %63 = arith.mulf %62, %cst : f64
          affine.store %63, %arg2[%57] : memref<?xf64>
        }
        affine.for %arg6 = #map15()[%0] to #map16()[%0] step 5 {
          %2 = affine.load %arg3[%arg6 - 1] : memref<?xf64>
          %3 = affine.load %arg3[%arg6] : memref<?xf64>
          %4 = arith.addf %2, %3 : f64
          %5 = affine.load %arg3[%arg6 + 1] : memref<?xf64>
          %6 = arith.addf %4, %5 : f64
          %7 = arith.mulf %6, %cst : f64
          affine.store %7, %arg2[%arg6] : memref<?xf64>
          %8 = affine.apply #map3(%arg6)
          %9 = affine.load %arg3[%8 - 1] : memref<?xf64>
          %10 = affine.load %arg3[%8] : memref<?xf64>
          %11 = arith.addf %9, %10 : f64
          %12 = affine.load %arg3[%8 + 1] : memref<?xf64>
          %13 = arith.addf %11, %12 : f64
          %14 = arith.mulf %13, %cst : f64
          affine.store %14, %arg2[%8] : memref<?xf64>
          %15 = affine.apply #map4(%arg6)
          %16 = affine.load %arg3[%15 - 1] : memref<?xf64>
          %17 = affine.load %arg3[%15] : memref<?xf64>
          %18 = arith.addf %16, %17 : f64
          %19 = affine.load %arg3[%15 + 1] : memref<?xf64>
          %20 = arith.addf %18, %19 : f64
          %21 = arith.mulf %20, %cst : f64
          affine.store %21, %arg2[%15] : memref<?xf64>
          %22 = affine.apply #map5(%arg6)
          %23 = affine.load %arg3[%22 - 1] : memref<?xf64>
          %24 = affine.load %arg3[%22] : memref<?xf64>
          %25 = arith.addf %23, %24 : f64
          %26 = affine.load %arg3[%22 + 1] : memref<?xf64>
          %27 = arith.addf %25, %26 : f64
          %28 = arith.mulf %27, %cst : f64
          affine.store %28, %arg2[%22] : memref<?xf64>
          %29 = affine.apply #map6(%arg6)
          %30 = affine.load %arg3[%29 - 1] : memref<?xf64>
          %31 = affine.load %arg3[%29] : memref<?xf64>
          %32 = arith.addf %30, %31 : f64
          %33 = affine.load %arg3[%29 + 1] : memref<?xf64>
          %34 = arith.addf %32, %33 : f64
          %35 = arith.mulf %34, %cst : f64
          affine.store %35, %arg2[%29] : memref<?xf64>
        }
        affine.for %arg6 = #map16()[%0] to #map17()[%0] {
          %2 = affine.load %arg3[%arg6 - 1] : memref<?xf64>
          %3 = affine.load %arg3[%arg6] : memref<?xf64>
          %4 = arith.addf %2, %3 : f64
          %5 = affine.load %arg3[%arg6 + 1] : memref<?xf64>
          %6 = arith.addf %4, %5 : f64
          %7 = arith.mulf %6, %cst : f64
          affine.store %7, %arg2[%arg6] : memref<?xf64>
        }
      }
    }
    return
  }
}

