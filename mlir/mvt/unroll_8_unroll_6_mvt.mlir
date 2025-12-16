#map = affine_map<()[s0] -> (((s0 floordiv 6) floordiv 8) * 48)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0 + 3)>
#map4 = affine_map<(d0) -> (d0 + 4)>
#map5 = affine_map<(d0) -> (d0 + 5)>
#map6 = affine_map<(d0) -> (d0 + 6)>
#map7 = affine_map<(d0) -> (d0 + 12)>
#map8 = affine_map<(d0) -> (d0 + 18)>
#map9 = affine_map<(d0) -> (d0 + 24)>
#map10 = affine_map<(d0) -> (d0 + 30)>
#map11 = affine_map<(d0) -> (d0 + 36)>
#map12 = affine_map<(d0) -> (d0 + 42)>
#map13 = affine_map<()[s0] -> ((s0 floordiv 6) * 6)>
#map14 = affine_map<()[s0] -> ((s0 floordiv 6) * 6 + ((s0 mod 6) floordiv 8) * 8)>
#map15 = affine_map<(d0) -> (d0 + 7)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>, #dlti.dl_entry<"dlti.endianness", "little">>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_mvt(%arg0: i32, %arg1: memref<?xf64>, %arg2: memref<?xf64>, %arg3: memref<?xf64>, %arg4: memref<?xf64>, %arg5: memref<?x2000xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg0 : i32 to index
    affine.for %arg6 = 0 to %0 {
      affine.for %arg7 = 0 to #map()[%0] step 48 {
        %1 = affine.load %arg1[%arg6] : memref<?xf64>
        %2 = affine.load %arg5[%arg6, %arg7] : memref<?x2000xf64>
        %3 = affine.load %arg3[%arg7] : memref<?xf64>
        %4 = arith.mulf %2, %3 : f64
        %5 = arith.addf %1, %4 : f64
        affine.store %5, %arg1[%arg6] : memref<?xf64>
        %6 = affine.apply #map1(%arg7)
        %7 = affine.load %arg1[%arg6] : memref<?xf64>
        %8 = affine.load %arg5[%arg6, %6] : memref<?x2000xf64>
        %9 = affine.load %arg3[%6] : memref<?xf64>
        %10 = arith.mulf %8, %9 : f64
        %11 = arith.addf %7, %10 : f64
        affine.store %11, %arg1[%arg6] : memref<?xf64>
        %12 = affine.apply #map2(%arg7)
        %13 = affine.load %arg1[%arg6] : memref<?xf64>
        %14 = affine.load %arg5[%arg6, %12] : memref<?x2000xf64>
        %15 = affine.load %arg3[%12] : memref<?xf64>
        %16 = arith.mulf %14, %15 : f64
        %17 = arith.addf %13, %16 : f64
        affine.store %17, %arg1[%arg6] : memref<?xf64>
        %18 = affine.apply #map3(%arg7)
        %19 = affine.load %arg1[%arg6] : memref<?xf64>
        %20 = affine.load %arg5[%arg6, %18] : memref<?x2000xf64>
        %21 = affine.load %arg3[%18] : memref<?xf64>
        %22 = arith.mulf %20, %21 : f64
        %23 = arith.addf %19, %22 : f64
        affine.store %23, %arg1[%arg6] : memref<?xf64>
        %24 = affine.apply #map4(%arg7)
        %25 = affine.load %arg1[%arg6] : memref<?xf64>
        %26 = affine.load %arg5[%arg6, %24] : memref<?x2000xf64>
        %27 = affine.load %arg3[%24] : memref<?xf64>
        %28 = arith.mulf %26, %27 : f64
        %29 = arith.addf %25, %28 : f64
        affine.store %29, %arg1[%arg6] : memref<?xf64>
        %30 = affine.apply #map5(%arg7)
        %31 = affine.load %arg1[%arg6] : memref<?xf64>
        %32 = affine.load %arg5[%arg6, %30] : memref<?x2000xf64>
        %33 = affine.load %arg3[%30] : memref<?xf64>
        %34 = arith.mulf %32, %33 : f64
        %35 = arith.addf %31, %34 : f64
        affine.store %35, %arg1[%arg6] : memref<?xf64>
        %36 = affine.apply #map6(%arg7)
        %37 = affine.load %arg1[%arg6] : memref<?xf64>
        %38 = affine.load %arg5[%arg6, %36] : memref<?x2000xf64>
        %39 = affine.load %arg3[%36] : memref<?xf64>
        %40 = arith.mulf %38, %39 : f64
        %41 = arith.addf %37, %40 : f64
        affine.store %41, %arg1[%arg6] : memref<?xf64>
        %42 = affine.apply #map1(%36)
        %43 = affine.load %arg1[%arg6] : memref<?xf64>
        %44 = affine.load %arg5[%arg6, %42] : memref<?x2000xf64>
        %45 = affine.load %arg3[%42] : memref<?xf64>
        %46 = arith.mulf %44, %45 : f64
        %47 = arith.addf %43, %46 : f64
        affine.store %47, %arg1[%arg6] : memref<?xf64>
        %48 = affine.apply #map2(%36)
        %49 = affine.load %arg1[%arg6] : memref<?xf64>
        %50 = affine.load %arg5[%arg6, %48] : memref<?x2000xf64>
        %51 = affine.load %arg3[%48] : memref<?xf64>
        %52 = arith.mulf %50, %51 : f64
        %53 = arith.addf %49, %52 : f64
        affine.store %53, %arg1[%arg6] : memref<?xf64>
        %54 = affine.apply #map3(%36)
        %55 = affine.load %arg1[%arg6] : memref<?xf64>
        %56 = affine.load %arg5[%arg6, %54] : memref<?x2000xf64>
        %57 = affine.load %arg3[%54] : memref<?xf64>
        %58 = arith.mulf %56, %57 : f64
        %59 = arith.addf %55, %58 : f64
        affine.store %59, %arg1[%arg6] : memref<?xf64>
        %60 = affine.apply #map4(%36)
        %61 = affine.load %arg1[%arg6] : memref<?xf64>
        %62 = affine.load %arg5[%arg6, %60] : memref<?x2000xf64>
        %63 = affine.load %arg3[%60] : memref<?xf64>
        %64 = arith.mulf %62, %63 : f64
        %65 = arith.addf %61, %64 : f64
        affine.store %65, %arg1[%arg6] : memref<?xf64>
        %66 = affine.apply #map5(%36)
        %67 = affine.load %arg1[%arg6] : memref<?xf64>
        %68 = affine.load %arg5[%arg6, %66] : memref<?x2000xf64>
        %69 = affine.load %arg3[%66] : memref<?xf64>
        %70 = arith.mulf %68, %69 : f64
        %71 = arith.addf %67, %70 : f64
        affine.store %71, %arg1[%arg6] : memref<?xf64>
        %72 = affine.apply #map7(%arg7)
        %73 = affine.load %arg1[%arg6] : memref<?xf64>
        %74 = affine.load %arg5[%arg6, %72] : memref<?x2000xf64>
        %75 = affine.load %arg3[%72] : memref<?xf64>
        %76 = arith.mulf %74, %75 : f64
        %77 = arith.addf %73, %76 : f64
        affine.store %77, %arg1[%arg6] : memref<?xf64>
        %78 = affine.apply #map1(%72)
        %79 = affine.load %arg1[%arg6] : memref<?xf64>
        %80 = affine.load %arg5[%arg6, %78] : memref<?x2000xf64>
        %81 = affine.load %arg3[%78] : memref<?xf64>
        %82 = arith.mulf %80, %81 : f64
        %83 = arith.addf %79, %82 : f64
        affine.store %83, %arg1[%arg6] : memref<?xf64>
        %84 = affine.apply #map2(%72)
        %85 = affine.load %arg1[%arg6] : memref<?xf64>
        %86 = affine.load %arg5[%arg6, %84] : memref<?x2000xf64>
        %87 = affine.load %arg3[%84] : memref<?xf64>
        %88 = arith.mulf %86, %87 : f64
        %89 = arith.addf %85, %88 : f64
        affine.store %89, %arg1[%arg6] : memref<?xf64>
        %90 = affine.apply #map3(%72)
        %91 = affine.load %arg1[%arg6] : memref<?xf64>
        %92 = affine.load %arg5[%arg6, %90] : memref<?x2000xf64>
        %93 = affine.load %arg3[%90] : memref<?xf64>
        %94 = arith.mulf %92, %93 : f64
        %95 = arith.addf %91, %94 : f64
        affine.store %95, %arg1[%arg6] : memref<?xf64>
        %96 = affine.apply #map4(%72)
        %97 = affine.load %arg1[%arg6] : memref<?xf64>
        %98 = affine.load %arg5[%arg6, %96] : memref<?x2000xf64>
        %99 = affine.load %arg3[%96] : memref<?xf64>
        %100 = arith.mulf %98, %99 : f64
        %101 = arith.addf %97, %100 : f64
        affine.store %101, %arg1[%arg6] : memref<?xf64>
        %102 = affine.apply #map5(%72)
        %103 = affine.load %arg1[%arg6] : memref<?xf64>
        %104 = affine.load %arg5[%arg6, %102] : memref<?x2000xf64>
        %105 = affine.load %arg3[%102] : memref<?xf64>
        %106 = arith.mulf %104, %105 : f64
        %107 = arith.addf %103, %106 : f64
        affine.store %107, %arg1[%arg6] : memref<?xf64>
        %108 = affine.apply #map8(%arg7)
        %109 = affine.load %arg1[%arg6] : memref<?xf64>
        %110 = affine.load %arg5[%arg6, %108] : memref<?x2000xf64>
        %111 = affine.load %arg3[%108] : memref<?xf64>
        %112 = arith.mulf %110, %111 : f64
        %113 = arith.addf %109, %112 : f64
        affine.store %113, %arg1[%arg6] : memref<?xf64>
        %114 = affine.apply #map1(%108)
        %115 = affine.load %arg1[%arg6] : memref<?xf64>
        %116 = affine.load %arg5[%arg6, %114] : memref<?x2000xf64>
        %117 = affine.load %arg3[%114] : memref<?xf64>
        %118 = arith.mulf %116, %117 : f64
        %119 = arith.addf %115, %118 : f64
        affine.store %119, %arg1[%arg6] : memref<?xf64>
        %120 = affine.apply #map2(%108)
        %121 = affine.load %arg1[%arg6] : memref<?xf64>
        %122 = affine.load %arg5[%arg6, %120] : memref<?x2000xf64>
        %123 = affine.load %arg3[%120] : memref<?xf64>
        %124 = arith.mulf %122, %123 : f64
        %125 = arith.addf %121, %124 : f64
        affine.store %125, %arg1[%arg6] : memref<?xf64>
        %126 = affine.apply #map3(%108)
        %127 = affine.load %arg1[%arg6] : memref<?xf64>
        %128 = affine.load %arg5[%arg6, %126] : memref<?x2000xf64>
        %129 = affine.load %arg3[%126] : memref<?xf64>
        %130 = arith.mulf %128, %129 : f64
        %131 = arith.addf %127, %130 : f64
        affine.store %131, %arg1[%arg6] : memref<?xf64>
        %132 = affine.apply #map4(%108)
        %133 = affine.load %arg1[%arg6] : memref<?xf64>
        %134 = affine.load %arg5[%arg6, %132] : memref<?x2000xf64>
        %135 = affine.load %arg3[%132] : memref<?xf64>
        %136 = arith.mulf %134, %135 : f64
        %137 = arith.addf %133, %136 : f64
        affine.store %137, %arg1[%arg6] : memref<?xf64>
        %138 = affine.apply #map5(%108)
        %139 = affine.load %arg1[%arg6] : memref<?xf64>
        %140 = affine.load %arg5[%arg6, %138] : memref<?x2000xf64>
        %141 = affine.load %arg3[%138] : memref<?xf64>
        %142 = arith.mulf %140, %141 : f64
        %143 = arith.addf %139, %142 : f64
        affine.store %143, %arg1[%arg6] : memref<?xf64>
        %144 = affine.apply #map9(%arg7)
        %145 = affine.load %arg1[%arg6] : memref<?xf64>
        %146 = affine.load %arg5[%arg6, %144] : memref<?x2000xf64>
        %147 = affine.load %arg3[%144] : memref<?xf64>
        %148 = arith.mulf %146, %147 : f64
        %149 = arith.addf %145, %148 : f64
        affine.store %149, %arg1[%arg6] : memref<?xf64>
        %150 = affine.apply #map1(%144)
        %151 = affine.load %arg1[%arg6] : memref<?xf64>
        %152 = affine.load %arg5[%arg6, %150] : memref<?x2000xf64>
        %153 = affine.load %arg3[%150] : memref<?xf64>
        %154 = arith.mulf %152, %153 : f64
        %155 = arith.addf %151, %154 : f64
        affine.store %155, %arg1[%arg6] : memref<?xf64>
        %156 = affine.apply #map2(%144)
        %157 = affine.load %arg1[%arg6] : memref<?xf64>
        %158 = affine.load %arg5[%arg6, %156] : memref<?x2000xf64>
        %159 = affine.load %arg3[%156] : memref<?xf64>
        %160 = arith.mulf %158, %159 : f64
        %161 = arith.addf %157, %160 : f64
        affine.store %161, %arg1[%arg6] : memref<?xf64>
        %162 = affine.apply #map3(%144)
        %163 = affine.load %arg1[%arg6] : memref<?xf64>
        %164 = affine.load %arg5[%arg6, %162] : memref<?x2000xf64>
        %165 = affine.load %arg3[%162] : memref<?xf64>
        %166 = arith.mulf %164, %165 : f64
        %167 = arith.addf %163, %166 : f64
        affine.store %167, %arg1[%arg6] : memref<?xf64>
        %168 = affine.apply #map4(%144)
        %169 = affine.load %arg1[%arg6] : memref<?xf64>
        %170 = affine.load %arg5[%arg6, %168] : memref<?x2000xf64>
        %171 = affine.load %arg3[%168] : memref<?xf64>
        %172 = arith.mulf %170, %171 : f64
        %173 = arith.addf %169, %172 : f64
        affine.store %173, %arg1[%arg6] : memref<?xf64>
        %174 = affine.apply #map5(%144)
        %175 = affine.load %arg1[%arg6] : memref<?xf64>
        %176 = affine.load %arg5[%arg6, %174] : memref<?x2000xf64>
        %177 = affine.load %arg3[%174] : memref<?xf64>
        %178 = arith.mulf %176, %177 : f64
        %179 = arith.addf %175, %178 : f64
        affine.store %179, %arg1[%arg6] : memref<?xf64>
        %180 = affine.apply #map10(%arg7)
        %181 = affine.load %arg1[%arg6] : memref<?xf64>
        %182 = affine.load %arg5[%arg6, %180] : memref<?x2000xf64>
        %183 = affine.load %arg3[%180] : memref<?xf64>
        %184 = arith.mulf %182, %183 : f64
        %185 = arith.addf %181, %184 : f64
        affine.store %185, %arg1[%arg6] : memref<?xf64>
        %186 = affine.apply #map1(%180)
        %187 = affine.load %arg1[%arg6] : memref<?xf64>
        %188 = affine.load %arg5[%arg6, %186] : memref<?x2000xf64>
        %189 = affine.load %arg3[%186] : memref<?xf64>
        %190 = arith.mulf %188, %189 : f64
        %191 = arith.addf %187, %190 : f64
        affine.store %191, %arg1[%arg6] : memref<?xf64>
        %192 = affine.apply #map2(%180)
        %193 = affine.load %arg1[%arg6] : memref<?xf64>
        %194 = affine.load %arg5[%arg6, %192] : memref<?x2000xf64>
        %195 = affine.load %arg3[%192] : memref<?xf64>
        %196 = arith.mulf %194, %195 : f64
        %197 = arith.addf %193, %196 : f64
        affine.store %197, %arg1[%arg6] : memref<?xf64>
        %198 = affine.apply #map3(%180)
        %199 = affine.load %arg1[%arg6] : memref<?xf64>
        %200 = affine.load %arg5[%arg6, %198] : memref<?x2000xf64>
        %201 = affine.load %arg3[%198] : memref<?xf64>
        %202 = arith.mulf %200, %201 : f64
        %203 = arith.addf %199, %202 : f64
        affine.store %203, %arg1[%arg6] : memref<?xf64>
        %204 = affine.apply #map4(%180)
        %205 = affine.load %arg1[%arg6] : memref<?xf64>
        %206 = affine.load %arg5[%arg6, %204] : memref<?x2000xf64>
        %207 = affine.load %arg3[%204] : memref<?xf64>
        %208 = arith.mulf %206, %207 : f64
        %209 = arith.addf %205, %208 : f64
        affine.store %209, %arg1[%arg6] : memref<?xf64>
        %210 = affine.apply #map5(%180)
        %211 = affine.load %arg1[%arg6] : memref<?xf64>
        %212 = affine.load %arg5[%arg6, %210] : memref<?x2000xf64>
        %213 = affine.load %arg3[%210] : memref<?xf64>
        %214 = arith.mulf %212, %213 : f64
        %215 = arith.addf %211, %214 : f64
        affine.store %215, %arg1[%arg6] : memref<?xf64>
        %216 = affine.apply #map11(%arg7)
        %217 = affine.load %arg1[%arg6] : memref<?xf64>
        %218 = affine.load %arg5[%arg6, %216] : memref<?x2000xf64>
        %219 = affine.load %arg3[%216] : memref<?xf64>
        %220 = arith.mulf %218, %219 : f64
        %221 = arith.addf %217, %220 : f64
        affine.store %221, %arg1[%arg6] : memref<?xf64>
        %222 = affine.apply #map1(%216)
        %223 = affine.load %arg1[%arg6] : memref<?xf64>
        %224 = affine.load %arg5[%arg6, %222] : memref<?x2000xf64>
        %225 = affine.load %arg3[%222] : memref<?xf64>
        %226 = arith.mulf %224, %225 : f64
        %227 = arith.addf %223, %226 : f64
        affine.store %227, %arg1[%arg6] : memref<?xf64>
        %228 = affine.apply #map2(%216)
        %229 = affine.load %arg1[%arg6] : memref<?xf64>
        %230 = affine.load %arg5[%arg6, %228] : memref<?x2000xf64>
        %231 = affine.load %arg3[%228] : memref<?xf64>
        %232 = arith.mulf %230, %231 : f64
        %233 = arith.addf %229, %232 : f64
        affine.store %233, %arg1[%arg6] : memref<?xf64>
        %234 = affine.apply #map3(%216)
        %235 = affine.load %arg1[%arg6] : memref<?xf64>
        %236 = affine.load %arg5[%arg6, %234] : memref<?x2000xf64>
        %237 = affine.load %arg3[%234] : memref<?xf64>
        %238 = arith.mulf %236, %237 : f64
        %239 = arith.addf %235, %238 : f64
        affine.store %239, %arg1[%arg6] : memref<?xf64>
        %240 = affine.apply #map4(%216)
        %241 = affine.load %arg1[%arg6] : memref<?xf64>
        %242 = affine.load %arg5[%arg6, %240] : memref<?x2000xf64>
        %243 = affine.load %arg3[%240] : memref<?xf64>
        %244 = arith.mulf %242, %243 : f64
        %245 = arith.addf %241, %244 : f64
        affine.store %245, %arg1[%arg6] : memref<?xf64>
        %246 = affine.apply #map5(%216)
        %247 = affine.load %arg1[%arg6] : memref<?xf64>
        %248 = affine.load %arg5[%arg6, %246] : memref<?x2000xf64>
        %249 = affine.load %arg3[%246] : memref<?xf64>
        %250 = arith.mulf %248, %249 : f64
        %251 = arith.addf %247, %250 : f64
        affine.store %251, %arg1[%arg6] : memref<?xf64>
        %252 = affine.apply #map12(%arg7)
        %253 = affine.load %arg1[%arg6] : memref<?xf64>
        %254 = affine.load %arg5[%arg6, %252] : memref<?x2000xf64>
        %255 = affine.load %arg3[%252] : memref<?xf64>
        %256 = arith.mulf %254, %255 : f64
        %257 = arith.addf %253, %256 : f64
        affine.store %257, %arg1[%arg6] : memref<?xf64>
        %258 = affine.apply #map1(%252)
        %259 = affine.load %arg1[%arg6] : memref<?xf64>
        %260 = affine.load %arg5[%arg6, %258] : memref<?x2000xf64>
        %261 = affine.load %arg3[%258] : memref<?xf64>
        %262 = arith.mulf %260, %261 : f64
        %263 = arith.addf %259, %262 : f64
        affine.store %263, %arg1[%arg6] : memref<?xf64>
        %264 = affine.apply #map2(%252)
        %265 = affine.load %arg1[%arg6] : memref<?xf64>
        %266 = affine.load %arg5[%arg6, %264] : memref<?x2000xf64>
        %267 = affine.load %arg3[%264] : memref<?xf64>
        %268 = arith.mulf %266, %267 : f64
        %269 = arith.addf %265, %268 : f64
        affine.store %269, %arg1[%arg6] : memref<?xf64>
        %270 = affine.apply #map3(%252)
        %271 = affine.load %arg1[%arg6] : memref<?xf64>
        %272 = affine.load %arg5[%arg6, %270] : memref<?x2000xf64>
        %273 = affine.load %arg3[%270] : memref<?xf64>
        %274 = arith.mulf %272, %273 : f64
        %275 = arith.addf %271, %274 : f64
        affine.store %275, %arg1[%arg6] : memref<?xf64>
        %276 = affine.apply #map4(%252)
        %277 = affine.load %arg1[%arg6] : memref<?xf64>
        %278 = affine.load %arg5[%arg6, %276] : memref<?x2000xf64>
        %279 = affine.load %arg3[%276] : memref<?xf64>
        %280 = arith.mulf %278, %279 : f64
        %281 = arith.addf %277, %280 : f64
        affine.store %281, %arg1[%arg6] : memref<?xf64>
        %282 = affine.apply #map5(%252)
        %283 = affine.load %arg1[%arg6] : memref<?xf64>
        %284 = affine.load %arg5[%arg6, %282] : memref<?x2000xf64>
        %285 = affine.load %arg3[%282] : memref<?xf64>
        %286 = arith.mulf %284, %285 : f64
        %287 = arith.addf %283, %286 : f64
        affine.store %287, %arg1[%arg6] : memref<?xf64>
      }
      affine.for %arg7 = #map()[%0] to #map13()[%0] step 6 {
        %1 = affine.load %arg1[%arg6] : memref<?xf64>
        %2 = affine.load %arg5[%arg6, %arg7] : memref<?x2000xf64>
        %3 = affine.load %arg3[%arg7] : memref<?xf64>
        %4 = arith.mulf %2, %3 : f64
        %5 = arith.addf %1, %4 : f64
        affine.store %5, %arg1[%arg6] : memref<?xf64>
        %6 = affine.apply #map1(%arg7)
        %7 = affine.load %arg1[%arg6] : memref<?xf64>
        %8 = affine.load %arg5[%arg6, %6] : memref<?x2000xf64>
        %9 = affine.load %arg3[%6] : memref<?xf64>
        %10 = arith.mulf %8, %9 : f64
        %11 = arith.addf %7, %10 : f64
        affine.store %11, %arg1[%arg6] : memref<?xf64>
        %12 = affine.apply #map2(%arg7)
        %13 = affine.load %arg1[%arg6] : memref<?xf64>
        %14 = affine.load %arg5[%arg6, %12] : memref<?x2000xf64>
        %15 = affine.load %arg3[%12] : memref<?xf64>
        %16 = arith.mulf %14, %15 : f64
        %17 = arith.addf %13, %16 : f64
        affine.store %17, %arg1[%arg6] : memref<?xf64>
        %18 = affine.apply #map3(%arg7)
        %19 = affine.load %arg1[%arg6] : memref<?xf64>
        %20 = affine.load %arg5[%arg6, %18] : memref<?x2000xf64>
        %21 = affine.load %arg3[%18] : memref<?xf64>
        %22 = arith.mulf %20, %21 : f64
        %23 = arith.addf %19, %22 : f64
        affine.store %23, %arg1[%arg6] : memref<?xf64>
        %24 = affine.apply #map4(%arg7)
        %25 = affine.load %arg1[%arg6] : memref<?xf64>
        %26 = affine.load %arg5[%arg6, %24] : memref<?x2000xf64>
        %27 = affine.load %arg3[%24] : memref<?xf64>
        %28 = arith.mulf %26, %27 : f64
        %29 = arith.addf %25, %28 : f64
        affine.store %29, %arg1[%arg6] : memref<?xf64>
        %30 = affine.apply #map5(%arg7)
        %31 = affine.load %arg1[%arg6] : memref<?xf64>
        %32 = affine.load %arg5[%arg6, %30] : memref<?x2000xf64>
        %33 = affine.load %arg3[%30] : memref<?xf64>
        %34 = arith.mulf %32, %33 : f64
        %35 = arith.addf %31, %34 : f64
        affine.store %35, %arg1[%arg6] : memref<?xf64>
      }
      affine.for %arg7 = #map13()[%0] to #map14()[%0] step 8 {
        %1 = affine.load %arg1[%arg6] : memref<?xf64>
        %2 = affine.load %arg5[%arg6, %arg7] : memref<?x2000xf64>
        %3 = affine.load %arg3[%arg7] : memref<?xf64>
        %4 = arith.mulf %2, %3 : f64
        %5 = arith.addf %1, %4 : f64
        affine.store %5, %arg1[%arg6] : memref<?xf64>
        %6 = affine.apply #map1(%arg7)
        %7 = affine.load %arg1[%arg6] : memref<?xf64>
        %8 = affine.load %arg5[%arg6, %6] : memref<?x2000xf64>
        %9 = affine.load %arg3[%6] : memref<?xf64>
        %10 = arith.mulf %8, %9 : f64
        %11 = arith.addf %7, %10 : f64
        affine.store %11, %arg1[%arg6] : memref<?xf64>
        %12 = affine.apply #map2(%arg7)
        %13 = affine.load %arg1[%arg6] : memref<?xf64>
        %14 = affine.load %arg5[%arg6, %12] : memref<?x2000xf64>
        %15 = affine.load %arg3[%12] : memref<?xf64>
        %16 = arith.mulf %14, %15 : f64
        %17 = arith.addf %13, %16 : f64
        affine.store %17, %arg1[%arg6] : memref<?xf64>
        %18 = affine.apply #map3(%arg7)
        %19 = affine.load %arg1[%arg6] : memref<?xf64>
        %20 = affine.load %arg5[%arg6, %18] : memref<?x2000xf64>
        %21 = affine.load %arg3[%18] : memref<?xf64>
        %22 = arith.mulf %20, %21 : f64
        %23 = arith.addf %19, %22 : f64
        affine.store %23, %arg1[%arg6] : memref<?xf64>
        %24 = affine.apply #map4(%arg7)
        %25 = affine.load %arg1[%arg6] : memref<?xf64>
        %26 = affine.load %arg5[%arg6, %24] : memref<?x2000xf64>
        %27 = affine.load %arg3[%24] : memref<?xf64>
        %28 = arith.mulf %26, %27 : f64
        %29 = arith.addf %25, %28 : f64
        affine.store %29, %arg1[%arg6] : memref<?xf64>
        %30 = affine.apply #map5(%arg7)
        %31 = affine.load %arg1[%arg6] : memref<?xf64>
        %32 = affine.load %arg5[%arg6, %30] : memref<?x2000xf64>
        %33 = affine.load %arg3[%30] : memref<?xf64>
        %34 = arith.mulf %32, %33 : f64
        %35 = arith.addf %31, %34 : f64
        affine.store %35, %arg1[%arg6] : memref<?xf64>
        %36 = affine.apply #map6(%arg7)
        %37 = affine.load %arg1[%arg6] : memref<?xf64>
        %38 = affine.load %arg5[%arg6, %36] : memref<?x2000xf64>
        %39 = affine.load %arg3[%36] : memref<?xf64>
        %40 = arith.mulf %38, %39 : f64
        %41 = arith.addf %37, %40 : f64
        affine.store %41, %arg1[%arg6] : memref<?xf64>
        %42 = affine.apply #map15(%arg7)
        %43 = affine.load %arg1[%arg6] : memref<?xf64>
        %44 = affine.load %arg5[%arg6, %42] : memref<?x2000xf64>
        %45 = affine.load %arg3[%42] : memref<?xf64>
        %46 = arith.mulf %44, %45 : f64
        %47 = arith.addf %43, %46 : f64
        affine.store %47, %arg1[%arg6] : memref<?xf64>
      }
      affine.for %arg7 = #map14()[%0] to %0 {
        %1 = affine.load %arg1[%arg6] : memref<?xf64>
        %2 = affine.load %arg5[%arg6, %arg7] : memref<?x2000xf64>
        %3 = affine.load %arg3[%arg7] : memref<?xf64>
        %4 = arith.mulf %2, %3 : f64
        %5 = arith.addf %1, %4 : f64
        affine.store %5, %arg1[%arg6] : memref<?xf64>
      }
    }
    affine.for %arg6 = 0 to %0 {
      affine.for %arg7 = 0 to #map()[%0] step 48 {
        %1 = affine.load %arg2[%arg6] : memref<?xf64>
        %2 = affine.load %arg5[%arg7, %arg6] : memref<?x2000xf64>
        %3 = affine.load %arg4[%arg7] : memref<?xf64>
        %4 = arith.mulf %2, %3 : f64
        %5 = arith.addf %1, %4 : f64
        affine.store %5, %arg2[%arg6] : memref<?xf64>
        %6 = affine.apply #map1(%arg7)
        %7 = affine.load %arg2[%arg6] : memref<?xf64>
        %8 = affine.load %arg5[%6, %arg6] : memref<?x2000xf64>
        %9 = affine.load %arg4[%6] : memref<?xf64>
        %10 = arith.mulf %8, %9 : f64
        %11 = arith.addf %7, %10 : f64
        affine.store %11, %arg2[%arg6] : memref<?xf64>
        %12 = affine.apply #map2(%arg7)
        %13 = affine.load %arg2[%arg6] : memref<?xf64>
        %14 = affine.load %arg5[%12, %arg6] : memref<?x2000xf64>
        %15 = affine.load %arg4[%12] : memref<?xf64>
        %16 = arith.mulf %14, %15 : f64
        %17 = arith.addf %13, %16 : f64
        affine.store %17, %arg2[%arg6] : memref<?xf64>
        %18 = affine.apply #map3(%arg7)
        %19 = affine.load %arg2[%arg6] : memref<?xf64>
        %20 = affine.load %arg5[%18, %arg6] : memref<?x2000xf64>
        %21 = affine.load %arg4[%18] : memref<?xf64>
        %22 = arith.mulf %20, %21 : f64
        %23 = arith.addf %19, %22 : f64
        affine.store %23, %arg2[%arg6] : memref<?xf64>
        %24 = affine.apply #map4(%arg7)
        %25 = affine.load %arg2[%arg6] : memref<?xf64>
        %26 = affine.load %arg5[%24, %arg6] : memref<?x2000xf64>
        %27 = affine.load %arg4[%24] : memref<?xf64>
        %28 = arith.mulf %26, %27 : f64
        %29 = arith.addf %25, %28 : f64
        affine.store %29, %arg2[%arg6] : memref<?xf64>
        %30 = affine.apply #map5(%arg7)
        %31 = affine.load %arg2[%arg6] : memref<?xf64>
        %32 = affine.load %arg5[%30, %arg6] : memref<?x2000xf64>
        %33 = affine.load %arg4[%30] : memref<?xf64>
        %34 = arith.mulf %32, %33 : f64
        %35 = arith.addf %31, %34 : f64
        affine.store %35, %arg2[%arg6] : memref<?xf64>
        %36 = affine.apply #map6(%arg7)
        %37 = affine.load %arg2[%arg6] : memref<?xf64>
        %38 = affine.load %arg5[%36, %arg6] : memref<?x2000xf64>
        %39 = affine.load %arg4[%36] : memref<?xf64>
        %40 = arith.mulf %38, %39 : f64
        %41 = arith.addf %37, %40 : f64
        affine.store %41, %arg2[%arg6] : memref<?xf64>
        %42 = affine.apply #map1(%36)
        %43 = affine.load %arg2[%arg6] : memref<?xf64>
        %44 = affine.load %arg5[%42, %arg6] : memref<?x2000xf64>
        %45 = affine.load %arg4[%42] : memref<?xf64>
        %46 = arith.mulf %44, %45 : f64
        %47 = arith.addf %43, %46 : f64
        affine.store %47, %arg2[%arg6] : memref<?xf64>
        %48 = affine.apply #map2(%36)
        %49 = affine.load %arg2[%arg6] : memref<?xf64>
        %50 = affine.load %arg5[%48, %arg6] : memref<?x2000xf64>
        %51 = affine.load %arg4[%48] : memref<?xf64>
        %52 = arith.mulf %50, %51 : f64
        %53 = arith.addf %49, %52 : f64
        affine.store %53, %arg2[%arg6] : memref<?xf64>
        %54 = affine.apply #map3(%36)
        %55 = affine.load %arg2[%arg6] : memref<?xf64>
        %56 = affine.load %arg5[%54, %arg6] : memref<?x2000xf64>
        %57 = affine.load %arg4[%54] : memref<?xf64>
        %58 = arith.mulf %56, %57 : f64
        %59 = arith.addf %55, %58 : f64
        affine.store %59, %arg2[%arg6] : memref<?xf64>
        %60 = affine.apply #map4(%36)
        %61 = affine.load %arg2[%arg6] : memref<?xf64>
        %62 = affine.load %arg5[%60, %arg6] : memref<?x2000xf64>
        %63 = affine.load %arg4[%60] : memref<?xf64>
        %64 = arith.mulf %62, %63 : f64
        %65 = arith.addf %61, %64 : f64
        affine.store %65, %arg2[%arg6] : memref<?xf64>
        %66 = affine.apply #map5(%36)
        %67 = affine.load %arg2[%arg6] : memref<?xf64>
        %68 = affine.load %arg5[%66, %arg6] : memref<?x2000xf64>
        %69 = affine.load %arg4[%66] : memref<?xf64>
        %70 = arith.mulf %68, %69 : f64
        %71 = arith.addf %67, %70 : f64
        affine.store %71, %arg2[%arg6] : memref<?xf64>
        %72 = affine.apply #map7(%arg7)
        %73 = affine.load %arg2[%arg6] : memref<?xf64>
        %74 = affine.load %arg5[%72, %arg6] : memref<?x2000xf64>
        %75 = affine.load %arg4[%72] : memref<?xf64>
        %76 = arith.mulf %74, %75 : f64
        %77 = arith.addf %73, %76 : f64
        affine.store %77, %arg2[%arg6] : memref<?xf64>
        %78 = affine.apply #map1(%72)
        %79 = affine.load %arg2[%arg6] : memref<?xf64>
        %80 = affine.load %arg5[%78, %arg6] : memref<?x2000xf64>
        %81 = affine.load %arg4[%78] : memref<?xf64>
        %82 = arith.mulf %80, %81 : f64
        %83 = arith.addf %79, %82 : f64
        affine.store %83, %arg2[%arg6] : memref<?xf64>
        %84 = affine.apply #map2(%72)
        %85 = affine.load %arg2[%arg6] : memref<?xf64>
        %86 = affine.load %arg5[%84, %arg6] : memref<?x2000xf64>
        %87 = affine.load %arg4[%84] : memref<?xf64>
        %88 = arith.mulf %86, %87 : f64
        %89 = arith.addf %85, %88 : f64
        affine.store %89, %arg2[%arg6] : memref<?xf64>
        %90 = affine.apply #map3(%72)
        %91 = affine.load %arg2[%arg6] : memref<?xf64>
        %92 = affine.load %arg5[%90, %arg6] : memref<?x2000xf64>
        %93 = affine.load %arg4[%90] : memref<?xf64>
        %94 = arith.mulf %92, %93 : f64
        %95 = arith.addf %91, %94 : f64
        affine.store %95, %arg2[%arg6] : memref<?xf64>
        %96 = affine.apply #map4(%72)
        %97 = affine.load %arg2[%arg6] : memref<?xf64>
        %98 = affine.load %arg5[%96, %arg6] : memref<?x2000xf64>
        %99 = affine.load %arg4[%96] : memref<?xf64>
        %100 = arith.mulf %98, %99 : f64
        %101 = arith.addf %97, %100 : f64
        affine.store %101, %arg2[%arg6] : memref<?xf64>
        %102 = affine.apply #map5(%72)
        %103 = affine.load %arg2[%arg6] : memref<?xf64>
        %104 = affine.load %arg5[%102, %arg6] : memref<?x2000xf64>
        %105 = affine.load %arg4[%102] : memref<?xf64>
        %106 = arith.mulf %104, %105 : f64
        %107 = arith.addf %103, %106 : f64
        affine.store %107, %arg2[%arg6] : memref<?xf64>
        %108 = affine.apply #map8(%arg7)
        %109 = affine.load %arg2[%arg6] : memref<?xf64>
        %110 = affine.load %arg5[%108, %arg6] : memref<?x2000xf64>
        %111 = affine.load %arg4[%108] : memref<?xf64>
        %112 = arith.mulf %110, %111 : f64
        %113 = arith.addf %109, %112 : f64
        affine.store %113, %arg2[%arg6] : memref<?xf64>
        %114 = affine.apply #map1(%108)
        %115 = affine.load %arg2[%arg6] : memref<?xf64>
        %116 = affine.load %arg5[%114, %arg6] : memref<?x2000xf64>
        %117 = affine.load %arg4[%114] : memref<?xf64>
        %118 = arith.mulf %116, %117 : f64
        %119 = arith.addf %115, %118 : f64
        affine.store %119, %arg2[%arg6] : memref<?xf64>
        %120 = affine.apply #map2(%108)
        %121 = affine.load %arg2[%arg6] : memref<?xf64>
        %122 = affine.load %arg5[%120, %arg6] : memref<?x2000xf64>
        %123 = affine.load %arg4[%120] : memref<?xf64>
        %124 = arith.mulf %122, %123 : f64
        %125 = arith.addf %121, %124 : f64
        affine.store %125, %arg2[%arg6] : memref<?xf64>
        %126 = affine.apply #map3(%108)
        %127 = affine.load %arg2[%arg6] : memref<?xf64>
        %128 = affine.load %arg5[%126, %arg6] : memref<?x2000xf64>
        %129 = affine.load %arg4[%126] : memref<?xf64>
        %130 = arith.mulf %128, %129 : f64
        %131 = arith.addf %127, %130 : f64
        affine.store %131, %arg2[%arg6] : memref<?xf64>
        %132 = affine.apply #map4(%108)
        %133 = affine.load %arg2[%arg6] : memref<?xf64>
        %134 = affine.load %arg5[%132, %arg6] : memref<?x2000xf64>
        %135 = affine.load %arg4[%132] : memref<?xf64>
        %136 = arith.mulf %134, %135 : f64
        %137 = arith.addf %133, %136 : f64
        affine.store %137, %arg2[%arg6] : memref<?xf64>
        %138 = affine.apply #map5(%108)
        %139 = affine.load %arg2[%arg6] : memref<?xf64>
        %140 = affine.load %arg5[%138, %arg6] : memref<?x2000xf64>
        %141 = affine.load %arg4[%138] : memref<?xf64>
        %142 = arith.mulf %140, %141 : f64
        %143 = arith.addf %139, %142 : f64
        affine.store %143, %arg2[%arg6] : memref<?xf64>
        %144 = affine.apply #map9(%arg7)
        %145 = affine.load %arg2[%arg6] : memref<?xf64>
        %146 = affine.load %arg5[%144, %arg6] : memref<?x2000xf64>
        %147 = affine.load %arg4[%144] : memref<?xf64>
        %148 = arith.mulf %146, %147 : f64
        %149 = arith.addf %145, %148 : f64
        affine.store %149, %arg2[%arg6] : memref<?xf64>
        %150 = affine.apply #map1(%144)
        %151 = affine.load %arg2[%arg6] : memref<?xf64>
        %152 = affine.load %arg5[%150, %arg6] : memref<?x2000xf64>
        %153 = affine.load %arg4[%150] : memref<?xf64>
        %154 = arith.mulf %152, %153 : f64
        %155 = arith.addf %151, %154 : f64
        affine.store %155, %arg2[%arg6] : memref<?xf64>
        %156 = affine.apply #map2(%144)
        %157 = affine.load %arg2[%arg6] : memref<?xf64>
        %158 = affine.load %arg5[%156, %arg6] : memref<?x2000xf64>
        %159 = affine.load %arg4[%156] : memref<?xf64>
        %160 = arith.mulf %158, %159 : f64
        %161 = arith.addf %157, %160 : f64
        affine.store %161, %arg2[%arg6] : memref<?xf64>
        %162 = affine.apply #map3(%144)
        %163 = affine.load %arg2[%arg6] : memref<?xf64>
        %164 = affine.load %arg5[%162, %arg6] : memref<?x2000xf64>
        %165 = affine.load %arg4[%162] : memref<?xf64>
        %166 = arith.mulf %164, %165 : f64
        %167 = arith.addf %163, %166 : f64
        affine.store %167, %arg2[%arg6] : memref<?xf64>
        %168 = affine.apply #map4(%144)
        %169 = affine.load %arg2[%arg6] : memref<?xf64>
        %170 = affine.load %arg5[%168, %arg6] : memref<?x2000xf64>
        %171 = affine.load %arg4[%168] : memref<?xf64>
        %172 = arith.mulf %170, %171 : f64
        %173 = arith.addf %169, %172 : f64
        affine.store %173, %arg2[%arg6] : memref<?xf64>
        %174 = affine.apply #map5(%144)
        %175 = affine.load %arg2[%arg6] : memref<?xf64>
        %176 = affine.load %arg5[%174, %arg6] : memref<?x2000xf64>
        %177 = affine.load %arg4[%174] : memref<?xf64>
        %178 = arith.mulf %176, %177 : f64
        %179 = arith.addf %175, %178 : f64
        affine.store %179, %arg2[%arg6] : memref<?xf64>
        %180 = affine.apply #map10(%arg7)
        %181 = affine.load %arg2[%arg6] : memref<?xf64>
        %182 = affine.load %arg5[%180, %arg6] : memref<?x2000xf64>
        %183 = affine.load %arg4[%180] : memref<?xf64>
        %184 = arith.mulf %182, %183 : f64
        %185 = arith.addf %181, %184 : f64
        affine.store %185, %arg2[%arg6] : memref<?xf64>
        %186 = affine.apply #map1(%180)
        %187 = affine.load %arg2[%arg6] : memref<?xf64>
        %188 = affine.load %arg5[%186, %arg6] : memref<?x2000xf64>
        %189 = affine.load %arg4[%186] : memref<?xf64>
        %190 = arith.mulf %188, %189 : f64
        %191 = arith.addf %187, %190 : f64
        affine.store %191, %arg2[%arg6] : memref<?xf64>
        %192 = affine.apply #map2(%180)
        %193 = affine.load %arg2[%arg6] : memref<?xf64>
        %194 = affine.load %arg5[%192, %arg6] : memref<?x2000xf64>
        %195 = affine.load %arg4[%192] : memref<?xf64>
        %196 = arith.mulf %194, %195 : f64
        %197 = arith.addf %193, %196 : f64
        affine.store %197, %arg2[%arg6] : memref<?xf64>
        %198 = affine.apply #map3(%180)
        %199 = affine.load %arg2[%arg6] : memref<?xf64>
        %200 = affine.load %arg5[%198, %arg6] : memref<?x2000xf64>
        %201 = affine.load %arg4[%198] : memref<?xf64>
        %202 = arith.mulf %200, %201 : f64
        %203 = arith.addf %199, %202 : f64
        affine.store %203, %arg2[%arg6] : memref<?xf64>
        %204 = affine.apply #map4(%180)
        %205 = affine.load %arg2[%arg6] : memref<?xf64>
        %206 = affine.load %arg5[%204, %arg6] : memref<?x2000xf64>
        %207 = affine.load %arg4[%204] : memref<?xf64>
        %208 = arith.mulf %206, %207 : f64
        %209 = arith.addf %205, %208 : f64
        affine.store %209, %arg2[%arg6] : memref<?xf64>
        %210 = affine.apply #map5(%180)
        %211 = affine.load %arg2[%arg6] : memref<?xf64>
        %212 = affine.load %arg5[%210, %arg6] : memref<?x2000xf64>
        %213 = affine.load %arg4[%210] : memref<?xf64>
        %214 = arith.mulf %212, %213 : f64
        %215 = arith.addf %211, %214 : f64
        affine.store %215, %arg2[%arg6] : memref<?xf64>
        %216 = affine.apply #map11(%arg7)
        %217 = affine.load %arg2[%arg6] : memref<?xf64>
        %218 = affine.load %arg5[%216, %arg6] : memref<?x2000xf64>
        %219 = affine.load %arg4[%216] : memref<?xf64>
        %220 = arith.mulf %218, %219 : f64
        %221 = arith.addf %217, %220 : f64
        affine.store %221, %arg2[%arg6] : memref<?xf64>
        %222 = affine.apply #map1(%216)
        %223 = affine.load %arg2[%arg6] : memref<?xf64>
        %224 = affine.load %arg5[%222, %arg6] : memref<?x2000xf64>
        %225 = affine.load %arg4[%222] : memref<?xf64>
        %226 = arith.mulf %224, %225 : f64
        %227 = arith.addf %223, %226 : f64
        affine.store %227, %arg2[%arg6] : memref<?xf64>
        %228 = affine.apply #map2(%216)
        %229 = affine.load %arg2[%arg6] : memref<?xf64>
        %230 = affine.load %arg5[%228, %arg6] : memref<?x2000xf64>
        %231 = affine.load %arg4[%228] : memref<?xf64>
        %232 = arith.mulf %230, %231 : f64
        %233 = arith.addf %229, %232 : f64
        affine.store %233, %arg2[%arg6] : memref<?xf64>
        %234 = affine.apply #map3(%216)
        %235 = affine.load %arg2[%arg6] : memref<?xf64>
        %236 = affine.load %arg5[%234, %arg6] : memref<?x2000xf64>
        %237 = affine.load %arg4[%234] : memref<?xf64>
        %238 = arith.mulf %236, %237 : f64
        %239 = arith.addf %235, %238 : f64
        affine.store %239, %arg2[%arg6] : memref<?xf64>
        %240 = affine.apply #map4(%216)
        %241 = affine.load %arg2[%arg6] : memref<?xf64>
        %242 = affine.load %arg5[%240, %arg6] : memref<?x2000xf64>
        %243 = affine.load %arg4[%240] : memref<?xf64>
        %244 = arith.mulf %242, %243 : f64
        %245 = arith.addf %241, %244 : f64
        affine.store %245, %arg2[%arg6] : memref<?xf64>
        %246 = affine.apply #map5(%216)
        %247 = affine.load %arg2[%arg6] : memref<?xf64>
        %248 = affine.load %arg5[%246, %arg6] : memref<?x2000xf64>
        %249 = affine.load %arg4[%246] : memref<?xf64>
        %250 = arith.mulf %248, %249 : f64
        %251 = arith.addf %247, %250 : f64
        affine.store %251, %arg2[%arg6] : memref<?xf64>
        %252 = affine.apply #map12(%arg7)
        %253 = affine.load %arg2[%arg6] : memref<?xf64>
        %254 = affine.load %arg5[%252, %arg6] : memref<?x2000xf64>
        %255 = affine.load %arg4[%252] : memref<?xf64>
        %256 = arith.mulf %254, %255 : f64
        %257 = arith.addf %253, %256 : f64
        affine.store %257, %arg2[%arg6] : memref<?xf64>
        %258 = affine.apply #map1(%252)
        %259 = affine.load %arg2[%arg6] : memref<?xf64>
        %260 = affine.load %arg5[%258, %arg6] : memref<?x2000xf64>
        %261 = affine.load %arg4[%258] : memref<?xf64>
        %262 = arith.mulf %260, %261 : f64
        %263 = arith.addf %259, %262 : f64
        affine.store %263, %arg2[%arg6] : memref<?xf64>
        %264 = affine.apply #map2(%252)
        %265 = affine.load %arg2[%arg6] : memref<?xf64>
        %266 = affine.load %arg5[%264, %arg6] : memref<?x2000xf64>
        %267 = affine.load %arg4[%264] : memref<?xf64>
        %268 = arith.mulf %266, %267 : f64
        %269 = arith.addf %265, %268 : f64
        affine.store %269, %arg2[%arg6] : memref<?xf64>
        %270 = affine.apply #map3(%252)
        %271 = affine.load %arg2[%arg6] : memref<?xf64>
        %272 = affine.load %arg5[%270, %arg6] : memref<?x2000xf64>
        %273 = affine.load %arg4[%270] : memref<?xf64>
        %274 = arith.mulf %272, %273 : f64
        %275 = arith.addf %271, %274 : f64
        affine.store %275, %arg2[%arg6] : memref<?xf64>
        %276 = affine.apply #map4(%252)
        %277 = affine.load %arg2[%arg6] : memref<?xf64>
        %278 = affine.load %arg5[%276, %arg6] : memref<?x2000xf64>
        %279 = affine.load %arg4[%276] : memref<?xf64>
        %280 = arith.mulf %278, %279 : f64
        %281 = arith.addf %277, %280 : f64
        affine.store %281, %arg2[%arg6] : memref<?xf64>
        %282 = affine.apply #map5(%252)
        %283 = affine.load %arg2[%arg6] : memref<?xf64>
        %284 = affine.load %arg5[%282, %arg6] : memref<?x2000xf64>
        %285 = affine.load %arg4[%282] : memref<?xf64>
        %286 = arith.mulf %284, %285 : f64
        %287 = arith.addf %283, %286 : f64
        affine.store %287, %arg2[%arg6] : memref<?xf64>
      }
      affine.for %arg7 = #map()[%0] to #map13()[%0] step 6 {
        %1 = affine.load %arg2[%arg6] : memref<?xf64>
        %2 = affine.load %arg5[%arg7, %arg6] : memref<?x2000xf64>
        %3 = affine.load %arg4[%arg7] : memref<?xf64>
        %4 = arith.mulf %2, %3 : f64
        %5 = arith.addf %1, %4 : f64
        affine.store %5, %arg2[%arg6] : memref<?xf64>
        %6 = affine.apply #map1(%arg7)
        %7 = affine.load %arg2[%arg6] : memref<?xf64>
        %8 = affine.load %arg5[%6, %arg6] : memref<?x2000xf64>
        %9 = affine.load %arg4[%6] : memref<?xf64>
        %10 = arith.mulf %8, %9 : f64
        %11 = arith.addf %7, %10 : f64
        affine.store %11, %arg2[%arg6] : memref<?xf64>
        %12 = affine.apply #map2(%arg7)
        %13 = affine.load %arg2[%arg6] : memref<?xf64>
        %14 = affine.load %arg5[%12, %arg6] : memref<?x2000xf64>
        %15 = affine.load %arg4[%12] : memref<?xf64>
        %16 = arith.mulf %14, %15 : f64
        %17 = arith.addf %13, %16 : f64
        affine.store %17, %arg2[%arg6] : memref<?xf64>
        %18 = affine.apply #map3(%arg7)
        %19 = affine.load %arg2[%arg6] : memref<?xf64>
        %20 = affine.load %arg5[%18, %arg6] : memref<?x2000xf64>
        %21 = affine.load %arg4[%18] : memref<?xf64>
        %22 = arith.mulf %20, %21 : f64
        %23 = arith.addf %19, %22 : f64
        affine.store %23, %arg2[%arg6] : memref<?xf64>
        %24 = affine.apply #map4(%arg7)
        %25 = affine.load %arg2[%arg6] : memref<?xf64>
        %26 = affine.load %arg5[%24, %arg6] : memref<?x2000xf64>
        %27 = affine.load %arg4[%24] : memref<?xf64>
        %28 = arith.mulf %26, %27 : f64
        %29 = arith.addf %25, %28 : f64
        affine.store %29, %arg2[%arg6] : memref<?xf64>
        %30 = affine.apply #map5(%arg7)
        %31 = affine.load %arg2[%arg6] : memref<?xf64>
        %32 = affine.load %arg5[%30, %arg6] : memref<?x2000xf64>
        %33 = affine.load %arg4[%30] : memref<?xf64>
        %34 = arith.mulf %32, %33 : f64
        %35 = arith.addf %31, %34 : f64
        affine.store %35, %arg2[%arg6] : memref<?xf64>
      }
      affine.for %arg7 = #map13()[%0] to #map14()[%0] step 8 {
        %1 = affine.load %arg2[%arg6] : memref<?xf64>
        %2 = affine.load %arg5[%arg7, %arg6] : memref<?x2000xf64>
        %3 = affine.load %arg4[%arg7] : memref<?xf64>
        %4 = arith.mulf %2, %3 : f64
        %5 = arith.addf %1, %4 : f64
        affine.store %5, %arg2[%arg6] : memref<?xf64>
        %6 = affine.apply #map1(%arg7)
        %7 = affine.load %arg2[%arg6] : memref<?xf64>
        %8 = affine.load %arg5[%6, %arg6] : memref<?x2000xf64>
        %9 = affine.load %arg4[%6] : memref<?xf64>
        %10 = arith.mulf %8, %9 : f64
        %11 = arith.addf %7, %10 : f64
        affine.store %11, %arg2[%arg6] : memref<?xf64>
        %12 = affine.apply #map2(%arg7)
        %13 = affine.load %arg2[%arg6] : memref<?xf64>
        %14 = affine.load %arg5[%12, %arg6] : memref<?x2000xf64>
        %15 = affine.load %arg4[%12] : memref<?xf64>
        %16 = arith.mulf %14, %15 : f64
        %17 = arith.addf %13, %16 : f64
        affine.store %17, %arg2[%arg6] : memref<?xf64>
        %18 = affine.apply #map3(%arg7)
        %19 = affine.load %arg2[%arg6] : memref<?xf64>
        %20 = affine.load %arg5[%18, %arg6] : memref<?x2000xf64>
        %21 = affine.load %arg4[%18] : memref<?xf64>
        %22 = arith.mulf %20, %21 : f64
        %23 = arith.addf %19, %22 : f64
        affine.store %23, %arg2[%arg6] : memref<?xf64>
        %24 = affine.apply #map4(%arg7)
        %25 = affine.load %arg2[%arg6] : memref<?xf64>
        %26 = affine.load %arg5[%24, %arg6] : memref<?x2000xf64>
        %27 = affine.load %arg4[%24] : memref<?xf64>
        %28 = arith.mulf %26, %27 : f64
        %29 = arith.addf %25, %28 : f64
        affine.store %29, %arg2[%arg6] : memref<?xf64>
        %30 = affine.apply #map5(%arg7)
        %31 = affine.load %arg2[%arg6] : memref<?xf64>
        %32 = affine.load %arg5[%30, %arg6] : memref<?x2000xf64>
        %33 = affine.load %arg4[%30] : memref<?xf64>
        %34 = arith.mulf %32, %33 : f64
        %35 = arith.addf %31, %34 : f64
        affine.store %35, %arg2[%arg6] : memref<?xf64>
        %36 = affine.apply #map6(%arg7)
        %37 = affine.load %arg2[%arg6] : memref<?xf64>
        %38 = affine.load %arg5[%36, %arg6] : memref<?x2000xf64>
        %39 = affine.load %arg4[%36] : memref<?xf64>
        %40 = arith.mulf %38, %39 : f64
        %41 = arith.addf %37, %40 : f64
        affine.store %41, %arg2[%arg6] : memref<?xf64>
        %42 = affine.apply #map15(%arg7)
        %43 = affine.load %arg2[%arg6] : memref<?xf64>
        %44 = affine.load %arg5[%42, %arg6] : memref<?x2000xf64>
        %45 = affine.load %arg4[%42] : memref<?xf64>
        %46 = arith.mulf %44, %45 : f64
        %47 = arith.addf %43, %46 : f64
        affine.store %47, %arg2[%arg6] : memref<?xf64>
      }
      affine.for %arg7 = #map14()[%0] to %0 {
        %1 = affine.load %arg2[%arg6] : memref<?xf64>
        %2 = affine.load %arg5[%arg7, %arg6] : memref<?x2000xf64>
        %3 = affine.load %arg4[%arg7] : memref<?xf64>
        %4 = arith.mulf %2, %3 : f64
        %5 = arith.addf %1, %4 : f64
        affine.store %5, %arg2[%arg6] : memref<?xf64>
      }
    }
    return
  }
}

