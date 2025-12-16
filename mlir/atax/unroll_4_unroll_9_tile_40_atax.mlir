#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 40, s0)>
#map2 = affine_map<()[s0] -> (((s0 floordiv 9) floordiv 4) * 36)>
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
#map14 = affine_map<()[s0] -> ((s0 floordiv 9) * 9)>
#map15 = affine_map<()[s0] -> ((s0 floordiv 9) * 9 + ((s0 mod 9) floordiv 4) * 4)>
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
        affine.for %arg8 = 0 to #map2()[%0] step 36 {
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
          %49 = affine.apply #map10(%arg8)
          %50 = affine.load %arg5[%arg7] : memref<?xf64>
          %51 = affine.load %arg2[%arg7, %49] : memref<?x2100xf64>
          %52 = affine.load %arg3[%49] : memref<?xf64>
          %53 = arith.mulf %51, %52 : f64
          %54 = arith.addf %50, %53 : f64
          affine.store %54, %arg5[%arg7] : memref<?xf64>
          %55 = affine.apply #map11(%arg8)
          %56 = affine.load %arg5[%arg7] : memref<?xf64>
          %57 = affine.load %arg2[%arg7, %55] : memref<?x2100xf64>
          %58 = affine.load %arg3[%55] : memref<?xf64>
          %59 = arith.mulf %57, %58 : f64
          %60 = arith.addf %56, %59 : f64
          affine.store %60, %arg5[%arg7] : memref<?xf64>
          %61 = affine.apply #map3(%55)
          %62 = affine.load %arg5[%arg7] : memref<?xf64>
          %63 = affine.load %arg2[%arg7, %61] : memref<?x2100xf64>
          %64 = affine.load %arg3[%61] : memref<?xf64>
          %65 = arith.mulf %63, %64 : f64
          %66 = arith.addf %62, %65 : f64
          affine.store %66, %arg5[%arg7] : memref<?xf64>
          %67 = affine.apply #map4(%55)
          %68 = affine.load %arg5[%arg7] : memref<?xf64>
          %69 = affine.load %arg2[%arg7, %67] : memref<?x2100xf64>
          %70 = affine.load %arg3[%67] : memref<?xf64>
          %71 = arith.mulf %69, %70 : f64
          %72 = arith.addf %68, %71 : f64
          affine.store %72, %arg5[%arg7] : memref<?xf64>
          %73 = affine.apply #map5(%55)
          %74 = affine.load %arg5[%arg7] : memref<?xf64>
          %75 = affine.load %arg2[%arg7, %73] : memref<?x2100xf64>
          %76 = affine.load %arg3[%73] : memref<?xf64>
          %77 = arith.mulf %75, %76 : f64
          %78 = arith.addf %74, %77 : f64
          affine.store %78, %arg5[%arg7] : memref<?xf64>
          %79 = affine.apply #map6(%55)
          %80 = affine.load %arg5[%arg7] : memref<?xf64>
          %81 = affine.load %arg2[%arg7, %79] : memref<?x2100xf64>
          %82 = affine.load %arg3[%79] : memref<?xf64>
          %83 = arith.mulf %81, %82 : f64
          %84 = arith.addf %80, %83 : f64
          affine.store %84, %arg5[%arg7] : memref<?xf64>
          %85 = affine.apply #map7(%55)
          %86 = affine.load %arg5[%arg7] : memref<?xf64>
          %87 = affine.load %arg2[%arg7, %85] : memref<?x2100xf64>
          %88 = affine.load %arg3[%85] : memref<?xf64>
          %89 = arith.mulf %87, %88 : f64
          %90 = arith.addf %86, %89 : f64
          affine.store %90, %arg5[%arg7] : memref<?xf64>
          %91 = affine.apply #map8(%55)
          %92 = affine.load %arg5[%arg7] : memref<?xf64>
          %93 = affine.load %arg2[%arg7, %91] : memref<?x2100xf64>
          %94 = affine.load %arg3[%91] : memref<?xf64>
          %95 = arith.mulf %93, %94 : f64
          %96 = arith.addf %92, %95 : f64
          affine.store %96, %arg5[%arg7] : memref<?xf64>
          %97 = affine.apply #map9(%55)
          %98 = affine.load %arg5[%arg7] : memref<?xf64>
          %99 = affine.load %arg2[%arg7, %97] : memref<?x2100xf64>
          %100 = affine.load %arg3[%97] : memref<?xf64>
          %101 = arith.mulf %99, %100 : f64
          %102 = arith.addf %98, %101 : f64
          affine.store %102, %arg5[%arg7] : memref<?xf64>
          %103 = affine.apply #map10(%55)
          %104 = affine.load %arg5[%arg7] : memref<?xf64>
          %105 = affine.load %arg2[%arg7, %103] : memref<?x2100xf64>
          %106 = affine.load %arg3[%103] : memref<?xf64>
          %107 = arith.mulf %105, %106 : f64
          %108 = arith.addf %104, %107 : f64
          affine.store %108, %arg5[%arg7] : memref<?xf64>
          %109 = affine.apply #map12(%arg8)
          %110 = affine.load %arg5[%arg7] : memref<?xf64>
          %111 = affine.load %arg2[%arg7, %109] : memref<?x2100xf64>
          %112 = affine.load %arg3[%109] : memref<?xf64>
          %113 = arith.mulf %111, %112 : f64
          %114 = arith.addf %110, %113 : f64
          affine.store %114, %arg5[%arg7] : memref<?xf64>
          %115 = affine.apply #map3(%109)
          %116 = affine.load %arg5[%arg7] : memref<?xf64>
          %117 = affine.load %arg2[%arg7, %115] : memref<?x2100xf64>
          %118 = affine.load %arg3[%115] : memref<?xf64>
          %119 = arith.mulf %117, %118 : f64
          %120 = arith.addf %116, %119 : f64
          affine.store %120, %arg5[%arg7] : memref<?xf64>
          %121 = affine.apply #map4(%109)
          %122 = affine.load %arg5[%arg7] : memref<?xf64>
          %123 = affine.load %arg2[%arg7, %121] : memref<?x2100xf64>
          %124 = affine.load %arg3[%121] : memref<?xf64>
          %125 = arith.mulf %123, %124 : f64
          %126 = arith.addf %122, %125 : f64
          affine.store %126, %arg5[%arg7] : memref<?xf64>
          %127 = affine.apply #map5(%109)
          %128 = affine.load %arg5[%arg7] : memref<?xf64>
          %129 = affine.load %arg2[%arg7, %127] : memref<?x2100xf64>
          %130 = affine.load %arg3[%127] : memref<?xf64>
          %131 = arith.mulf %129, %130 : f64
          %132 = arith.addf %128, %131 : f64
          affine.store %132, %arg5[%arg7] : memref<?xf64>
          %133 = affine.apply #map6(%109)
          %134 = affine.load %arg5[%arg7] : memref<?xf64>
          %135 = affine.load %arg2[%arg7, %133] : memref<?x2100xf64>
          %136 = affine.load %arg3[%133] : memref<?xf64>
          %137 = arith.mulf %135, %136 : f64
          %138 = arith.addf %134, %137 : f64
          affine.store %138, %arg5[%arg7] : memref<?xf64>
          %139 = affine.apply #map7(%109)
          %140 = affine.load %arg5[%arg7] : memref<?xf64>
          %141 = affine.load %arg2[%arg7, %139] : memref<?x2100xf64>
          %142 = affine.load %arg3[%139] : memref<?xf64>
          %143 = arith.mulf %141, %142 : f64
          %144 = arith.addf %140, %143 : f64
          affine.store %144, %arg5[%arg7] : memref<?xf64>
          %145 = affine.apply #map8(%109)
          %146 = affine.load %arg5[%arg7] : memref<?xf64>
          %147 = affine.load %arg2[%arg7, %145] : memref<?x2100xf64>
          %148 = affine.load %arg3[%145] : memref<?xf64>
          %149 = arith.mulf %147, %148 : f64
          %150 = arith.addf %146, %149 : f64
          affine.store %150, %arg5[%arg7] : memref<?xf64>
          %151 = affine.apply #map9(%109)
          %152 = affine.load %arg5[%arg7] : memref<?xf64>
          %153 = affine.load %arg2[%arg7, %151] : memref<?x2100xf64>
          %154 = affine.load %arg3[%151] : memref<?xf64>
          %155 = arith.mulf %153, %154 : f64
          %156 = arith.addf %152, %155 : f64
          affine.store %156, %arg5[%arg7] : memref<?xf64>
          %157 = affine.apply #map10(%109)
          %158 = affine.load %arg5[%arg7] : memref<?xf64>
          %159 = affine.load %arg2[%arg7, %157] : memref<?x2100xf64>
          %160 = affine.load %arg3[%157] : memref<?xf64>
          %161 = arith.mulf %159, %160 : f64
          %162 = arith.addf %158, %161 : f64
          affine.store %162, %arg5[%arg7] : memref<?xf64>
          %163 = affine.apply #map13(%arg8)
          %164 = affine.load %arg5[%arg7] : memref<?xf64>
          %165 = affine.load %arg2[%arg7, %163] : memref<?x2100xf64>
          %166 = affine.load %arg3[%163] : memref<?xf64>
          %167 = arith.mulf %165, %166 : f64
          %168 = arith.addf %164, %167 : f64
          affine.store %168, %arg5[%arg7] : memref<?xf64>
          %169 = affine.apply #map3(%163)
          %170 = affine.load %arg5[%arg7] : memref<?xf64>
          %171 = affine.load %arg2[%arg7, %169] : memref<?x2100xf64>
          %172 = affine.load %arg3[%169] : memref<?xf64>
          %173 = arith.mulf %171, %172 : f64
          %174 = arith.addf %170, %173 : f64
          affine.store %174, %arg5[%arg7] : memref<?xf64>
          %175 = affine.apply #map4(%163)
          %176 = affine.load %arg5[%arg7] : memref<?xf64>
          %177 = affine.load %arg2[%arg7, %175] : memref<?x2100xf64>
          %178 = affine.load %arg3[%175] : memref<?xf64>
          %179 = arith.mulf %177, %178 : f64
          %180 = arith.addf %176, %179 : f64
          affine.store %180, %arg5[%arg7] : memref<?xf64>
          %181 = affine.apply #map5(%163)
          %182 = affine.load %arg5[%arg7] : memref<?xf64>
          %183 = affine.load %arg2[%arg7, %181] : memref<?x2100xf64>
          %184 = affine.load %arg3[%181] : memref<?xf64>
          %185 = arith.mulf %183, %184 : f64
          %186 = arith.addf %182, %185 : f64
          affine.store %186, %arg5[%arg7] : memref<?xf64>
          %187 = affine.apply #map6(%163)
          %188 = affine.load %arg5[%arg7] : memref<?xf64>
          %189 = affine.load %arg2[%arg7, %187] : memref<?x2100xf64>
          %190 = affine.load %arg3[%187] : memref<?xf64>
          %191 = arith.mulf %189, %190 : f64
          %192 = arith.addf %188, %191 : f64
          affine.store %192, %arg5[%arg7] : memref<?xf64>
          %193 = affine.apply #map7(%163)
          %194 = affine.load %arg5[%arg7] : memref<?xf64>
          %195 = affine.load %arg2[%arg7, %193] : memref<?x2100xf64>
          %196 = affine.load %arg3[%193] : memref<?xf64>
          %197 = arith.mulf %195, %196 : f64
          %198 = arith.addf %194, %197 : f64
          affine.store %198, %arg5[%arg7] : memref<?xf64>
          %199 = affine.apply #map8(%163)
          %200 = affine.load %arg5[%arg7] : memref<?xf64>
          %201 = affine.load %arg2[%arg7, %199] : memref<?x2100xf64>
          %202 = affine.load %arg3[%199] : memref<?xf64>
          %203 = arith.mulf %201, %202 : f64
          %204 = arith.addf %200, %203 : f64
          affine.store %204, %arg5[%arg7] : memref<?xf64>
          %205 = affine.apply #map9(%163)
          %206 = affine.load %arg5[%arg7] : memref<?xf64>
          %207 = affine.load %arg2[%arg7, %205] : memref<?x2100xf64>
          %208 = affine.load %arg3[%205] : memref<?xf64>
          %209 = arith.mulf %207, %208 : f64
          %210 = arith.addf %206, %209 : f64
          affine.store %210, %arg5[%arg7] : memref<?xf64>
          %211 = affine.apply #map10(%163)
          %212 = affine.load %arg5[%arg7] : memref<?xf64>
          %213 = affine.load %arg2[%arg7, %211] : memref<?x2100xf64>
          %214 = affine.load %arg3[%211] : memref<?xf64>
          %215 = arith.mulf %213, %214 : f64
          %216 = arith.addf %212, %215 : f64
          affine.store %216, %arg5[%arg7] : memref<?xf64>
        }
        affine.for %arg8 = #map2()[%0] to #map14()[%0] step 9 {
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
          %49 = affine.apply #map10(%arg8)
          %50 = affine.load %arg5[%arg7] : memref<?xf64>
          %51 = affine.load %arg2[%arg7, %49] : memref<?x2100xf64>
          %52 = affine.load %arg3[%49] : memref<?xf64>
          %53 = arith.mulf %51, %52 : f64
          %54 = arith.addf %50, %53 : f64
          affine.store %54, %arg5[%arg7] : memref<?xf64>
        }
        affine.for %arg8 = #map14()[%0] to #map15()[%0] step 4 {
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
        }
        affine.for %arg8 = #map15()[%0] to %0 {
          %2 = affine.load %arg5[%arg7] : memref<?xf64>
          %3 = affine.load %arg2[%arg7, %arg8] : memref<?x2100xf64>
          %4 = affine.load %arg3[%arg8] : memref<?xf64>
          %5 = arith.mulf %3, %4 : f64
          %6 = arith.addf %2, %5 : f64
          affine.store %6, %arg5[%arg7] : memref<?xf64>
        }
        affine.for %arg8 = 0 to #map2()[%0] step 36 {
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
          %49 = affine.apply #map10(%arg8)
          %50 = affine.load %arg4[%49] : memref<?xf64>
          %51 = affine.load %arg2[%arg7, %49] : memref<?x2100xf64>
          %52 = affine.load %arg5[%arg7] : memref<?xf64>
          %53 = arith.mulf %51, %52 : f64
          %54 = arith.addf %50, %53 : f64
          affine.store %54, %arg4[%49] : memref<?xf64>
          %55 = affine.apply #map11(%arg8)
          %56 = affine.load %arg4[%55] : memref<?xf64>
          %57 = affine.load %arg2[%arg7, %55] : memref<?x2100xf64>
          %58 = affine.load %arg5[%arg7] : memref<?xf64>
          %59 = arith.mulf %57, %58 : f64
          %60 = arith.addf %56, %59 : f64
          affine.store %60, %arg4[%55] : memref<?xf64>
          %61 = affine.apply #map3(%55)
          %62 = affine.load %arg4[%61] : memref<?xf64>
          %63 = affine.load %arg2[%arg7, %61] : memref<?x2100xf64>
          %64 = affine.load %arg5[%arg7] : memref<?xf64>
          %65 = arith.mulf %63, %64 : f64
          %66 = arith.addf %62, %65 : f64
          affine.store %66, %arg4[%61] : memref<?xf64>
          %67 = affine.apply #map4(%55)
          %68 = affine.load %arg4[%67] : memref<?xf64>
          %69 = affine.load %arg2[%arg7, %67] : memref<?x2100xf64>
          %70 = affine.load %arg5[%arg7] : memref<?xf64>
          %71 = arith.mulf %69, %70 : f64
          %72 = arith.addf %68, %71 : f64
          affine.store %72, %arg4[%67] : memref<?xf64>
          %73 = affine.apply #map5(%55)
          %74 = affine.load %arg4[%73] : memref<?xf64>
          %75 = affine.load %arg2[%arg7, %73] : memref<?x2100xf64>
          %76 = affine.load %arg5[%arg7] : memref<?xf64>
          %77 = arith.mulf %75, %76 : f64
          %78 = arith.addf %74, %77 : f64
          affine.store %78, %arg4[%73] : memref<?xf64>
          %79 = affine.apply #map6(%55)
          %80 = affine.load %arg4[%79] : memref<?xf64>
          %81 = affine.load %arg2[%arg7, %79] : memref<?x2100xf64>
          %82 = affine.load %arg5[%arg7] : memref<?xf64>
          %83 = arith.mulf %81, %82 : f64
          %84 = arith.addf %80, %83 : f64
          affine.store %84, %arg4[%79] : memref<?xf64>
          %85 = affine.apply #map7(%55)
          %86 = affine.load %arg4[%85] : memref<?xf64>
          %87 = affine.load %arg2[%arg7, %85] : memref<?x2100xf64>
          %88 = affine.load %arg5[%arg7] : memref<?xf64>
          %89 = arith.mulf %87, %88 : f64
          %90 = arith.addf %86, %89 : f64
          affine.store %90, %arg4[%85] : memref<?xf64>
          %91 = affine.apply #map8(%55)
          %92 = affine.load %arg4[%91] : memref<?xf64>
          %93 = affine.load %arg2[%arg7, %91] : memref<?x2100xf64>
          %94 = affine.load %arg5[%arg7] : memref<?xf64>
          %95 = arith.mulf %93, %94 : f64
          %96 = arith.addf %92, %95 : f64
          affine.store %96, %arg4[%91] : memref<?xf64>
          %97 = affine.apply #map9(%55)
          %98 = affine.load %arg4[%97] : memref<?xf64>
          %99 = affine.load %arg2[%arg7, %97] : memref<?x2100xf64>
          %100 = affine.load %arg5[%arg7] : memref<?xf64>
          %101 = arith.mulf %99, %100 : f64
          %102 = arith.addf %98, %101 : f64
          affine.store %102, %arg4[%97] : memref<?xf64>
          %103 = affine.apply #map10(%55)
          %104 = affine.load %arg4[%103] : memref<?xf64>
          %105 = affine.load %arg2[%arg7, %103] : memref<?x2100xf64>
          %106 = affine.load %arg5[%arg7] : memref<?xf64>
          %107 = arith.mulf %105, %106 : f64
          %108 = arith.addf %104, %107 : f64
          affine.store %108, %arg4[%103] : memref<?xf64>
          %109 = affine.apply #map12(%arg8)
          %110 = affine.load %arg4[%109] : memref<?xf64>
          %111 = affine.load %arg2[%arg7, %109] : memref<?x2100xf64>
          %112 = affine.load %arg5[%arg7] : memref<?xf64>
          %113 = arith.mulf %111, %112 : f64
          %114 = arith.addf %110, %113 : f64
          affine.store %114, %arg4[%109] : memref<?xf64>
          %115 = affine.apply #map3(%109)
          %116 = affine.load %arg4[%115] : memref<?xf64>
          %117 = affine.load %arg2[%arg7, %115] : memref<?x2100xf64>
          %118 = affine.load %arg5[%arg7] : memref<?xf64>
          %119 = arith.mulf %117, %118 : f64
          %120 = arith.addf %116, %119 : f64
          affine.store %120, %arg4[%115] : memref<?xf64>
          %121 = affine.apply #map4(%109)
          %122 = affine.load %arg4[%121] : memref<?xf64>
          %123 = affine.load %arg2[%arg7, %121] : memref<?x2100xf64>
          %124 = affine.load %arg5[%arg7] : memref<?xf64>
          %125 = arith.mulf %123, %124 : f64
          %126 = arith.addf %122, %125 : f64
          affine.store %126, %arg4[%121] : memref<?xf64>
          %127 = affine.apply #map5(%109)
          %128 = affine.load %arg4[%127] : memref<?xf64>
          %129 = affine.load %arg2[%arg7, %127] : memref<?x2100xf64>
          %130 = affine.load %arg5[%arg7] : memref<?xf64>
          %131 = arith.mulf %129, %130 : f64
          %132 = arith.addf %128, %131 : f64
          affine.store %132, %arg4[%127] : memref<?xf64>
          %133 = affine.apply #map6(%109)
          %134 = affine.load %arg4[%133] : memref<?xf64>
          %135 = affine.load %arg2[%arg7, %133] : memref<?x2100xf64>
          %136 = affine.load %arg5[%arg7] : memref<?xf64>
          %137 = arith.mulf %135, %136 : f64
          %138 = arith.addf %134, %137 : f64
          affine.store %138, %arg4[%133] : memref<?xf64>
          %139 = affine.apply #map7(%109)
          %140 = affine.load %arg4[%139] : memref<?xf64>
          %141 = affine.load %arg2[%arg7, %139] : memref<?x2100xf64>
          %142 = affine.load %arg5[%arg7] : memref<?xf64>
          %143 = arith.mulf %141, %142 : f64
          %144 = arith.addf %140, %143 : f64
          affine.store %144, %arg4[%139] : memref<?xf64>
          %145 = affine.apply #map8(%109)
          %146 = affine.load %arg4[%145] : memref<?xf64>
          %147 = affine.load %arg2[%arg7, %145] : memref<?x2100xf64>
          %148 = affine.load %arg5[%arg7] : memref<?xf64>
          %149 = arith.mulf %147, %148 : f64
          %150 = arith.addf %146, %149 : f64
          affine.store %150, %arg4[%145] : memref<?xf64>
          %151 = affine.apply #map9(%109)
          %152 = affine.load %arg4[%151] : memref<?xf64>
          %153 = affine.load %arg2[%arg7, %151] : memref<?x2100xf64>
          %154 = affine.load %arg5[%arg7] : memref<?xf64>
          %155 = arith.mulf %153, %154 : f64
          %156 = arith.addf %152, %155 : f64
          affine.store %156, %arg4[%151] : memref<?xf64>
          %157 = affine.apply #map10(%109)
          %158 = affine.load %arg4[%157] : memref<?xf64>
          %159 = affine.load %arg2[%arg7, %157] : memref<?x2100xf64>
          %160 = affine.load %arg5[%arg7] : memref<?xf64>
          %161 = arith.mulf %159, %160 : f64
          %162 = arith.addf %158, %161 : f64
          affine.store %162, %arg4[%157] : memref<?xf64>
          %163 = affine.apply #map13(%arg8)
          %164 = affine.load %arg4[%163] : memref<?xf64>
          %165 = affine.load %arg2[%arg7, %163] : memref<?x2100xf64>
          %166 = affine.load %arg5[%arg7] : memref<?xf64>
          %167 = arith.mulf %165, %166 : f64
          %168 = arith.addf %164, %167 : f64
          affine.store %168, %arg4[%163] : memref<?xf64>
          %169 = affine.apply #map3(%163)
          %170 = affine.load %arg4[%169] : memref<?xf64>
          %171 = affine.load %arg2[%arg7, %169] : memref<?x2100xf64>
          %172 = affine.load %arg5[%arg7] : memref<?xf64>
          %173 = arith.mulf %171, %172 : f64
          %174 = arith.addf %170, %173 : f64
          affine.store %174, %arg4[%169] : memref<?xf64>
          %175 = affine.apply #map4(%163)
          %176 = affine.load %arg4[%175] : memref<?xf64>
          %177 = affine.load %arg2[%arg7, %175] : memref<?x2100xf64>
          %178 = affine.load %arg5[%arg7] : memref<?xf64>
          %179 = arith.mulf %177, %178 : f64
          %180 = arith.addf %176, %179 : f64
          affine.store %180, %arg4[%175] : memref<?xf64>
          %181 = affine.apply #map5(%163)
          %182 = affine.load %arg4[%181] : memref<?xf64>
          %183 = affine.load %arg2[%arg7, %181] : memref<?x2100xf64>
          %184 = affine.load %arg5[%arg7] : memref<?xf64>
          %185 = arith.mulf %183, %184 : f64
          %186 = arith.addf %182, %185 : f64
          affine.store %186, %arg4[%181] : memref<?xf64>
          %187 = affine.apply #map6(%163)
          %188 = affine.load %arg4[%187] : memref<?xf64>
          %189 = affine.load %arg2[%arg7, %187] : memref<?x2100xf64>
          %190 = affine.load %arg5[%arg7] : memref<?xf64>
          %191 = arith.mulf %189, %190 : f64
          %192 = arith.addf %188, %191 : f64
          affine.store %192, %arg4[%187] : memref<?xf64>
          %193 = affine.apply #map7(%163)
          %194 = affine.load %arg4[%193] : memref<?xf64>
          %195 = affine.load %arg2[%arg7, %193] : memref<?x2100xf64>
          %196 = affine.load %arg5[%arg7] : memref<?xf64>
          %197 = arith.mulf %195, %196 : f64
          %198 = arith.addf %194, %197 : f64
          affine.store %198, %arg4[%193] : memref<?xf64>
          %199 = affine.apply #map8(%163)
          %200 = affine.load %arg4[%199] : memref<?xf64>
          %201 = affine.load %arg2[%arg7, %199] : memref<?x2100xf64>
          %202 = affine.load %arg5[%arg7] : memref<?xf64>
          %203 = arith.mulf %201, %202 : f64
          %204 = arith.addf %200, %203 : f64
          affine.store %204, %arg4[%199] : memref<?xf64>
          %205 = affine.apply #map9(%163)
          %206 = affine.load %arg4[%205] : memref<?xf64>
          %207 = affine.load %arg2[%arg7, %205] : memref<?x2100xf64>
          %208 = affine.load %arg5[%arg7] : memref<?xf64>
          %209 = arith.mulf %207, %208 : f64
          %210 = arith.addf %206, %209 : f64
          affine.store %210, %arg4[%205] : memref<?xf64>
          %211 = affine.apply #map10(%163)
          %212 = affine.load %arg4[%211] : memref<?xf64>
          %213 = affine.load %arg2[%arg7, %211] : memref<?x2100xf64>
          %214 = affine.load %arg5[%arg7] : memref<?xf64>
          %215 = arith.mulf %213, %214 : f64
          %216 = arith.addf %212, %215 : f64
          affine.store %216, %arg4[%211] : memref<?xf64>
        }
        affine.for %arg8 = #map2()[%0] to #map14()[%0] step 9 {
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
          %49 = affine.apply #map10(%arg8)
          %50 = affine.load %arg4[%49] : memref<?xf64>
          %51 = affine.load %arg2[%arg7, %49] : memref<?x2100xf64>
          %52 = affine.load %arg5[%arg7] : memref<?xf64>
          %53 = arith.mulf %51, %52 : f64
          %54 = arith.addf %50, %53 : f64
          affine.store %54, %arg4[%49] : memref<?xf64>
        }
        affine.for %arg8 = #map14()[%0] to #map15()[%0] step 4 {
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
        }
        affine.for %arg8 = #map15()[%0] to %0 {
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

