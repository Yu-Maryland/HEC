#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 70, s0)>
#map2 = affine_map<()[s0] -> (((s0 floordiv 13) floordiv 4) * 52)>
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
#map16 = affine_map<(d0) -> (d0 + 26)>
#map17 = affine_map<(d0) -> (d0 + 39)>
#map18 = affine_map<()[s0] -> ((s0 floordiv 13) * 13)>
#map19 = affine_map<()[s0] -> ((s0 floordiv 13) * 13 + ((s0 mod 13) floordiv 4) * 4)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>, #dlti.dl_entry<"dlti.endianness", "little">>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_doitgen(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: memref<?x140x160xf64>, %arg4: memref<?x160xf64>, %arg5: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 0.000000e+00 : f64
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg2 : i32 to index
    %2 = arith.index_cast %arg0 : i32 to index
    affine.for %arg6 = 0 to %2 step 70 {
      affine.for %arg7 = 0 to %0 step 70 {
        affine.for %arg8 = #map(%arg6) to min #map1(%arg6)[%2] {
          affine.for %arg9 = #map(%arg7) to min #map1(%arg7)[%0] {
            affine.for %arg10 = 0 to %1 {
              affine.store %cst, %arg5[%arg10] : memref<?xf64>
              affine.for %arg11 = 0 to #map2()[%1] step 52 {
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
                %38 = affine.apply #map8(%arg11)
                %39 = affine.load %arg3[%arg8, %arg9, %38] : memref<?x140x160xf64>
                %40 = affine.load %arg4[%38, %arg10] : memref<?x160xf64>
                %41 = arith.mulf %39, %40 : f64
                %42 = affine.load %arg5[%arg10] : memref<?xf64>
                %43 = arith.addf %42, %41 : f64
                affine.store %43, %arg5[%arg10] : memref<?xf64>
                %44 = affine.apply #map9(%arg11)
                %45 = affine.load %arg3[%arg8, %arg9, %44] : memref<?x140x160xf64>
                %46 = affine.load %arg4[%44, %arg10] : memref<?x160xf64>
                %47 = arith.mulf %45, %46 : f64
                %48 = affine.load %arg5[%arg10] : memref<?xf64>
                %49 = arith.addf %48, %47 : f64
                affine.store %49, %arg5[%arg10] : memref<?xf64>
                %50 = affine.apply #map10(%arg11)
                %51 = affine.load %arg3[%arg8, %arg9, %50] : memref<?x140x160xf64>
                %52 = affine.load %arg4[%50, %arg10] : memref<?x160xf64>
                %53 = arith.mulf %51, %52 : f64
                %54 = affine.load %arg5[%arg10] : memref<?xf64>
                %55 = arith.addf %54, %53 : f64
                affine.store %55, %arg5[%arg10] : memref<?xf64>
                %56 = affine.apply #map11(%arg11)
                %57 = affine.load %arg3[%arg8, %arg9, %56] : memref<?x140x160xf64>
                %58 = affine.load %arg4[%56, %arg10] : memref<?x160xf64>
                %59 = arith.mulf %57, %58 : f64
                %60 = affine.load %arg5[%arg10] : memref<?xf64>
                %61 = arith.addf %60, %59 : f64
                affine.store %61, %arg5[%arg10] : memref<?xf64>
                %62 = affine.apply #map12(%arg11)
                %63 = affine.load %arg3[%arg8, %arg9, %62] : memref<?x140x160xf64>
                %64 = affine.load %arg4[%62, %arg10] : memref<?x160xf64>
                %65 = arith.mulf %63, %64 : f64
                %66 = affine.load %arg5[%arg10] : memref<?xf64>
                %67 = arith.addf %66, %65 : f64
                affine.store %67, %arg5[%arg10] : memref<?xf64>
                %68 = affine.apply #map13(%arg11)
                %69 = affine.load %arg3[%arg8, %arg9, %68] : memref<?x140x160xf64>
                %70 = affine.load %arg4[%68, %arg10] : memref<?x160xf64>
                %71 = arith.mulf %69, %70 : f64
                %72 = affine.load %arg5[%arg10] : memref<?xf64>
                %73 = arith.addf %72, %71 : f64
                affine.store %73, %arg5[%arg10] : memref<?xf64>
                %74 = affine.apply #map14(%arg11)
                %75 = affine.load %arg3[%arg8, %arg9, %74] : memref<?x140x160xf64>
                %76 = affine.load %arg4[%74, %arg10] : memref<?x160xf64>
                %77 = arith.mulf %75, %76 : f64
                %78 = affine.load %arg5[%arg10] : memref<?xf64>
                %79 = arith.addf %78, %77 : f64
                affine.store %79, %arg5[%arg10] : memref<?xf64>
                %80 = affine.apply #map15(%arg11)
                %81 = affine.load %arg3[%arg8, %arg9, %80] : memref<?x140x160xf64>
                %82 = affine.load %arg4[%80, %arg10] : memref<?x160xf64>
                %83 = arith.mulf %81, %82 : f64
                %84 = affine.load %arg5[%arg10] : memref<?xf64>
                %85 = arith.addf %84, %83 : f64
                affine.store %85, %arg5[%arg10] : memref<?xf64>
                %86 = affine.apply #map3(%80)
                %87 = affine.load %arg3[%arg8, %arg9, %86] : memref<?x140x160xf64>
                %88 = affine.load %arg4[%86, %arg10] : memref<?x160xf64>
                %89 = arith.mulf %87, %88 : f64
                %90 = affine.load %arg5[%arg10] : memref<?xf64>
                %91 = arith.addf %90, %89 : f64
                affine.store %91, %arg5[%arg10] : memref<?xf64>
                %92 = affine.apply #map4(%80)
                %93 = affine.load %arg3[%arg8, %arg9, %92] : memref<?x140x160xf64>
                %94 = affine.load %arg4[%92, %arg10] : memref<?x160xf64>
                %95 = arith.mulf %93, %94 : f64
                %96 = affine.load %arg5[%arg10] : memref<?xf64>
                %97 = arith.addf %96, %95 : f64
                affine.store %97, %arg5[%arg10] : memref<?xf64>
                %98 = affine.apply #map5(%80)
                %99 = affine.load %arg3[%arg8, %arg9, %98] : memref<?x140x160xf64>
                %100 = affine.load %arg4[%98, %arg10] : memref<?x160xf64>
                %101 = arith.mulf %99, %100 : f64
                %102 = affine.load %arg5[%arg10] : memref<?xf64>
                %103 = arith.addf %102, %101 : f64
                affine.store %103, %arg5[%arg10] : memref<?xf64>
                %104 = affine.apply #map6(%80)
                %105 = affine.load %arg3[%arg8, %arg9, %104] : memref<?x140x160xf64>
                %106 = affine.load %arg4[%104, %arg10] : memref<?x160xf64>
                %107 = arith.mulf %105, %106 : f64
                %108 = affine.load %arg5[%arg10] : memref<?xf64>
                %109 = arith.addf %108, %107 : f64
                affine.store %109, %arg5[%arg10] : memref<?xf64>
                %110 = affine.apply #map7(%80)
                %111 = affine.load %arg3[%arg8, %arg9, %110] : memref<?x140x160xf64>
                %112 = affine.load %arg4[%110, %arg10] : memref<?x160xf64>
                %113 = arith.mulf %111, %112 : f64
                %114 = affine.load %arg5[%arg10] : memref<?xf64>
                %115 = arith.addf %114, %113 : f64
                affine.store %115, %arg5[%arg10] : memref<?xf64>
                %116 = affine.apply #map8(%80)
                %117 = affine.load %arg3[%arg8, %arg9, %116] : memref<?x140x160xf64>
                %118 = affine.load %arg4[%116, %arg10] : memref<?x160xf64>
                %119 = arith.mulf %117, %118 : f64
                %120 = affine.load %arg5[%arg10] : memref<?xf64>
                %121 = arith.addf %120, %119 : f64
                affine.store %121, %arg5[%arg10] : memref<?xf64>
                %122 = affine.apply #map9(%80)
                %123 = affine.load %arg3[%arg8, %arg9, %122] : memref<?x140x160xf64>
                %124 = affine.load %arg4[%122, %arg10] : memref<?x160xf64>
                %125 = arith.mulf %123, %124 : f64
                %126 = affine.load %arg5[%arg10] : memref<?xf64>
                %127 = arith.addf %126, %125 : f64
                affine.store %127, %arg5[%arg10] : memref<?xf64>
                %128 = affine.apply #map10(%80)
                %129 = affine.load %arg3[%arg8, %arg9, %128] : memref<?x140x160xf64>
                %130 = affine.load %arg4[%128, %arg10] : memref<?x160xf64>
                %131 = arith.mulf %129, %130 : f64
                %132 = affine.load %arg5[%arg10] : memref<?xf64>
                %133 = arith.addf %132, %131 : f64
                affine.store %133, %arg5[%arg10] : memref<?xf64>
                %134 = affine.apply #map11(%80)
                %135 = affine.load %arg3[%arg8, %arg9, %134] : memref<?x140x160xf64>
                %136 = affine.load %arg4[%134, %arg10] : memref<?x160xf64>
                %137 = arith.mulf %135, %136 : f64
                %138 = affine.load %arg5[%arg10] : memref<?xf64>
                %139 = arith.addf %138, %137 : f64
                affine.store %139, %arg5[%arg10] : memref<?xf64>
                %140 = affine.apply #map12(%80)
                %141 = affine.load %arg3[%arg8, %arg9, %140] : memref<?x140x160xf64>
                %142 = affine.load %arg4[%140, %arg10] : memref<?x160xf64>
                %143 = arith.mulf %141, %142 : f64
                %144 = affine.load %arg5[%arg10] : memref<?xf64>
                %145 = arith.addf %144, %143 : f64
                affine.store %145, %arg5[%arg10] : memref<?xf64>
                %146 = affine.apply #map13(%80)
                %147 = affine.load %arg3[%arg8, %arg9, %146] : memref<?x140x160xf64>
                %148 = affine.load %arg4[%146, %arg10] : memref<?x160xf64>
                %149 = arith.mulf %147, %148 : f64
                %150 = affine.load %arg5[%arg10] : memref<?xf64>
                %151 = arith.addf %150, %149 : f64
                affine.store %151, %arg5[%arg10] : memref<?xf64>
                %152 = affine.apply #map14(%80)
                %153 = affine.load %arg3[%arg8, %arg9, %152] : memref<?x140x160xf64>
                %154 = affine.load %arg4[%152, %arg10] : memref<?x160xf64>
                %155 = arith.mulf %153, %154 : f64
                %156 = affine.load %arg5[%arg10] : memref<?xf64>
                %157 = arith.addf %156, %155 : f64
                affine.store %157, %arg5[%arg10] : memref<?xf64>
                %158 = affine.apply #map16(%arg11)
                %159 = affine.load %arg3[%arg8, %arg9, %158] : memref<?x140x160xf64>
                %160 = affine.load %arg4[%158, %arg10] : memref<?x160xf64>
                %161 = arith.mulf %159, %160 : f64
                %162 = affine.load %arg5[%arg10] : memref<?xf64>
                %163 = arith.addf %162, %161 : f64
                affine.store %163, %arg5[%arg10] : memref<?xf64>
                %164 = affine.apply #map3(%158)
                %165 = affine.load %arg3[%arg8, %arg9, %164] : memref<?x140x160xf64>
                %166 = affine.load %arg4[%164, %arg10] : memref<?x160xf64>
                %167 = arith.mulf %165, %166 : f64
                %168 = affine.load %arg5[%arg10] : memref<?xf64>
                %169 = arith.addf %168, %167 : f64
                affine.store %169, %arg5[%arg10] : memref<?xf64>
                %170 = affine.apply #map4(%158)
                %171 = affine.load %arg3[%arg8, %arg9, %170] : memref<?x140x160xf64>
                %172 = affine.load %arg4[%170, %arg10] : memref<?x160xf64>
                %173 = arith.mulf %171, %172 : f64
                %174 = affine.load %arg5[%arg10] : memref<?xf64>
                %175 = arith.addf %174, %173 : f64
                affine.store %175, %arg5[%arg10] : memref<?xf64>
                %176 = affine.apply #map5(%158)
                %177 = affine.load %arg3[%arg8, %arg9, %176] : memref<?x140x160xf64>
                %178 = affine.load %arg4[%176, %arg10] : memref<?x160xf64>
                %179 = arith.mulf %177, %178 : f64
                %180 = affine.load %arg5[%arg10] : memref<?xf64>
                %181 = arith.addf %180, %179 : f64
                affine.store %181, %arg5[%arg10] : memref<?xf64>
                %182 = affine.apply #map6(%158)
                %183 = affine.load %arg3[%arg8, %arg9, %182] : memref<?x140x160xf64>
                %184 = affine.load %arg4[%182, %arg10] : memref<?x160xf64>
                %185 = arith.mulf %183, %184 : f64
                %186 = affine.load %arg5[%arg10] : memref<?xf64>
                %187 = arith.addf %186, %185 : f64
                affine.store %187, %arg5[%arg10] : memref<?xf64>
                %188 = affine.apply #map7(%158)
                %189 = affine.load %arg3[%arg8, %arg9, %188] : memref<?x140x160xf64>
                %190 = affine.load %arg4[%188, %arg10] : memref<?x160xf64>
                %191 = arith.mulf %189, %190 : f64
                %192 = affine.load %arg5[%arg10] : memref<?xf64>
                %193 = arith.addf %192, %191 : f64
                affine.store %193, %arg5[%arg10] : memref<?xf64>
                %194 = affine.apply #map8(%158)
                %195 = affine.load %arg3[%arg8, %arg9, %194] : memref<?x140x160xf64>
                %196 = affine.load %arg4[%194, %arg10] : memref<?x160xf64>
                %197 = arith.mulf %195, %196 : f64
                %198 = affine.load %arg5[%arg10] : memref<?xf64>
                %199 = arith.addf %198, %197 : f64
                affine.store %199, %arg5[%arg10] : memref<?xf64>
                %200 = affine.apply #map9(%158)
                %201 = affine.load %arg3[%arg8, %arg9, %200] : memref<?x140x160xf64>
                %202 = affine.load %arg4[%200, %arg10] : memref<?x160xf64>
                %203 = arith.mulf %201, %202 : f64
                %204 = affine.load %arg5[%arg10] : memref<?xf64>
                %205 = arith.addf %204, %203 : f64
                affine.store %205, %arg5[%arg10] : memref<?xf64>
                %206 = affine.apply #map10(%158)
                %207 = affine.load %arg3[%arg8, %arg9, %206] : memref<?x140x160xf64>
                %208 = affine.load %arg4[%206, %arg10] : memref<?x160xf64>
                %209 = arith.mulf %207, %208 : f64
                %210 = affine.load %arg5[%arg10] : memref<?xf64>
                %211 = arith.addf %210, %209 : f64
                affine.store %211, %arg5[%arg10] : memref<?xf64>
                %212 = affine.apply #map11(%158)
                %213 = affine.load %arg3[%arg8, %arg9, %212] : memref<?x140x160xf64>
                %214 = affine.load %arg4[%212, %arg10] : memref<?x160xf64>
                %215 = arith.mulf %213, %214 : f64
                %216 = affine.load %arg5[%arg10] : memref<?xf64>
                %217 = arith.addf %216, %215 : f64
                affine.store %217, %arg5[%arg10] : memref<?xf64>
                %218 = affine.apply #map12(%158)
                %219 = affine.load %arg3[%arg8, %arg9, %218] : memref<?x140x160xf64>
                %220 = affine.load %arg4[%218, %arg10] : memref<?x160xf64>
                %221 = arith.mulf %219, %220 : f64
                %222 = affine.load %arg5[%arg10] : memref<?xf64>
                %223 = arith.addf %222, %221 : f64
                affine.store %223, %arg5[%arg10] : memref<?xf64>
                %224 = affine.apply #map13(%158)
                %225 = affine.load %arg3[%arg8, %arg9, %224] : memref<?x140x160xf64>
                %226 = affine.load %arg4[%224, %arg10] : memref<?x160xf64>
                %227 = arith.mulf %225, %226 : f64
                %228 = affine.load %arg5[%arg10] : memref<?xf64>
                %229 = arith.addf %228, %227 : f64
                affine.store %229, %arg5[%arg10] : memref<?xf64>
                %230 = affine.apply #map14(%158)
                %231 = affine.load %arg3[%arg8, %arg9, %230] : memref<?x140x160xf64>
                %232 = affine.load %arg4[%230, %arg10] : memref<?x160xf64>
                %233 = arith.mulf %231, %232 : f64
                %234 = affine.load %arg5[%arg10] : memref<?xf64>
                %235 = arith.addf %234, %233 : f64
                affine.store %235, %arg5[%arg10] : memref<?xf64>
                %236 = affine.apply #map17(%arg11)
                %237 = affine.load %arg3[%arg8, %arg9, %236] : memref<?x140x160xf64>
                %238 = affine.load %arg4[%236, %arg10] : memref<?x160xf64>
                %239 = arith.mulf %237, %238 : f64
                %240 = affine.load %arg5[%arg10] : memref<?xf64>
                %241 = arith.addf %240, %239 : f64
                affine.store %241, %arg5[%arg10] : memref<?xf64>
                %242 = affine.apply #map3(%236)
                %243 = affine.load %arg3[%arg8, %arg9, %242] : memref<?x140x160xf64>
                %244 = affine.load %arg4[%242, %arg10] : memref<?x160xf64>
                %245 = arith.mulf %243, %244 : f64
                %246 = affine.load %arg5[%arg10] : memref<?xf64>
                %247 = arith.addf %246, %245 : f64
                affine.store %247, %arg5[%arg10] : memref<?xf64>
                %248 = affine.apply #map4(%236)
                %249 = affine.load %arg3[%arg8, %arg9, %248] : memref<?x140x160xf64>
                %250 = affine.load %arg4[%248, %arg10] : memref<?x160xf64>
                %251 = arith.mulf %249, %250 : f64
                %252 = affine.load %arg5[%arg10] : memref<?xf64>
                %253 = arith.addf %252, %251 : f64
                affine.store %253, %arg5[%arg10] : memref<?xf64>
                %254 = affine.apply #map5(%236)
                %255 = affine.load %arg3[%arg8, %arg9, %254] : memref<?x140x160xf64>
                %256 = affine.load %arg4[%254, %arg10] : memref<?x160xf64>
                %257 = arith.mulf %255, %256 : f64
                %258 = affine.load %arg5[%arg10] : memref<?xf64>
                %259 = arith.addf %258, %257 : f64
                affine.store %259, %arg5[%arg10] : memref<?xf64>
                %260 = affine.apply #map6(%236)
                %261 = affine.load %arg3[%arg8, %arg9, %260] : memref<?x140x160xf64>
                %262 = affine.load %arg4[%260, %arg10] : memref<?x160xf64>
                %263 = arith.mulf %261, %262 : f64
                %264 = affine.load %arg5[%arg10] : memref<?xf64>
                %265 = arith.addf %264, %263 : f64
                affine.store %265, %arg5[%arg10] : memref<?xf64>
                %266 = affine.apply #map7(%236)
                %267 = affine.load %arg3[%arg8, %arg9, %266] : memref<?x140x160xf64>
                %268 = affine.load %arg4[%266, %arg10] : memref<?x160xf64>
                %269 = arith.mulf %267, %268 : f64
                %270 = affine.load %arg5[%arg10] : memref<?xf64>
                %271 = arith.addf %270, %269 : f64
                affine.store %271, %arg5[%arg10] : memref<?xf64>
                %272 = affine.apply #map8(%236)
                %273 = affine.load %arg3[%arg8, %arg9, %272] : memref<?x140x160xf64>
                %274 = affine.load %arg4[%272, %arg10] : memref<?x160xf64>
                %275 = arith.mulf %273, %274 : f64
                %276 = affine.load %arg5[%arg10] : memref<?xf64>
                %277 = arith.addf %276, %275 : f64
                affine.store %277, %arg5[%arg10] : memref<?xf64>
                %278 = affine.apply #map9(%236)
                %279 = affine.load %arg3[%arg8, %arg9, %278] : memref<?x140x160xf64>
                %280 = affine.load %arg4[%278, %arg10] : memref<?x160xf64>
                %281 = arith.mulf %279, %280 : f64
                %282 = affine.load %arg5[%arg10] : memref<?xf64>
                %283 = arith.addf %282, %281 : f64
                affine.store %283, %arg5[%arg10] : memref<?xf64>
                %284 = affine.apply #map10(%236)
                %285 = affine.load %arg3[%arg8, %arg9, %284] : memref<?x140x160xf64>
                %286 = affine.load %arg4[%284, %arg10] : memref<?x160xf64>
                %287 = arith.mulf %285, %286 : f64
                %288 = affine.load %arg5[%arg10] : memref<?xf64>
                %289 = arith.addf %288, %287 : f64
                affine.store %289, %arg5[%arg10] : memref<?xf64>
                %290 = affine.apply #map11(%236)
                %291 = affine.load %arg3[%arg8, %arg9, %290] : memref<?x140x160xf64>
                %292 = affine.load %arg4[%290, %arg10] : memref<?x160xf64>
                %293 = arith.mulf %291, %292 : f64
                %294 = affine.load %arg5[%arg10] : memref<?xf64>
                %295 = arith.addf %294, %293 : f64
                affine.store %295, %arg5[%arg10] : memref<?xf64>
                %296 = affine.apply #map12(%236)
                %297 = affine.load %arg3[%arg8, %arg9, %296] : memref<?x140x160xf64>
                %298 = affine.load %arg4[%296, %arg10] : memref<?x160xf64>
                %299 = arith.mulf %297, %298 : f64
                %300 = affine.load %arg5[%arg10] : memref<?xf64>
                %301 = arith.addf %300, %299 : f64
                affine.store %301, %arg5[%arg10] : memref<?xf64>
                %302 = affine.apply #map13(%236)
                %303 = affine.load %arg3[%arg8, %arg9, %302] : memref<?x140x160xf64>
                %304 = affine.load %arg4[%302, %arg10] : memref<?x160xf64>
                %305 = arith.mulf %303, %304 : f64
                %306 = affine.load %arg5[%arg10] : memref<?xf64>
                %307 = arith.addf %306, %305 : f64
                affine.store %307, %arg5[%arg10] : memref<?xf64>
                %308 = affine.apply #map14(%236)
                %309 = affine.load %arg3[%arg8, %arg9, %308] : memref<?x140x160xf64>
                %310 = affine.load %arg4[%308, %arg10] : memref<?x160xf64>
                %311 = arith.mulf %309, %310 : f64
                %312 = affine.load %arg5[%arg10] : memref<?xf64>
                %313 = arith.addf %312, %311 : f64
                affine.store %313, %arg5[%arg10] : memref<?xf64>
              }
              affine.for %arg11 = #map2()[%1] to #map18()[%1] step 13 {
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
                %38 = affine.apply #map8(%arg11)
                %39 = affine.load %arg3[%arg8, %arg9, %38] : memref<?x140x160xf64>
                %40 = affine.load %arg4[%38, %arg10] : memref<?x160xf64>
                %41 = arith.mulf %39, %40 : f64
                %42 = affine.load %arg5[%arg10] : memref<?xf64>
                %43 = arith.addf %42, %41 : f64
                affine.store %43, %arg5[%arg10] : memref<?xf64>
                %44 = affine.apply #map9(%arg11)
                %45 = affine.load %arg3[%arg8, %arg9, %44] : memref<?x140x160xf64>
                %46 = affine.load %arg4[%44, %arg10] : memref<?x160xf64>
                %47 = arith.mulf %45, %46 : f64
                %48 = affine.load %arg5[%arg10] : memref<?xf64>
                %49 = arith.addf %48, %47 : f64
                affine.store %49, %arg5[%arg10] : memref<?xf64>
                %50 = affine.apply #map10(%arg11)
                %51 = affine.load %arg3[%arg8, %arg9, %50] : memref<?x140x160xf64>
                %52 = affine.load %arg4[%50, %arg10] : memref<?x160xf64>
                %53 = arith.mulf %51, %52 : f64
                %54 = affine.load %arg5[%arg10] : memref<?xf64>
                %55 = arith.addf %54, %53 : f64
                affine.store %55, %arg5[%arg10] : memref<?xf64>
                %56 = affine.apply #map11(%arg11)
                %57 = affine.load %arg3[%arg8, %arg9, %56] : memref<?x140x160xf64>
                %58 = affine.load %arg4[%56, %arg10] : memref<?x160xf64>
                %59 = arith.mulf %57, %58 : f64
                %60 = affine.load %arg5[%arg10] : memref<?xf64>
                %61 = arith.addf %60, %59 : f64
                affine.store %61, %arg5[%arg10] : memref<?xf64>
                %62 = affine.apply #map12(%arg11)
                %63 = affine.load %arg3[%arg8, %arg9, %62] : memref<?x140x160xf64>
                %64 = affine.load %arg4[%62, %arg10] : memref<?x160xf64>
                %65 = arith.mulf %63, %64 : f64
                %66 = affine.load %arg5[%arg10] : memref<?xf64>
                %67 = arith.addf %66, %65 : f64
                affine.store %67, %arg5[%arg10] : memref<?xf64>
                %68 = affine.apply #map13(%arg11)
                %69 = affine.load %arg3[%arg8, %arg9, %68] : memref<?x140x160xf64>
                %70 = affine.load %arg4[%68, %arg10] : memref<?x160xf64>
                %71 = arith.mulf %69, %70 : f64
                %72 = affine.load %arg5[%arg10] : memref<?xf64>
                %73 = arith.addf %72, %71 : f64
                affine.store %73, %arg5[%arg10] : memref<?xf64>
                %74 = affine.apply #map14(%arg11)
                %75 = affine.load %arg3[%arg8, %arg9, %74] : memref<?x140x160xf64>
                %76 = affine.load %arg4[%74, %arg10] : memref<?x160xf64>
                %77 = arith.mulf %75, %76 : f64
                %78 = affine.load %arg5[%arg10] : memref<?xf64>
                %79 = arith.addf %78, %77 : f64
                affine.store %79, %arg5[%arg10] : memref<?xf64>
              }
              affine.for %arg11 = #map18()[%1] to #map19()[%1] step 4 {
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
              }
              affine.for %arg11 = #map19()[%1] to %1 {
                %3 = affine.load %arg3[%arg8, %arg9, %arg11] : memref<?x140x160xf64>
                %4 = affine.load %arg4[%arg11, %arg10] : memref<?x160xf64>
                %5 = arith.mulf %3, %4 : f64
                %6 = affine.load %arg5[%arg10] : memref<?xf64>
                %7 = arith.addf %6, %5 : f64
                affine.store %7, %arg5[%arg10] : memref<?xf64>
              }
            }
            affine.for %arg10 = 0 to #map2()[%1] step 52 {
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
              %14 = affine.apply #map8(%arg10)
              %15 = affine.load %arg5[%14] : memref<?xf64>
              affine.store %15, %arg3[%arg8, %arg9, %14] : memref<?x140x160xf64>
              %16 = affine.apply #map9(%arg10)
              %17 = affine.load %arg5[%16] : memref<?xf64>
              affine.store %17, %arg3[%arg8, %arg9, %16] : memref<?x140x160xf64>
              %18 = affine.apply #map10(%arg10)
              %19 = affine.load %arg5[%18] : memref<?xf64>
              affine.store %19, %arg3[%arg8, %arg9, %18] : memref<?x140x160xf64>
              %20 = affine.apply #map11(%arg10)
              %21 = affine.load %arg5[%20] : memref<?xf64>
              affine.store %21, %arg3[%arg8, %arg9, %20] : memref<?x140x160xf64>
              %22 = affine.apply #map12(%arg10)
              %23 = affine.load %arg5[%22] : memref<?xf64>
              affine.store %23, %arg3[%arg8, %arg9, %22] : memref<?x140x160xf64>
              %24 = affine.apply #map13(%arg10)
              %25 = affine.load %arg5[%24] : memref<?xf64>
              affine.store %25, %arg3[%arg8, %arg9, %24] : memref<?x140x160xf64>
              %26 = affine.apply #map14(%arg10)
              %27 = affine.load %arg5[%26] : memref<?xf64>
              affine.store %27, %arg3[%arg8, %arg9, %26] : memref<?x140x160xf64>
              %28 = affine.apply #map15(%arg10)
              %29 = affine.load %arg5[%28] : memref<?xf64>
              affine.store %29, %arg3[%arg8, %arg9, %28] : memref<?x140x160xf64>
              %30 = affine.apply #map3(%28)
              %31 = affine.load %arg5[%30] : memref<?xf64>
              affine.store %31, %arg3[%arg8, %arg9, %30] : memref<?x140x160xf64>
              %32 = affine.apply #map4(%28)
              %33 = affine.load %arg5[%32] : memref<?xf64>
              affine.store %33, %arg3[%arg8, %arg9, %32] : memref<?x140x160xf64>
              %34 = affine.apply #map5(%28)
              %35 = affine.load %arg5[%34] : memref<?xf64>
              affine.store %35, %arg3[%arg8, %arg9, %34] : memref<?x140x160xf64>
              %36 = affine.apply #map6(%28)
              %37 = affine.load %arg5[%36] : memref<?xf64>
              affine.store %37, %arg3[%arg8, %arg9, %36] : memref<?x140x160xf64>
              %38 = affine.apply #map7(%28)
              %39 = affine.load %arg5[%38] : memref<?xf64>
              affine.store %39, %arg3[%arg8, %arg9, %38] : memref<?x140x160xf64>
              %40 = affine.apply #map8(%28)
              %41 = affine.load %arg5[%40] : memref<?xf64>
              affine.store %41, %arg3[%arg8, %arg9, %40] : memref<?x140x160xf64>
              %42 = affine.apply #map9(%28)
              %43 = affine.load %arg5[%42] : memref<?xf64>
              affine.store %43, %arg3[%arg8, %arg9, %42] : memref<?x140x160xf64>
              %44 = affine.apply #map10(%28)
              %45 = affine.load %arg5[%44] : memref<?xf64>
              affine.store %45, %arg3[%arg8, %arg9, %44] : memref<?x140x160xf64>
              %46 = affine.apply #map11(%28)
              %47 = affine.load %arg5[%46] : memref<?xf64>
              affine.store %47, %arg3[%arg8, %arg9, %46] : memref<?x140x160xf64>
              %48 = affine.apply #map12(%28)
              %49 = affine.load %arg5[%48] : memref<?xf64>
              affine.store %49, %arg3[%arg8, %arg9, %48] : memref<?x140x160xf64>
              %50 = affine.apply #map13(%28)
              %51 = affine.load %arg5[%50] : memref<?xf64>
              affine.store %51, %arg3[%arg8, %arg9, %50] : memref<?x140x160xf64>
              %52 = affine.apply #map14(%28)
              %53 = affine.load %arg5[%52] : memref<?xf64>
              affine.store %53, %arg3[%arg8, %arg9, %52] : memref<?x140x160xf64>
              %54 = affine.apply #map16(%arg10)
              %55 = affine.load %arg5[%54] : memref<?xf64>
              affine.store %55, %arg3[%arg8, %arg9, %54] : memref<?x140x160xf64>
              %56 = affine.apply #map3(%54)
              %57 = affine.load %arg5[%56] : memref<?xf64>
              affine.store %57, %arg3[%arg8, %arg9, %56] : memref<?x140x160xf64>
              %58 = affine.apply #map4(%54)
              %59 = affine.load %arg5[%58] : memref<?xf64>
              affine.store %59, %arg3[%arg8, %arg9, %58] : memref<?x140x160xf64>
              %60 = affine.apply #map5(%54)
              %61 = affine.load %arg5[%60] : memref<?xf64>
              affine.store %61, %arg3[%arg8, %arg9, %60] : memref<?x140x160xf64>
              %62 = affine.apply #map6(%54)
              %63 = affine.load %arg5[%62] : memref<?xf64>
              affine.store %63, %arg3[%arg8, %arg9, %62] : memref<?x140x160xf64>
              %64 = affine.apply #map7(%54)
              %65 = affine.load %arg5[%64] : memref<?xf64>
              affine.store %65, %arg3[%arg8, %arg9, %64] : memref<?x140x160xf64>
              %66 = affine.apply #map8(%54)
              %67 = affine.load %arg5[%66] : memref<?xf64>
              affine.store %67, %arg3[%arg8, %arg9, %66] : memref<?x140x160xf64>
              %68 = affine.apply #map9(%54)
              %69 = affine.load %arg5[%68] : memref<?xf64>
              affine.store %69, %arg3[%arg8, %arg9, %68] : memref<?x140x160xf64>
              %70 = affine.apply #map10(%54)
              %71 = affine.load %arg5[%70] : memref<?xf64>
              affine.store %71, %arg3[%arg8, %arg9, %70] : memref<?x140x160xf64>
              %72 = affine.apply #map11(%54)
              %73 = affine.load %arg5[%72] : memref<?xf64>
              affine.store %73, %arg3[%arg8, %arg9, %72] : memref<?x140x160xf64>
              %74 = affine.apply #map12(%54)
              %75 = affine.load %arg5[%74] : memref<?xf64>
              affine.store %75, %arg3[%arg8, %arg9, %74] : memref<?x140x160xf64>
              %76 = affine.apply #map13(%54)
              %77 = affine.load %arg5[%76] : memref<?xf64>
              affine.store %77, %arg3[%arg8, %arg9, %76] : memref<?x140x160xf64>
              %78 = affine.apply #map14(%54)
              %79 = affine.load %arg5[%78] : memref<?xf64>
              affine.store %79, %arg3[%arg8, %arg9, %78] : memref<?x140x160xf64>
              %80 = affine.apply #map17(%arg10)
              %81 = affine.load %arg5[%80] : memref<?xf64>
              affine.store %81, %arg3[%arg8, %arg9, %80] : memref<?x140x160xf64>
              %82 = affine.apply #map3(%80)
              %83 = affine.load %arg5[%82] : memref<?xf64>
              affine.store %83, %arg3[%arg8, %arg9, %82] : memref<?x140x160xf64>
              %84 = affine.apply #map4(%80)
              %85 = affine.load %arg5[%84] : memref<?xf64>
              affine.store %85, %arg3[%arg8, %arg9, %84] : memref<?x140x160xf64>
              %86 = affine.apply #map5(%80)
              %87 = affine.load %arg5[%86] : memref<?xf64>
              affine.store %87, %arg3[%arg8, %arg9, %86] : memref<?x140x160xf64>
              %88 = affine.apply #map6(%80)
              %89 = affine.load %arg5[%88] : memref<?xf64>
              affine.store %89, %arg3[%arg8, %arg9, %88] : memref<?x140x160xf64>
              %90 = affine.apply #map7(%80)
              %91 = affine.load %arg5[%90] : memref<?xf64>
              affine.store %91, %arg3[%arg8, %arg9, %90] : memref<?x140x160xf64>
              %92 = affine.apply #map8(%80)
              %93 = affine.load %arg5[%92] : memref<?xf64>
              affine.store %93, %arg3[%arg8, %arg9, %92] : memref<?x140x160xf64>
              %94 = affine.apply #map9(%80)
              %95 = affine.load %arg5[%94] : memref<?xf64>
              affine.store %95, %arg3[%arg8, %arg9, %94] : memref<?x140x160xf64>
              %96 = affine.apply #map10(%80)
              %97 = affine.load %arg5[%96] : memref<?xf64>
              affine.store %97, %arg3[%arg8, %arg9, %96] : memref<?x140x160xf64>
              %98 = affine.apply #map11(%80)
              %99 = affine.load %arg5[%98] : memref<?xf64>
              affine.store %99, %arg3[%arg8, %arg9, %98] : memref<?x140x160xf64>
              %100 = affine.apply #map12(%80)
              %101 = affine.load %arg5[%100] : memref<?xf64>
              affine.store %101, %arg3[%arg8, %arg9, %100] : memref<?x140x160xf64>
              %102 = affine.apply #map13(%80)
              %103 = affine.load %arg5[%102] : memref<?xf64>
              affine.store %103, %arg3[%arg8, %arg9, %102] : memref<?x140x160xf64>
              %104 = affine.apply #map14(%80)
              %105 = affine.load %arg5[%104] : memref<?xf64>
              affine.store %105, %arg3[%arg8, %arg9, %104] : memref<?x140x160xf64>
            }
            affine.for %arg10 = #map2()[%1] to #map18()[%1] step 13 {
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
              %14 = affine.apply #map8(%arg10)
              %15 = affine.load %arg5[%14] : memref<?xf64>
              affine.store %15, %arg3[%arg8, %arg9, %14] : memref<?x140x160xf64>
              %16 = affine.apply #map9(%arg10)
              %17 = affine.load %arg5[%16] : memref<?xf64>
              affine.store %17, %arg3[%arg8, %arg9, %16] : memref<?x140x160xf64>
              %18 = affine.apply #map10(%arg10)
              %19 = affine.load %arg5[%18] : memref<?xf64>
              affine.store %19, %arg3[%arg8, %arg9, %18] : memref<?x140x160xf64>
              %20 = affine.apply #map11(%arg10)
              %21 = affine.load %arg5[%20] : memref<?xf64>
              affine.store %21, %arg3[%arg8, %arg9, %20] : memref<?x140x160xf64>
              %22 = affine.apply #map12(%arg10)
              %23 = affine.load %arg5[%22] : memref<?xf64>
              affine.store %23, %arg3[%arg8, %arg9, %22] : memref<?x140x160xf64>
              %24 = affine.apply #map13(%arg10)
              %25 = affine.load %arg5[%24] : memref<?xf64>
              affine.store %25, %arg3[%arg8, %arg9, %24] : memref<?x140x160xf64>
              %26 = affine.apply #map14(%arg10)
              %27 = affine.load %arg5[%26] : memref<?xf64>
              affine.store %27, %arg3[%arg8, %arg9, %26] : memref<?x140x160xf64>
            }
            affine.for %arg10 = #map18()[%1] to #map19()[%1] step 4 {
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
            }
            affine.for %arg10 = #map19()[%1] to %1 {
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

