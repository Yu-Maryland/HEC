#map = affine_map<()[s0] -> (((s0 floordiv 5) floordiv 15) * 75)>
#map1 = affine_map<(d0) -> (d0 + 1)>
#map2 = affine_map<(d0) -> (d0 + 2)>
#map3 = affine_map<(d0) -> (d0 + 3)>
#map4 = affine_map<(d0) -> (d0 + 4)>
#map5 = affine_map<(d0) -> (d0 + 5)>
#map6 = affine_map<(d0) -> (d0 + 10)>
#map7 = affine_map<(d0) -> (d0 + 15)>
#map8 = affine_map<(d0) -> (d0 + 20)>
#map9 = affine_map<(d0) -> (d0 + 25)>
#map10 = affine_map<(d0) -> (d0 + 30)>
#map11 = affine_map<(d0) -> (d0 + 35)>
#map12 = affine_map<(d0) -> (d0 + 40)>
#map13 = affine_map<(d0) -> (d0 + 45)>
#map14 = affine_map<(d0) -> (d0 + 50)>
#map15 = affine_map<(d0) -> (d0 + 55)>
#map16 = affine_map<(d0) -> (d0 + 60)>
#map17 = affine_map<(d0) -> (d0 + 65)>
#map18 = affine_map<(d0) -> (d0 + 70)>
#map19 = affine_map<()[s0] -> ((s0 floordiv 5) * 5)>
#map20 = affine_map<()[s0] -> ((s0 floordiv 5) * 5 + ((s0 mod 5) floordiv 15) * 15)>
#map21 = affine_map<(d0) -> (d0 + 6)>
#map22 = affine_map<(d0) -> (d0 + 7)>
#map23 = affine_map<(d0) -> (d0 + 8)>
#map24 = affine_map<(d0) -> (d0 + 9)>
#map25 = affine_map<(d0) -> (d0 + 11)>
#map26 = affine_map<(d0) -> (d0 + 12)>
#map27 = affine_map<(d0) -> (d0 + 13)>
#map28 = affine_map<(d0) -> (d0 + 14)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>, #dlti.dl_entry<"dlti.endianness", "little">>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_doitgen(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: memref<?x140x160xf64>, %arg4: memref<?x160xf64>, %arg5: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant 0.000000e+00 : f64
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg2 : i32 to index
    %2 = arith.index_cast %arg0 : i32 to index
    affine.for %arg6 = 0 to %2 {
      affine.for %arg7 = 0 to %0 {
        affine.for %arg8 = 0 to %1 {
          affine.store %cst, %arg5[%arg8] : memref<?xf64>
          affine.for %arg9 = 0 to #map()[%1] step 75 {
            %3 = affine.load %arg3[%arg6, %arg7, %arg9] : memref<?x140x160xf64>
            %4 = affine.load %arg4[%arg9, %arg8] : memref<?x160xf64>
            %5 = arith.mulf %3, %4 : f64
            %6 = affine.load %arg5[%arg8] : memref<?xf64>
            %7 = arith.addf %6, %5 : f64
            affine.store %7, %arg5[%arg8] : memref<?xf64>
            %8 = affine.apply #map1(%arg9)
            %9 = affine.load %arg3[%arg6, %arg7, %8] : memref<?x140x160xf64>
            %10 = affine.load %arg4[%8, %arg8] : memref<?x160xf64>
            %11 = arith.mulf %9, %10 : f64
            %12 = affine.load %arg5[%arg8] : memref<?xf64>
            %13 = arith.addf %12, %11 : f64
            affine.store %13, %arg5[%arg8] : memref<?xf64>
            %14 = affine.apply #map2(%arg9)
            %15 = affine.load %arg3[%arg6, %arg7, %14] : memref<?x140x160xf64>
            %16 = affine.load %arg4[%14, %arg8] : memref<?x160xf64>
            %17 = arith.mulf %15, %16 : f64
            %18 = affine.load %arg5[%arg8] : memref<?xf64>
            %19 = arith.addf %18, %17 : f64
            affine.store %19, %arg5[%arg8] : memref<?xf64>
            %20 = affine.apply #map3(%arg9)
            %21 = affine.load %arg3[%arg6, %arg7, %20] : memref<?x140x160xf64>
            %22 = affine.load %arg4[%20, %arg8] : memref<?x160xf64>
            %23 = arith.mulf %21, %22 : f64
            %24 = affine.load %arg5[%arg8] : memref<?xf64>
            %25 = arith.addf %24, %23 : f64
            affine.store %25, %arg5[%arg8] : memref<?xf64>
            %26 = affine.apply #map4(%arg9)
            %27 = affine.load %arg3[%arg6, %arg7, %26] : memref<?x140x160xf64>
            %28 = affine.load %arg4[%26, %arg8] : memref<?x160xf64>
            %29 = arith.mulf %27, %28 : f64
            %30 = affine.load %arg5[%arg8] : memref<?xf64>
            %31 = arith.addf %30, %29 : f64
            affine.store %31, %arg5[%arg8] : memref<?xf64>
            %32 = affine.apply #map5(%arg9)
            %33 = affine.load %arg3[%arg6, %arg7, %32] : memref<?x140x160xf64>
            %34 = affine.load %arg4[%32, %arg8] : memref<?x160xf64>
            %35 = arith.mulf %33, %34 : f64
            %36 = affine.load %arg5[%arg8] : memref<?xf64>
            %37 = arith.addf %36, %35 : f64
            affine.store %37, %arg5[%arg8] : memref<?xf64>
            %38 = affine.apply #map1(%32)
            %39 = affine.load %arg3[%arg6, %arg7, %38] : memref<?x140x160xf64>
            %40 = affine.load %arg4[%38, %arg8] : memref<?x160xf64>
            %41 = arith.mulf %39, %40 : f64
            %42 = affine.load %arg5[%arg8] : memref<?xf64>
            %43 = arith.addf %42, %41 : f64
            affine.store %43, %arg5[%arg8] : memref<?xf64>
            %44 = affine.apply #map2(%32)
            %45 = affine.load %arg3[%arg6, %arg7, %44] : memref<?x140x160xf64>
            %46 = affine.load %arg4[%44, %arg8] : memref<?x160xf64>
            %47 = arith.mulf %45, %46 : f64
            %48 = affine.load %arg5[%arg8] : memref<?xf64>
            %49 = arith.addf %48, %47 : f64
            affine.store %49, %arg5[%arg8] : memref<?xf64>
            %50 = affine.apply #map3(%32)
            %51 = affine.load %arg3[%arg6, %arg7, %50] : memref<?x140x160xf64>
            %52 = affine.load %arg4[%50, %arg8] : memref<?x160xf64>
            %53 = arith.mulf %51, %52 : f64
            %54 = affine.load %arg5[%arg8] : memref<?xf64>
            %55 = arith.addf %54, %53 : f64
            affine.store %55, %arg5[%arg8] : memref<?xf64>
            %56 = affine.apply #map4(%32)
            %57 = affine.load %arg3[%arg6, %arg7, %56] : memref<?x140x160xf64>
            %58 = affine.load %arg4[%56, %arg8] : memref<?x160xf64>
            %59 = arith.mulf %57, %58 : f64
            %60 = affine.load %arg5[%arg8] : memref<?xf64>
            %61 = arith.addf %60, %59 : f64
            affine.store %61, %arg5[%arg8] : memref<?xf64>
            %62 = affine.apply #map6(%arg9)
            %63 = affine.load %arg3[%arg6, %arg7, %62] : memref<?x140x160xf64>
            %64 = affine.load %arg4[%62, %arg8] : memref<?x160xf64>
            %65 = arith.mulf %63, %64 : f64
            %66 = affine.load %arg5[%arg8] : memref<?xf64>
            %67 = arith.addf %66, %65 : f64
            affine.store %67, %arg5[%arg8] : memref<?xf64>
            %68 = affine.apply #map1(%62)
            %69 = affine.load %arg3[%arg6, %arg7, %68] : memref<?x140x160xf64>
            %70 = affine.load %arg4[%68, %arg8] : memref<?x160xf64>
            %71 = arith.mulf %69, %70 : f64
            %72 = affine.load %arg5[%arg8] : memref<?xf64>
            %73 = arith.addf %72, %71 : f64
            affine.store %73, %arg5[%arg8] : memref<?xf64>
            %74 = affine.apply #map2(%62)
            %75 = affine.load %arg3[%arg6, %arg7, %74] : memref<?x140x160xf64>
            %76 = affine.load %arg4[%74, %arg8] : memref<?x160xf64>
            %77 = arith.mulf %75, %76 : f64
            %78 = affine.load %arg5[%arg8] : memref<?xf64>
            %79 = arith.addf %78, %77 : f64
            affine.store %79, %arg5[%arg8] : memref<?xf64>
            %80 = affine.apply #map3(%62)
            %81 = affine.load %arg3[%arg6, %arg7, %80] : memref<?x140x160xf64>
            %82 = affine.load %arg4[%80, %arg8] : memref<?x160xf64>
            %83 = arith.mulf %81, %82 : f64
            %84 = affine.load %arg5[%arg8] : memref<?xf64>
            %85 = arith.addf %84, %83 : f64
            affine.store %85, %arg5[%arg8] : memref<?xf64>
            %86 = affine.apply #map4(%62)
            %87 = affine.load %arg3[%arg6, %arg7, %86] : memref<?x140x160xf64>
            %88 = affine.load %arg4[%86, %arg8] : memref<?x160xf64>
            %89 = arith.mulf %87, %88 : f64
            %90 = affine.load %arg5[%arg8] : memref<?xf64>
            %91 = arith.addf %90, %89 : f64
            affine.store %91, %arg5[%arg8] : memref<?xf64>
            %92 = affine.apply #map7(%arg9)
            %93 = affine.load %arg3[%arg6, %arg7, %92] : memref<?x140x160xf64>
            %94 = affine.load %arg4[%92, %arg8] : memref<?x160xf64>
            %95 = arith.mulf %93, %94 : f64
            %96 = affine.load %arg5[%arg8] : memref<?xf64>
            %97 = arith.addf %96, %95 : f64
            affine.store %97, %arg5[%arg8] : memref<?xf64>
            %98 = affine.apply #map1(%92)
            %99 = affine.load %arg3[%arg6, %arg7, %98] : memref<?x140x160xf64>
            %100 = affine.load %arg4[%98, %arg8] : memref<?x160xf64>
            %101 = arith.mulf %99, %100 : f64
            %102 = affine.load %arg5[%arg8] : memref<?xf64>
            %103 = arith.addf %102, %101 : f64
            affine.store %103, %arg5[%arg8] : memref<?xf64>
            %104 = affine.apply #map2(%92)
            %105 = affine.load %arg3[%arg6, %arg7, %104] : memref<?x140x160xf64>
            %106 = affine.load %arg4[%104, %arg8] : memref<?x160xf64>
            %107 = arith.mulf %105, %106 : f64
            %108 = affine.load %arg5[%arg8] : memref<?xf64>
            %109 = arith.addf %108, %107 : f64
            affine.store %109, %arg5[%arg8] : memref<?xf64>
            %110 = affine.apply #map3(%92)
            %111 = affine.load %arg3[%arg6, %arg7, %110] : memref<?x140x160xf64>
            %112 = affine.load %arg4[%110, %arg8] : memref<?x160xf64>
            %113 = arith.mulf %111, %112 : f64
            %114 = affine.load %arg5[%arg8] : memref<?xf64>
            %115 = arith.addf %114, %113 : f64
            affine.store %115, %arg5[%arg8] : memref<?xf64>
            %116 = affine.apply #map4(%92)
            %117 = affine.load %arg3[%arg6, %arg7, %116] : memref<?x140x160xf64>
            %118 = affine.load %arg4[%116, %arg8] : memref<?x160xf64>
            %119 = arith.mulf %117, %118 : f64
            %120 = affine.load %arg5[%arg8] : memref<?xf64>
            %121 = arith.addf %120, %119 : f64
            affine.store %121, %arg5[%arg8] : memref<?xf64>
            %122 = affine.apply #map8(%arg9)
            %123 = affine.load %arg3[%arg6, %arg7, %122] : memref<?x140x160xf64>
            %124 = affine.load %arg4[%122, %arg8] : memref<?x160xf64>
            %125 = arith.mulf %123, %124 : f64
            %126 = affine.load %arg5[%arg8] : memref<?xf64>
            %127 = arith.addf %126, %125 : f64
            affine.store %127, %arg5[%arg8] : memref<?xf64>
            %128 = affine.apply #map1(%122)
            %129 = affine.load %arg3[%arg6, %arg7, %128] : memref<?x140x160xf64>
            %130 = affine.load %arg4[%128, %arg8] : memref<?x160xf64>
            %131 = arith.mulf %129, %130 : f64
            %132 = affine.load %arg5[%arg8] : memref<?xf64>
            %133 = arith.addf %132, %131 : f64
            affine.store %133, %arg5[%arg8] : memref<?xf64>
            %134 = affine.apply #map2(%122)
            %135 = affine.load %arg3[%arg6, %arg7, %134] : memref<?x140x160xf64>
            %136 = affine.load %arg4[%134, %arg8] : memref<?x160xf64>
            %137 = arith.mulf %135, %136 : f64
            %138 = affine.load %arg5[%arg8] : memref<?xf64>
            %139 = arith.addf %138, %137 : f64
            affine.store %139, %arg5[%arg8] : memref<?xf64>
            %140 = affine.apply #map3(%122)
            %141 = affine.load %arg3[%arg6, %arg7, %140] : memref<?x140x160xf64>
            %142 = affine.load %arg4[%140, %arg8] : memref<?x160xf64>
            %143 = arith.mulf %141, %142 : f64
            %144 = affine.load %arg5[%arg8] : memref<?xf64>
            %145 = arith.addf %144, %143 : f64
            affine.store %145, %arg5[%arg8] : memref<?xf64>
            %146 = affine.apply #map4(%122)
            %147 = affine.load %arg3[%arg6, %arg7, %146] : memref<?x140x160xf64>
            %148 = affine.load %arg4[%146, %arg8] : memref<?x160xf64>
            %149 = arith.mulf %147, %148 : f64
            %150 = affine.load %arg5[%arg8] : memref<?xf64>
            %151 = arith.addf %150, %149 : f64
            affine.store %151, %arg5[%arg8] : memref<?xf64>
            %152 = affine.apply #map9(%arg9)
            %153 = affine.load %arg3[%arg6, %arg7, %152] : memref<?x140x160xf64>
            %154 = affine.load %arg4[%152, %arg8] : memref<?x160xf64>
            %155 = arith.mulf %153, %154 : f64
            %156 = affine.load %arg5[%arg8] : memref<?xf64>
            %157 = arith.addf %156, %155 : f64
            affine.store %157, %arg5[%arg8] : memref<?xf64>
            %158 = affine.apply #map1(%152)
            %159 = affine.load %arg3[%arg6, %arg7, %158] : memref<?x140x160xf64>
            %160 = affine.load %arg4[%158, %arg8] : memref<?x160xf64>
            %161 = arith.mulf %159, %160 : f64
            %162 = affine.load %arg5[%arg8] : memref<?xf64>
            %163 = arith.addf %162, %161 : f64
            affine.store %163, %arg5[%arg8] : memref<?xf64>
            %164 = affine.apply #map2(%152)
            %165 = affine.load %arg3[%arg6, %arg7, %164] : memref<?x140x160xf64>
            %166 = affine.load %arg4[%164, %arg8] : memref<?x160xf64>
            %167 = arith.mulf %165, %166 : f64
            %168 = affine.load %arg5[%arg8] : memref<?xf64>
            %169 = arith.addf %168, %167 : f64
            affine.store %169, %arg5[%arg8] : memref<?xf64>
            %170 = affine.apply #map3(%152)
            %171 = affine.load %arg3[%arg6, %arg7, %170] : memref<?x140x160xf64>
            %172 = affine.load %arg4[%170, %arg8] : memref<?x160xf64>
            %173 = arith.mulf %171, %172 : f64
            %174 = affine.load %arg5[%arg8] : memref<?xf64>
            %175 = arith.addf %174, %173 : f64
            affine.store %175, %arg5[%arg8] : memref<?xf64>
            %176 = affine.apply #map4(%152)
            %177 = affine.load %arg3[%arg6, %arg7, %176] : memref<?x140x160xf64>
            %178 = affine.load %arg4[%176, %arg8] : memref<?x160xf64>
            %179 = arith.mulf %177, %178 : f64
            %180 = affine.load %arg5[%arg8] : memref<?xf64>
            %181 = arith.addf %180, %179 : f64
            affine.store %181, %arg5[%arg8] : memref<?xf64>
            %182 = affine.apply #map10(%arg9)
            %183 = affine.load %arg3[%arg6, %arg7, %182] : memref<?x140x160xf64>
            %184 = affine.load %arg4[%182, %arg8] : memref<?x160xf64>
            %185 = arith.mulf %183, %184 : f64
            %186 = affine.load %arg5[%arg8] : memref<?xf64>
            %187 = arith.addf %186, %185 : f64
            affine.store %187, %arg5[%arg8] : memref<?xf64>
            %188 = affine.apply #map1(%182)
            %189 = affine.load %arg3[%arg6, %arg7, %188] : memref<?x140x160xf64>
            %190 = affine.load %arg4[%188, %arg8] : memref<?x160xf64>
            %191 = arith.mulf %189, %190 : f64
            %192 = affine.load %arg5[%arg8] : memref<?xf64>
            %193 = arith.addf %192, %191 : f64
            affine.store %193, %arg5[%arg8] : memref<?xf64>
            %194 = affine.apply #map2(%182)
            %195 = affine.load %arg3[%arg6, %arg7, %194] : memref<?x140x160xf64>
            %196 = affine.load %arg4[%194, %arg8] : memref<?x160xf64>
            %197 = arith.mulf %195, %196 : f64
            %198 = affine.load %arg5[%arg8] : memref<?xf64>
            %199 = arith.addf %198, %197 : f64
            affine.store %199, %arg5[%arg8] : memref<?xf64>
            %200 = affine.apply #map3(%182)
            %201 = affine.load %arg3[%arg6, %arg7, %200] : memref<?x140x160xf64>
            %202 = affine.load %arg4[%200, %arg8] : memref<?x160xf64>
            %203 = arith.mulf %201, %202 : f64
            %204 = affine.load %arg5[%arg8] : memref<?xf64>
            %205 = arith.addf %204, %203 : f64
            affine.store %205, %arg5[%arg8] : memref<?xf64>
            %206 = affine.apply #map4(%182)
            %207 = affine.load %arg3[%arg6, %arg7, %206] : memref<?x140x160xf64>
            %208 = affine.load %arg4[%206, %arg8] : memref<?x160xf64>
            %209 = arith.mulf %207, %208 : f64
            %210 = affine.load %arg5[%arg8] : memref<?xf64>
            %211 = arith.addf %210, %209 : f64
            affine.store %211, %arg5[%arg8] : memref<?xf64>
            %212 = affine.apply #map11(%arg9)
            %213 = affine.load %arg3[%arg6, %arg7, %212] : memref<?x140x160xf64>
            %214 = affine.load %arg4[%212, %arg8] : memref<?x160xf64>
            %215 = arith.mulf %213, %214 : f64
            %216 = affine.load %arg5[%arg8] : memref<?xf64>
            %217 = arith.addf %216, %215 : f64
            affine.store %217, %arg5[%arg8] : memref<?xf64>
            %218 = affine.apply #map1(%212)
            %219 = affine.load %arg3[%arg6, %arg7, %218] : memref<?x140x160xf64>
            %220 = affine.load %arg4[%218, %arg8] : memref<?x160xf64>
            %221 = arith.mulf %219, %220 : f64
            %222 = affine.load %arg5[%arg8] : memref<?xf64>
            %223 = arith.addf %222, %221 : f64
            affine.store %223, %arg5[%arg8] : memref<?xf64>
            %224 = affine.apply #map2(%212)
            %225 = affine.load %arg3[%arg6, %arg7, %224] : memref<?x140x160xf64>
            %226 = affine.load %arg4[%224, %arg8] : memref<?x160xf64>
            %227 = arith.mulf %225, %226 : f64
            %228 = affine.load %arg5[%arg8] : memref<?xf64>
            %229 = arith.addf %228, %227 : f64
            affine.store %229, %arg5[%arg8] : memref<?xf64>
            %230 = affine.apply #map3(%212)
            %231 = affine.load %arg3[%arg6, %arg7, %230] : memref<?x140x160xf64>
            %232 = affine.load %arg4[%230, %arg8] : memref<?x160xf64>
            %233 = arith.mulf %231, %232 : f64
            %234 = affine.load %arg5[%arg8] : memref<?xf64>
            %235 = arith.addf %234, %233 : f64
            affine.store %235, %arg5[%arg8] : memref<?xf64>
            %236 = affine.apply #map4(%212)
            %237 = affine.load %arg3[%arg6, %arg7, %236] : memref<?x140x160xf64>
            %238 = affine.load %arg4[%236, %arg8] : memref<?x160xf64>
            %239 = arith.mulf %237, %238 : f64
            %240 = affine.load %arg5[%arg8] : memref<?xf64>
            %241 = arith.addf %240, %239 : f64
            affine.store %241, %arg5[%arg8] : memref<?xf64>
            %242 = affine.apply #map12(%arg9)
            %243 = affine.load %arg3[%arg6, %arg7, %242] : memref<?x140x160xf64>
            %244 = affine.load %arg4[%242, %arg8] : memref<?x160xf64>
            %245 = arith.mulf %243, %244 : f64
            %246 = affine.load %arg5[%arg8] : memref<?xf64>
            %247 = arith.addf %246, %245 : f64
            affine.store %247, %arg5[%arg8] : memref<?xf64>
            %248 = affine.apply #map1(%242)
            %249 = affine.load %arg3[%arg6, %arg7, %248] : memref<?x140x160xf64>
            %250 = affine.load %arg4[%248, %arg8] : memref<?x160xf64>
            %251 = arith.mulf %249, %250 : f64
            %252 = affine.load %arg5[%arg8] : memref<?xf64>
            %253 = arith.addf %252, %251 : f64
            affine.store %253, %arg5[%arg8] : memref<?xf64>
            %254 = affine.apply #map2(%242)
            %255 = affine.load %arg3[%arg6, %arg7, %254] : memref<?x140x160xf64>
            %256 = affine.load %arg4[%254, %arg8] : memref<?x160xf64>
            %257 = arith.mulf %255, %256 : f64
            %258 = affine.load %arg5[%arg8] : memref<?xf64>
            %259 = arith.addf %258, %257 : f64
            affine.store %259, %arg5[%arg8] : memref<?xf64>
            %260 = affine.apply #map3(%242)
            %261 = affine.load %arg3[%arg6, %arg7, %260] : memref<?x140x160xf64>
            %262 = affine.load %arg4[%260, %arg8] : memref<?x160xf64>
            %263 = arith.mulf %261, %262 : f64
            %264 = affine.load %arg5[%arg8] : memref<?xf64>
            %265 = arith.addf %264, %263 : f64
            affine.store %265, %arg5[%arg8] : memref<?xf64>
            %266 = affine.apply #map4(%242)
            %267 = affine.load %arg3[%arg6, %arg7, %266] : memref<?x140x160xf64>
            %268 = affine.load %arg4[%266, %arg8] : memref<?x160xf64>
            %269 = arith.mulf %267, %268 : f64
            %270 = affine.load %arg5[%arg8] : memref<?xf64>
            %271 = arith.addf %270, %269 : f64
            affine.store %271, %arg5[%arg8] : memref<?xf64>
            %272 = affine.apply #map13(%arg9)
            %273 = affine.load %arg3[%arg6, %arg7, %272] : memref<?x140x160xf64>
            %274 = affine.load %arg4[%272, %arg8] : memref<?x160xf64>
            %275 = arith.mulf %273, %274 : f64
            %276 = affine.load %arg5[%arg8] : memref<?xf64>
            %277 = arith.addf %276, %275 : f64
            affine.store %277, %arg5[%arg8] : memref<?xf64>
            %278 = affine.apply #map1(%272)
            %279 = affine.load %arg3[%arg6, %arg7, %278] : memref<?x140x160xf64>
            %280 = affine.load %arg4[%278, %arg8] : memref<?x160xf64>
            %281 = arith.mulf %279, %280 : f64
            %282 = affine.load %arg5[%arg8] : memref<?xf64>
            %283 = arith.addf %282, %281 : f64
            affine.store %283, %arg5[%arg8] : memref<?xf64>
            %284 = affine.apply #map2(%272)
            %285 = affine.load %arg3[%arg6, %arg7, %284] : memref<?x140x160xf64>
            %286 = affine.load %arg4[%284, %arg8] : memref<?x160xf64>
            %287 = arith.mulf %285, %286 : f64
            %288 = affine.load %arg5[%arg8] : memref<?xf64>
            %289 = arith.addf %288, %287 : f64
            affine.store %289, %arg5[%arg8] : memref<?xf64>
            %290 = affine.apply #map3(%272)
            %291 = affine.load %arg3[%arg6, %arg7, %290] : memref<?x140x160xf64>
            %292 = affine.load %arg4[%290, %arg8] : memref<?x160xf64>
            %293 = arith.mulf %291, %292 : f64
            %294 = affine.load %arg5[%arg8] : memref<?xf64>
            %295 = arith.addf %294, %293 : f64
            affine.store %295, %arg5[%arg8] : memref<?xf64>
            %296 = affine.apply #map4(%272)
            %297 = affine.load %arg3[%arg6, %arg7, %296] : memref<?x140x160xf64>
            %298 = affine.load %arg4[%296, %arg8] : memref<?x160xf64>
            %299 = arith.mulf %297, %298 : f64
            %300 = affine.load %arg5[%arg8] : memref<?xf64>
            %301 = arith.addf %300, %299 : f64
            affine.store %301, %arg5[%arg8] : memref<?xf64>
            %302 = affine.apply #map14(%arg9)
            %303 = affine.load %arg3[%arg6, %arg7, %302] : memref<?x140x160xf64>
            %304 = affine.load %arg4[%302, %arg8] : memref<?x160xf64>
            %305 = arith.mulf %303, %304 : f64
            %306 = affine.load %arg5[%arg8] : memref<?xf64>
            %307 = arith.addf %306, %305 : f64
            affine.store %307, %arg5[%arg8] : memref<?xf64>
            %308 = affine.apply #map1(%302)
            %309 = affine.load %arg3[%arg6, %arg7, %308] : memref<?x140x160xf64>
            %310 = affine.load %arg4[%308, %arg8] : memref<?x160xf64>
            %311 = arith.mulf %309, %310 : f64
            %312 = affine.load %arg5[%arg8] : memref<?xf64>
            %313 = arith.addf %312, %311 : f64
            affine.store %313, %arg5[%arg8] : memref<?xf64>
            %314 = affine.apply #map2(%302)
            %315 = affine.load %arg3[%arg6, %arg7, %314] : memref<?x140x160xf64>
            %316 = affine.load %arg4[%314, %arg8] : memref<?x160xf64>
            %317 = arith.mulf %315, %316 : f64
            %318 = affine.load %arg5[%arg8] : memref<?xf64>
            %319 = arith.addf %318, %317 : f64
            affine.store %319, %arg5[%arg8] : memref<?xf64>
            %320 = affine.apply #map3(%302)
            %321 = affine.load %arg3[%arg6, %arg7, %320] : memref<?x140x160xf64>
            %322 = affine.load %arg4[%320, %arg8] : memref<?x160xf64>
            %323 = arith.mulf %321, %322 : f64
            %324 = affine.load %arg5[%arg8] : memref<?xf64>
            %325 = arith.addf %324, %323 : f64
            affine.store %325, %arg5[%arg8] : memref<?xf64>
            %326 = affine.apply #map4(%302)
            %327 = affine.load %arg3[%arg6, %arg7, %326] : memref<?x140x160xf64>
            %328 = affine.load %arg4[%326, %arg8] : memref<?x160xf64>
            %329 = arith.mulf %327, %328 : f64
            %330 = affine.load %arg5[%arg8] : memref<?xf64>
            %331 = arith.addf %330, %329 : f64
            affine.store %331, %arg5[%arg8] : memref<?xf64>
            %332 = affine.apply #map15(%arg9)
            %333 = affine.load %arg3[%arg6, %arg7, %332] : memref<?x140x160xf64>
            %334 = affine.load %arg4[%332, %arg8] : memref<?x160xf64>
            %335 = arith.mulf %333, %334 : f64
            %336 = affine.load %arg5[%arg8] : memref<?xf64>
            %337 = arith.addf %336, %335 : f64
            affine.store %337, %arg5[%arg8] : memref<?xf64>
            %338 = affine.apply #map1(%332)
            %339 = affine.load %arg3[%arg6, %arg7, %338] : memref<?x140x160xf64>
            %340 = affine.load %arg4[%338, %arg8] : memref<?x160xf64>
            %341 = arith.mulf %339, %340 : f64
            %342 = affine.load %arg5[%arg8] : memref<?xf64>
            %343 = arith.addf %342, %341 : f64
            affine.store %343, %arg5[%arg8] : memref<?xf64>
            %344 = affine.apply #map2(%332)
            %345 = affine.load %arg3[%arg6, %arg7, %344] : memref<?x140x160xf64>
            %346 = affine.load %arg4[%344, %arg8] : memref<?x160xf64>
            %347 = arith.mulf %345, %346 : f64
            %348 = affine.load %arg5[%arg8] : memref<?xf64>
            %349 = arith.addf %348, %347 : f64
            affine.store %349, %arg5[%arg8] : memref<?xf64>
            %350 = affine.apply #map3(%332)
            %351 = affine.load %arg3[%arg6, %arg7, %350] : memref<?x140x160xf64>
            %352 = affine.load %arg4[%350, %arg8] : memref<?x160xf64>
            %353 = arith.mulf %351, %352 : f64
            %354 = affine.load %arg5[%arg8] : memref<?xf64>
            %355 = arith.addf %354, %353 : f64
            affine.store %355, %arg5[%arg8] : memref<?xf64>
            %356 = affine.apply #map4(%332)
            %357 = affine.load %arg3[%arg6, %arg7, %356] : memref<?x140x160xf64>
            %358 = affine.load %arg4[%356, %arg8] : memref<?x160xf64>
            %359 = arith.mulf %357, %358 : f64
            %360 = affine.load %arg5[%arg8] : memref<?xf64>
            %361 = arith.addf %360, %359 : f64
            affine.store %361, %arg5[%arg8] : memref<?xf64>
            %362 = affine.apply #map16(%arg9)
            %363 = affine.load %arg3[%arg6, %arg7, %362] : memref<?x140x160xf64>
            %364 = affine.load %arg4[%362, %arg8] : memref<?x160xf64>
            %365 = arith.mulf %363, %364 : f64
            %366 = affine.load %arg5[%arg8] : memref<?xf64>
            %367 = arith.addf %366, %365 : f64
            affine.store %367, %arg5[%arg8] : memref<?xf64>
            %368 = affine.apply #map1(%362)
            %369 = affine.load %arg3[%arg6, %arg7, %368] : memref<?x140x160xf64>
            %370 = affine.load %arg4[%368, %arg8] : memref<?x160xf64>
            %371 = arith.mulf %369, %370 : f64
            %372 = affine.load %arg5[%arg8] : memref<?xf64>
            %373 = arith.addf %372, %371 : f64
            affine.store %373, %arg5[%arg8] : memref<?xf64>
            %374 = affine.apply #map2(%362)
            %375 = affine.load %arg3[%arg6, %arg7, %374] : memref<?x140x160xf64>
            %376 = affine.load %arg4[%374, %arg8] : memref<?x160xf64>
            %377 = arith.mulf %375, %376 : f64
            %378 = affine.load %arg5[%arg8] : memref<?xf64>
            %379 = arith.addf %378, %377 : f64
            affine.store %379, %arg5[%arg8] : memref<?xf64>
            %380 = affine.apply #map3(%362)
            %381 = affine.load %arg3[%arg6, %arg7, %380] : memref<?x140x160xf64>
            %382 = affine.load %arg4[%380, %arg8] : memref<?x160xf64>
            %383 = arith.mulf %381, %382 : f64
            %384 = affine.load %arg5[%arg8] : memref<?xf64>
            %385 = arith.addf %384, %383 : f64
            affine.store %385, %arg5[%arg8] : memref<?xf64>
            %386 = affine.apply #map4(%362)
            %387 = affine.load %arg3[%arg6, %arg7, %386] : memref<?x140x160xf64>
            %388 = affine.load %arg4[%386, %arg8] : memref<?x160xf64>
            %389 = arith.mulf %387, %388 : f64
            %390 = affine.load %arg5[%arg8] : memref<?xf64>
            %391 = arith.addf %390, %389 : f64
            affine.store %391, %arg5[%arg8] : memref<?xf64>
            %392 = affine.apply #map17(%arg9)
            %393 = affine.load %arg3[%arg6, %arg7, %392] : memref<?x140x160xf64>
            %394 = affine.load %arg4[%392, %arg8] : memref<?x160xf64>
            %395 = arith.mulf %393, %394 : f64
            %396 = affine.load %arg5[%arg8] : memref<?xf64>
            %397 = arith.addf %396, %395 : f64
            affine.store %397, %arg5[%arg8] : memref<?xf64>
            %398 = affine.apply #map1(%392)
            %399 = affine.load %arg3[%arg6, %arg7, %398] : memref<?x140x160xf64>
            %400 = affine.load %arg4[%398, %arg8] : memref<?x160xf64>
            %401 = arith.mulf %399, %400 : f64
            %402 = affine.load %arg5[%arg8] : memref<?xf64>
            %403 = arith.addf %402, %401 : f64
            affine.store %403, %arg5[%arg8] : memref<?xf64>
            %404 = affine.apply #map2(%392)
            %405 = affine.load %arg3[%arg6, %arg7, %404] : memref<?x140x160xf64>
            %406 = affine.load %arg4[%404, %arg8] : memref<?x160xf64>
            %407 = arith.mulf %405, %406 : f64
            %408 = affine.load %arg5[%arg8] : memref<?xf64>
            %409 = arith.addf %408, %407 : f64
            affine.store %409, %arg5[%arg8] : memref<?xf64>
            %410 = affine.apply #map3(%392)
            %411 = affine.load %arg3[%arg6, %arg7, %410] : memref<?x140x160xf64>
            %412 = affine.load %arg4[%410, %arg8] : memref<?x160xf64>
            %413 = arith.mulf %411, %412 : f64
            %414 = affine.load %arg5[%arg8] : memref<?xf64>
            %415 = arith.addf %414, %413 : f64
            affine.store %415, %arg5[%arg8] : memref<?xf64>
            %416 = affine.apply #map4(%392)
            %417 = affine.load %arg3[%arg6, %arg7, %416] : memref<?x140x160xf64>
            %418 = affine.load %arg4[%416, %arg8] : memref<?x160xf64>
            %419 = arith.mulf %417, %418 : f64
            %420 = affine.load %arg5[%arg8] : memref<?xf64>
            %421 = arith.addf %420, %419 : f64
            affine.store %421, %arg5[%arg8] : memref<?xf64>
            %422 = affine.apply #map18(%arg9)
            %423 = affine.load %arg3[%arg6, %arg7, %422] : memref<?x140x160xf64>
            %424 = affine.load %arg4[%422, %arg8] : memref<?x160xf64>
            %425 = arith.mulf %423, %424 : f64
            %426 = affine.load %arg5[%arg8] : memref<?xf64>
            %427 = arith.addf %426, %425 : f64
            affine.store %427, %arg5[%arg8] : memref<?xf64>
            %428 = affine.apply #map1(%422)
            %429 = affine.load %arg3[%arg6, %arg7, %428] : memref<?x140x160xf64>
            %430 = affine.load %arg4[%428, %arg8] : memref<?x160xf64>
            %431 = arith.mulf %429, %430 : f64
            %432 = affine.load %arg5[%arg8] : memref<?xf64>
            %433 = arith.addf %432, %431 : f64
            affine.store %433, %arg5[%arg8] : memref<?xf64>
            %434 = affine.apply #map2(%422)
            %435 = affine.load %arg3[%arg6, %arg7, %434] : memref<?x140x160xf64>
            %436 = affine.load %arg4[%434, %arg8] : memref<?x160xf64>
            %437 = arith.mulf %435, %436 : f64
            %438 = affine.load %arg5[%arg8] : memref<?xf64>
            %439 = arith.addf %438, %437 : f64
            affine.store %439, %arg5[%arg8] : memref<?xf64>
            %440 = affine.apply #map3(%422)
            %441 = affine.load %arg3[%arg6, %arg7, %440] : memref<?x140x160xf64>
            %442 = affine.load %arg4[%440, %arg8] : memref<?x160xf64>
            %443 = arith.mulf %441, %442 : f64
            %444 = affine.load %arg5[%arg8] : memref<?xf64>
            %445 = arith.addf %444, %443 : f64
            affine.store %445, %arg5[%arg8] : memref<?xf64>
            %446 = affine.apply #map4(%422)
            %447 = affine.load %arg3[%arg6, %arg7, %446] : memref<?x140x160xf64>
            %448 = affine.load %arg4[%446, %arg8] : memref<?x160xf64>
            %449 = arith.mulf %447, %448 : f64
            %450 = affine.load %arg5[%arg8] : memref<?xf64>
            %451 = arith.addf %450, %449 : f64
            affine.store %451, %arg5[%arg8] : memref<?xf64>
          }
          affine.for %arg9 = #map()[%1] to #map19()[%1] step 5 {
            %3 = affine.load %arg3[%arg6, %arg7, %arg9] : memref<?x140x160xf64>
            %4 = affine.load %arg4[%arg9, %arg8] : memref<?x160xf64>
            %5 = arith.mulf %3, %4 : f64
            %6 = affine.load %arg5[%arg8] : memref<?xf64>
            %7 = arith.addf %6, %5 : f64
            affine.store %7, %arg5[%arg8] : memref<?xf64>
            %8 = affine.apply #map1(%arg9)
            %9 = affine.load %arg3[%arg6, %arg7, %8] : memref<?x140x160xf64>
            %10 = affine.load %arg4[%8, %arg8] : memref<?x160xf64>
            %11 = arith.mulf %9, %10 : f64
            %12 = affine.load %arg5[%arg8] : memref<?xf64>
            %13 = arith.addf %12, %11 : f64
            affine.store %13, %arg5[%arg8] : memref<?xf64>
            %14 = affine.apply #map2(%arg9)
            %15 = affine.load %arg3[%arg6, %arg7, %14] : memref<?x140x160xf64>
            %16 = affine.load %arg4[%14, %arg8] : memref<?x160xf64>
            %17 = arith.mulf %15, %16 : f64
            %18 = affine.load %arg5[%arg8] : memref<?xf64>
            %19 = arith.addf %18, %17 : f64
            affine.store %19, %arg5[%arg8] : memref<?xf64>
            %20 = affine.apply #map3(%arg9)
            %21 = affine.load %arg3[%arg6, %arg7, %20] : memref<?x140x160xf64>
            %22 = affine.load %arg4[%20, %arg8] : memref<?x160xf64>
            %23 = arith.mulf %21, %22 : f64
            %24 = affine.load %arg5[%arg8] : memref<?xf64>
            %25 = arith.addf %24, %23 : f64
            affine.store %25, %arg5[%arg8] : memref<?xf64>
            %26 = affine.apply #map4(%arg9)
            %27 = affine.load %arg3[%arg6, %arg7, %26] : memref<?x140x160xf64>
            %28 = affine.load %arg4[%26, %arg8] : memref<?x160xf64>
            %29 = arith.mulf %27, %28 : f64
            %30 = affine.load %arg5[%arg8] : memref<?xf64>
            %31 = arith.addf %30, %29 : f64
            affine.store %31, %arg5[%arg8] : memref<?xf64>
          }
          affine.for %arg9 = #map19()[%1] to #map20()[%1] step 15 {
            %3 = affine.load %arg3[%arg6, %arg7, %arg9] : memref<?x140x160xf64>
            %4 = affine.load %arg4[%arg9, %arg8] : memref<?x160xf64>
            %5 = arith.mulf %3, %4 : f64
            %6 = affine.load %arg5[%arg8] : memref<?xf64>
            %7 = arith.addf %6, %5 : f64
            affine.store %7, %arg5[%arg8] : memref<?xf64>
            %8 = affine.apply #map1(%arg9)
            %9 = affine.load %arg3[%arg6, %arg7, %8] : memref<?x140x160xf64>
            %10 = affine.load %arg4[%8, %arg8] : memref<?x160xf64>
            %11 = arith.mulf %9, %10 : f64
            %12 = affine.load %arg5[%arg8] : memref<?xf64>
            %13 = arith.addf %12, %11 : f64
            affine.store %13, %arg5[%arg8] : memref<?xf64>
            %14 = affine.apply #map2(%arg9)
            %15 = affine.load %arg3[%arg6, %arg7, %14] : memref<?x140x160xf64>
            %16 = affine.load %arg4[%14, %arg8] : memref<?x160xf64>
            %17 = arith.mulf %15, %16 : f64
            %18 = affine.load %arg5[%arg8] : memref<?xf64>
            %19 = arith.addf %18, %17 : f64
            affine.store %19, %arg5[%arg8] : memref<?xf64>
            %20 = affine.apply #map3(%arg9)
            %21 = affine.load %arg3[%arg6, %arg7, %20] : memref<?x140x160xf64>
            %22 = affine.load %arg4[%20, %arg8] : memref<?x160xf64>
            %23 = arith.mulf %21, %22 : f64
            %24 = affine.load %arg5[%arg8] : memref<?xf64>
            %25 = arith.addf %24, %23 : f64
            affine.store %25, %arg5[%arg8] : memref<?xf64>
            %26 = affine.apply #map4(%arg9)
            %27 = affine.load %arg3[%arg6, %arg7, %26] : memref<?x140x160xf64>
            %28 = affine.load %arg4[%26, %arg8] : memref<?x160xf64>
            %29 = arith.mulf %27, %28 : f64
            %30 = affine.load %arg5[%arg8] : memref<?xf64>
            %31 = arith.addf %30, %29 : f64
            affine.store %31, %arg5[%arg8] : memref<?xf64>
            %32 = affine.apply #map5(%arg9)
            %33 = affine.load %arg3[%arg6, %arg7, %32] : memref<?x140x160xf64>
            %34 = affine.load %arg4[%32, %arg8] : memref<?x160xf64>
            %35 = arith.mulf %33, %34 : f64
            %36 = affine.load %arg5[%arg8] : memref<?xf64>
            %37 = arith.addf %36, %35 : f64
            affine.store %37, %arg5[%arg8] : memref<?xf64>
            %38 = affine.apply #map21(%arg9)
            %39 = affine.load %arg3[%arg6, %arg7, %38] : memref<?x140x160xf64>
            %40 = affine.load %arg4[%38, %arg8] : memref<?x160xf64>
            %41 = arith.mulf %39, %40 : f64
            %42 = affine.load %arg5[%arg8] : memref<?xf64>
            %43 = arith.addf %42, %41 : f64
            affine.store %43, %arg5[%arg8] : memref<?xf64>
            %44 = affine.apply #map22(%arg9)
            %45 = affine.load %arg3[%arg6, %arg7, %44] : memref<?x140x160xf64>
            %46 = affine.load %arg4[%44, %arg8] : memref<?x160xf64>
            %47 = arith.mulf %45, %46 : f64
            %48 = affine.load %arg5[%arg8] : memref<?xf64>
            %49 = arith.addf %48, %47 : f64
            affine.store %49, %arg5[%arg8] : memref<?xf64>
            %50 = affine.apply #map23(%arg9)
            %51 = affine.load %arg3[%arg6, %arg7, %50] : memref<?x140x160xf64>
            %52 = affine.load %arg4[%50, %arg8] : memref<?x160xf64>
            %53 = arith.mulf %51, %52 : f64
            %54 = affine.load %arg5[%arg8] : memref<?xf64>
            %55 = arith.addf %54, %53 : f64
            affine.store %55, %arg5[%arg8] : memref<?xf64>
            %56 = affine.apply #map24(%arg9)
            %57 = affine.load %arg3[%arg6, %arg7, %56] : memref<?x140x160xf64>
            %58 = affine.load %arg4[%56, %arg8] : memref<?x160xf64>
            %59 = arith.mulf %57, %58 : f64
            %60 = affine.load %arg5[%arg8] : memref<?xf64>
            %61 = arith.addf %60, %59 : f64
            affine.store %61, %arg5[%arg8] : memref<?xf64>
            %62 = affine.apply #map6(%arg9)
            %63 = affine.load %arg3[%arg6, %arg7, %62] : memref<?x140x160xf64>
            %64 = affine.load %arg4[%62, %arg8] : memref<?x160xf64>
            %65 = arith.mulf %63, %64 : f64
            %66 = affine.load %arg5[%arg8] : memref<?xf64>
            %67 = arith.addf %66, %65 : f64
            affine.store %67, %arg5[%arg8] : memref<?xf64>
            %68 = affine.apply #map25(%arg9)
            %69 = affine.load %arg3[%arg6, %arg7, %68] : memref<?x140x160xf64>
            %70 = affine.load %arg4[%68, %arg8] : memref<?x160xf64>
            %71 = arith.mulf %69, %70 : f64
            %72 = affine.load %arg5[%arg8] : memref<?xf64>
            %73 = arith.addf %72, %71 : f64
            affine.store %73, %arg5[%arg8] : memref<?xf64>
            %74 = affine.apply #map26(%arg9)
            %75 = affine.load %arg3[%arg6, %arg7, %74] : memref<?x140x160xf64>
            %76 = affine.load %arg4[%74, %arg8] : memref<?x160xf64>
            %77 = arith.mulf %75, %76 : f64
            %78 = affine.load %arg5[%arg8] : memref<?xf64>
            %79 = arith.addf %78, %77 : f64
            affine.store %79, %arg5[%arg8] : memref<?xf64>
            %80 = affine.apply #map27(%arg9)
            %81 = affine.load %arg3[%arg6, %arg7, %80] : memref<?x140x160xf64>
            %82 = affine.load %arg4[%80, %arg8] : memref<?x160xf64>
            %83 = arith.mulf %81, %82 : f64
            %84 = affine.load %arg5[%arg8] : memref<?xf64>
            %85 = arith.addf %84, %83 : f64
            affine.store %85, %arg5[%arg8] : memref<?xf64>
            %86 = affine.apply #map28(%arg9)
            %87 = affine.load %arg3[%arg6, %arg7, %86] : memref<?x140x160xf64>
            %88 = affine.load %arg4[%86, %arg8] : memref<?x160xf64>
            %89 = arith.mulf %87, %88 : f64
            %90 = affine.load %arg5[%arg8] : memref<?xf64>
            %91 = arith.addf %90, %89 : f64
            affine.store %91, %arg5[%arg8] : memref<?xf64>
          }
          affine.for %arg9 = #map20()[%1] to %1 {
            %3 = affine.load %arg3[%arg6, %arg7, %arg9] : memref<?x140x160xf64>
            %4 = affine.load %arg4[%arg9, %arg8] : memref<?x160xf64>
            %5 = arith.mulf %3, %4 : f64
            %6 = affine.load %arg5[%arg8] : memref<?xf64>
            %7 = arith.addf %6, %5 : f64
            affine.store %7, %arg5[%arg8] : memref<?xf64>
          }
        }
        affine.for %arg8 = 0 to #map()[%1] step 75 {
          %3 = affine.load %arg5[%arg8] : memref<?xf64>
          affine.store %3, %arg3[%arg6, %arg7, %arg8] : memref<?x140x160xf64>
          %4 = affine.apply #map1(%arg8)
          %5 = affine.load %arg5[%4] : memref<?xf64>
          affine.store %5, %arg3[%arg6, %arg7, %4] : memref<?x140x160xf64>
          %6 = affine.apply #map2(%arg8)
          %7 = affine.load %arg5[%6] : memref<?xf64>
          affine.store %7, %arg3[%arg6, %arg7, %6] : memref<?x140x160xf64>
          %8 = affine.apply #map3(%arg8)
          %9 = affine.load %arg5[%8] : memref<?xf64>
          affine.store %9, %arg3[%arg6, %arg7, %8] : memref<?x140x160xf64>
          %10 = affine.apply #map4(%arg8)
          %11 = affine.load %arg5[%10] : memref<?xf64>
          affine.store %11, %arg3[%arg6, %arg7, %10] : memref<?x140x160xf64>
          %12 = affine.apply #map5(%arg8)
          %13 = affine.load %arg5[%12] : memref<?xf64>
          affine.store %13, %arg3[%arg6, %arg7, %12] : memref<?x140x160xf64>
          %14 = affine.apply #map1(%12)
          %15 = affine.load %arg5[%14] : memref<?xf64>
          affine.store %15, %arg3[%arg6, %arg7, %14] : memref<?x140x160xf64>
          %16 = affine.apply #map2(%12)
          %17 = affine.load %arg5[%16] : memref<?xf64>
          affine.store %17, %arg3[%arg6, %arg7, %16] : memref<?x140x160xf64>
          %18 = affine.apply #map3(%12)
          %19 = affine.load %arg5[%18] : memref<?xf64>
          affine.store %19, %arg3[%arg6, %arg7, %18] : memref<?x140x160xf64>
          %20 = affine.apply #map4(%12)
          %21 = affine.load %arg5[%20] : memref<?xf64>
          affine.store %21, %arg3[%arg6, %arg7, %20] : memref<?x140x160xf64>
          %22 = affine.apply #map6(%arg8)
          %23 = affine.load %arg5[%22] : memref<?xf64>
          affine.store %23, %arg3[%arg6, %arg7, %22] : memref<?x140x160xf64>
          %24 = affine.apply #map1(%22)
          %25 = affine.load %arg5[%24] : memref<?xf64>
          affine.store %25, %arg3[%arg6, %arg7, %24] : memref<?x140x160xf64>
          %26 = affine.apply #map2(%22)
          %27 = affine.load %arg5[%26] : memref<?xf64>
          affine.store %27, %arg3[%arg6, %arg7, %26] : memref<?x140x160xf64>
          %28 = affine.apply #map3(%22)
          %29 = affine.load %arg5[%28] : memref<?xf64>
          affine.store %29, %arg3[%arg6, %arg7, %28] : memref<?x140x160xf64>
          %30 = affine.apply #map4(%22)
          %31 = affine.load %arg5[%30] : memref<?xf64>
          affine.store %31, %arg3[%arg6, %arg7, %30] : memref<?x140x160xf64>
          %32 = affine.apply #map7(%arg8)
          %33 = affine.load %arg5[%32] : memref<?xf64>
          affine.store %33, %arg3[%arg6, %arg7, %32] : memref<?x140x160xf64>
          %34 = affine.apply #map1(%32)
          %35 = affine.load %arg5[%34] : memref<?xf64>
          affine.store %35, %arg3[%arg6, %arg7, %34] : memref<?x140x160xf64>
          %36 = affine.apply #map2(%32)
          %37 = affine.load %arg5[%36] : memref<?xf64>
          affine.store %37, %arg3[%arg6, %arg7, %36] : memref<?x140x160xf64>
          %38 = affine.apply #map3(%32)
          %39 = affine.load %arg5[%38] : memref<?xf64>
          affine.store %39, %arg3[%arg6, %arg7, %38] : memref<?x140x160xf64>
          %40 = affine.apply #map4(%32)
          %41 = affine.load %arg5[%40] : memref<?xf64>
          affine.store %41, %arg3[%arg6, %arg7, %40] : memref<?x140x160xf64>
          %42 = affine.apply #map8(%arg8)
          %43 = affine.load %arg5[%42] : memref<?xf64>
          affine.store %43, %arg3[%arg6, %arg7, %42] : memref<?x140x160xf64>
          %44 = affine.apply #map1(%42)
          %45 = affine.load %arg5[%44] : memref<?xf64>
          affine.store %45, %arg3[%arg6, %arg7, %44] : memref<?x140x160xf64>
          %46 = affine.apply #map2(%42)
          %47 = affine.load %arg5[%46] : memref<?xf64>
          affine.store %47, %arg3[%arg6, %arg7, %46] : memref<?x140x160xf64>
          %48 = affine.apply #map3(%42)
          %49 = affine.load %arg5[%48] : memref<?xf64>
          affine.store %49, %arg3[%arg6, %arg7, %48] : memref<?x140x160xf64>
          %50 = affine.apply #map4(%42)
          %51 = affine.load %arg5[%50] : memref<?xf64>
          affine.store %51, %arg3[%arg6, %arg7, %50] : memref<?x140x160xf64>
          %52 = affine.apply #map9(%arg8)
          %53 = affine.load %arg5[%52] : memref<?xf64>
          affine.store %53, %arg3[%arg6, %arg7, %52] : memref<?x140x160xf64>
          %54 = affine.apply #map1(%52)
          %55 = affine.load %arg5[%54] : memref<?xf64>
          affine.store %55, %arg3[%arg6, %arg7, %54] : memref<?x140x160xf64>
          %56 = affine.apply #map2(%52)
          %57 = affine.load %arg5[%56] : memref<?xf64>
          affine.store %57, %arg3[%arg6, %arg7, %56] : memref<?x140x160xf64>
          %58 = affine.apply #map3(%52)
          %59 = affine.load %arg5[%58] : memref<?xf64>
          affine.store %59, %arg3[%arg6, %arg7, %58] : memref<?x140x160xf64>
          %60 = affine.apply #map4(%52)
          %61 = affine.load %arg5[%60] : memref<?xf64>
          affine.store %61, %arg3[%arg6, %arg7, %60] : memref<?x140x160xf64>
          %62 = affine.apply #map10(%arg8)
          %63 = affine.load %arg5[%62] : memref<?xf64>
          affine.store %63, %arg3[%arg6, %arg7, %62] : memref<?x140x160xf64>
          %64 = affine.apply #map1(%62)
          %65 = affine.load %arg5[%64] : memref<?xf64>
          affine.store %65, %arg3[%arg6, %arg7, %64] : memref<?x140x160xf64>
          %66 = affine.apply #map2(%62)
          %67 = affine.load %arg5[%66] : memref<?xf64>
          affine.store %67, %arg3[%arg6, %arg7, %66] : memref<?x140x160xf64>
          %68 = affine.apply #map3(%62)
          %69 = affine.load %arg5[%68] : memref<?xf64>
          affine.store %69, %arg3[%arg6, %arg7, %68] : memref<?x140x160xf64>
          %70 = affine.apply #map4(%62)
          %71 = affine.load %arg5[%70] : memref<?xf64>
          affine.store %71, %arg3[%arg6, %arg7, %70] : memref<?x140x160xf64>
          %72 = affine.apply #map11(%arg8)
          %73 = affine.load %arg5[%72] : memref<?xf64>
          affine.store %73, %arg3[%arg6, %arg7, %72] : memref<?x140x160xf64>
          %74 = affine.apply #map1(%72)
          %75 = affine.load %arg5[%74] : memref<?xf64>
          affine.store %75, %arg3[%arg6, %arg7, %74] : memref<?x140x160xf64>
          %76 = affine.apply #map2(%72)
          %77 = affine.load %arg5[%76] : memref<?xf64>
          affine.store %77, %arg3[%arg6, %arg7, %76] : memref<?x140x160xf64>
          %78 = affine.apply #map3(%72)
          %79 = affine.load %arg5[%78] : memref<?xf64>
          affine.store %79, %arg3[%arg6, %arg7, %78] : memref<?x140x160xf64>
          %80 = affine.apply #map4(%72)
          %81 = affine.load %arg5[%80] : memref<?xf64>
          affine.store %81, %arg3[%arg6, %arg7, %80] : memref<?x140x160xf64>
          %82 = affine.apply #map12(%arg8)
          %83 = affine.load %arg5[%82] : memref<?xf64>
          affine.store %83, %arg3[%arg6, %arg7, %82] : memref<?x140x160xf64>
          %84 = affine.apply #map1(%82)
          %85 = affine.load %arg5[%84] : memref<?xf64>
          affine.store %85, %arg3[%arg6, %arg7, %84] : memref<?x140x160xf64>
          %86 = affine.apply #map2(%82)
          %87 = affine.load %arg5[%86] : memref<?xf64>
          affine.store %87, %arg3[%arg6, %arg7, %86] : memref<?x140x160xf64>
          %88 = affine.apply #map3(%82)
          %89 = affine.load %arg5[%88] : memref<?xf64>
          affine.store %89, %arg3[%arg6, %arg7, %88] : memref<?x140x160xf64>
          %90 = affine.apply #map4(%82)
          %91 = affine.load %arg5[%90] : memref<?xf64>
          affine.store %91, %arg3[%arg6, %arg7, %90] : memref<?x140x160xf64>
          %92 = affine.apply #map13(%arg8)
          %93 = affine.load %arg5[%92] : memref<?xf64>
          affine.store %93, %arg3[%arg6, %arg7, %92] : memref<?x140x160xf64>
          %94 = affine.apply #map1(%92)
          %95 = affine.load %arg5[%94] : memref<?xf64>
          affine.store %95, %arg3[%arg6, %arg7, %94] : memref<?x140x160xf64>
          %96 = affine.apply #map2(%92)
          %97 = affine.load %arg5[%96] : memref<?xf64>
          affine.store %97, %arg3[%arg6, %arg7, %96] : memref<?x140x160xf64>
          %98 = affine.apply #map3(%92)
          %99 = affine.load %arg5[%98] : memref<?xf64>
          affine.store %99, %arg3[%arg6, %arg7, %98] : memref<?x140x160xf64>
          %100 = affine.apply #map4(%92)
          %101 = affine.load %arg5[%100] : memref<?xf64>
          affine.store %101, %arg3[%arg6, %arg7, %100] : memref<?x140x160xf64>
          %102 = affine.apply #map14(%arg8)
          %103 = affine.load %arg5[%102] : memref<?xf64>
          affine.store %103, %arg3[%arg6, %arg7, %102] : memref<?x140x160xf64>
          %104 = affine.apply #map1(%102)
          %105 = affine.load %arg5[%104] : memref<?xf64>
          affine.store %105, %arg3[%arg6, %arg7, %104] : memref<?x140x160xf64>
          %106 = affine.apply #map2(%102)
          %107 = affine.load %arg5[%106] : memref<?xf64>
          affine.store %107, %arg3[%arg6, %arg7, %106] : memref<?x140x160xf64>
          %108 = affine.apply #map3(%102)
          %109 = affine.load %arg5[%108] : memref<?xf64>
          affine.store %109, %arg3[%arg6, %arg7, %108] : memref<?x140x160xf64>
          %110 = affine.apply #map4(%102)
          %111 = affine.load %arg5[%110] : memref<?xf64>
          affine.store %111, %arg3[%arg6, %arg7, %110] : memref<?x140x160xf64>
          %112 = affine.apply #map15(%arg8)
          %113 = affine.load %arg5[%112] : memref<?xf64>
          affine.store %113, %arg3[%arg6, %arg7, %112] : memref<?x140x160xf64>
          %114 = affine.apply #map1(%112)
          %115 = affine.load %arg5[%114] : memref<?xf64>
          affine.store %115, %arg3[%arg6, %arg7, %114] : memref<?x140x160xf64>
          %116 = affine.apply #map2(%112)
          %117 = affine.load %arg5[%116] : memref<?xf64>
          affine.store %117, %arg3[%arg6, %arg7, %116] : memref<?x140x160xf64>
          %118 = affine.apply #map3(%112)
          %119 = affine.load %arg5[%118] : memref<?xf64>
          affine.store %119, %arg3[%arg6, %arg7, %118] : memref<?x140x160xf64>
          %120 = affine.apply #map4(%112)
          %121 = affine.load %arg5[%120] : memref<?xf64>
          affine.store %121, %arg3[%arg6, %arg7, %120] : memref<?x140x160xf64>
          %122 = affine.apply #map16(%arg8)
          %123 = affine.load %arg5[%122] : memref<?xf64>
          affine.store %123, %arg3[%arg6, %arg7, %122] : memref<?x140x160xf64>
          %124 = affine.apply #map1(%122)
          %125 = affine.load %arg5[%124] : memref<?xf64>
          affine.store %125, %arg3[%arg6, %arg7, %124] : memref<?x140x160xf64>
          %126 = affine.apply #map2(%122)
          %127 = affine.load %arg5[%126] : memref<?xf64>
          affine.store %127, %arg3[%arg6, %arg7, %126] : memref<?x140x160xf64>
          %128 = affine.apply #map3(%122)
          %129 = affine.load %arg5[%128] : memref<?xf64>
          affine.store %129, %arg3[%arg6, %arg7, %128] : memref<?x140x160xf64>
          %130 = affine.apply #map4(%122)
          %131 = affine.load %arg5[%130] : memref<?xf64>
          affine.store %131, %arg3[%arg6, %arg7, %130] : memref<?x140x160xf64>
          %132 = affine.apply #map17(%arg8)
          %133 = affine.load %arg5[%132] : memref<?xf64>
          affine.store %133, %arg3[%arg6, %arg7, %132] : memref<?x140x160xf64>
          %134 = affine.apply #map1(%132)
          %135 = affine.load %arg5[%134] : memref<?xf64>
          affine.store %135, %arg3[%arg6, %arg7, %134] : memref<?x140x160xf64>
          %136 = affine.apply #map2(%132)
          %137 = affine.load %arg5[%136] : memref<?xf64>
          affine.store %137, %arg3[%arg6, %arg7, %136] : memref<?x140x160xf64>
          %138 = affine.apply #map3(%132)
          %139 = affine.load %arg5[%138] : memref<?xf64>
          affine.store %139, %arg3[%arg6, %arg7, %138] : memref<?x140x160xf64>
          %140 = affine.apply #map4(%132)
          %141 = affine.load %arg5[%140] : memref<?xf64>
          affine.store %141, %arg3[%arg6, %arg7, %140] : memref<?x140x160xf64>
          %142 = affine.apply #map18(%arg8)
          %143 = affine.load %arg5[%142] : memref<?xf64>
          affine.store %143, %arg3[%arg6, %arg7, %142] : memref<?x140x160xf64>
          %144 = affine.apply #map1(%142)
          %145 = affine.load %arg5[%144] : memref<?xf64>
          affine.store %145, %arg3[%arg6, %arg7, %144] : memref<?x140x160xf64>
          %146 = affine.apply #map2(%142)
          %147 = affine.load %arg5[%146] : memref<?xf64>
          affine.store %147, %arg3[%arg6, %arg7, %146] : memref<?x140x160xf64>
          %148 = affine.apply #map3(%142)
          %149 = affine.load %arg5[%148] : memref<?xf64>
          affine.store %149, %arg3[%arg6, %arg7, %148] : memref<?x140x160xf64>
          %150 = affine.apply #map4(%142)
          %151 = affine.load %arg5[%150] : memref<?xf64>
          affine.store %151, %arg3[%arg6, %arg7, %150] : memref<?x140x160xf64>
        }
        affine.for %arg8 = #map()[%1] to #map19()[%1] step 5 {
          %3 = affine.load %arg5[%arg8] : memref<?xf64>
          affine.store %3, %arg3[%arg6, %arg7, %arg8] : memref<?x140x160xf64>
          %4 = affine.apply #map1(%arg8)
          %5 = affine.load %arg5[%4] : memref<?xf64>
          affine.store %5, %arg3[%arg6, %arg7, %4] : memref<?x140x160xf64>
          %6 = affine.apply #map2(%arg8)
          %7 = affine.load %arg5[%6] : memref<?xf64>
          affine.store %7, %arg3[%arg6, %arg7, %6] : memref<?x140x160xf64>
          %8 = affine.apply #map3(%arg8)
          %9 = affine.load %arg5[%8] : memref<?xf64>
          affine.store %9, %arg3[%arg6, %arg7, %8] : memref<?x140x160xf64>
          %10 = affine.apply #map4(%arg8)
          %11 = affine.load %arg5[%10] : memref<?xf64>
          affine.store %11, %arg3[%arg6, %arg7, %10] : memref<?x140x160xf64>
        }
        affine.for %arg8 = #map19()[%1] to #map20()[%1] step 15 {
          %3 = affine.load %arg5[%arg8] : memref<?xf64>
          affine.store %3, %arg3[%arg6, %arg7, %arg8] : memref<?x140x160xf64>
          %4 = affine.apply #map1(%arg8)
          %5 = affine.load %arg5[%4] : memref<?xf64>
          affine.store %5, %arg3[%arg6, %arg7, %4] : memref<?x140x160xf64>
          %6 = affine.apply #map2(%arg8)
          %7 = affine.load %arg5[%6] : memref<?xf64>
          affine.store %7, %arg3[%arg6, %arg7, %6] : memref<?x140x160xf64>
          %8 = affine.apply #map3(%arg8)
          %9 = affine.load %arg5[%8] : memref<?xf64>
          affine.store %9, %arg3[%arg6, %arg7, %8] : memref<?x140x160xf64>
          %10 = affine.apply #map4(%arg8)
          %11 = affine.load %arg5[%10] : memref<?xf64>
          affine.store %11, %arg3[%arg6, %arg7, %10] : memref<?x140x160xf64>
          %12 = affine.apply #map5(%arg8)
          %13 = affine.load %arg5[%12] : memref<?xf64>
          affine.store %13, %arg3[%arg6, %arg7, %12] : memref<?x140x160xf64>
          %14 = affine.apply #map21(%arg8)
          %15 = affine.load %arg5[%14] : memref<?xf64>
          affine.store %15, %arg3[%arg6, %arg7, %14] : memref<?x140x160xf64>
          %16 = affine.apply #map22(%arg8)
          %17 = affine.load %arg5[%16] : memref<?xf64>
          affine.store %17, %arg3[%arg6, %arg7, %16] : memref<?x140x160xf64>
          %18 = affine.apply #map23(%arg8)
          %19 = affine.load %arg5[%18] : memref<?xf64>
          affine.store %19, %arg3[%arg6, %arg7, %18] : memref<?x140x160xf64>
          %20 = affine.apply #map24(%arg8)
          %21 = affine.load %arg5[%20] : memref<?xf64>
          affine.store %21, %arg3[%arg6, %arg7, %20] : memref<?x140x160xf64>
          %22 = affine.apply #map6(%arg8)
          %23 = affine.load %arg5[%22] : memref<?xf64>
          affine.store %23, %arg3[%arg6, %arg7, %22] : memref<?x140x160xf64>
          %24 = affine.apply #map25(%arg8)
          %25 = affine.load %arg5[%24] : memref<?xf64>
          affine.store %25, %arg3[%arg6, %arg7, %24] : memref<?x140x160xf64>
          %26 = affine.apply #map26(%arg8)
          %27 = affine.load %arg5[%26] : memref<?xf64>
          affine.store %27, %arg3[%arg6, %arg7, %26] : memref<?x140x160xf64>
          %28 = affine.apply #map27(%arg8)
          %29 = affine.load %arg5[%28] : memref<?xf64>
          affine.store %29, %arg3[%arg6, %arg7, %28] : memref<?x140x160xf64>
          %30 = affine.apply #map28(%arg8)
          %31 = affine.load %arg5[%30] : memref<?xf64>
          affine.store %31, %arg3[%arg6, %arg7, %30] : memref<?x140x160xf64>
        }
        affine.for %arg8 = #map20()[%1] to %1 {
          %3 = affine.load %arg5[%arg8] : memref<?xf64>
          affine.store %3, %arg3[%arg6, %arg7, %arg8] : memref<?x140x160xf64>
        }
      }
    }
    return
  }
}

