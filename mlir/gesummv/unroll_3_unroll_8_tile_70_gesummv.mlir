#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 70, s0)>
#map2 = affine_map<()[s0] -> (((s0 floordiv 8) floordiv 3) * 24)>
#map3 = affine_map<(d0) -> (d0 + 1)>
#map4 = affine_map<(d0) -> (d0 + 2)>
#map5 = affine_map<(d0) -> (d0 + 3)>
#map6 = affine_map<(d0) -> (d0 + 4)>
#map7 = affine_map<(d0) -> (d0 + 5)>
#map8 = affine_map<(d0) -> (d0 + 6)>
#map9 = affine_map<(d0) -> (d0 + 7)>
#map10 = affine_map<(d0) -> (d0 + 8)>
#map11 = affine_map<(d0) -> (d0 + 16)>
#map12 = affine_map<()[s0] -> ((s0 floordiv 8) * 8)>
#map13 = affine_map<()[s0] -> ((s0 floordiv 8) * 8 + ((s0 mod 8) floordiv 3) * 3)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_gesummv(%arg0: i32, %arg1: f64, %arg2: f64, %arg3: memref<?x1300xf64>, %arg4: memref<?x1300xf64>, %arg5: memref<?xf64>, %arg6: memref<?xf64>, %arg7: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 0.000000e+00 : f64
    %0 = arith.index_cast %arg0 : i32 to index
    affine.for %arg8 = 0 to %0 step 70 {
      affine.for %arg9 = #map(%arg8) to min #map1(%arg8)[%0] {
        affine.store %cst, %arg5[%arg9] : memref<?xf64>
        affine.store %cst, %arg7[%arg9] : memref<?xf64>
        affine.for %arg10 = 0 to #map2()[%0] step 24 {
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
          %71 = affine.apply #map8(%arg10)
          %72 = affine.load %arg3[%arg9, %71] : memref<?x1300xf64>
          %73 = affine.load %arg6[%71] : memref<?xf64>
          %74 = arith.mulf %72, %73 : f64
          %75 = affine.load %arg5[%arg9] : memref<?xf64>
          %76 = arith.addf %74, %75 : f64
          affine.store %76, %arg5[%arg9] : memref<?xf64>
          %77 = affine.load %arg4[%arg9, %71] : memref<?x1300xf64>
          %78 = affine.load %arg6[%71] : memref<?xf64>
          %79 = arith.mulf %77, %78 : f64
          %80 = affine.load %arg7[%arg9] : memref<?xf64>
          %81 = arith.addf %79, %80 : f64
          affine.store %81, %arg7[%arg9] : memref<?xf64>
          %82 = affine.apply #map9(%arg10)
          %83 = affine.load %arg3[%arg9, %82] : memref<?x1300xf64>
          %84 = affine.load %arg6[%82] : memref<?xf64>
          %85 = arith.mulf %83, %84 : f64
          %86 = affine.load %arg5[%arg9] : memref<?xf64>
          %87 = arith.addf %85, %86 : f64
          affine.store %87, %arg5[%arg9] : memref<?xf64>
          %88 = affine.load %arg4[%arg9, %82] : memref<?x1300xf64>
          %89 = affine.load %arg6[%82] : memref<?xf64>
          %90 = arith.mulf %88, %89 : f64
          %91 = affine.load %arg7[%arg9] : memref<?xf64>
          %92 = arith.addf %90, %91 : f64
          affine.store %92, %arg7[%arg9] : memref<?xf64>
          %93 = affine.apply #map10(%arg10)
          %94 = affine.load %arg3[%arg9, %93] : memref<?x1300xf64>
          %95 = affine.load %arg6[%93] : memref<?xf64>
          %96 = arith.mulf %94, %95 : f64
          %97 = affine.load %arg5[%arg9] : memref<?xf64>
          %98 = arith.addf %96, %97 : f64
          affine.store %98, %arg5[%arg9] : memref<?xf64>
          %99 = affine.load %arg4[%arg9, %93] : memref<?x1300xf64>
          %100 = affine.load %arg6[%93] : memref<?xf64>
          %101 = arith.mulf %99, %100 : f64
          %102 = affine.load %arg7[%arg9] : memref<?xf64>
          %103 = arith.addf %101, %102 : f64
          affine.store %103, %arg7[%arg9] : memref<?xf64>
          %104 = affine.apply #map3(%93)
          %105 = affine.load %arg3[%arg9, %104] : memref<?x1300xf64>
          %106 = affine.load %arg6[%104] : memref<?xf64>
          %107 = arith.mulf %105, %106 : f64
          %108 = affine.load %arg5[%arg9] : memref<?xf64>
          %109 = arith.addf %107, %108 : f64
          affine.store %109, %arg5[%arg9] : memref<?xf64>
          %110 = affine.load %arg4[%arg9, %104] : memref<?x1300xf64>
          %111 = affine.load %arg6[%104] : memref<?xf64>
          %112 = arith.mulf %110, %111 : f64
          %113 = affine.load %arg7[%arg9] : memref<?xf64>
          %114 = arith.addf %112, %113 : f64
          affine.store %114, %arg7[%arg9] : memref<?xf64>
          %115 = affine.apply #map4(%93)
          %116 = affine.load %arg3[%arg9, %115] : memref<?x1300xf64>
          %117 = affine.load %arg6[%115] : memref<?xf64>
          %118 = arith.mulf %116, %117 : f64
          %119 = affine.load %arg5[%arg9] : memref<?xf64>
          %120 = arith.addf %118, %119 : f64
          affine.store %120, %arg5[%arg9] : memref<?xf64>
          %121 = affine.load %arg4[%arg9, %115] : memref<?x1300xf64>
          %122 = affine.load %arg6[%115] : memref<?xf64>
          %123 = arith.mulf %121, %122 : f64
          %124 = affine.load %arg7[%arg9] : memref<?xf64>
          %125 = arith.addf %123, %124 : f64
          affine.store %125, %arg7[%arg9] : memref<?xf64>
          %126 = affine.apply #map5(%93)
          %127 = affine.load %arg3[%arg9, %126] : memref<?x1300xf64>
          %128 = affine.load %arg6[%126] : memref<?xf64>
          %129 = arith.mulf %127, %128 : f64
          %130 = affine.load %arg5[%arg9] : memref<?xf64>
          %131 = arith.addf %129, %130 : f64
          affine.store %131, %arg5[%arg9] : memref<?xf64>
          %132 = affine.load %arg4[%arg9, %126] : memref<?x1300xf64>
          %133 = affine.load %arg6[%126] : memref<?xf64>
          %134 = arith.mulf %132, %133 : f64
          %135 = affine.load %arg7[%arg9] : memref<?xf64>
          %136 = arith.addf %134, %135 : f64
          affine.store %136, %arg7[%arg9] : memref<?xf64>
          %137 = affine.apply #map6(%93)
          %138 = affine.load %arg3[%arg9, %137] : memref<?x1300xf64>
          %139 = affine.load %arg6[%137] : memref<?xf64>
          %140 = arith.mulf %138, %139 : f64
          %141 = affine.load %arg5[%arg9] : memref<?xf64>
          %142 = arith.addf %140, %141 : f64
          affine.store %142, %arg5[%arg9] : memref<?xf64>
          %143 = affine.load %arg4[%arg9, %137] : memref<?x1300xf64>
          %144 = affine.load %arg6[%137] : memref<?xf64>
          %145 = arith.mulf %143, %144 : f64
          %146 = affine.load %arg7[%arg9] : memref<?xf64>
          %147 = arith.addf %145, %146 : f64
          affine.store %147, %arg7[%arg9] : memref<?xf64>
          %148 = affine.apply #map7(%93)
          %149 = affine.load %arg3[%arg9, %148] : memref<?x1300xf64>
          %150 = affine.load %arg6[%148] : memref<?xf64>
          %151 = arith.mulf %149, %150 : f64
          %152 = affine.load %arg5[%arg9] : memref<?xf64>
          %153 = arith.addf %151, %152 : f64
          affine.store %153, %arg5[%arg9] : memref<?xf64>
          %154 = affine.load %arg4[%arg9, %148] : memref<?x1300xf64>
          %155 = affine.load %arg6[%148] : memref<?xf64>
          %156 = arith.mulf %154, %155 : f64
          %157 = affine.load %arg7[%arg9] : memref<?xf64>
          %158 = arith.addf %156, %157 : f64
          affine.store %158, %arg7[%arg9] : memref<?xf64>
          %159 = affine.apply #map8(%93)
          %160 = affine.load %arg3[%arg9, %159] : memref<?x1300xf64>
          %161 = affine.load %arg6[%159] : memref<?xf64>
          %162 = arith.mulf %160, %161 : f64
          %163 = affine.load %arg5[%arg9] : memref<?xf64>
          %164 = arith.addf %162, %163 : f64
          affine.store %164, %arg5[%arg9] : memref<?xf64>
          %165 = affine.load %arg4[%arg9, %159] : memref<?x1300xf64>
          %166 = affine.load %arg6[%159] : memref<?xf64>
          %167 = arith.mulf %165, %166 : f64
          %168 = affine.load %arg7[%arg9] : memref<?xf64>
          %169 = arith.addf %167, %168 : f64
          affine.store %169, %arg7[%arg9] : memref<?xf64>
          %170 = affine.apply #map9(%93)
          %171 = affine.load %arg3[%arg9, %170] : memref<?x1300xf64>
          %172 = affine.load %arg6[%170] : memref<?xf64>
          %173 = arith.mulf %171, %172 : f64
          %174 = affine.load %arg5[%arg9] : memref<?xf64>
          %175 = arith.addf %173, %174 : f64
          affine.store %175, %arg5[%arg9] : memref<?xf64>
          %176 = affine.load %arg4[%arg9, %170] : memref<?x1300xf64>
          %177 = affine.load %arg6[%170] : memref<?xf64>
          %178 = arith.mulf %176, %177 : f64
          %179 = affine.load %arg7[%arg9] : memref<?xf64>
          %180 = arith.addf %178, %179 : f64
          affine.store %180, %arg7[%arg9] : memref<?xf64>
          %181 = affine.apply #map11(%arg10)
          %182 = affine.load %arg3[%arg9, %181] : memref<?x1300xf64>
          %183 = affine.load %arg6[%181] : memref<?xf64>
          %184 = arith.mulf %182, %183 : f64
          %185 = affine.load %arg5[%arg9] : memref<?xf64>
          %186 = arith.addf %184, %185 : f64
          affine.store %186, %arg5[%arg9] : memref<?xf64>
          %187 = affine.load %arg4[%arg9, %181] : memref<?x1300xf64>
          %188 = affine.load %arg6[%181] : memref<?xf64>
          %189 = arith.mulf %187, %188 : f64
          %190 = affine.load %arg7[%arg9] : memref<?xf64>
          %191 = arith.addf %189, %190 : f64
          affine.store %191, %arg7[%arg9] : memref<?xf64>
          %192 = affine.apply #map3(%181)
          %193 = affine.load %arg3[%arg9, %192] : memref<?x1300xf64>
          %194 = affine.load %arg6[%192] : memref<?xf64>
          %195 = arith.mulf %193, %194 : f64
          %196 = affine.load %arg5[%arg9] : memref<?xf64>
          %197 = arith.addf %195, %196 : f64
          affine.store %197, %arg5[%arg9] : memref<?xf64>
          %198 = affine.load %arg4[%arg9, %192] : memref<?x1300xf64>
          %199 = affine.load %arg6[%192] : memref<?xf64>
          %200 = arith.mulf %198, %199 : f64
          %201 = affine.load %arg7[%arg9] : memref<?xf64>
          %202 = arith.addf %200, %201 : f64
          affine.store %202, %arg7[%arg9] : memref<?xf64>
          %203 = affine.apply #map4(%181)
          %204 = affine.load %arg3[%arg9, %203] : memref<?x1300xf64>
          %205 = affine.load %arg6[%203] : memref<?xf64>
          %206 = arith.mulf %204, %205 : f64
          %207 = affine.load %arg5[%arg9] : memref<?xf64>
          %208 = arith.addf %206, %207 : f64
          affine.store %208, %arg5[%arg9] : memref<?xf64>
          %209 = affine.load %arg4[%arg9, %203] : memref<?x1300xf64>
          %210 = affine.load %arg6[%203] : memref<?xf64>
          %211 = arith.mulf %209, %210 : f64
          %212 = affine.load %arg7[%arg9] : memref<?xf64>
          %213 = arith.addf %211, %212 : f64
          affine.store %213, %arg7[%arg9] : memref<?xf64>
          %214 = affine.apply #map5(%181)
          %215 = affine.load %arg3[%arg9, %214] : memref<?x1300xf64>
          %216 = affine.load %arg6[%214] : memref<?xf64>
          %217 = arith.mulf %215, %216 : f64
          %218 = affine.load %arg5[%arg9] : memref<?xf64>
          %219 = arith.addf %217, %218 : f64
          affine.store %219, %arg5[%arg9] : memref<?xf64>
          %220 = affine.load %arg4[%arg9, %214] : memref<?x1300xf64>
          %221 = affine.load %arg6[%214] : memref<?xf64>
          %222 = arith.mulf %220, %221 : f64
          %223 = affine.load %arg7[%arg9] : memref<?xf64>
          %224 = arith.addf %222, %223 : f64
          affine.store %224, %arg7[%arg9] : memref<?xf64>
          %225 = affine.apply #map6(%181)
          %226 = affine.load %arg3[%arg9, %225] : memref<?x1300xf64>
          %227 = affine.load %arg6[%225] : memref<?xf64>
          %228 = arith.mulf %226, %227 : f64
          %229 = affine.load %arg5[%arg9] : memref<?xf64>
          %230 = arith.addf %228, %229 : f64
          affine.store %230, %arg5[%arg9] : memref<?xf64>
          %231 = affine.load %arg4[%arg9, %225] : memref<?x1300xf64>
          %232 = affine.load %arg6[%225] : memref<?xf64>
          %233 = arith.mulf %231, %232 : f64
          %234 = affine.load %arg7[%arg9] : memref<?xf64>
          %235 = arith.addf %233, %234 : f64
          affine.store %235, %arg7[%arg9] : memref<?xf64>
          %236 = affine.apply #map7(%181)
          %237 = affine.load %arg3[%arg9, %236] : memref<?x1300xf64>
          %238 = affine.load %arg6[%236] : memref<?xf64>
          %239 = arith.mulf %237, %238 : f64
          %240 = affine.load %arg5[%arg9] : memref<?xf64>
          %241 = arith.addf %239, %240 : f64
          affine.store %241, %arg5[%arg9] : memref<?xf64>
          %242 = affine.load %arg4[%arg9, %236] : memref<?x1300xf64>
          %243 = affine.load %arg6[%236] : memref<?xf64>
          %244 = arith.mulf %242, %243 : f64
          %245 = affine.load %arg7[%arg9] : memref<?xf64>
          %246 = arith.addf %244, %245 : f64
          affine.store %246, %arg7[%arg9] : memref<?xf64>
          %247 = affine.apply #map8(%181)
          %248 = affine.load %arg3[%arg9, %247] : memref<?x1300xf64>
          %249 = affine.load %arg6[%247] : memref<?xf64>
          %250 = arith.mulf %248, %249 : f64
          %251 = affine.load %arg5[%arg9] : memref<?xf64>
          %252 = arith.addf %250, %251 : f64
          affine.store %252, %arg5[%arg9] : memref<?xf64>
          %253 = affine.load %arg4[%arg9, %247] : memref<?x1300xf64>
          %254 = affine.load %arg6[%247] : memref<?xf64>
          %255 = arith.mulf %253, %254 : f64
          %256 = affine.load %arg7[%arg9] : memref<?xf64>
          %257 = arith.addf %255, %256 : f64
          affine.store %257, %arg7[%arg9] : memref<?xf64>
          %258 = affine.apply #map9(%181)
          %259 = affine.load %arg3[%arg9, %258] : memref<?x1300xf64>
          %260 = affine.load %arg6[%258] : memref<?xf64>
          %261 = arith.mulf %259, %260 : f64
          %262 = affine.load %arg5[%arg9] : memref<?xf64>
          %263 = arith.addf %261, %262 : f64
          affine.store %263, %arg5[%arg9] : memref<?xf64>
          %264 = affine.load %arg4[%arg9, %258] : memref<?x1300xf64>
          %265 = affine.load %arg6[%258] : memref<?xf64>
          %266 = arith.mulf %264, %265 : f64
          %267 = affine.load %arg7[%arg9] : memref<?xf64>
          %268 = arith.addf %266, %267 : f64
          affine.store %268, %arg7[%arg9] : memref<?xf64>
        }
        affine.for %arg10 = #map2()[%0] to #map12()[%0] step 8 {
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
          %71 = affine.apply #map8(%arg10)
          %72 = affine.load %arg3[%arg9, %71] : memref<?x1300xf64>
          %73 = affine.load %arg6[%71] : memref<?xf64>
          %74 = arith.mulf %72, %73 : f64
          %75 = affine.load %arg5[%arg9] : memref<?xf64>
          %76 = arith.addf %74, %75 : f64
          affine.store %76, %arg5[%arg9] : memref<?xf64>
          %77 = affine.load %arg4[%arg9, %71] : memref<?x1300xf64>
          %78 = affine.load %arg6[%71] : memref<?xf64>
          %79 = arith.mulf %77, %78 : f64
          %80 = affine.load %arg7[%arg9] : memref<?xf64>
          %81 = arith.addf %79, %80 : f64
          affine.store %81, %arg7[%arg9] : memref<?xf64>
          %82 = affine.apply #map9(%arg10)
          %83 = affine.load %arg3[%arg9, %82] : memref<?x1300xf64>
          %84 = affine.load %arg6[%82] : memref<?xf64>
          %85 = arith.mulf %83, %84 : f64
          %86 = affine.load %arg5[%arg9] : memref<?xf64>
          %87 = arith.addf %85, %86 : f64
          affine.store %87, %arg5[%arg9] : memref<?xf64>
          %88 = affine.load %arg4[%arg9, %82] : memref<?x1300xf64>
          %89 = affine.load %arg6[%82] : memref<?xf64>
          %90 = arith.mulf %88, %89 : f64
          %91 = affine.load %arg7[%arg9] : memref<?xf64>
          %92 = arith.addf %90, %91 : f64
          affine.store %92, %arg7[%arg9] : memref<?xf64>
        }
        affine.for %arg10 = #map12()[%0] to #map13()[%0] step 3 {
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
        }
        affine.for %arg10 = #map13()[%0] to %0 {
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

