#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 40, s0)>
#map2 = affine_map<()[s0] -> ((((s0 - 2) floordiv 14) floordiv 6) * 84 + 1)>
#map3 = affine_map<(d0) -> (d0 + 1)>
#map4 = affine_map<(d0) -> (d0 + 2)>
#map5 = affine_map<(d0) -> (d0 + 3)>
#map6 = affine_map<(d0) -> (d0 + 4)>
#map7 = affine_map<(d0) -> (d0 + 5)>
#map8 = affine_map<(d0) -> (d0 + 6)>
#map9 = affine_map<(d0) -> (d0 + 7)>
#map10 = affine_map<(d0) -> (d0 + 8)>
#map11 = affine_map<(d0) -> (d0 + 9)>
#map12 = affine_map<(d0) -> (d0 + 10)>
#map13 = affine_map<(d0) -> (d0 + 11)>
#map14 = affine_map<(d0) -> (d0 + 12)>
#map15 = affine_map<(d0) -> (d0 + 13)>
#map16 = affine_map<(d0) -> (d0 + 14)>
#map17 = affine_map<(d0) -> (d0 + 28)>
#map18 = affine_map<(d0) -> (d0 + 42)>
#map19 = affine_map<(d0) -> (d0 + 56)>
#map20 = affine_map<(d0) -> (d0 + 70)>
#map21 = affine_map<()[s0] -> (((s0 - 2) floordiv 14) * 14 + 1)>
#map22 = affine_map<()[s0] -> (((s0 - 2) floordiv 14) * 14 + ((s0 - ((s0 - 2) floordiv 14) * 14 - 2) floordiv 6) * 6 + 1)>
#map23 = affine_map<()[s0] -> (s0 - 1)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>, #dlti.dl_entry<"dlti.endianness", "little">>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_jacobi_1d(%arg0: i32, %arg1: i32, %arg2: memref<?xf64>, %arg3: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 3.333300e-01 : f64
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg0 : i32 to index
    affine.for %arg4 = 0 to %1 step 40 {
      affine.for %arg5 = #map(%arg4) to min #map1(%arg4)[%1] {
        affine.for %arg6 = 1 to #map2()[%0] step 84 {
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
          %71 = affine.apply #map12(%arg6)
          %72 = affine.load %arg2[%71 - 1] : memref<?xf64>
          %73 = affine.load %arg2[%71] : memref<?xf64>
          %74 = arith.addf %72, %73 : f64
          %75 = affine.load %arg2[%71 + 1] : memref<?xf64>
          %76 = arith.addf %74, %75 : f64
          %77 = arith.mulf %76, %cst : f64
          affine.store %77, %arg3[%71] : memref<?xf64>
          %78 = affine.apply #map13(%arg6)
          %79 = affine.load %arg2[%78 - 1] : memref<?xf64>
          %80 = affine.load %arg2[%78] : memref<?xf64>
          %81 = arith.addf %79, %80 : f64
          %82 = affine.load %arg2[%78 + 1] : memref<?xf64>
          %83 = arith.addf %81, %82 : f64
          %84 = arith.mulf %83, %cst : f64
          affine.store %84, %arg3[%78] : memref<?xf64>
          %85 = affine.apply #map14(%arg6)
          %86 = affine.load %arg2[%85 - 1] : memref<?xf64>
          %87 = affine.load %arg2[%85] : memref<?xf64>
          %88 = arith.addf %86, %87 : f64
          %89 = affine.load %arg2[%85 + 1] : memref<?xf64>
          %90 = arith.addf %88, %89 : f64
          %91 = arith.mulf %90, %cst : f64
          affine.store %91, %arg3[%85] : memref<?xf64>
          %92 = affine.apply #map15(%arg6)
          %93 = affine.load %arg2[%92 - 1] : memref<?xf64>
          %94 = affine.load %arg2[%92] : memref<?xf64>
          %95 = arith.addf %93, %94 : f64
          %96 = affine.load %arg2[%92 + 1] : memref<?xf64>
          %97 = arith.addf %95, %96 : f64
          %98 = arith.mulf %97, %cst : f64
          affine.store %98, %arg3[%92] : memref<?xf64>
          %99 = affine.apply #map16(%arg6)
          %100 = affine.load %arg2[%99 - 1] : memref<?xf64>
          %101 = affine.load %arg2[%99] : memref<?xf64>
          %102 = arith.addf %100, %101 : f64
          %103 = affine.load %arg2[%99 + 1] : memref<?xf64>
          %104 = arith.addf %102, %103 : f64
          %105 = arith.mulf %104, %cst : f64
          affine.store %105, %arg3[%99] : memref<?xf64>
          %106 = affine.apply #map3(%99)
          %107 = affine.load %arg2[%106 - 1] : memref<?xf64>
          %108 = affine.load %arg2[%106] : memref<?xf64>
          %109 = arith.addf %107, %108 : f64
          %110 = affine.load %arg2[%106 + 1] : memref<?xf64>
          %111 = arith.addf %109, %110 : f64
          %112 = arith.mulf %111, %cst : f64
          affine.store %112, %arg3[%106] : memref<?xf64>
          %113 = affine.apply #map4(%99)
          %114 = affine.load %arg2[%113 - 1] : memref<?xf64>
          %115 = affine.load %arg2[%113] : memref<?xf64>
          %116 = arith.addf %114, %115 : f64
          %117 = affine.load %arg2[%113 + 1] : memref<?xf64>
          %118 = arith.addf %116, %117 : f64
          %119 = arith.mulf %118, %cst : f64
          affine.store %119, %arg3[%113] : memref<?xf64>
          %120 = affine.apply #map5(%99)
          %121 = affine.load %arg2[%120 - 1] : memref<?xf64>
          %122 = affine.load %arg2[%120] : memref<?xf64>
          %123 = arith.addf %121, %122 : f64
          %124 = affine.load %arg2[%120 + 1] : memref<?xf64>
          %125 = arith.addf %123, %124 : f64
          %126 = arith.mulf %125, %cst : f64
          affine.store %126, %arg3[%120] : memref<?xf64>
          %127 = affine.apply #map6(%99)
          %128 = affine.load %arg2[%127 - 1] : memref<?xf64>
          %129 = affine.load %arg2[%127] : memref<?xf64>
          %130 = arith.addf %128, %129 : f64
          %131 = affine.load %arg2[%127 + 1] : memref<?xf64>
          %132 = arith.addf %130, %131 : f64
          %133 = arith.mulf %132, %cst : f64
          affine.store %133, %arg3[%127] : memref<?xf64>
          %134 = affine.apply #map7(%99)
          %135 = affine.load %arg2[%134 - 1] : memref<?xf64>
          %136 = affine.load %arg2[%134] : memref<?xf64>
          %137 = arith.addf %135, %136 : f64
          %138 = affine.load %arg2[%134 + 1] : memref<?xf64>
          %139 = arith.addf %137, %138 : f64
          %140 = arith.mulf %139, %cst : f64
          affine.store %140, %arg3[%134] : memref<?xf64>
          %141 = affine.apply #map8(%99)
          %142 = affine.load %arg2[%141 - 1] : memref<?xf64>
          %143 = affine.load %arg2[%141] : memref<?xf64>
          %144 = arith.addf %142, %143 : f64
          %145 = affine.load %arg2[%141 + 1] : memref<?xf64>
          %146 = arith.addf %144, %145 : f64
          %147 = arith.mulf %146, %cst : f64
          affine.store %147, %arg3[%141] : memref<?xf64>
          %148 = affine.apply #map9(%99)
          %149 = affine.load %arg2[%148 - 1] : memref<?xf64>
          %150 = affine.load %arg2[%148] : memref<?xf64>
          %151 = arith.addf %149, %150 : f64
          %152 = affine.load %arg2[%148 + 1] : memref<?xf64>
          %153 = arith.addf %151, %152 : f64
          %154 = arith.mulf %153, %cst : f64
          affine.store %154, %arg3[%148] : memref<?xf64>
          %155 = affine.apply #map10(%99)
          %156 = affine.load %arg2[%155 - 1] : memref<?xf64>
          %157 = affine.load %arg2[%155] : memref<?xf64>
          %158 = arith.addf %156, %157 : f64
          %159 = affine.load %arg2[%155 + 1] : memref<?xf64>
          %160 = arith.addf %158, %159 : f64
          %161 = arith.mulf %160, %cst : f64
          affine.store %161, %arg3[%155] : memref<?xf64>
          %162 = affine.apply #map11(%99)
          %163 = affine.load %arg2[%162 - 1] : memref<?xf64>
          %164 = affine.load %arg2[%162] : memref<?xf64>
          %165 = arith.addf %163, %164 : f64
          %166 = affine.load %arg2[%162 + 1] : memref<?xf64>
          %167 = arith.addf %165, %166 : f64
          %168 = arith.mulf %167, %cst : f64
          affine.store %168, %arg3[%162] : memref<?xf64>
          %169 = affine.apply #map12(%99)
          %170 = affine.load %arg2[%169 - 1] : memref<?xf64>
          %171 = affine.load %arg2[%169] : memref<?xf64>
          %172 = arith.addf %170, %171 : f64
          %173 = affine.load %arg2[%169 + 1] : memref<?xf64>
          %174 = arith.addf %172, %173 : f64
          %175 = arith.mulf %174, %cst : f64
          affine.store %175, %arg3[%169] : memref<?xf64>
          %176 = affine.apply #map13(%99)
          %177 = affine.load %arg2[%176 - 1] : memref<?xf64>
          %178 = affine.load %arg2[%176] : memref<?xf64>
          %179 = arith.addf %177, %178 : f64
          %180 = affine.load %arg2[%176 + 1] : memref<?xf64>
          %181 = arith.addf %179, %180 : f64
          %182 = arith.mulf %181, %cst : f64
          affine.store %182, %arg3[%176] : memref<?xf64>
          %183 = affine.apply #map14(%99)
          %184 = affine.load %arg2[%183 - 1] : memref<?xf64>
          %185 = affine.load %arg2[%183] : memref<?xf64>
          %186 = arith.addf %184, %185 : f64
          %187 = affine.load %arg2[%183 + 1] : memref<?xf64>
          %188 = arith.addf %186, %187 : f64
          %189 = arith.mulf %188, %cst : f64
          affine.store %189, %arg3[%183] : memref<?xf64>
          %190 = affine.apply #map15(%99)
          %191 = affine.load %arg2[%190 - 1] : memref<?xf64>
          %192 = affine.load %arg2[%190] : memref<?xf64>
          %193 = arith.addf %191, %192 : f64
          %194 = affine.load %arg2[%190 + 1] : memref<?xf64>
          %195 = arith.addf %193, %194 : f64
          %196 = arith.mulf %195, %cst : f64
          affine.store %196, %arg3[%190] : memref<?xf64>
          %197 = affine.apply #map17(%arg6)
          %198 = affine.load %arg2[%197 - 1] : memref<?xf64>
          %199 = affine.load %arg2[%197] : memref<?xf64>
          %200 = arith.addf %198, %199 : f64
          %201 = affine.load %arg2[%197 + 1] : memref<?xf64>
          %202 = arith.addf %200, %201 : f64
          %203 = arith.mulf %202, %cst : f64
          affine.store %203, %arg3[%197] : memref<?xf64>
          %204 = affine.apply #map3(%197)
          %205 = affine.load %arg2[%204 - 1] : memref<?xf64>
          %206 = affine.load %arg2[%204] : memref<?xf64>
          %207 = arith.addf %205, %206 : f64
          %208 = affine.load %arg2[%204 + 1] : memref<?xf64>
          %209 = arith.addf %207, %208 : f64
          %210 = arith.mulf %209, %cst : f64
          affine.store %210, %arg3[%204] : memref<?xf64>
          %211 = affine.apply #map4(%197)
          %212 = affine.load %arg2[%211 - 1] : memref<?xf64>
          %213 = affine.load %arg2[%211] : memref<?xf64>
          %214 = arith.addf %212, %213 : f64
          %215 = affine.load %arg2[%211 + 1] : memref<?xf64>
          %216 = arith.addf %214, %215 : f64
          %217 = arith.mulf %216, %cst : f64
          affine.store %217, %arg3[%211] : memref<?xf64>
          %218 = affine.apply #map5(%197)
          %219 = affine.load %arg2[%218 - 1] : memref<?xf64>
          %220 = affine.load %arg2[%218] : memref<?xf64>
          %221 = arith.addf %219, %220 : f64
          %222 = affine.load %arg2[%218 + 1] : memref<?xf64>
          %223 = arith.addf %221, %222 : f64
          %224 = arith.mulf %223, %cst : f64
          affine.store %224, %arg3[%218] : memref<?xf64>
          %225 = affine.apply #map6(%197)
          %226 = affine.load %arg2[%225 - 1] : memref<?xf64>
          %227 = affine.load %arg2[%225] : memref<?xf64>
          %228 = arith.addf %226, %227 : f64
          %229 = affine.load %arg2[%225 + 1] : memref<?xf64>
          %230 = arith.addf %228, %229 : f64
          %231 = arith.mulf %230, %cst : f64
          affine.store %231, %arg3[%225] : memref<?xf64>
          %232 = affine.apply #map7(%197)
          %233 = affine.load %arg2[%232 - 1] : memref<?xf64>
          %234 = affine.load %arg2[%232] : memref<?xf64>
          %235 = arith.addf %233, %234 : f64
          %236 = affine.load %arg2[%232 + 1] : memref<?xf64>
          %237 = arith.addf %235, %236 : f64
          %238 = arith.mulf %237, %cst : f64
          affine.store %238, %arg3[%232] : memref<?xf64>
          %239 = affine.apply #map8(%197)
          %240 = affine.load %arg2[%239 - 1] : memref<?xf64>
          %241 = affine.load %arg2[%239] : memref<?xf64>
          %242 = arith.addf %240, %241 : f64
          %243 = affine.load %arg2[%239 + 1] : memref<?xf64>
          %244 = arith.addf %242, %243 : f64
          %245 = arith.mulf %244, %cst : f64
          affine.store %245, %arg3[%239] : memref<?xf64>
          %246 = affine.apply #map9(%197)
          %247 = affine.load %arg2[%246 - 1] : memref<?xf64>
          %248 = affine.load %arg2[%246] : memref<?xf64>
          %249 = arith.addf %247, %248 : f64
          %250 = affine.load %arg2[%246 + 1] : memref<?xf64>
          %251 = arith.addf %249, %250 : f64
          %252 = arith.mulf %251, %cst : f64
          affine.store %252, %arg3[%246] : memref<?xf64>
          %253 = affine.apply #map10(%197)
          %254 = affine.load %arg2[%253 - 1] : memref<?xf64>
          %255 = affine.load %arg2[%253] : memref<?xf64>
          %256 = arith.addf %254, %255 : f64
          %257 = affine.load %arg2[%253 + 1] : memref<?xf64>
          %258 = arith.addf %256, %257 : f64
          %259 = arith.mulf %258, %cst : f64
          affine.store %259, %arg3[%253] : memref<?xf64>
          %260 = affine.apply #map11(%197)
          %261 = affine.load %arg2[%260 - 1] : memref<?xf64>
          %262 = affine.load %arg2[%260] : memref<?xf64>
          %263 = arith.addf %261, %262 : f64
          %264 = affine.load %arg2[%260 + 1] : memref<?xf64>
          %265 = arith.addf %263, %264 : f64
          %266 = arith.mulf %265, %cst : f64
          affine.store %266, %arg3[%260] : memref<?xf64>
          %267 = affine.apply #map12(%197)
          %268 = affine.load %arg2[%267 - 1] : memref<?xf64>
          %269 = affine.load %arg2[%267] : memref<?xf64>
          %270 = arith.addf %268, %269 : f64
          %271 = affine.load %arg2[%267 + 1] : memref<?xf64>
          %272 = arith.addf %270, %271 : f64
          %273 = arith.mulf %272, %cst : f64
          affine.store %273, %arg3[%267] : memref<?xf64>
          %274 = affine.apply #map13(%197)
          %275 = affine.load %arg2[%274 - 1] : memref<?xf64>
          %276 = affine.load %arg2[%274] : memref<?xf64>
          %277 = arith.addf %275, %276 : f64
          %278 = affine.load %arg2[%274 + 1] : memref<?xf64>
          %279 = arith.addf %277, %278 : f64
          %280 = arith.mulf %279, %cst : f64
          affine.store %280, %arg3[%274] : memref<?xf64>
          %281 = affine.apply #map14(%197)
          %282 = affine.load %arg2[%281 - 1] : memref<?xf64>
          %283 = affine.load %arg2[%281] : memref<?xf64>
          %284 = arith.addf %282, %283 : f64
          %285 = affine.load %arg2[%281 + 1] : memref<?xf64>
          %286 = arith.addf %284, %285 : f64
          %287 = arith.mulf %286, %cst : f64
          affine.store %287, %arg3[%281] : memref<?xf64>
          %288 = affine.apply #map15(%197)
          %289 = affine.load %arg2[%288 - 1] : memref<?xf64>
          %290 = affine.load %arg2[%288] : memref<?xf64>
          %291 = arith.addf %289, %290 : f64
          %292 = affine.load %arg2[%288 + 1] : memref<?xf64>
          %293 = arith.addf %291, %292 : f64
          %294 = arith.mulf %293, %cst : f64
          affine.store %294, %arg3[%288] : memref<?xf64>
          %295 = affine.apply #map18(%arg6)
          %296 = affine.load %arg2[%295 - 1] : memref<?xf64>
          %297 = affine.load %arg2[%295] : memref<?xf64>
          %298 = arith.addf %296, %297 : f64
          %299 = affine.load %arg2[%295 + 1] : memref<?xf64>
          %300 = arith.addf %298, %299 : f64
          %301 = arith.mulf %300, %cst : f64
          affine.store %301, %arg3[%295] : memref<?xf64>
          %302 = affine.apply #map3(%295)
          %303 = affine.load %arg2[%302 - 1] : memref<?xf64>
          %304 = affine.load %arg2[%302] : memref<?xf64>
          %305 = arith.addf %303, %304 : f64
          %306 = affine.load %arg2[%302 + 1] : memref<?xf64>
          %307 = arith.addf %305, %306 : f64
          %308 = arith.mulf %307, %cst : f64
          affine.store %308, %arg3[%302] : memref<?xf64>
          %309 = affine.apply #map4(%295)
          %310 = affine.load %arg2[%309 - 1] : memref<?xf64>
          %311 = affine.load %arg2[%309] : memref<?xf64>
          %312 = arith.addf %310, %311 : f64
          %313 = affine.load %arg2[%309 + 1] : memref<?xf64>
          %314 = arith.addf %312, %313 : f64
          %315 = arith.mulf %314, %cst : f64
          affine.store %315, %arg3[%309] : memref<?xf64>
          %316 = affine.apply #map5(%295)
          %317 = affine.load %arg2[%316 - 1] : memref<?xf64>
          %318 = affine.load %arg2[%316] : memref<?xf64>
          %319 = arith.addf %317, %318 : f64
          %320 = affine.load %arg2[%316 + 1] : memref<?xf64>
          %321 = arith.addf %319, %320 : f64
          %322 = arith.mulf %321, %cst : f64
          affine.store %322, %arg3[%316] : memref<?xf64>
          %323 = affine.apply #map6(%295)
          %324 = affine.load %arg2[%323 - 1] : memref<?xf64>
          %325 = affine.load %arg2[%323] : memref<?xf64>
          %326 = arith.addf %324, %325 : f64
          %327 = affine.load %arg2[%323 + 1] : memref<?xf64>
          %328 = arith.addf %326, %327 : f64
          %329 = arith.mulf %328, %cst : f64
          affine.store %329, %arg3[%323] : memref<?xf64>
          %330 = affine.apply #map7(%295)
          %331 = affine.load %arg2[%330 - 1] : memref<?xf64>
          %332 = affine.load %arg2[%330] : memref<?xf64>
          %333 = arith.addf %331, %332 : f64
          %334 = affine.load %arg2[%330 + 1] : memref<?xf64>
          %335 = arith.addf %333, %334 : f64
          %336 = arith.mulf %335, %cst : f64
          affine.store %336, %arg3[%330] : memref<?xf64>
          %337 = affine.apply #map8(%295)
          %338 = affine.load %arg2[%337 - 1] : memref<?xf64>
          %339 = affine.load %arg2[%337] : memref<?xf64>
          %340 = arith.addf %338, %339 : f64
          %341 = affine.load %arg2[%337 + 1] : memref<?xf64>
          %342 = arith.addf %340, %341 : f64
          %343 = arith.mulf %342, %cst : f64
          affine.store %343, %arg3[%337] : memref<?xf64>
          %344 = affine.apply #map9(%295)
          %345 = affine.load %arg2[%344 - 1] : memref<?xf64>
          %346 = affine.load %arg2[%344] : memref<?xf64>
          %347 = arith.addf %345, %346 : f64
          %348 = affine.load %arg2[%344 + 1] : memref<?xf64>
          %349 = arith.addf %347, %348 : f64
          %350 = arith.mulf %349, %cst : f64
          affine.store %350, %arg3[%344] : memref<?xf64>
          %351 = affine.apply #map10(%295)
          %352 = affine.load %arg2[%351 - 1] : memref<?xf64>
          %353 = affine.load %arg2[%351] : memref<?xf64>
          %354 = arith.addf %352, %353 : f64
          %355 = affine.load %arg2[%351 + 1] : memref<?xf64>
          %356 = arith.addf %354, %355 : f64
          %357 = arith.mulf %356, %cst : f64
          affine.store %357, %arg3[%351] : memref<?xf64>
          %358 = affine.apply #map11(%295)
          %359 = affine.load %arg2[%358 - 1] : memref<?xf64>
          %360 = affine.load %arg2[%358] : memref<?xf64>
          %361 = arith.addf %359, %360 : f64
          %362 = affine.load %arg2[%358 + 1] : memref<?xf64>
          %363 = arith.addf %361, %362 : f64
          %364 = arith.mulf %363, %cst : f64
          affine.store %364, %arg3[%358] : memref<?xf64>
          %365 = affine.apply #map12(%295)
          %366 = affine.load %arg2[%365 - 1] : memref<?xf64>
          %367 = affine.load %arg2[%365] : memref<?xf64>
          %368 = arith.addf %366, %367 : f64
          %369 = affine.load %arg2[%365 + 1] : memref<?xf64>
          %370 = arith.addf %368, %369 : f64
          %371 = arith.mulf %370, %cst : f64
          affine.store %371, %arg3[%365] : memref<?xf64>
          %372 = affine.apply #map13(%295)
          %373 = affine.load %arg2[%372 - 1] : memref<?xf64>
          %374 = affine.load %arg2[%372] : memref<?xf64>
          %375 = arith.addf %373, %374 : f64
          %376 = affine.load %arg2[%372 + 1] : memref<?xf64>
          %377 = arith.addf %375, %376 : f64
          %378 = arith.mulf %377, %cst : f64
          affine.store %378, %arg3[%372] : memref<?xf64>
          %379 = affine.apply #map14(%295)
          %380 = affine.load %arg2[%379 - 1] : memref<?xf64>
          %381 = affine.load %arg2[%379] : memref<?xf64>
          %382 = arith.addf %380, %381 : f64
          %383 = affine.load %arg2[%379 + 1] : memref<?xf64>
          %384 = arith.addf %382, %383 : f64
          %385 = arith.mulf %384, %cst : f64
          affine.store %385, %arg3[%379] : memref<?xf64>
          %386 = affine.apply #map15(%295)
          %387 = affine.load %arg2[%386 - 1] : memref<?xf64>
          %388 = affine.load %arg2[%386] : memref<?xf64>
          %389 = arith.addf %387, %388 : f64
          %390 = affine.load %arg2[%386 + 1] : memref<?xf64>
          %391 = arith.addf %389, %390 : f64
          %392 = arith.mulf %391, %cst : f64
          affine.store %392, %arg3[%386] : memref<?xf64>
          %393 = affine.apply #map19(%arg6)
          %394 = affine.load %arg2[%393 - 1] : memref<?xf64>
          %395 = affine.load %arg2[%393] : memref<?xf64>
          %396 = arith.addf %394, %395 : f64
          %397 = affine.load %arg2[%393 + 1] : memref<?xf64>
          %398 = arith.addf %396, %397 : f64
          %399 = arith.mulf %398, %cst : f64
          affine.store %399, %arg3[%393] : memref<?xf64>
          %400 = affine.apply #map3(%393)
          %401 = affine.load %arg2[%400 - 1] : memref<?xf64>
          %402 = affine.load %arg2[%400] : memref<?xf64>
          %403 = arith.addf %401, %402 : f64
          %404 = affine.load %arg2[%400 + 1] : memref<?xf64>
          %405 = arith.addf %403, %404 : f64
          %406 = arith.mulf %405, %cst : f64
          affine.store %406, %arg3[%400] : memref<?xf64>
          %407 = affine.apply #map4(%393)
          %408 = affine.load %arg2[%407 - 1] : memref<?xf64>
          %409 = affine.load %arg2[%407] : memref<?xf64>
          %410 = arith.addf %408, %409 : f64
          %411 = affine.load %arg2[%407 + 1] : memref<?xf64>
          %412 = arith.addf %410, %411 : f64
          %413 = arith.mulf %412, %cst : f64
          affine.store %413, %arg3[%407] : memref<?xf64>
          %414 = affine.apply #map5(%393)
          %415 = affine.load %arg2[%414 - 1] : memref<?xf64>
          %416 = affine.load %arg2[%414] : memref<?xf64>
          %417 = arith.addf %415, %416 : f64
          %418 = affine.load %arg2[%414 + 1] : memref<?xf64>
          %419 = arith.addf %417, %418 : f64
          %420 = arith.mulf %419, %cst : f64
          affine.store %420, %arg3[%414] : memref<?xf64>
          %421 = affine.apply #map6(%393)
          %422 = affine.load %arg2[%421 - 1] : memref<?xf64>
          %423 = affine.load %arg2[%421] : memref<?xf64>
          %424 = arith.addf %422, %423 : f64
          %425 = affine.load %arg2[%421 + 1] : memref<?xf64>
          %426 = arith.addf %424, %425 : f64
          %427 = arith.mulf %426, %cst : f64
          affine.store %427, %arg3[%421] : memref<?xf64>
          %428 = affine.apply #map7(%393)
          %429 = affine.load %arg2[%428 - 1] : memref<?xf64>
          %430 = affine.load %arg2[%428] : memref<?xf64>
          %431 = arith.addf %429, %430 : f64
          %432 = affine.load %arg2[%428 + 1] : memref<?xf64>
          %433 = arith.addf %431, %432 : f64
          %434 = arith.mulf %433, %cst : f64
          affine.store %434, %arg3[%428] : memref<?xf64>
          %435 = affine.apply #map8(%393)
          %436 = affine.load %arg2[%435 - 1] : memref<?xf64>
          %437 = affine.load %arg2[%435] : memref<?xf64>
          %438 = arith.addf %436, %437 : f64
          %439 = affine.load %arg2[%435 + 1] : memref<?xf64>
          %440 = arith.addf %438, %439 : f64
          %441 = arith.mulf %440, %cst : f64
          affine.store %441, %arg3[%435] : memref<?xf64>
          %442 = affine.apply #map9(%393)
          %443 = affine.load %arg2[%442 - 1] : memref<?xf64>
          %444 = affine.load %arg2[%442] : memref<?xf64>
          %445 = arith.addf %443, %444 : f64
          %446 = affine.load %arg2[%442 + 1] : memref<?xf64>
          %447 = arith.addf %445, %446 : f64
          %448 = arith.mulf %447, %cst : f64
          affine.store %448, %arg3[%442] : memref<?xf64>
          %449 = affine.apply #map10(%393)
          %450 = affine.load %arg2[%449 - 1] : memref<?xf64>
          %451 = affine.load %arg2[%449] : memref<?xf64>
          %452 = arith.addf %450, %451 : f64
          %453 = affine.load %arg2[%449 + 1] : memref<?xf64>
          %454 = arith.addf %452, %453 : f64
          %455 = arith.mulf %454, %cst : f64
          affine.store %455, %arg3[%449] : memref<?xf64>
          %456 = affine.apply #map11(%393)
          %457 = affine.load %arg2[%456 - 1] : memref<?xf64>
          %458 = affine.load %arg2[%456] : memref<?xf64>
          %459 = arith.addf %457, %458 : f64
          %460 = affine.load %arg2[%456 + 1] : memref<?xf64>
          %461 = arith.addf %459, %460 : f64
          %462 = arith.mulf %461, %cst : f64
          affine.store %462, %arg3[%456] : memref<?xf64>
          %463 = affine.apply #map12(%393)
          %464 = affine.load %arg2[%463 - 1] : memref<?xf64>
          %465 = affine.load %arg2[%463] : memref<?xf64>
          %466 = arith.addf %464, %465 : f64
          %467 = affine.load %arg2[%463 + 1] : memref<?xf64>
          %468 = arith.addf %466, %467 : f64
          %469 = arith.mulf %468, %cst : f64
          affine.store %469, %arg3[%463] : memref<?xf64>
          %470 = affine.apply #map13(%393)
          %471 = affine.load %arg2[%470 - 1] : memref<?xf64>
          %472 = affine.load %arg2[%470] : memref<?xf64>
          %473 = arith.addf %471, %472 : f64
          %474 = affine.load %arg2[%470 + 1] : memref<?xf64>
          %475 = arith.addf %473, %474 : f64
          %476 = arith.mulf %475, %cst : f64
          affine.store %476, %arg3[%470] : memref<?xf64>
          %477 = affine.apply #map14(%393)
          %478 = affine.load %arg2[%477 - 1] : memref<?xf64>
          %479 = affine.load %arg2[%477] : memref<?xf64>
          %480 = arith.addf %478, %479 : f64
          %481 = affine.load %arg2[%477 + 1] : memref<?xf64>
          %482 = arith.addf %480, %481 : f64
          %483 = arith.mulf %482, %cst : f64
          affine.store %483, %arg3[%477] : memref<?xf64>
          %484 = affine.apply #map15(%393)
          %485 = affine.load %arg2[%484 - 1] : memref<?xf64>
          %486 = affine.load %arg2[%484] : memref<?xf64>
          %487 = arith.addf %485, %486 : f64
          %488 = affine.load %arg2[%484 + 1] : memref<?xf64>
          %489 = arith.addf %487, %488 : f64
          %490 = arith.mulf %489, %cst : f64
          affine.store %490, %arg3[%484] : memref<?xf64>
          %491 = affine.apply #map20(%arg6)
          %492 = affine.load %arg2[%491 - 1] : memref<?xf64>
          %493 = affine.load %arg2[%491] : memref<?xf64>
          %494 = arith.addf %492, %493 : f64
          %495 = affine.load %arg2[%491 + 1] : memref<?xf64>
          %496 = arith.addf %494, %495 : f64
          %497 = arith.mulf %496, %cst : f64
          affine.store %497, %arg3[%491] : memref<?xf64>
          %498 = affine.apply #map3(%491)
          %499 = affine.load %arg2[%498 - 1] : memref<?xf64>
          %500 = affine.load %arg2[%498] : memref<?xf64>
          %501 = arith.addf %499, %500 : f64
          %502 = affine.load %arg2[%498 + 1] : memref<?xf64>
          %503 = arith.addf %501, %502 : f64
          %504 = arith.mulf %503, %cst : f64
          affine.store %504, %arg3[%498] : memref<?xf64>
          %505 = affine.apply #map4(%491)
          %506 = affine.load %arg2[%505 - 1] : memref<?xf64>
          %507 = affine.load %arg2[%505] : memref<?xf64>
          %508 = arith.addf %506, %507 : f64
          %509 = affine.load %arg2[%505 + 1] : memref<?xf64>
          %510 = arith.addf %508, %509 : f64
          %511 = arith.mulf %510, %cst : f64
          affine.store %511, %arg3[%505] : memref<?xf64>
          %512 = affine.apply #map5(%491)
          %513 = affine.load %arg2[%512 - 1] : memref<?xf64>
          %514 = affine.load %arg2[%512] : memref<?xf64>
          %515 = arith.addf %513, %514 : f64
          %516 = affine.load %arg2[%512 + 1] : memref<?xf64>
          %517 = arith.addf %515, %516 : f64
          %518 = arith.mulf %517, %cst : f64
          affine.store %518, %arg3[%512] : memref<?xf64>
          %519 = affine.apply #map6(%491)
          %520 = affine.load %arg2[%519 - 1] : memref<?xf64>
          %521 = affine.load %arg2[%519] : memref<?xf64>
          %522 = arith.addf %520, %521 : f64
          %523 = affine.load %arg2[%519 + 1] : memref<?xf64>
          %524 = arith.addf %522, %523 : f64
          %525 = arith.mulf %524, %cst : f64
          affine.store %525, %arg3[%519] : memref<?xf64>
          %526 = affine.apply #map7(%491)
          %527 = affine.load %arg2[%526 - 1] : memref<?xf64>
          %528 = affine.load %arg2[%526] : memref<?xf64>
          %529 = arith.addf %527, %528 : f64
          %530 = affine.load %arg2[%526 + 1] : memref<?xf64>
          %531 = arith.addf %529, %530 : f64
          %532 = arith.mulf %531, %cst : f64
          affine.store %532, %arg3[%526] : memref<?xf64>
          %533 = affine.apply #map8(%491)
          %534 = affine.load %arg2[%533 - 1] : memref<?xf64>
          %535 = affine.load %arg2[%533] : memref<?xf64>
          %536 = arith.addf %534, %535 : f64
          %537 = affine.load %arg2[%533 + 1] : memref<?xf64>
          %538 = arith.addf %536, %537 : f64
          %539 = arith.mulf %538, %cst : f64
          affine.store %539, %arg3[%533] : memref<?xf64>
          %540 = affine.apply #map9(%491)
          %541 = affine.load %arg2[%540 - 1] : memref<?xf64>
          %542 = affine.load %arg2[%540] : memref<?xf64>
          %543 = arith.addf %541, %542 : f64
          %544 = affine.load %arg2[%540 + 1] : memref<?xf64>
          %545 = arith.addf %543, %544 : f64
          %546 = arith.mulf %545, %cst : f64
          affine.store %546, %arg3[%540] : memref<?xf64>
          %547 = affine.apply #map10(%491)
          %548 = affine.load %arg2[%547 - 1] : memref<?xf64>
          %549 = affine.load %arg2[%547] : memref<?xf64>
          %550 = arith.addf %548, %549 : f64
          %551 = affine.load %arg2[%547 + 1] : memref<?xf64>
          %552 = arith.addf %550, %551 : f64
          %553 = arith.mulf %552, %cst : f64
          affine.store %553, %arg3[%547] : memref<?xf64>
          %554 = affine.apply #map11(%491)
          %555 = affine.load %arg2[%554 - 1] : memref<?xf64>
          %556 = affine.load %arg2[%554] : memref<?xf64>
          %557 = arith.addf %555, %556 : f64
          %558 = affine.load %arg2[%554 + 1] : memref<?xf64>
          %559 = arith.addf %557, %558 : f64
          %560 = arith.mulf %559, %cst : f64
          affine.store %560, %arg3[%554] : memref<?xf64>
          %561 = affine.apply #map12(%491)
          %562 = affine.load %arg2[%561 - 1] : memref<?xf64>
          %563 = affine.load %arg2[%561] : memref<?xf64>
          %564 = arith.addf %562, %563 : f64
          %565 = affine.load %arg2[%561 + 1] : memref<?xf64>
          %566 = arith.addf %564, %565 : f64
          %567 = arith.mulf %566, %cst : f64
          affine.store %567, %arg3[%561] : memref<?xf64>
          %568 = affine.apply #map13(%491)
          %569 = affine.load %arg2[%568 - 1] : memref<?xf64>
          %570 = affine.load %arg2[%568] : memref<?xf64>
          %571 = arith.addf %569, %570 : f64
          %572 = affine.load %arg2[%568 + 1] : memref<?xf64>
          %573 = arith.addf %571, %572 : f64
          %574 = arith.mulf %573, %cst : f64
          affine.store %574, %arg3[%568] : memref<?xf64>
          %575 = affine.apply #map14(%491)
          %576 = affine.load %arg2[%575 - 1] : memref<?xf64>
          %577 = affine.load %arg2[%575] : memref<?xf64>
          %578 = arith.addf %576, %577 : f64
          %579 = affine.load %arg2[%575 + 1] : memref<?xf64>
          %580 = arith.addf %578, %579 : f64
          %581 = arith.mulf %580, %cst : f64
          affine.store %581, %arg3[%575] : memref<?xf64>
          %582 = affine.apply #map15(%491)
          %583 = affine.load %arg2[%582 - 1] : memref<?xf64>
          %584 = affine.load %arg2[%582] : memref<?xf64>
          %585 = arith.addf %583, %584 : f64
          %586 = affine.load %arg2[%582 + 1] : memref<?xf64>
          %587 = arith.addf %585, %586 : f64
          %588 = arith.mulf %587, %cst : f64
          affine.store %588, %arg3[%582] : memref<?xf64>
        }
        affine.for %arg6 = #map2()[%0] to #map21()[%0] step 14 {
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
          %71 = affine.apply #map12(%arg6)
          %72 = affine.load %arg2[%71 - 1] : memref<?xf64>
          %73 = affine.load %arg2[%71] : memref<?xf64>
          %74 = arith.addf %72, %73 : f64
          %75 = affine.load %arg2[%71 + 1] : memref<?xf64>
          %76 = arith.addf %74, %75 : f64
          %77 = arith.mulf %76, %cst : f64
          affine.store %77, %arg3[%71] : memref<?xf64>
          %78 = affine.apply #map13(%arg6)
          %79 = affine.load %arg2[%78 - 1] : memref<?xf64>
          %80 = affine.load %arg2[%78] : memref<?xf64>
          %81 = arith.addf %79, %80 : f64
          %82 = affine.load %arg2[%78 + 1] : memref<?xf64>
          %83 = arith.addf %81, %82 : f64
          %84 = arith.mulf %83, %cst : f64
          affine.store %84, %arg3[%78] : memref<?xf64>
          %85 = affine.apply #map14(%arg6)
          %86 = affine.load %arg2[%85 - 1] : memref<?xf64>
          %87 = affine.load %arg2[%85] : memref<?xf64>
          %88 = arith.addf %86, %87 : f64
          %89 = affine.load %arg2[%85 + 1] : memref<?xf64>
          %90 = arith.addf %88, %89 : f64
          %91 = arith.mulf %90, %cst : f64
          affine.store %91, %arg3[%85] : memref<?xf64>
          %92 = affine.apply #map15(%arg6)
          %93 = affine.load %arg2[%92 - 1] : memref<?xf64>
          %94 = affine.load %arg2[%92] : memref<?xf64>
          %95 = arith.addf %93, %94 : f64
          %96 = affine.load %arg2[%92 + 1] : memref<?xf64>
          %97 = arith.addf %95, %96 : f64
          %98 = arith.mulf %97, %cst : f64
          affine.store %98, %arg3[%92] : memref<?xf64>
        }
        affine.for %arg6 = #map21()[%0] to #map22()[%0] step 6 {
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
        }
        affine.for %arg6 = #map22()[%0] to #map23()[%0] {
          %2 = affine.load %arg2[%arg6 - 1] : memref<?xf64>
          %3 = affine.load %arg2[%arg6] : memref<?xf64>
          %4 = arith.addf %2, %3 : f64
          %5 = affine.load %arg2[%arg6 + 1] : memref<?xf64>
          %6 = arith.addf %4, %5 : f64
          %7 = arith.mulf %6, %cst : f64
          affine.store %7, %arg3[%arg6] : memref<?xf64>
        }
        affine.for %arg6 = 1 to #map2()[%0] step 84 {
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
          %71 = affine.apply #map12(%arg6)
          %72 = affine.load %arg3[%71 - 1] : memref<?xf64>
          %73 = affine.load %arg3[%71] : memref<?xf64>
          %74 = arith.addf %72, %73 : f64
          %75 = affine.load %arg3[%71 + 1] : memref<?xf64>
          %76 = arith.addf %74, %75 : f64
          %77 = arith.mulf %76, %cst : f64
          affine.store %77, %arg2[%71] : memref<?xf64>
          %78 = affine.apply #map13(%arg6)
          %79 = affine.load %arg3[%78 - 1] : memref<?xf64>
          %80 = affine.load %arg3[%78] : memref<?xf64>
          %81 = arith.addf %79, %80 : f64
          %82 = affine.load %arg3[%78 + 1] : memref<?xf64>
          %83 = arith.addf %81, %82 : f64
          %84 = arith.mulf %83, %cst : f64
          affine.store %84, %arg2[%78] : memref<?xf64>
          %85 = affine.apply #map14(%arg6)
          %86 = affine.load %arg3[%85 - 1] : memref<?xf64>
          %87 = affine.load %arg3[%85] : memref<?xf64>
          %88 = arith.addf %86, %87 : f64
          %89 = affine.load %arg3[%85 + 1] : memref<?xf64>
          %90 = arith.addf %88, %89 : f64
          %91 = arith.mulf %90, %cst : f64
          affine.store %91, %arg2[%85] : memref<?xf64>
          %92 = affine.apply #map15(%arg6)
          %93 = affine.load %arg3[%92 - 1] : memref<?xf64>
          %94 = affine.load %arg3[%92] : memref<?xf64>
          %95 = arith.addf %93, %94 : f64
          %96 = affine.load %arg3[%92 + 1] : memref<?xf64>
          %97 = arith.addf %95, %96 : f64
          %98 = arith.mulf %97, %cst : f64
          affine.store %98, %arg2[%92] : memref<?xf64>
          %99 = affine.apply #map16(%arg6)
          %100 = affine.load %arg3[%99 - 1] : memref<?xf64>
          %101 = affine.load %arg3[%99] : memref<?xf64>
          %102 = arith.addf %100, %101 : f64
          %103 = affine.load %arg3[%99 + 1] : memref<?xf64>
          %104 = arith.addf %102, %103 : f64
          %105 = arith.mulf %104, %cst : f64
          affine.store %105, %arg2[%99] : memref<?xf64>
          %106 = affine.apply #map3(%99)
          %107 = affine.load %arg3[%106 - 1] : memref<?xf64>
          %108 = affine.load %arg3[%106] : memref<?xf64>
          %109 = arith.addf %107, %108 : f64
          %110 = affine.load %arg3[%106 + 1] : memref<?xf64>
          %111 = arith.addf %109, %110 : f64
          %112 = arith.mulf %111, %cst : f64
          affine.store %112, %arg2[%106] : memref<?xf64>
          %113 = affine.apply #map4(%99)
          %114 = affine.load %arg3[%113 - 1] : memref<?xf64>
          %115 = affine.load %arg3[%113] : memref<?xf64>
          %116 = arith.addf %114, %115 : f64
          %117 = affine.load %arg3[%113 + 1] : memref<?xf64>
          %118 = arith.addf %116, %117 : f64
          %119 = arith.mulf %118, %cst : f64
          affine.store %119, %arg2[%113] : memref<?xf64>
          %120 = affine.apply #map5(%99)
          %121 = affine.load %arg3[%120 - 1] : memref<?xf64>
          %122 = affine.load %arg3[%120] : memref<?xf64>
          %123 = arith.addf %121, %122 : f64
          %124 = affine.load %arg3[%120 + 1] : memref<?xf64>
          %125 = arith.addf %123, %124 : f64
          %126 = arith.mulf %125, %cst : f64
          affine.store %126, %arg2[%120] : memref<?xf64>
          %127 = affine.apply #map6(%99)
          %128 = affine.load %arg3[%127 - 1] : memref<?xf64>
          %129 = affine.load %arg3[%127] : memref<?xf64>
          %130 = arith.addf %128, %129 : f64
          %131 = affine.load %arg3[%127 + 1] : memref<?xf64>
          %132 = arith.addf %130, %131 : f64
          %133 = arith.mulf %132, %cst : f64
          affine.store %133, %arg2[%127] : memref<?xf64>
          %134 = affine.apply #map7(%99)
          %135 = affine.load %arg3[%134 - 1] : memref<?xf64>
          %136 = affine.load %arg3[%134] : memref<?xf64>
          %137 = arith.addf %135, %136 : f64
          %138 = affine.load %arg3[%134 + 1] : memref<?xf64>
          %139 = arith.addf %137, %138 : f64
          %140 = arith.mulf %139, %cst : f64
          affine.store %140, %arg2[%134] : memref<?xf64>
          %141 = affine.apply #map8(%99)
          %142 = affine.load %arg3[%141 - 1] : memref<?xf64>
          %143 = affine.load %arg3[%141] : memref<?xf64>
          %144 = arith.addf %142, %143 : f64
          %145 = affine.load %arg3[%141 + 1] : memref<?xf64>
          %146 = arith.addf %144, %145 : f64
          %147 = arith.mulf %146, %cst : f64
          affine.store %147, %arg2[%141] : memref<?xf64>
          %148 = affine.apply #map9(%99)
          %149 = affine.load %arg3[%148 - 1] : memref<?xf64>
          %150 = affine.load %arg3[%148] : memref<?xf64>
          %151 = arith.addf %149, %150 : f64
          %152 = affine.load %arg3[%148 + 1] : memref<?xf64>
          %153 = arith.addf %151, %152 : f64
          %154 = arith.mulf %153, %cst : f64
          affine.store %154, %arg2[%148] : memref<?xf64>
          %155 = affine.apply #map10(%99)
          %156 = affine.load %arg3[%155 - 1] : memref<?xf64>
          %157 = affine.load %arg3[%155] : memref<?xf64>
          %158 = arith.addf %156, %157 : f64
          %159 = affine.load %arg3[%155 + 1] : memref<?xf64>
          %160 = arith.addf %158, %159 : f64
          %161 = arith.mulf %160, %cst : f64
          affine.store %161, %arg2[%155] : memref<?xf64>
          %162 = affine.apply #map11(%99)
          %163 = affine.load %arg3[%162 - 1] : memref<?xf64>
          %164 = affine.load %arg3[%162] : memref<?xf64>
          %165 = arith.addf %163, %164 : f64
          %166 = affine.load %arg3[%162 + 1] : memref<?xf64>
          %167 = arith.addf %165, %166 : f64
          %168 = arith.mulf %167, %cst : f64
          affine.store %168, %arg2[%162] : memref<?xf64>
          %169 = affine.apply #map12(%99)
          %170 = affine.load %arg3[%169 - 1] : memref<?xf64>
          %171 = affine.load %arg3[%169] : memref<?xf64>
          %172 = arith.addf %170, %171 : f64
          %173 = affine.load %arg3[%169 + 1] : memref<?xf64>
          %174 = arith.addf %172, %173 : f64
          %175 = arith.mulf %174, %cst : f64
          affine.store %175, %arg2[%169] : memref<?xf64>
          %176 = affine.apply #map13(%99)
          %177 = affine.load %arg3[%176 - 1] : memref<?xf64>
          %178 = affine.load %arg3[%176] : memref<?xf64>
          %179 = arith.addf %177, %178 : f64
          %180 = affine.load %arg3[%176 + 1] : memref<?xf64>
          %181 = arith.addf %179, %180 : f64
          %182 = arith.mulf %181, %cst : f64
          affine.store %182, %arg2[%176] : memref<?xf64>
          %183 = affine.apply #map14(%99)
          %184 = affine.load %arg3[%183 - 1] : memref<?xf64>
          %185 = affine.load %arg3[%183] : memref<?xf64>
          %186 = arith.addf %184, %185 : f64
          %187 = affine.load %arg3[%183 + 1] : memref<?xf64>
          %188 = arith.addf %186, %187 : f64
          %189 = arith.mulf %188, %cst : f64
          affine.store %189, %arg2[%183] : memref<?xf64>
          %190 = affine.apply #map15(%99)
          %191 = affine.load %arg3[%190 - 1] : memref<?xf64>
          %192 = affine.load %arg3[%190] : memref<?xf64>
          %193 = arith.addf %191, %192 : f64
          %194 = affine.load %arg3[%190 + 1] : memref<?xf64>
          %195 = arith.addf %193, %194 : f64
          %196 = arith.mulf %195, %cst : f64
          affine.store %196, %arg2[%190] : memref<?xf64>
          %197 = affine.apply #map17(%arg6)
          %198 = affine.load %arg3[%197 - 1] : memref<?xf64>
          %199 = affine.load %arg3[%197] : memref<?xf64>
          %200 = arith.addf %198, %199 : f64
          %201 = affine.load %arg3[%197 + 1] : memref<?xf64>
          %202 = arith.addf %200, %201 : f64
          %203 = arith.mulf %202, %cst : f64
          affine.store %203, %arg2[%197] : memref<?xf64>
          %204 = affine.apply #map3(%197)
          %205 = affine.load %arg3[%204 - 1] : memref<?xf64>
          %206 = affine.load %arg3[%204] : memref<?xf64>
          %207 = arith.addf %205, %206 : f64
          %208 = affine.load %arg3[%204 + 1] : memref<?xf64>
          %209 = arith.addf %207, %208 : f64
          %210 = arith.mulf %209, %cst : f64
          affine.store %210, %arg2[%204] : memref<?xf64>
          %211 = affine.apply #map4(%197)
          %212 = affine.load %arg3[%211 - 1] : memref<?xf64>
          %213 = affine.load %arg3[%211] : memref<?xf64>
          %214 = arith.addf %212, %213 : f64
          %215 = affine.load %arg3[%211 + 1] : memref<?xf64>
          %216 = arith.addf %214, %215 : f64
          %217 = arith.mulf %216, %cst : f64
          affine.store %217, %arg2[%211] : memref<?xf64>
          %218 = affine.apply #map5(%197)
          %219 = affine.load %arg3[%218 - 1] : memref<?xf64>
          %220 = affine.load %arg3[%218] : memref<?xf64>
          %221 = arith.addf %219, %220 : f64
          %222 = affine.load %arg3[%218 + 1] : memref<?xf64>
          %223 = arith.addf %221, %222 : f64
          %224 = arith.mulf %223, %cst : f64
          affine.store %224, %arg2[%218] : memref<?xf64>
          %225 = affine.apply #map6(%197)
          %226 = affine.load %arg3[%225 - 1] : memref<?xf64>
          %227 = affine.load %arg3[%225] : memref<?xf64>
          %228 = arith.addf %226, %227 : f64
          %229 = affine.load %arg3[%225 + 1] : memref<?xf64>
          %230 = arith.addf %228, %229 : f64
          %231 = arith.mulf %230, %cst : f64
          affine.store %231, %arg2[%225] : memref<?xf64>
          %232 = affine.apply #map7(%197)
          %233 = affine.load %arg3[%232 - 1] : memref<?xf64>
          %234 = affine.load %arg3[%232] : memref<?xf64>
          %235 = arith.addf %233, %234 : f64
          %236 = affine.load %arg3[%232 + 1] : memref<?xf64>
          %237 = arith.addf %235, %236 : f64
          %238 = arith.mulf %237, %cst : f64
          affine.store %238, %arg2[%232] : memref<?xf64>
          %239 = affine.apply #map8(%197)
          %240 = affine.load %arg3[%239 - 1] : memref<?xf64>
          %241 = affine.load %arg3[%239] : memref<?xf64>
          %242 = arith.addf %240, %241 : f64
          %243 = affine.load %arg3[%239 + 1] : memref<?xf64>
          %244 = arith.addf %242, %243 : f64
          %245 = arith.mulf %244, %cst : f64
          affine.store %245, %arg2[%239] : memref<?xf64>
          %246 = affine.apply #map9(%197)
          %247 = affine.load %arg3[%246 - 1] : memref<?xf64>
          %248 = affine.load %arg3[%246] : memref<?xf64>
          %249 = arith.addf %247, %248 : f64
          %250 = affine.load %arg3[%246 + 1] : memref<?xf64>
          %251 = arith.addf %249, %250 : f64
          %252 = arith.mulf %251, %cst : f64
          affine.store %252, %arg2[%246] : memref<?xf64>
          %253 = affine.apply #map10(%197)
          %254 = affine.load %arg3[%253 - 1] : memref<?xf64>
          %255 = affine.load %arg3[%253] : memref<?xf64>
          %256 = arith.addf %254, %255 : f64
          %257 = affine.load %arg3[%253 + 1] : memref<?xf64>
          %258 = arith.addf %256, %257 : f64
          %259 = arith.mulf %258, %cst : f64
          affine.store %259, %arg2[%253] : memref<?xf64>
          %260 = affine.apply #map11(%197)
          %261 = affine.load %arg3[%260 - 1] : memref<?xf64>
          %262 = affine.load %arg3[%260] : memref<?xf64>
          %263 = arith.addf %261, %262 : f64
          %264 = affine.load %arg3[%260 + 1] : memref<?xf64>
          %265 = arith.addf %263, %264 : f64
          %266 = arith.mulf %265, %cst : f64
          affine.store %266, %arg2[%260] : memref<?xf64>
          %267 = affine.apply #map12(%197)
          %268 = affine.load %arg3[%267 - 1] : memref<?xf64>
          %269 = affine.load %arg3[%267] : memref<?xf64>
          %270 = arith.addf %268, %269 : f64
          %271 = affine.load %arg3[%267 + 1] : memref<?xf64>
          %272 = arith.addf %270, %271 : f64
          %273 = arith.mulf %272, %cst : f64
          affine.store %273, %arg2[%267] : memref<?xf64>
          %274 = affine.apply #map13(%197)
          %275 = affine.load %arg3[%274 - 1] : memref<?xf64>
          %276 = affine.load %arg3[%274] : memref<?xf64>
          %277 = arith.addf %275, %276 : f64
          %278 = affine.load %arg3[%274 + 1] : memref<?xf64>
          %279 = arith.addf %277, %278 : f64
          %280 = arith.mulf %279, %cst : f64
          affine.store %280, %arg2[%274] : memref<?xf64>
          %281 = affine.apply #map14(%197)
          %282 = affine.load %arg3[%281 - 1] : memref<?xf64>
          %283 = affine.load %arg3[%281] : memref<?xf64>
          %284 = arith.addf %282, %283 : f64
          %285 = affine.load %arg3[%281 + 1] : memref<?xf64>
          %286 = arith.addf %284, %285 : f64
          %287 = arith.mulf %286, %cst : f64
          affine.store %287, %arg2[%281] : memref<?xf64>
          %288 = affine.apply #map15(%197)
          %289 = affine.load %arg3[%288 - 1] : memref<?xf64>
          %290 = affine.load %arg3[%288] : memref<?xf64>
          %291 = arith.addf %289, %290 : f64
          %292 = affine.load %arg3[%288 + 1] : memref<?xf64>
          %293 = arith.addf %291, %292 : f64
          %294 = arith.mulf %293, %cst : f64
          affine.store %294, %arg2[%288] : memref<?xf64>
          %295 = affine.apply #map18(%arg6)
          %296 = affine.load %arg3[%295 - 1] : memref<?xf64>
          %297 = affine.load %arg3[%295] : memref<?xf64>
          %298 = arith.addf %296, %297 : f64
          %299 = affine.load %arg3[%295 + 1] : memref<?xf64>
          %300 = arith.addf %298, %299 : f64
          %301 = arith.mulf %300, %cst : f64
          affine.store %301, %arg2[%295] : memref<?xf64>
          %302 = affine.apply #map3(%295)
          %303 = affine.load %arg3[%302 - 1] : memref<?xf64>
          %304 = affine.load %arg3[%302] : memref<?xf64>
          %305 = arith.addf %303, %304 : f64
          %306 = affine.load %arg3[%302 + 1] : memref<?xf64>
          %307 = arith.addf %305, %306 : f64
          %308 = arith.mulf %307, %cst : f64
          affine.store %308, %arg2[%302] : memref<?xf64>
          %309 = affine.apply #map4(%295)
          %310 = affine.load %arg3[%309 - 1] : memref<?xf64>
          %311 = affine.load %arg3[%309] : memref<?xf64>
          %312 = arith.addf %310, %311 : f64
          %313 = affine.load %arg3[%309 + 1] : memref<?xf64>
          %314 = arith.addf %312, %313 : f64
          %315 = arith.mulf %314, %cst : f64
          affine.store %315, %arg2[%309] : memref<?xf64>
          %316 = affine.apply #map5(%295)
          %317 = affine.load %arg3[%316 - 1] : memref<?xf64>
          %318 = affine.load %arg3[%316] : memref<?xf64>
          %319 = arith.addf %317, %318 : f64
          %320 = affine.load %arg3[%316 + 1] : memref<?xf64>
          %321 = arith.addf %319, %320 : f64
          %322 = arith.mulf %321, %cst : f64
          affine.store %322, %arg2[%316] : memref<?xf64>
          %323 = affine.apply #map6(%295)
          %324 = affine.load %arg3[%323 - 1] : memref<?xf64>
          %325 = affine.load %arg3[%323] : memref<?xf64>
          %326 = arith.addf %324, %325 : f64
          %327 = affine.load %arg3[%323 + 1] : memref<?xf64>
          %328 = arith.addf %326, %327 : f64
          %329 = arith.mulf %328, %cst : f64
          affine.store %329, %arg2[%323] : memref<?xf64>
          %330 = affine.apply #map7(%295)
          %331 = affine.load %arg3[%330 - 1] : memref<?xf64>
          %332 = affine.load %arg3[%330] : memref<?xf64>
          %333 = arith.addf %331, %332 : f64
          %334 = affine.load %arg3[%330 + 1] : memref<?xf64>
          %335 = arith.addf %333, %334 : f64
          %336 = arith.mulf %335, %cst : f64
          affine.store %336, %arg2[%330] : memref<?xf64>
          %337 = affine.apply #map8(%295)
          %338 = affine.load %arg3[%337 - 1] : memref<?xf64>
          %339 = affine.load %arg3[%337] : memref<?xf64>
          %340 = arith.addf %338, %339 : f64
          %341 = affine.load %arg3[%337 + 1] : memref<?xf64>
          %342 = arith.addf %340, %341 : f64
          %343 = arith.mulf %342, %cst : f64
          affine.store %343, %arg2[%337] : memref<?xf64>
          %344 = affine.apply #map9(%295)
          %345 = affine.load %arg3[%344 - 1] : memref<?xf64>
          %346 = affine.load %arg3[%344] : memref<?xf64>
          %347 = arith.addf %345, %346 : f64
          %348 = affine.load %arg3[%344 + 1] : memref<?xf64>
          %349 = arith.addf %347, %348 : f64
          %350 = arith.mulf %349, %cst : f64
          affine.store %350, %arg2[%344] : memref<?xf64>
          %351 = affine.apply #map10(%295)
          %352 = affine.load %arg3[%351 - 1] : memref<?xf64>
          %353 = affine.load %arg3[%351] : memref<?xf64>
          %354 = arith.addf %352, %353 : f64
          %355 = affine.load %arg3[%351 + 1] : memref<?xf64>
          %356 = arith.addf %354, %355 : f64
          %357 = arith.mulf %356, %cst : f64
          affine.store %357, %arg2[%351] : memref<?xf64>
          %358 = affine.apply #map11(%295)
          %359 = affine.load %arg3[%358 - 1] : memref<?xf64>
          %360 = affine.load %arg3[%358] : memref<?xf64>
          %361 = arith.addf %359, %360 : f64
          %362 = affine.load %arg3[%358 + 1] : memref<?xf64>
          %363 = arith.addf %361, %362 : f64
          %364 = arith.mulf %363, %cst : f64
          affine.store %364, %arg2[%358] : memref<?xf64>
          %365 = affine.apply #map12(%295)
          %366 = affine.load %arg3[%365 - 1] : memref<?xf64>
          %367 = affine.load %arg3[%365] : memref<?xf64>
          %368 = arith.addf %366, %367 : f64
          %369 = affine.load %arg3[%365 + 1] : memref<?xf64>
          %370 = arith.addf %368, %369 : f64
          %371 = arith.mulf %370, %cst : f64
          affine.store %371, %arg2[%365] : memref<?xf64>
          %372 = affine.apply #map13(%295)
          %373 = affine.load %arg3[%372 - 1] : memref<?xf64>
          %374 = affine.load %arg3[%372] : memref<?xf64>
          %375 = arith.addf %373, %374 : f64
          %376 = affine.load %arg3[%372 + 1] : memref<?xf64>
          %377 = arith.addf %375, %376 : f64
          %378 = arith.mulf %377, %cst : f64
          affine.store %378, %arg2[%372] : memref<?xf64>
          %379 = affine.apply #map14(%295)
          %380 = affine.load %arg3[%379 - 1] : memref<?xf64>
          %381 = affine.load %arg3[%379] : memref<?xf64>
          %382 = arith.addf %380, %381 : f64
          %383 = affine.load %arg3[%379 + 1] : memref<?xf64>
          %384 = arith.addf %382, %383 : f64
          %385 = arith.mulf %384, %cst : f64
          affine.store %385, %arg2[%379] : memref<?xf64>
          %386 = affine.apply #map15(%295)
          %387 = affine.load %arg3[%386 - 1] : memref<?xf64>
          %388 = affine.load %arg3[%386] : memref<?xf64>
          %389 = arith.addf %387, %388 : f64
          %390 = affine.load %arg3[%386 + 1] : memref<?xf64>
          %391 = arith.addf %389, %390 : f64
          %392 = arith.mulf %391, %cst : f64
          affine.store %392, %arg2[%386] : memref<?xf64>
          %393 = affine.apply #map19(%arg6)
          %394 = affine.load %arg3[%393 - 1] : memref<?xf64>
          %395 = affine.load %arg3[%393] : memref<?xf64>
          %396 = arith.addf %394, %395 : f64
          %397 = affine.load %arg3[%393 + 1] : memref<?xf64>
          %398 = arith.addf %396, %397 : f64
          %399 = arith.mulf %398, %cst : f64
          affine.store %399, %arg2[%393] : memref<?xf64>
          %400 = affine.apply #map3(%393)
          %401 = affine.load %arg3[%400 - 1] : memref<?xf64>
          %402 = affine.load %arg3[%400] : memref<?xf64>
          %403 = arith.addf %401, %402 : f64
          %404 = affine.load %arg3[%400 + 1] : memref<?xf64>
          %405 = arith.addf %403, %404 : f64
          %406 = arith.mulf %405, %cst : f64
          affine.store %406, %arg2[%400] : memref<?xf64>
          %407 = affine.apply #map4(%393)
          %408 = affine.load %arg3[%407 - 1] : memref<?xf64>
          %409 = affine.load %arg3[%407] : memref<?xf64>
          %410 = arith.addf %408, %409 : f64
          %411 = affine.load %arg3[%407 + 1] : memref<?xf64>
          %412 = arith.addf %410, %411 : f64
          %413 = arith.mulf %412, %cst : f64
          affine.store %413, %arg2[%407] : memref<?xf64>
          %414 = affine.apply #map5(%393)
          %415 = affine.load %arg3[%414 - 1] : memref<?xf64>
          %416 = affine.load %arg3[%414] : memref<?xf64>
          %417 = arith.addf %415, %416 : f64
          %418 = affine.load %arg3[%414 + 1] : memref<?xf64>
          %419 = arith.addf %417, %418 : f64
          %420 = arith.mulf %419, %cst : f64
          affine.store %420, %arg2[%414] : memref<?xf64>
          %421 = affine.apply #map6(%393)
          %422 = affine.load %arg3[%421 - 1] : memref<?xf64>
          %423 = affine.load %arg3[%421] : memref<?xf64>
          %424 = arith.addf %422, %423 : f64
          %425 = affine.load %arg3[%421 + 1] : memref<?xf64>
          %426 = arith.addf %424, %425 : f64
          %427 = arith.mulf %426, %cst : f64
          affine.store %427, %arg2[%421] : memref<?xf64>
          %428 = affine.apply #map7(%393)
          %429 = affine.load %arg3[%428 - 1] : memref<?xf64>
          %430 = affine.load %arg3[%428] : memref<?xf64>
          %431 = arith.addf %429, %430 : f64
          %432 = affine.load %arg3[%428 + 1] : memref<?xf64>
          %433 = arith.addf %431, %432 : f64
          %434 = arith.mulf %433, %cst : f64
          affine.store %434, %arg2[%428] : memref<?xf64>
          %435 = affine.apply #map8(%393)
          %436 = affine.load %arg3[%435 - 1] : memref<?xf64>
          %437 = affine.load %arg3[%435] : memref<?xf64>
          %438 = arith.addf %436, %437 : f64
          %439 = affine.load %arg3[%435 + 1] : memref<?xf64>
          %440 = arith.addf %438, %439 : f64
          %441 = arith.mulf %440, %cst : f64
          affine.store %441, %arg2[%435] : memref<?xf64>
          %442 = affine.apply #map9(%393)
          %443 = affine.load %arg3[%442 - 1] : memref<?xf64>
          %444 = affine.load %arg3[%442] : memref<?xf64>
          %445 = arith.addf %443, %444 : f64
          %446 = affine.load %arg3[%442 + 1] : memref<?xf64>
          %447 = arith.addf %445, %446 : f64
          %448 = arith.mulf %447, %cst : f64
          affine.store %448, %arg2[%442] : memref<?xf64>
          %449 = affine.apply #map10(%393)
          %450 = affine.load %arg3[%449 - 1] : memref<?xf64>
          %451 = affine.load %arg3[%449] : memref<?xf64>
          %452 = arith.addf %450, %451 : f64
          %453 = affine.load %arg3[%449 + 1] : memref<?xf64>
          %454 = arith.addf %452, %453 : f64
          %455 = arith.mulf %454, %cst : f64
          affine.store %455, %arg2[%449] : memref<?xf64>
          %456 = affine.apply #map11(%393)
          %457 = affine.load %arg3[%456 - 1] : memref<?xf64>
          %458 = affine.load %arg3[%456] : memref<?xf64>
          %459 = arith.addf %457, %458 : f64
          %460 = affine.load %arg3[%456 + 1] : memref<?xf64>
          %461 = arith.addf %459, %460 : f64
          %462 = arith.mulf %461, %cst : f64
          affine.store %462, %arg2[%456] : memref<?xf64>
          %463 = affine.apply #map12(%393)
          %464 = affine.load %arg3[%463 - 1] : memref<?xf64>
          %465 = affine.load %arg3[%463] : memref<?xf64>
          %466 = arith.addf %464, %465 : f64
          %467 = affine.load %arg3[%463 + 1] : memref<?xf64>
          %468 = arith.addf %466, %467 : f64
          %469 = arith.mulf %468, %cst : f64
          affine.store %469, %arg2[%463] : memref<?xf64>
          %470 = affine.apply #map13(%393)
          %471 = affine.load %arg3[%470 - 1] : memref<?xf64>
          %472 = affine.load %arg3[%470] : memref<?xf64>
          %473 = arith.addf %471, %472 : f64
          %474 = affine.load %arg3[%470 + 1] : memref<?xf64>
          %475 = arith.addf %473, %474 : f64
          %476 = arith.mulf %475, %cst : f64
          affine.store %476, %arg2[%470] : memref<?xf64>
          %477 = affine.apply #map14(%393)
          %478 = affine.load %arg3[%477 - 1] : memref<?xf64>
          %479 = affine.load %arg3[%477] : memref<?xf64>
          %480 = arith.addf %478, %479 : f64
          %481 = affine.load %arg3[%477 + 1] : memref<?xf64>
          %482 = arith.addf %480, %481 : f64
          %483 = arith.mulf %482, %cst : f64
          affine.store %483, %arg2[%477] : memref<?xf64>
          %484 = affine.apply #map15(%393)
          %485 = affine.load %arg3[%484 - 1] : memref<?xf64>
          %486 = affine.load %arg3[%484] : memref<?xf64>
          %487 = arith.addf %485, %486 : f64
          %488 = affine.load %arg3[%484 + 1] : memref<?xf64>
          %489 = arith.addf %487, %488 : f64
          %490 = arith.mulf %489, %cst : f64
          affine.store %490, %arg2[%484] : memref<?xf64>
          %491 = affine.apply #map20(%arg6)
          %492 = affine.load %arg3[%491 - 1] : memref<?xf64>
          %493 = affine.load %arg3[%491] : memref<?xf64>
          %494 = arith.addf %492, %493 : f64
          %495 = affine.load %arg3[%491 + 1] : memref<?xf64>
          %496 = arith.addf %494, %495 : f64
          %497 = arith.mulf %496, %cst : f64
          affine.store %497, %arg2[%491] : memref<?xf64>
          %498 = affine.apply #map3(%491)
          %499 = affine.load %arg3[%498 - 1] : memref<?xf64>
          %500 = affine.load %arg3[%498] : memref<?xf64>
          %501 = arith.addf %499, %500 : f64
          %502 = affine.load %arg3[%498 + 1] : memref<?xf64>
          %503 = arith.addf %501, %502 : f64
          %504 = arith.mulf %503, %cst : f64
          affine.store %504, %arg2[%498] : memref<?xf64>
          %505 = affine.apply #map4(%491)
          %506 = affine.load %arg3[%505 - 1] : memref<?xf64>
          %507 = affine.load %arg3[%505] : memref<?xf64>
          %508 = arith.addf %506, %507 : f64
          %509 = affine.load %arg3[%505 + 1] : memref<?xf64>
          %510 = arith.addf %508, %509 : f64
          %511 = arith.mulf %510, %cst : f64
          affine.store %511, %arg2[%505] : memref<?xf64>
          %512 = affine.apply #map5(%491)
          %513 = affine.load %arg3[%512 - 1] : memref<?xf64>
          %514 = affine.load %arg3[%512] : memref<?xf64>
          %515 = arith.addf %513, %514 : f64
          %516 = affine.load %arg3[%512 + 1] : memref<?xf64>
          %517 = arith.addf %515, %516 : f64
          %518 = arith.mulf %517, %cst : f64
          affine.store %518, %arg2[%512] : memref<?xf64>
          %519 = affine.apply #map6(%491)
          %520 = affine.load %arg3[%519 - 1] : memref<?xf64>
          %521 = affine.load %arg3[%519] : memref<?xf64>
          %522 = arith.addf %520, %521 : f64
          %523 = affine.load %arg3[%519 + 1] : memref<?xf64>
          %524 = arith.addf %522, %523 : f64
          %525 = arith.mulf %524, %cst : f64
          affine.store %525, %arg2[%519] : memref<?xf64>
          %526 = affine.apply #map7(%491)
          %527 = affine.load %arg3[%526 - 1] : memref<?xf64>
          %528 = affine.load %arg3[%526] : memref<?xf64>
          %529 = arith.addf %527, %528 : f64
          %530 = affine.load %arg3[%526 + 1] : memref<?xf64>
          %531 = arith.addf %529, %530 : f64
          %532 = arith.mulf %531, %cst : f64
          affine.store %532, %arg2[%526] : memref<?xf64>
          %533 = affine.apply #map8(%491)
          %534 = affine.load %arg3[%533 - 1] : memref<?xf64>
          %535 = affine.load %arg3[%533] : memref<?xf64>
          %536 = arith.addf %534, %535 : f64
          %537 = affine.load %arg3[%533 + 1] : memref<?xf64>
          %538 = arith.addf %536, %537 : f64
          %539 = arith.mulf %538, %cst : f64
          affine.store %539, %arg2[%533] : memref<?xf64>
          %540 = affine.apply #map9(%491)
          %541 = affine.load %arg3[%540 - 1] : memref<?xf64>
          %542 = affine.load %arg3[%540] : memref<?xf64>
          %543 = arith.addf %541, %542 : f64
          %544 = affine.load %arg3[%540 + 1] : memref<?xf64>
          %545 = arith.addf %543, %544 : f64
          %546 = arith.mulf %545, %cst : f64
          affine.store %546, %arg2[%540] : memref<?xf64>
          %547 = affine.apply #map10(%491)
          %548 = affine.load %arg3[%547 - 1] : memref<?xf64>
          %549 = affine.load %arg3[%547] : memref<?xf64>
          %550 = arith.addf %548, %549 : f64
          %551 = affine.load %arg3[%547 + 1] : memref<?xf64>
          %552 = arith.addf %550, %551 : f64
          %553 = arith.mulf %552, %cst : f64
          affine.store %553, %arg2[%547] : memref<?xf64>
          %554 = affine.apply #map11(%491)
          %555 = affine.load %arg3[%554 - 1] : memref<?xf64>
          %556 = affine.load %arg3[%554] : memref<?xf64>
          %557 = arith.addf %555, %556 : f64
          %558 = affine.load %arg3[%554 + 1] : memref<?xf64>
          %559 = arith.addf %557, %558 : f64
          %560 = arith.mulf %559, %cst : f64
          affine.store %560, %arg2[%554] : memref<?xf64>
          %561 = affine.apply #map12(%491)
          %562 = affine.load %arg3[%561 - 1] : memref<?xf64>
          %563 = affine.load %arg3[%561] : memref<?xf64>
          %564 = arith.addf %562, %563 : f64
          %565 = affine.load %arg3[%561 + 1] : memref<?xf64>
          %566 = arith.addf %564, %565 : f64
          %567 = arith.mulf %566, %cst : f64
          affine.store %567, %arg2[%561] : memref<?xf64>
          %568 = affine.apply #map13(%491)
          %569 = affine.load %arg3[%568 - 1] : memref<?xf64>
          %570 = affine.load %arg3[%568] : memref<?xf64>
          %571 = arith.addf %569, %570 : f64
          %572 = affine.load %arg3[%568 + 1] : memref<?xf64>
          %573 = arith.addf %571, %572 : f64
          %574 = arith.mulf %573, %cst : f64
          affine.store %574, %arg2[%568] : memref<?xf64>
          %575 = affine.apply #map14(%491)
          %576 = affine.load %arg3[%575 - 1] : memref<?xf64>
          %577 = affine.load %arg3[%575] : memref<?xf64>
          %578 = arith.addf %576, %577 : f64
          %579 = affine.load %arg3[%575 + 1] : memref<?xf64>
          %580 = arith.addf %578, %579 : f64
          %581 = arith.mulf %580, %cst : f64
          affine.store %581, %arg2[%575] : memref<?xf64>
          %582 = affine.apply #map15(%491)
          %583 = affine.load %arg3[%582 - 1] : memref<?xf64>
          %584 = affine.load %arg3[%582] : memref<?xf64>
          %585 = arith.addf %583, %584 : f64
          %586 = affine.load %arg3[%582 + 1] : memref<?xf64>
          %587 = arith.addf %585, %586 : f64
          %588 = arith.mulf %587, %cst : f64
          affine.store %588, %arg2[%582] : memref<?xf64>
        }
        affine.for %arg6 = #map2()[%0] to #map21()[%0] step 14 {
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
          %71 = affine.apply #map12(%arg6)
          %72 = affine.load %arg3[%71 - 1] : memref<?xf64>
          %73 = affine.load %arg3[%71] : memref<?xf64>
          %74 = arith.addf %72, %73 : f64
          %75 = affine.load %arg3[%71 + 1] : memref<?xf64>
          %76 = arith.addf %74, %75 : f64
          %77 = arith.mulf %76, %cst : f64
          affine.store %77, %arg2[%71] : memref<?xf64>
          %78 = affine.apply #map13(%arg6)
          %79 = affine.load %arg3[%78 - 1] : memref<?xf64>
          %80 = affine.load %arg3[%78] : memref<?xf64>
          %81 = arith.addf %79, %80 : f64
          %82 = affine.load %arg3[%78 + 1] : memref<?xf64>
          %83 = arith.addf %81, %82 : f64
          %84 = arith.mulf %83, %cst : f64
          affine.store %84, %arg2[%78] : memref<?xf64>
          %85 = affine.apply #map14(%arg6)
          %86 = affine.load %arg3[%85 - 1] : memref<?xf64>
          %87 = affine.load %arg3[%85] : memref<?xf64>
          %88 = arith.addf %86, %87 : f64
          %89 = affine.load %arg3[%85 + 1] : memref<?xf64>
          %90 = arith.addf %88, %89 : f64
          %91 = arith.mulf %90, %cst : f64
          affine.store %91, %arg2[%85] : memref<?xf64>
          %92 = affine.apply #map15(%arg6)
          %93 = affine.load %arg3[%92 - 1] : memref<?xf64>
          %94 = affine.load %arg3[%92] : memref<?xf64>
          %95 = arith.addf %93, %94 : f64
          %96 = affine.load %arg3[%92 + 1] : memref<?xf64>
          %97 = arith.addf %95, %96 : f64
          %98 = arith.mulf %97, %cst : f64
          affine.store %98, %arg2[%92] : memref<?xf64>
        }
        affine.for %arg6 = #map21()[%0] to #map22()[%0] step 6 {
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
        }
        affine.for %arg6 = #map22()[%0] to #map23()[%0] {
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

