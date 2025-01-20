; ModuleID = 'C:/fpga/simon/all_in_one/all_in_one/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

; Function Attrs: noinline willreturn
define void @apatb_systolic_top_uart_4parallel_ir(i1 zeroext %opcode_in0, i1 zeroext %opcode_in1, i1 zeroext %opcode_in2, i1 zeroext %opcode_in3, i1 zeroext %start_in, i1 zeroext %tx_in, i1 zeroext %clk_in, i1 zeroext %rst_in, i1* noalias nocapture nonnull dereferenceable(1) %done_out, i1* noalias nocapture nonnull dereferenceable(1) %busy_out, i1* noalias nocapture nonnull dereferenceable(1) %rx_out, i1* noalias nocapture nonnull dereferenceable(1) %out4, i1* noalias nocapture nonnull dereferenceable(1) %out5, i1* noalias nocapture nonnull dereferenceable(1) %out6, i1* noalias nocapture nonnull dereferenceable(1) %out7, i1* noalias nocapture nonnull dereferenceable(1) %out8) local_unnamed_addr #0 {
entry:
  %done_out_copy = alloca i1, align 512
  %busy_out_copy = alloca i1, align 512
  %rx_out_copy = alloca i1, align 512
  %out4_copy = alloca i1, align 512
  %out5_copy = alloca i1, align 512
  %out6_copy = alloca i1, align 512
  %out7_copy = alloca i1, align 512
  %out8_copy = alloca i1, align 512
  call fastcc void @copy_in(i1* nonnull %done_out, i1* nonnull align 512 %done_out_copy, i1* nonnull %busy_out, i1* nonnull align 512 %busy_out_copy, i1* nonnull %rx_out, i1* nonnull align 512 %rx_out_copy, i1* nonnull %out4, i1* nonnull align 512 %out4_copy, i1* nonnull %out5, i1* nonnull align 512 %out5_copy, i1* nonnull %out6, i1* nonnull align 512 %out6_copy, i1* nonnull %out7, i1* nonnull align 512 %out7_copy, i1* nonnull %out8, i1* nonnull align 512 %out8_copy)
  call void @apatb_systolic_top_uart_4parallel_hw(i1 %opcode_in0, i1 %opcode_in1, i1 %opcode_in2, i1 %opcode_in3, i1 %start_in, i1 %tx_in, i1 %clk_in, i1 %rst_in, i1* %done_out_copy, i1* %busy_out_copy, i1* %rx_out_copy, i1* %out4_copy, i1* %out5_copy, i1* %out6_copy, i1* %out7_copy, i1* %out8_copy)
  call void @copy_back(i1* %done_out, i1* %done_out_copy, i1* %busy_out, i1* %busy_out_copy, i1* %rx_out, i1* %rx_out_copy, i1* %out4, i1* %out4_copy, i1* %out5, i1* %out5_copy, i1* %out6, i1* %out6_copy, i1* %out7, i1* %out7_copy, i1* %out8, i1* %out8_copy)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_in(i1* noalias readonly, i1* noalias align 512, i1* noalias readonly, i1* noalias align 512, i1* noalias readonly, i1* noalias align 512, i1* noalias readonly, i1* noalias align 512, i1* noalias readonly, i1* noalias align 512, i1* noalias readonly, i1* noalias align 512, i1* noalias readonly, i1* noalias align 512, i1* noalias readonly, i1* noalias align 512) unnamed_addr #1 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %1, i1* %0)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %3, i1* %2)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %5, i1* %4)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %7, i1* %6)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %9, i1* %8)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %11, i1* %10)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %13, i1* %12)
  call fastcc void @onebyonecpy_hls.p0i1(i1* align 512 %15, i1* %14)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0i1(i1* noalias align 512 %dst, i1* noalias readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq i1* %dst, null
  %1 = icmp eq i1* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %3 = bitcast i1* %src to i8*
  %4 = load i8, i8* %3
  %5 = trunc i8 %4 to i1
  store i1 %5, i1* %dst, align 512
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_out(i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512) unnamed_addr #3 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* %0, i1* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %2, i1* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %4, i1* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %6, i1* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %8, i1* align 512 %9)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %10, i1* align 512 %11)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %12, i1* align 512 %13)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %14, i1* align 512 %15)
  ret void
}

declare void @apatb_systolic_top_uart_4parallel_hw(i1, i1, i1, i1, i1, i1, i1, i1, i1*, i1*, i1*, i1*, i1*, i1*, i1*, i1*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_back(i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512, i1* noalias, i1* noalias readonly align 512) unnamed_addr #3 {
entry:
  call fastcc void @onebyonecpy_hls.p0i1(i1* %0, i1* align 512 %1)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %2, i1* align 512 %3)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %4, i1* align 512 %5)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %6, i1* align 512 %7)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %8, i1* align 512 %9)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %10, i1* align 512 %11)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %12, i1* align 512 %13)
  call fastcc void @onebyonecpy_hls.p0i1(i1* %14, i1* align 512 %15)
  ret void
}

declare void @systolic_top_uart_4parallel_hw_stub(i1 zeroext, i1 zeroext, i1 zeroext, i1 zeroext, i1 zeroext, i1 zeroext, i1 zeroext, i1 zeroext, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull, i1* noalias nocapture nonnull)

define void @systolic_top_uart_4parallel_hw_stub_wrapper(i1, i1, i1, i1, i1, i1, i1, i1, i1*, i1*, i1*, i1*, i1*, i1*, i1*, i1*) #4 {
entry:
  call void @copy_out(i1* null, i1* %8, i1* null, i1* %9, i1* null, i1* %10, i1* null, i1* %11, i1* null, i1* %12, i1* null, i1* %13, i1* null, i1* %14, i1* null, i1* %15)
  call void @systolic_top_uart_4parallel_hw_stub(i1 %0, i1 %1, i1 %2, i1 %3, i1 %4, i1 %5, i1 %6, i1 %7, i1* %8, i1* %9, i1* %10, i1* %11, i1* %12, i1* %13, i1* %14, i1* %15)
  call void @copy_in(i1* null, i1* %8, i1* null, i1* %9, i1* null, i1* %10, i1* null, i1* %11, i1* null, i1* %12, i1* null, i1* %13, i1* null, i1* %14, i1* null, i1* %15)
  ret void
}

attributes #0 = { noinline willreturn "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
attributes #4 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
