#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0)[s0] -> (d0 + 40, s0)>
#map2 = affine_map<(d0) -> (d0 + 1)>
#map3 = affine_map<(d0)[s0] -> (d0 + (((-d0 + s0 - 1) floordiv 12) floordiv 3) * 36 + 1)>
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
#map15 = affine_map<(d0) -> (d0 + 24)>
#map16 = affine_map<(d0)[s0] -> (d0 + ((-d0 + s0 - 1) floordiv 12) * 12 + 1)>
#map17 = affine_map<(d0)[s0] -> (d0 + ((-d0 + s0 - 1) floordiv 12) * 12 + ((-d0 + s0 - ((-d0 + s0 - 1) floordiv 12) * 12 - 1) floordiv 3) * 3 + 1)>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kernel_trmm(%arg0: i32, %arg1: i32, %arg2: f64, %arg3: memref<?x1000xf64>, %arg4: memref<?x1200xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg0 : i32 to index
    affine.for %arg5 = 0 to %1 step 40 {
      affine.for %arg6 = 0 to %0 step 40 {
        affine.for %arg7 = #map(%arg5) to min #map1(%arg5)[%1] {
          affine.for %arg8 = #map(%arg6) to min #map1(%arg6)[%0] {
            affine.for %arg9 = #map2(%arg7) to #map3(%arg7)[%1] step 36 {
              %4 = affine.load %arg3[%arg9, %arg7] : memref<?x1000xf64>
              %5 = affine.load %arg4[%arg9, %arg8] : memref<?x1200xf64>
              %6 = arith.mulf %4, %5 : f64
              %7 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %8 = arith.addf %7, %6 : f64
              affine.store %8, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %9 = affine.apply #map2(%arg9)
              %10 = affine.load %arg3[%9, %arg7] : memref<?x1000xf64>
              %11 = affine.load %arg4[%9, %arg8] : memref<?x1200xf64>
              %12 = arith.mulf %10, %11 : f64
              %13 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %14 = arith.addf %13, %12 : f64
              affine.store %14, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %15 = affine.apply #map4(%arg9)
              %16 = affine.load %arg3[%15, %arg7] : memref<?x1000xf64>
              %17 = affine.load %arg4[%15, %arg8] : memref<?x1200xf64>
              %18 = arith.mulf %16, %17 : f64
              %19 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %20 = arith.addf %19, %18 : f64
              affine.store %20, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %21 = affine.apply #map5(%arg9)
              %22 = affine.load %arg3[%21, %arg7] : memref<?x1000xf64>
              %23 = affine.load %arg4[%21, %arg8] : memref<?x1200xf64>
              %24 = arith.mulf %22, %23 : f64
              %25 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %26 = arith.addf %25, %24 : f64
              affine.store %26, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %27 = affine.apply #map6(%arg9)
              %28 = affine.load %arg3[%27, %arg7] : memref<?x1000xf64>
              %29 = affine.load %arg4[%27, %arg8] : memref<?x1200xf64>
              %30 = arith.mulf %28, %29 : f64
              %31 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %32 = arith.addf %31, %30 : f64
              affine.store %32, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %33 = affine.apply #map7(%arg9)
              %34 = affine.load %arg3[%33, %arg7] : memref<?x1000xf64>
              %35 = affine.load %arg4[%33, %arg8] : memref<?x1200xf64>
              %36 = arith.mulf %34, %35 : f64
              %37 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %38 = arith.addf %37, %36 : f64
              affine.store %38, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %39 = affine.apply #map8(%arg9)
              %40 = affine.load %arg3[%39, %arg7] : memref<?x1000xf64>
              %41 = affine.load %arg4[%39, %arg8] : memref<?x1200xf64>
              %42 = arith.mulf %40, %41 : f64
              %43 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %44 = arith.addf %43, %42 : f64
              affine.store %44, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %45 = affine.apply #map9(%arg9)
              %46 = affine.load %arg3[%45, %arg7] : memref<?x1000xf64>
              %47 = affine.load %arg4[%45, %arg8] : memref<?x1200xf64>
              %48 = arith.mulf %46, %47 : f64
              %49 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %50 = arith.addf %49, %48 : f64
              affine.store %50, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %51 = affine.apply #map10(%arg9)
              %52 = affine.load %arg3[%51, %arg7] : memref<?x1000xf64>
              %53 = affine.load %arg4[%51, %arg8] : memref<?x1200xf64>
              %54 = arith.mulf %52, %53 : f64
              %55 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %56 = arith.addf %55, %54 : f64
              affine.store %56, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %57 = affine.apply #map11(%arg9)
              %58 = affine.load %arg3[%57, %arg7] : memref<?x1000xf64>
              %59 = affine.load %arg4[%57, %arg8] : memref<?x1200xf64>
              %60 = arith.mulf %58, %59 : f64
              %61 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %62 = arith.addf %61, %60 : f64
              affine.store %62, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %63 = affine.apply #map12(%arg9)
              %64 = affine.load %arg3[%63, %arg7] : memref<?x1000xf64>
              %65 = affine.load %arg4[%63, %arg8] : memref<?x1200xf64>
              %66 = arith.mulf %64, %65 : f64
              %67 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %68 = arith.addf %67, %66 : f64
              affine.store %68, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %69 = affine.apply #map13(%arg9)
              %70 = affine.load %arg3[%69, %arg7] : memref<?x1000xf64>
              %71 = affine.load %arg4[%69, %arg8] : memref<?x1200xf64>
              %72 = arith.mulf %70, %71 : f64
              %73 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %74 = arith.addf %73, %72 : f64
              affine.store %74, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %75 = affine.apply #map14(%arg9)
              %76 = affine.load %arg3[%75, %arg7] : memref<?x1000xf64>
              %77 = affine.load %arg4[%75, %arg8] : memref<?x1200xf64>
              %78 = arith.mulf %76, %77 : f64
              %79 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %80 = arith.addf %79, %78 : f64
              affine.store %80, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %81 = affine.apply #map2(%75)
              %82 = affine.load %arg3[%81, %arg7] : memref<?x1000xf64>
              %83 = affine.load %arg4[%81, %arg8] : memref<?x1200xf64>
              %84 = arith.mulf %82, %83 : f64
              %85 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %86 = arith.addf %85, %84 : f64
              affine.store %86, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %87 = affine.apply #map4(%75)
              %88 = affine.load %arg3[%87, %arg7] : memref<?x1000xf64>
              %89 = affine.load %arg4[%87, %arg8] : memref<?x1200xf64>
              %90 = arith.mulf %88, %89 : f64
              %91 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %92 = arith.addf %91, %90 : f64
              affine.store %92, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %93 = affine.apply #map5(%75)
              %94 = affine.load %arg3[%93, %arg7] : memref<?x1000xf64>
              %95 = affine.load %arg4[%93, %arg8] : memref<?x1200xf64>
              %96 = arith.mulf %94, %95 : f64
              %97 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %98 = arith.addf %97, %96 : f64
              affine.store %98, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %99 = affine.apply #map6(%75)
              %100 = affine.load %arg3[%99, %arg7] : memref<?x1000xf64>
              %101 = affine.load %arg4[%99, %arg8] : memref<?x1200xf64>
              %102 = arith.mulf %100, %101 : f64
              %103 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %104 = arith.addf %103, %102 : f64
              affine.store %104, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %105 = affine.apply #map7(%75)
              %106 = affine.load %arg3[%105, %arg7] : memref<?x1000xf64>
              %107 = affine.load %arg4[%105, %arg8] : memref<?x1200xf64>
              %108 = arith.mulf %106, %107 : f64
              %109 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %110 = arith.addf %109, %108 : f64
              affine.store %110, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %111 = affine.apply #map8(%75)
              %112 = affine.load %arg3[%111, %arg7] : memref<?x1000xf64>
              %113 = affine.load %arg4[%111, %arg8] : memref<?x1200xf64>
              %114 = arith.mulf %112, %113 : f64
              %115 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %116 = arith.addf %115, %114 : f64
              affine.store %116, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %117 = affine.apply #map9(%75)
              %118 = affine.load %arg3[%117, %arg7] : memref<?x1000xf64>
              %119 = affine.load %arg4[%117, %arg8] : memref<?x1200xf64>
              %120 = arith.mulf %118, %119 : f64
              %121 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %122 = arith.addf %121, %120 : f64
              affine.store %122, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %123 = affine.apply #map10(%75)
              %124 = affine.load %arg3[%123, %arg7] : memref<?x1000xf64>
              %125 = affine.load %arg4[%123, %arg8] : memref<?x1200xf64>
              %126 = arith.mulf %124, %125 : f64
              %127 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %128 = arith.addf %127, %126 : f64
              affine.store %128, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %129 = affine.apply #map11(%75)
              %130 = affine.load %arg3[%129, %arg7] : memref<?x1000xf64>
              %131 = affine.load %arg4[%129, %arg8] : memref<?x1200xf64>
              %132 = arith.mulf %130, %131 : f64
              %133 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %134 = arith.addf %133, %132 : f64
              affine.store %134, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %135 = affine.apply #map12(%75)
              %136 = affine.load %arg3[%135, %arg7] : memref<?x1000xf64>
              %137 = affine.load %arg4[%135, %arg8] : memref<?x1200xf64>
              %138 = arith.mulf %136, %137 : f64
              %139 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %140 = arith.addf %139, %138 : f64
              affine.store %140, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %141 = affine.apply #map13(%75)
              %142 = affine.load %arg3[%141, %arg7] : memref<?x1000xf64>
              %143 = affine.load %arg4[%141, %arg8] : memref<?x1200xf64>
              %144 = arith.mulf %142, %143 : f64
              %145 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %146 = arith.addf %145, %144 : f64
              affine.store %146, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %147 = affine.apply #map15(%arg9)
              %148 = affine.load %arg3[%147, %arg7] : memref<?x1000xf64>
              %149 = affine.load %arg4[%147, %arg8] : memref<?x1200xf64>
              %150 = arith.mulf %148, %149 : f64
              %151 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %152 = arith.addf %151, %150 : f64
              affine.store %152, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %153 = affine.apply #map2(%147)
              %154 = affine.load %arg3[%153, %arg7] : memref<?x1000xf64>
              %155 = affine.load %arg4[%153, %arg8] : memref<?x1200xf64>
              %156 = arith.mulf %154, %155 : f64
              %157 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %158 = arith.addf %157, %156 : f64
              affine.store %158, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %159 = affine.apply #map4(%147)
              %160 = affine.load %arg3[%159, %arg7] : memref<?x1000xf64>
              %161 = affine.load %arg4[%159, %arg8] : memref<?x1200xf64>
              %162 = arith.mulf %160, %161 : f64
              %163 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %164 = arith.addf %163, %162 : f64
              affine.store %164, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %165 = affine.apply #map5(%147)
              %166 = affine.load %arg3[%165, %arg7] : memref<?x1000xf64>
              %167 = affine.load %arg4[%165, %arg8] : memref<?x1200xf64>
              %168 = arith.mulf %166, %167 : f64
              %169 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %170 = arith.addf %169, %168 : f64
              affine.store %170, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %171 = affine.apply #map6(%147)
              %172 = affine.load %arg3[%171, %arg7] : memref<?x1000xf64>
              %173 = affine.load %arg4[%171, %arg8] : memref<?x1200xf64>
              %174 = arith.mulf %172, %173 : f64
              %175 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %176 = arith.addf %175, %174 : f64
              affine.store %176, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %177 = affine.apply #map7(%147)
              %178 = affine.load %arg3[%177, %arg7] : memref<?x1000xf64>
              %179 = affine.load %arg4[%177, %arg8] : memref<?x1200xf64>
              %180 = arith.mulf %178, %179 : f64
              %181 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %182 = arith.addf %181, %180 : f64
              affine.store %182, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %183 = affine.apply #map8(%147)
              %184 = affine.load %arg3[%183, %arg7] : memref<?x1000xf64>
              %185 = affine.load %arg4[%183, %arg8] : memref<?x1200xf64>
              %186 = arith.mulf %184, %185 : f64
              %187 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %188 = arith.addf %187, %186 : f64
              affine.store %188, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %189 = affine.apply #map9(%147)
              %190 = affine.load %arg3[%189, %arg7] : memref<?x1000xf64>
              %191 = affine.load %arg4[%189, %arg8] : memref<?x1200xf64>
              %192 = arith.mulf %190, %191 : f64
              %193 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %194 = arith.addf %193, %192 : f64
              affine.store %194, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %195 = affine.apply #map10(%147)
              %196 = affine.load %arg3[%195, %arg7] : memref<?x1000xf64>
              %197 = affine.load %arg4[%195, %arg8] : memref<?x1200xf64>
              %198 = arith.mulf %196, %197 : f64
              %199 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %200 = arith.addf %199, %198 : f64
              affine.store %200, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %201 = affine.apply #map11(%147)
              %202 = affine.load %arg3[%201, %arg7] : memref<?x1000xf64>
              %203 = affine.load %arg4[%201, %arg8] : memref<?x1200xf64>
              %204 = arith.mulf %202, %203 : f64
              %205 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %206 = arith.addf %205, %204 : f64
              affine.store %206, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %207 = affine.apply #map12(%147)
              %208 = affine.load %arg3[%207, %arg7] : memref<?x1000xf64>
              %209 = affine.load %arg4[%207, %arg8] : memref<?x1200xf64>
              %210 = arith.mulf %208, %209 : f64
              %211 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %212 = arith.addf %211, %210 : f64
              affine.store %212, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %213 = affine.apply #map13(%147)
              %214 = affine.load %arg3[%213, %arg7] : memref<?x1000xf64>
              %215 = affine.load %arg4[%213, %arg8] : memref<?x1200xf64>
              %216 = arith.mulf %214, %215 : f64
              %217 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %218 = arith.addf %217, %216 : f64
              affine.store %218, %arg4[%arg7, %arg8] : memref<?x1200xf64>
            }
            affine.for %arg9 = #map3(%arg7)[%1] to #map16(%arg7)[%1] step 12 {
              %4 = affine.load %arg3[%arg9, %arg7] : memref<?x1000xf64>
              %5 = affine.load %arg4[%arg9, %arg8] : memref<?x1200xf64>
              %6 = arith.mulf %4, %5 : f64
              %7 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %8 = arith.addf %7, %6 : f64
              affine.store %8, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %9 = affine.apply #map2(%arg9)
              %10 = affine.load %arg3[%9, %arg7] : memref<?x1000xf64>
              %11 = affine.load %arg4[%9, %arg8] : memref<?x1200xf64>
              %12 = arith.mulf %10, %11 : f64
              %13 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %14 = arith.addf %13, %12 : f64
              affine.store %14, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %15 = affine.apply #map4(%arg9)
              %16 = affine.load %arg3[%15, %arg7] : memref<?x1000xf64>
              %17 = affine.load %arg4[%15, %arg8] : memref<?x1200xf64>
              %18 = arith.mulf %16, %17 : f64
              %19 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %20 = arith.addf %19, %18 : f64
              affine.store %20, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %21 = affine.apply #map5(%arg9)
              %22 = affine.load %arg3[%21, %arg7] : memref<?x1000xf64>
              %23 = affine.load %arg4[%21, %arg8] : memref<?x1200xf64>
              %24 = arith.mulf %22, %23 : f64
              %25 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %26 = arith.addf %25, %24 : f64
              affine.store %26, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %27 = affine.apply #map6(%arg9)
              %28 = affine.load %arg3[%27, %arg7] : memref<?x1000xf64>
              %29 = affine.load %arg4[%27, %arg8] : memref<?x1200xf64>
              %30 = arith.mulf %28, %29 : f64
              %31 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %32 = arith.addf %31, %30 : f64
              affine.store %32, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %33 = affine.apply #map7(%arg9)
              %34 = affine.load %arg3[%33, %arg7] : memref<?x1000xf64>
              %35 = affine.load %arg4[%33, %arg8] : memref<?x1200xf64>
              %36 = arith.mulf %34, %35 : f64
              %37 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %38 = arith.addf %37, %36 : f64
              affine.store %38, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %39 = affine.apply #map8(%arg9)
              %40 = affine.load %arg3[%39, %arg7] : memref<?x1000xf64>
              %41 = affine.load %arg4[%39, %arg8] : memref<?x1200xf64>
              %42 = arith.mulf %40, %41 : f64
              %43 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %44 = arith.addf %43, %42 : f64
              affine.store %44, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %45 = affine.apply #map9(%arg9)
              %46 = affine.load %arg3[%45, %arg7] : memref<?x1000xf64>
              %47 = affine.load %arg4[%45, %arg8] : memref<?x1200xf64>
              %48 = arith.mulf %46, %47 : f64
              %49 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %50 = arith.addf %49, %48 : f64
              affine.store %50, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %51 = affine.apply #map10(%arg9)
              %52 = affine.load %arg3[%51, %arg7] : memref<?x1000xf64>
              %53 = affine.load %arg4[%51, %arg8] : memref<?x1200xf64>
              %54 = arith.mulf %52, %53 : f64
              %55 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %56 = arith.addf %55, %54 : f64
              affine.store %56, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %57 = affine.apply #map11(%arg9)
              %58 = affine.load %arg3[%57, %arg7] : memref<?x1000xf64>
              %59 = affine.load %arg4[%57, %arg8] : memref<?x1200xf64>
              %60 = arith.mulf %58, %59 : f64
              %61 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %62 = arith.addf %61, %60 : f64
              affine.store %62, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %63 = affine.apply #map12(%arg9)
              %64 = affine.load %arg3[%63, %arg7] : memref<?x1000xf64>
              %65 = affine.load %arg4[%63, %arg8] : memref<?x1200xf64>
              %66 = arith.mulf %64, %65 : f64
              %67 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %68 = arith.addf %67, %66 : f64
              affine.store %68, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %69 = affine.apply #map13(%arg9)
              %70 = affine.load %arg3[%69, %arg7] : memref<?x1000xf64>
              %71 = affine.load %arg4[%69, %arg8] : memref<?x1200xf64>
              %72 = arith.mulf %70, %71 : f64
              %73 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %74 = arith.addf %73, %72 : f64
              affine.store %74, %arg4[%arg7, %arg8] : memref<?x1200xf64>
            }
            affine.for %arg9 = #map16(%arg7)[%1] to #map17(%arg7)[%1] step 3 {
              %4 = affine.load %arg3[%arg9, %arg7] : memref<?x1000xf64>
              %5 = affine.load %arg4[%arg9, %arg8] : memref<?x1200xf64>
              %6 = arith.mulf %4, %5 : f64
              %7 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %8 = arith.addf %7, %6 : f64
              affine.store %8, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %9 = affine.apply #map2(%arg9)
              %10 = affine.load %arg3[%9, %arg7] : memref<?x1000xf64>
              %11 = affine.load %arg4[%9, %arg8] : memref<?x1200xf64>
              %12 = arith.mulf %10, %11 : f64
              %13 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %14 = arith.addf %13, %12 : f64
              affine.store %14, %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %15 = affine.apply #map4(%arg9)
              %16 = affine.load %arg3[%15, %arg7] : memref<?x1000xf64>
              %17 = affine.load %arg4[%15, %arg8] : memref<?x1200xf64>
              %18 = arith.mulf %16, %17 : f64
              %19 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %20 = arith.addf %19, %18 : f64
              affine.store %20, %arg4[%arg7, %arg8] : memref<?x1200xf64>
            }
            affine.for %arg9 = #map17(%arg7)[%1] to %1 {
              %4 = affine.load %arg3[%arg9, %arg7] : memref<?x1000xf64>
              %5 = affine.load %arg4[%arg9, %arg8] : memref<?x1200xf64>
              %6 = arith.mulf %4, %5 : f64
              %7 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
              %8 = arith.addf %7, %6 : f64
              affine.store %8, %arg4[%arg7, %arg8] : memref<?x1200xf64>
            }
            %2 = affine.load %arg4[%arg7, %arg8] : memref<?x1200xf64>
            %3 = arith.mulf %arg2, %2 : f64
            affine.store %3, %arg4[%arg7, %arg8] : memref<?x1200xf64>
          }
        }
      }
    }
    return
  }
}

