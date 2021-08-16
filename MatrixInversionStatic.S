# 1 "MatrixInversion.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "MatrixInversion.S"
 .file "MatrixInversion.c"
 .text
 .p2align 4,,15
 .globl fixedToFloat
 .type fixedToFloat, @function
fixedToFloat:
.LFB63:
 .cfi_startproc
 pxor %xmm0, %xmm0
 movq %rdi, %rax
 sarq $32, %rax
 pxor %xmm1, %xmm1
 movl %edi, %ecx
 cvtsi2sd %eax, %xmm0
 movl $1, %eax
 sall %cl, %eax
 cvtsi2sd %eax, %xmm1
 divsd %xmm1, %xmm0
 ret
 .cfi_endproc
.LFE63:
 .size fixedToFloat, .-fixedToFloat
 .p2align 4,,15
 .globl floatToFixed
 .type floatToFixed, @function
floatToFixed:
.LFB64:
 .cfi_startproc
 ucomisd .LC0(%rip), %xmm0
 jp .L7
 jne .L7
 xorl %eax, %eax
 ret
 .p2align 4,,10
 .p2align 3
.L7:
 mulsd .LC1(%rip), %xmm0
 cvttsd2si %xmm0, %eax
 salq $32, %rax
 orq $11, %rax
 ret
 .cfi_endproc
.LFE64:
 .size floatToFixed, .-floatToFixed
 .section .rodata.str1.1,"aMS",@progbits,1
.LC2:
 .string "%f %f %f %f "
 .text
 .p2align 4,,15
 .globl printMatrix
 .type printMatrix, @function
printMatrix:
.LFB65:
 .cfi_startproc
 pushq %r13
 .cfi_def_cfa_offset 16
 .cfi_offset 13, -16
 pushq %r12
 .cfi_def_cfa_offset 24
 .cfi_offset 12, -24
 leaq 160(%rdi), %r12
 pushq %rbp
 .cfi_def_cfa_offset 32
 .cfi_offset 6, -32
 pushq %rbx
 .cfi_def_cfa_offset 40
 .cfi_offset 3, -40
 movq %rdi, %r13
 movl $1, %ebp
 subq $8, %rsp
 .cfi_def_cfa_offset 48
 .p2align 4,,10
 .p2align 3
.L10:
 movl $24, %ebx
.L11:
 movq 0(%r13), %rax
 pxor %xmm3, %xmm3
 pxor %xmm6, %xmm6
 pxor %xmm5, %xmm5
 leaq (%rax,%rbx), %rcx
 leaq -8(%rax,%rbx), %rdi
 leaq -16(%rax,%rbx), %rsi
 leaq -24(%rax,%rbx), %rdx
 movl %ebp, %eax
 addq $32, %rbx
 cvtsi2sd 4(%rcx), %xmm3
 movl (%rcx), %ecx
 pxor %xmm4, %xmm4
 pxor %xmm7, %xmm7
 pxor %xmm2, %xmm2
 sall %cl, %eax
 movl (%rdi), %ecx
 cvtsi2sd %eax, %xmm6
 movl %ebp, %eax
 pxor %xmm1, %xmm1
 cvtsi2sd 4(%rdi), %xmm2
 movl $1, %edi
 sall %cl, %eax
 movl (%rsi), %ecx
 cvtsi2sd %eax, %xmm5
 movl %ebp, %eax
 pxor %xmm0, %xmm0
 cvtsi2sd 4(%rsi), %xmm1
 leaq .LC2(%rip), %rsi
 sall %cl, %eax
 movl (%rdx), %ecx
 cvtsi2sd %eax, %xmm4
 movl %ebp, %eax
 cvtsi2sd 4(%rdx), %xmm0
 sall %cl, %eax
 cvtsi2sd %eax, %xmm7
 movl $4, %eax
 divsd %xmm6, %xmm3
 divsd %xmm7, %xmm0
 divsd %xmm5, %xmm2
 divsd %xmm4, %xmm1
 call __printf_chk@PLT
 cmpq $184, %rbx
 jne .L11
 movl $10, %edi
 addq $8, %r13
 call putchar@PLT
 cmpq %r13, %r12
 jne .L10
 addq $8, %rsp
 .cfi_def_cfa_offset 40
 popq %rbx
 .cfi_def_cfa_offset 32
 popq %rbp
 .cfi_def_cfa_offset 24
 popq %r12
 .cfi_def_cfa_offset 16
 popq %r13
 .cfi_def_cfa_offset 8
 ret
 .cfi_endproc
.LFE65:
 .size printMatrix, .-printMatrix
 .section .rodata.str1.1
.LC3:
 .string "Error! Could not open file"
.LC4:
 .string " "
.LC5:
 .string " Null token"
 .text
 .p2align 4,,15
 .globl buildMatrix
 .type buildMatrix, @function
buildMatrix:
.LFB66:
 .cfi_startproc
 pushq %r15
 .cfi_def_cfa_offset 16
 .cfi_offset 15, -16
 pushq %r14
 .cfi_def_cfa_offset 24
 .cfi_offset 14, -24
 pushq %r13
 .cfi_def_cfa_offset 32
 .cfi_offset 13, -32
 pushq %r12
 .cfi_def_cfa_offset 40
 .cfi_offset 12, -40
 pushq %rbp
 .cfi_def_cfa_offset 48
 .cfi_offset 6, -48
 pushq %rbx
 .cfi_def_cfa_offset 56
 .cfi_offset 3, -56
 subq $312, %rsp
 .cfi_def_cfa_offset 368
 movq %fs:40, %rax
 movq %rax, 296(%rsp)
 xorl %eax, %eax
 testq %rdi, %rdi
 je .L30
 leaq 160(%rsi), %r15
 leaq 32(%rsp), %r13
 leaq 24(%rsp), %r12
 movq %rdi, %r14
 movq %rsi, %rbp
 .p2align 4,,10
 .p2align 3
.L23:
 movq %r14, %rdx
 movl $255, %esi
 movq %r13, %rdi
 call fgets@PLT
 leaq .LC4(%rip), %rsi
 movq %r13, %rdi
 call strtok@PLT
 testq %rax, %rax
 movq %rax, %rdx
 je .L31
.L17:
 xorl %ebx, %ebx
 jmp .L18
 .p2align 4,,10
 .p2align 3
.L25:
 mulsd .LC1(%rip), %xmm0
 movl $11, (%rdx)
 cvttsd2si %xmm0, %eax
 movl %eax, 4(%rdx)
.L29:
 leaq .LC4(%rip), %rsi
 xorl %edi, %edi
 addq $8, %rbx
 call strtok@PLT
 cmpq $160, %rbx
 movq %rax, %rdx
 je .L32
.L18:
 movq %rdx, %rdi
 movq %r12, %rsi
 call strtod@PLT
 movq 0(%rbp), %rdx
 pxor %xmm1, %xmm1
 addq %rbx, %rdx
 ucomisd %xmm1, %xmm0
 jp .L25
 jne .L25
 movq $0, (%rdx)
 jmp .L29
.L31:
 leaq .LC5(%rip), %rdi
 movq %rax, 8(%rsp)
 call puts@PLT
 movq 8(%rsp), %rdx
 jmp .L17
 .p2align 4,,10
 .p2align 3
.L32:
 addq $8, %rbp
 cmpq %rbp, %r15
 jne .L23
 movq 296(%rsp), %rax
 xorq %fs:40, %rax
 jne .L33
 addq $312, %rsp
 .cfi_remember_state
 .cfi_def_cfa_offset 56
 popq %rbx
 .cfi_def_cfa_offset 48
 popq %rbp
 .cfi_def_cfa_offset 40
 popq %r12
 .cfi_def_cfa_offset 32
 popq %r13
 .cfi_def_cfa_offset 24
 popq %r14
 .cfi_def_cfa_offset 16
 popq %r15
 .cfi_def_cfa_offset 8
 ret
.L30:
 .cfi_restore_state
 leaq .LC3(%rip), %rdi
 call puts@PLT
 orl $-1, %edi
 call exit@PLT
.L33:
 call __stack_chk_fail@PLT
 .cfi_endproc
.LFE66:
 .size buildMatrix, .-buildMatrix
 .p2align 4,,15
 .globl generateIdentityMatrix
 .type generateIdentityMatrix, @function
generateIdentityMatrix:
.LFB67:
 .cfi_startproc
 xorl %esi, %esi
 .p2align 4,,10
 .p2align 3
.L38:
 movq (%rdi,%rsi,8), %rdx
 movl %esi, %ecx
 xorl %eax, %eax
 .p2align 4,,10
 .p2align 3
.L37:
 cmpl %eax, %ecx
 je .L35
 movl $0, (%rdx,%rax,8)
 movl $0, 4(%rdx,%rax,8)
.L36:
 addq $1, %rax
 cmpq $20, %rax
 jne .L37
 addq $1, %rsi
 cmpq $20, %rsi
 jne .L38
 rep ret
 .p2align 4,,10
 .p2align 3
.L35:
 movl $11, (%rdx,%rax,8)
 movl $2048, 4(%rdx,%rax,8)
 jmp .L36
 .cfi_endproc
.LFE67:
 .size generateIdentityMatrix, .-generateIdentityMatrix
 .p2align 4,,15
 .globl divideRow
 .type divideRow, @function
divideRow:
.LFB68:
 .cfi_startproc
 movq %rdi, %rdx
 movq %rsi, %rax
 leaq 160(%rsi), %r10
 sarq $32, %rdx
 cmpl $11, %edi
 pushq %rbx
 .cfi_def_cfa_offset 16
 .cfi_offset 3, -16
 setne %r11b
 cmpl $1024, %edx
 movl %edx, %r8d
 setne %dl
 movl %edi, %r9d
 orl %edx, %r11d
 movq %rsi, %rdx
 movl $11, %esi
 jmp .L51
 .p2align 4,,10
 .p2align 3
.L49:
#APP
# 139 "MatrixInversion.c" 1
 SDR %edi, %ecx, %r8d
# 0 "" 2
#NO_APP
 movl 8(%rdx), %ecx
 movl %edi, 12(%rdx)
 addl $11, %ecx
 subl %r9d, %ecx
 testl %edi, %edi
 movl %ecx, 8(%rdx)
 je .L48
 cmpl $11, %ecx
 jle .L50
 subl $11, %ecx
 movl $11, 8(%rdx)
 sarl %cl, %edi
 movl %edi, 12(%rdx)
 .p2align 4,,10
 .p2align 3
.L48:
 addq $16, %rdx
 cmpq %rdx, %r10
 je .L73
.L51:
 movl 4(%rdx), %ecx
 testl %ecx, %ecx
 je .L43
 testb %r11b, %r11b
 je .L48
#APP
# 114 "MatrixInversion.c" 1
 SDR %edi, %ecx, %r8d
# 0 "" 2
#NO_APP
 movl (%rdx), %ecx
 movl %edi, 4(%rdx)
 addl $11, %ecx
 subl %r9d, %ecx
 testl %edi, %edi
 movl %ecx, (%rdx)
 je .L43
 cmpl $11, %ecx
 jle .L46
 subl $11, %ecx
 movl $11, (%rdx)
 sarl %cl, %edi
 movl %edi, 4(%rdx)
 .p2align 4,,10
 .p2align 3
.L43:
 movl 12(%rdx), %ecx
 testl %ecx, %ecx
 je .L48
 cmpl $1024, %r8d
 jne .L49
 cmpl $11, %r9d
 jne .L49
 addq $16, %rdx
 cmpq %rdx, %r10
 jne .L51
.L73:
 popq %rbx
 .cfi_remember_state
 .cfi_def_cfa_offset 8
 ret
 .p2align 4,,10
 .p2align 3
.L46:
 .cfi_restore_state
 je .L43
 movl %esi, %ebx
 movl $11, (%rdx)
 subl %ecx, %ebx
 movl %ebx, %ecx
 sall %cl, %edi
 movl %edi, 4(%rdx)
 jmp .L43
 .p2align 4,,10
 .p2align 3
.L50:
 je .L48
 movl %esi, %ebx
 movl $11, 8(%rdx)
 subl %ecx, %ebx
 movl %ebx, %ecx
 sall %cl, %edi
 movl %edi, 12(%rdx)
 jmp .L48
 .cfi_endproc
.LFE68:
 .size divideRow, .-divideRow
 .p2align 4,,15
 .globl subtractRowTimes
 .type subtractRowTimes, @function
subtractRowTimes:
.LFB69:
 .cfi_startproc
 movl %edi, %r10d
 movq %rsi, %rax
 shrq $32, %rdi
 xorl %r8d, %r8d
 movl $11, %r11d
 .p2align 4,,10
 .p2align 3
.L106:
 testl %edi, %edi
 je .L112
 pushq %r14
 .cfi_def_cfa_offset 16
 .cfi_offset 14, -16
 pushq %rbp
 .cfi_def_cfa_offset 24
 .cfi_offset 6, -24
 pushq %rbx
 .cfi_def_cfa_offset 32
 .cfi_offset 3, -32
.L107:
 movl 4(%rdx,%r8), %ecx
 testl %ecx, %ecx
 je .L81
 movl (%rdx,%r8), %ebx
 movl (%rax,%r8), %ebp
 imull %edi, %ecx
 movl 4(%rax,%r8), %esi
 addl %r10d, %ebx
 subl $11, %ebx
 sarl $11, %ecx
 cmpl %ebx, %ebp
 movl %ecx, %r9d
 jge .L78
 movl %ebx, %ecx
 movl %ebx, (%rax,%r8)
 subl %ebp, %ecx
 movl %ebx, %ebp
 sall %cl, %esi
.L79:
 subl %r9d, %esi
 testl %esi, %esi
 movl %esi, 4(%rax,%r8)
 je .L81
 cmpl $11, %ebp
 jle .L80
 leal -11(%rbp), %ecx
 movl $11, (%rax,%r8)
 sarl %cl, %esi
 movl %esi, 4(%rax,%r8)
 .p2align 4,,10
 .p2align 3
.L81:
 movl 12(%rdx,%r8), %ecx
 testl %ecx, %ecx
 je .L76
 movl 8(%rdx,%r8), %ebx
 movl 8(%rax,%r8), %ebp
 imull %edi, %ecx
 movl 12(%rax,%r8), %esi
 addl %r10d, %ebx
 subl $11, %ebx
 sarl $11, %ecx
 cmpl %ebx, %ebp
 movl %ecx, %r9d
 jge .L82
 movl %ebx, %ecx
 movl %ebx, 8(%rax,%r8)
 subl %ebp, %ecx
 movl %ebx, %ebp
 sall %cl, %esi
.L83:
 subl %r9d, %esi
 testl %esi, %esi
 movl %esi, 12(%rax,%r8)
 je .L76
 cmpl $11, %ebp
 jle .L85
 leal -11(%rbp), %ecx
 movl $11, 8(%rax,%r8)
 sarl %cl, %esi
 movl %esi, 12(%rax,%r8)
 .p2align 4,,10
 .p2align 3
.L76:
 addq $16, %r8
 cmpq $160, %r8
 je .L113
.L86:
 testl %edi, %edi
 jne .L107
 addq $16, %r8
 cmpq $160, %r8
 jne .L86
.L113:
 popq %rbx
 .cfi_def_cfa_offset 24
 popq %rbp
 .cfi_def_cfa_offset 16
 popq %r14
 .cfi_def_cfa_offset 8
 ret
 .p2align 4,,10
 .p2align 3
.L112:
 .cfi_restore 3
 .cfi_restore 6
 .cfi_restore 14
 addq $16, %r8
 cmpq $160, %r8
 jne .L106
 rep ret
 .p2align 4,,10
 .p2align 3
.L78:
 .cfi_def_cfa_offset 32
 .cfi_offset 3, -32
 .cfi_offset 6, -24
 .cfi_offset 14, -16
 movl %ebp, %ecx
 movl %r9d, %r14d
 subl %ebx, %ecx
 sall %cl, %r14d
 cmpl %ebx, %ebp
 cmovg %r14d, %r9d
 jmp .L79
 .p2align 4,,10
 .p2align 3
.L82:
 movl %ebp, %ecx
 movl %r9d, %r14d
 subl %ebx, %ecx
 sall %cl, %r14d
 cmpl %ebx, %ebp
 cmovg %r14d, %r9d
 jmp .L83
 .p2align 4,,10
 .p2align 3
.L85:
 je .L76
 movl %r11d, %ecx
 movl $11, 8(%rax,%r8)
 subl %ebp, %ecx
 sall %cl, %esi
 movl %esi, 12(%rax,%r8)
 jmp .L76
 .p2align 4,,10
 .p2align 3
.L80:
 je .L81
 movl %r11d, %ecx
 movl $11, (%rax,%r8)
 subl %ebp, %ecx
 sall %cl, %esi
 movl %esi, 4(%rax,%r8)
 jmp .L81
 .cfi_endproc
.LFE69:
 .size subtractRowTimes, .-subtractRowTimes
 .p2align 4,,15
 .globl getSwapRow
 .type getSwapRow, @function
getSwapRow:
.LFB70:
 .cfi_startproc
 cmpl $19, %esi
 jg .L119
 movslq %esi, %r8
 movl $19, %r11d
 pushq %rbx
 .cfi_def_cfa_offset 16
 .cfi_offset 3, -16
 subq %rsi, %r11
 leaq 2(%r8), %rsi
 leaq 0(,%r8,8), %r10
 andl $4294967294, %r11d
 xorl %eax, %eax
 xorl %r9d, %r9d
 addq %rsi, %r11
 jmp .L118
 .p2align 4,,10
 .p2align 3
.L125:
 addq $2, %rsi
.L118:
 movq (%rdi,%r8,8), %rdx
 addq %r10, %rdx
 movl (%rdx), %ecx
 movl 4(%rdx), %edx
 sarl %cl, %edx
 movl %edx, %ecx
 sarl $31, %ecx
 xorl %ecx, %edx
 subl %ecx, %edx
 cmpl %r9d, %edx
 jle .L116
 movl %r8d, %eax
 movl %edx, %r9d
.L116:
 movq 8(%rdi,%r8,8), %rdx
 leal 1(%r8), %ebx
 addq %r10, %rdx
 movl (%rdx), %ecx
 movl 4(%rdx), %edx
 sarl %cl, %edx
 movl %edx, %ecx
 sarl $31, %ecx
 xorl %ecx, %edx
 subl %ecx, %edx
 cmpl %r9d, %edx
 jle .L117
 movl %ebx, %eax
 movl %edx, %r9d
.L117:
 cmpq %rsi, %r11
 movq %rsi, %r8
 jne .L125
 popq %rbx
 .cfi_def_cfa_offset 8
 ret
 .p2align 4,,10
 .p2align 3
.L119:
 .cfi_restore 3
 xorl %eax, %eax
 ret
 .cfi_endproc
.LFE70:
 .size getSwapRow, .-getSwapRow
 .section .rodata.str1.8,"aMS",@progbits,1
 .align 8
.LC6:
 .string "Error! Matrix is not invertable. There is no usable value to pivot in column %d\n"
 .text
 .p2align 4,,15
 .globl invertMatrix
 .type invertMatrix, @function
invertMatrix:
.LFB71:
 .cfi_startproc
 pushq %r15
 .cfi_def_cfa_offset 16
 .cfi_offset 15, -16
 pushq %r14
 .cfi_def_cfa_offset 24
 .cfi_offset 14, -24
 pushq %r13
 .cfi_def_cfa_offset 32
 .cfi_offset 13, -32
 pushq %r12
 .cfi_def_cfa_offset 40
 .cfi_offset 12, -40
 pushq %rbp
 .cfi_def_cfa_offset 48
 .cfi_offset 6, -48
 pushq %rbx
 .cfi_def_cfa_offset 56
 .cfi_offset 3, -56
 movq %rdi, %rbp
 movq %rsi, %rbx
 xorl %esi, %esi
 subq $40, %rsp
 .cfi_def_cfa_offset 96
 .p2align 4,,10
 .p2align 3
.L130:
 movq (%rbx,%rsi,8), %rdx
 movl %esi, %ecx
 xorl %eax, %eax
 .p2align 4,,10
 .p2align 3
.L129:
 cmpl %eax, %ecx
 je .L127
 movl $0, (%rdx,%rax,8)
 movl $0, 4(%rdx,%rax,8)
.L128:
 addq $1, %rax
 cmpq $20, %rax
 jne .L129
 addq $1, %rsi
 cmpq $20, %rsi
 jne .L130
 movq %rbp, %r12
 movq %rbx, 8(%rsp)
 movq $0, 24(%rsp)
 .p2align 4,,10
 .p2align 3
.L156:
 movq 24(%rsp), %rdi
 movq (%r12), %rsi
 leaq 0(,%rdi,8), %r13
 movl %edi, 20(%rsp)
 leaq (%rsi,%r13), %rax
 movl 4(%rax), %edx
 movq (%rax), %rcx
 movq %rdi, %rax
 addl $1, %eax
 testl %edx, %edx
 jne .L132
 movq 8(%r12), %rdx
 addq %r13, %rdx
 movl (%rdx), %ecx
 movl 4(%rdx), %r8d
 sarl %cl, %r8d
 testl %r8d, %r8d
 je .L157
 movl %r8d, %edx
 sarl $31, %edx
 xorl %edx, %r8d
 subl %edx, %r8d
.L133:
 leal 2(%rdi), %r9d
 cmpl $19, %r9d
 ja .L134
 movq 16(%r12), %rdx
 addq %r13, %rdx
 movl (%rdx), %ecx
 movl 4(%rdx), %edx
 sarl %cl, %edx
 movl %edx, %ecx
 sarl $31, %ecx
 xorl %ecx, %edx
 subl %ecx, %edx
 cmpl %edx, %r8d
 jl .L135
 movl %eax, %r9d
 movl %r8d, %edx
.L135:
 movq 24(%r12), %r8
 leal 3(%rdi), %eax
 addq %r13, %r8
 movl (%r8), %ecx
 movl 4(%r8), %r8d
 sarl %cl, %r8d
 movl %r8d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r8d
 subl %ecx, %r8d
 cmpl %r8d, %edx
 jl .L136
 movl %r9d, %eax
 movl %edx, %r8d
.L136:
 leal 4(%rdi), %r10d
 cmpl $19, %r10d
 ja .L134
 movq 32(%r12), %rdx
 addq %r13, %rdx
 movl (%rdx), %ecx
 movl 4(%rdx), %r9d
 sarl %cl, %r9d
 movl %r9d, %edx
 sarl $31, %edx
 xorl %edx, %r9d
 subl %edx, %r9d
 cmpl %r9d, %r8d
 jl .L137
 movl %eax, %r10d
 movl %r8d, %r9d
.L137:
 movq 40(%r12), %rdx
 leal 5(%rdi), %eax
 addq %r13, %rdx
 movl (%rdx), %ecx
 movl 4(%rdx), %edx
 sarl %cl, %edx
 movl %edx, %ecx
 sarl $31, %ecx
 xorl %ecx, %edx
 subl %ecx, %edx
 cmpl %edx, %r9d
 jl .L138
 movl %r10d, %eax
 movl %r9d, %edx
.L138:
 leal 6(%rdi), %r9d
 cmpl $19, %r9d
 ja .L134
 movq 48(%r12), %r8
 addq %r13, %r8
 movl (%r8), %ecx
 movl 4(%r8), %r8d
 sarl %cl, %r8d
 movl %r8d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r8d
 subl %ecx, %r8d
 cmpl %r8d, %edx
 jl .L139
 movl %eax, %r9d
 movl %edx, %r8d
.L139:
 movq 56(%r12), %rdx
 leal 7(%rdi), %eax
 addq %r13, %rdx
 movl (%rdx), %ecx
 movl 4(%rdx), %edx
 sarl %cl, %edx
 movl %edx, %ecx
 sarl $31, %ecx
 xorl %ecx, %edx
 subl %ecx, %edx
 cmpl %edx, %r8d
 jl .L140
 movl %r9d, %eax
 movl %r8d, %edx
.L140:
 leal 8(%rdi), %r9d
 cmpl $19, %r9d
 ja .L134
 movq 64(%r12), %r8
 addq %r13, %r8
 movl (%r8), %ecx
 movl 4(%r8), %r8d
 sarl %cl, %r8d
 movl %r8d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r8d
 subl %ecx, %r8d
 cmpl %r8d, %edx
 jl .L141
 movl %eax, %r9d
 movl %edx, %r8d
.L141:
 movq 72(%r12), %rdx
 leal 9(%rdi), %eax
 addq %r13, %rdx
 movl (%rdx), %ecx
 movl 4(%rdx), %edx
 sarl %cl, %edx
 movl %edx, %ecx
 sarl $31, %ecx
 xorl %ecx, %edx
 subl %ecx, %edx
 cmpl %edx, %r8d
 jl .L142
 movl %r9d, %eax
 movl %r8d, %edx
.L142:
 leal 10(%rdi), %r9d
 cmpl $19, %r9d
 ja .L134
 movq 80(%r12), %r8
 addq %r13, %r8
 movl (%r8), %ecx
 movl 4(%r8), %r8d
 sarl %cl, %r8d
 movl %r8d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r8d
 subl %ecx, %r8d
 cmpl %r8d, %edx
 jl .L143
 movl %eax, %r9d
 movl %edx, %r8d
.L143:
 movq 88(%r12), %rdx
 leal 11(%rdi), %eax
 addq %r13, %rdx
 movl (%rdx), %ecx
 movl 4(%rdx), %edx
 sarl %cl, %edx
 movl %edx, %ecx
 sarl $31, %ecx
 xorl %ecx, %edx
 subl %ecx, %edx
 cmpl %edx, %r8d
 jl .L144
 movl %r9d, %eax
 movl %r8d, %edx
.L144:
 leal 12(%rdi), %r9d
 cmpl $19, %r9d
 ja .L134
 movq 96(%r12), %r8
 addq %r13, %r8
 movl (%r8), %ecx
 movl 4(%r8), %r8d
 sarl %cl, %r8d
 movl %r8d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r8d
 subl %ecx, %r8d
 cmpl %r8d, %edx
 jl .L145
 movl %eax, %r9d
 movl %edx, %r8d
.L145:
 movq 104(%r12), %rdx
 leal 13(%rdi), %eax
 addq %r13, %rdx
 movl (%rdx), %ecx
 movl 4(%rdx), %edx
 sarl %cl, %edx
 movl %edx, %ecx
 sarl $31, %ecx
 xorl %ecx, %edx
 subl %ecx, %edx
 cmpl %edx, %r8d
 jl .L146
 movl %r9d, %eax
 movl %r8d, %edx
.L146:
 leal 14(%rdi), %r9d
 cmpl $19, %r9d
 ja .L134
 movq 112(%r12), %r8
 addq %r13, %r8
 movl (%r8), %ecx
 movl 4(%r8), %r8d
 sarl %cl, %r8d
 movl %r8d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r8d
 subl %ecx, %r8d
 cmpl %r8d, %edx
 jl .L147
 movl %eax, %r9d
 movl %edx, %r8d
.L147:
 movq 120(%r12), %rdx
 leal 15(%rdi), %eax
 addq %r13, %rdx
 movl (%rdx), %ecx
 movl 4(%rdx), %edx
 sarl %cl, %edx
 movl %edx, %ecx
 sarl $31, %ecx
 xorl %ecx, %edx
 subl %ecx, %edx
 cmpl %edx, %r8d
 jl .L148
 movl %r9d, %eax
 movl %r8d, %edx
.L148:
 leal 16(%rdi), %r9d
 cmpl $19, %r9d
 ja .L134
 movq 128(%r12), %r8
 addq %r13, %r8
 movl (%r8), %ecx
 movl 4(%r8), %r8d
 sarl %cl, %r8d
 movl %r8d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r8d
 subl %ecx, %r8d
 cmpl %r8d, %edx
 jl .L149
 movl %eax, %r9d
 movl %edx, %r8d
.L149:
 movq 136(%r12), %rax
 leal 17(%rdi), %r10d
 addq %r13, %rax
 movl (%rax), %ecx
 movl 4(%rax), %edx
 sarl %cl, %edx
 movl %edx, %eax
 sarl $31, %eax
 xorl %eax, %edx
 subl %eax, %edx
 cmpl %edx, %r8d
 jl .L150
 movl %r9d, %r10d
 movl %r8d, %edx
.L150:
 leal 18(%rdi), %eax
 cmpl $19, %eax
 ja .L158
 movq 144(%r12), %r8
 addq %r13, %r8
 movl (%r8), %ecx
 movl 4(%r8), %r8d
 sarl %cl, %r8d
 movl %r8d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r8d
 subl %ecx, %r8d
 cmpl %r8d, %edx
 jl .L151
 movl %r10d, %eax
 movl %edx, %r8d
.L151:
 movq 152(%r12), %rdx
 addl $19, %edi
 addq %r13, %rdx
 movl (%rdx), %ecx
 movl 4(%rdx), %edx
 sarl %cl, %edx
 movl %edx, %ecx
 sarl $31, %ecx
 xorl %ecx, %edx
 subl %ecx, %edx
 cmpl %edx, %r8d
 jge .L134
 movl %edi, %eax
 .p2align 4,,10
 .p2align 3
.L152:
 cltq
 movq 8(%rsp), %rdi
 salq $3, %rax
 leaq 0(%rbp,%rax), %rdx
 addq %rbx, %rax
 movq (%rdx), %rcx
 movq %rcx, (%r12)
 movq %rsi, (%rdx)
 movq (%rax), %rcx
 movq (%rdi), %rdx
 movq %rcx, (%rdi)
 movq %rdx, (%rax)
 movq (%r12), %rsi
 leaq (%rsi,%r13), %rax
 movq (%rax), %rcx
 movl 4(%rax), %edx
.L132:
 movq %rdx, %rax
 movl %ecx, %edx
 salq $32, %rax
 orq %rax, %rdx
 movq %rdx, %rdi
 movq %rdx, %r15
 call divideRow
 movq 8(%rsp), %r14
 movq %rax, (%r12)
 movq %r15, %rdi
 xorl %r15d, %r15d
 movq (%r14), %rsi
 call divideRow
 movq %rax, (%r14)
 .p2align 4,,10
 .p2align 3
.L155:
 cmpl %r15d, 20(%rsp)
 je .L153
 movq 0(%rbp,%r15,8), %rsi
 movq (%r12), %rdx
 movq (%rsi,%r13), %r14
 movq %r14, %rdi
 call subtractRowTimes
 movq %rax, 0(%rbp,%r15,8)
 movq 8(%rsp), %rax
 movq %r14, %rdi
 movq (%rbx,%r15,8), %rsi
 movq (%rax), %rdx
 call subtractRowTimes
 movq %rax, (%rbx,%r15,8)
.L153:
 leal 1(%r15), %eax
 cmpl 20(%rsp), %eax
 je .L154
 movq 8(%rbp,%r15,8), %rsi
 movq (%r12), %rdx
 movq (%rsi,%r13), %r14
 movq %r14, %rdi
 call subtractRowTimes
 movq %rax, 8(%rbp,%r15,8)
 movq 8(%rsp), %rax
 movq %r14, %rdi
 movq 8(%rbx,%r15,8), %rsi
 movq (%rax), %rdx
 call subtractRowTimes
 movq %rax, 8(%rbx,%r15,8)
.L154:
 addq $2, %r15
 cmpq $20, %r15
 jne .L155
 addq $1, 24(%rsp)
 addq $8, %r12
 addq $8, 8(%rsp)
 movq 24(%rsp), %rax
 cmpq $20, %rax
 jne .L156
 addq $40, %rsp
 .cfi_remember_state
 .cfi_def_cfa_offset 56
 movl $1, %eax
 popq %rbx
 .cfi_def_cfa_offset 48
 popq %rbp
 .cfi_def_cfa_offset 40
 popq %r12
 .cfi_def_cfa_offset 32
 popq %r13
 .cfi_def_cfa_offset 24
 popq %r14
 .cfi_def_cfa_offset 16
 popq %r15
 .cfi_def_cfa_offset 8
 ret
.L158:
 .cfi_restore_state
 movl %r10d, %eax
 .p2align 4,,10
 .p2align 3
.L134:
 testl %eax, %eax
 jne .L152
 movl 20(%rsp), %edx
 leaq .LC6(%rip), %rsi
 movl $1, %edi
 call __printf_chk@PLT
 orl $-1, %edi
 call exit@PLT
 .p2align 4,,10
 .p2align 3
.L157:
 xorl %eax, %eax
 jmp .L133
 .p2align 4,,10
 .p2align 3
.L127:
 movl $11, (%rdx,%rax,8)
 movl $2048, 4(%rdx,%rax,8)
 jmp .L128
 .cfi_endproc
.LFE71:
 .size invertMatrix, .-invertMatrix
 .p2align 4,,15
 .globl computeConditionNumber
 .type computeConditionNumber, @function
computeConditionNumber:
.LFB72:
 .cfi_startproc
 leaq 160(%rdi), %r8
 xorl %eax, %eax
 .p2align 4,,10
 .p2align 3
.L166:
 movq (%rdi), %rdx
 movl (%rdx), %ecx
 movl 4(%rdx), %r9d
 movl 12(%rdx), %r10d
 sarl %cl, %r9d
 movl %r9d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r9d
 subl %ecx, %r9d
 movl 8(%rdx), %ecx
 sarl %cl, %r10d
 movl %r10d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r10d
 subl %ecx, %r10d
 movl 16(%rdx), %ecx
 addl %r9d, %r10d
 movl 20(%rdx), %r9d
 sarl %cl, %r9d
 movl %r9d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r9d
 subl %ecx, %r9d
 movl 24(%rdx), %ecx
 addl %r10d, %r9d
 movl 28(%rdx), %r10d
 sarl %cl, %r10d
 movl %r10d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r10d
 subl %ecx, %r10d
 movl 32(%rdx), %ecx
 addl %r10d, %r9d
 movl 36(%rdx), %r10d
 sarl %cl, %r10d
 movl %r10d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r10d
 subl %ecx, %r10d
 movl 40(%rdx), %ecx
 addl %r9d, %r10d
 movl 44(%rdx), %r9d
 sarl %cl, %r9d
 movl %r9d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r9d
 subl %ecx, %r9d
 movl 48(%rdx), %ecx
 addl %r9d, %r10d
 movl 52(%rdx), %r9d
 sarl %cl, %r9d
 movl %r9d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r9d
 subl %ecx, %r9d
 movl 56(%rdx), %ecx
 addl %r10d, %r9d
 movl 60(%rdx), %r10d
 sarl %cl, %r10d
 movl %r10d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r10d
 subl %ecx, %r10d
 movl 64(%rdx), %ecx
 addl %r10d, %r9d
 movl 68(%rdx), %r10d
 sarl %cl, %r10d
 movl %r10d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r10d
 subl %ecx, %r10d
 movl 72(%rdx), %ecx
 addl %r9d, %r10d
 movl 76(%rdx), %r9d
 sarl %cl, %r9d
 movl %r9d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r9d
 subl %ecx, %r9d
 movl 80(%rdx), %ecx
 addl %r9d, %r10d
 movl 84(%rdx), %r9d
 sarl %cl, %r9d
 movl %r9d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r9d
 subl %ecx, %r9d
 movl 88(%rdx), %ecx
 addl %r10d, %r9d
 movl 92(%rdx), %r10d
 sarl %cl, %r10d
 movl %r10d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r10d
 subl %ecx, %r10d
 movl 96(%rdx), %ecx
 addl %r10d, %r9d
 movl 100(%rdx), %r10d
 sarl %cl, %r10d
 movl %r10d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r10d
 subl %ecx, %r10d
 movl 104(%rdx), %ecx
 addl %r9d, %r10d
 movl 108(%rdx), %r9d
 sarl %cl, %r9d
 movl %r9d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r9d
 subl %ecx, %r9d
 movl 112(%rdx), %ecx
 addl %r9d, %r10d
 movl 116(%rdx), %r9d
 sarl %cl, %r9d
 movl %r9d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r9d
 subl %ecx, %r9d
 movl 120(%rdx), %ecx
 addl %r10d, %r9d
 movl 124(%rdx), %r10d
 movq 8(%rdi), %rsi
 sarl %cl, %r10d
 movl 12(%rsi), %r11d
 movl %r10d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r10d
 subl %ecx, %r10d
 movl 128(%rdx), %ecx
 addl %r10d, %r9d
 movl 132(%rdx), %r10d
 sarl %cl, %r10d
 movl %r10d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r10d
 subl %ecx, %r10d
 movl 136(%rdx), %ecx
 addl %r9d, %r10d
 movl 140(%rdx), %r9d
 sarl %cl, %r9d
 movl %r9d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r9d
 subl %ecx, %r9d
 movl 144(%rdx), %ecx
 addl %r9d, %r10d
 movl 148(%rdx), %r9d
 sarl %cl, %r9d
 movl %r9d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r9d
 subl %ecx, %r9d
 movl (%rsi), %ecx
 addl %r10d, %r9d
 movl 4(%rsi), %r10d
 sarl %cl, %r10d
 movl %r10d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r10d
 subl %ecx, %r10d
 movl 8(%rsi), %ecx
 sarl %cl, %r11d
 movl %r11d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r11d
 subl %ecx, %r11d
 movl 16(%rsi), %ecx
 addl %r11d, %r10d
 movl 20(%rsi), %r11d
 sarl %cl, %r11d
 movl %r11d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r11d
 subl %ecx, %r11d
 movl 24(%rsi), %ecx
 addl %r11d, %r10d
 movl 28(%rsi), %r11d
 sarl %cl, %r11d
 movl %r11d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r11d
 subl %ecx, %r11d
 movl 32(%rsi), %ecx
 addl %r10d, %r11d
 movl 36(%rsi), %r10d
 sarl %cl, %r10d
 movl %r10d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r10d
 subl %ecx, %r10d
 movl 40(%rsi), %ecx
 addl %r10d, %r11d
 movl 44(%rsi), %r10d
 sarl %cl, %r10d
 movl %r10d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r10d
 subl %ecx, %r10d
 movl 48(%rsi), %ecx
 addl %r11d, %r10d
 movl 52(%rsi), %r11d
 sarl %cl, %r11d
 movl %r11d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r11d
 subl %ecx, %r11d
 movl 56(%rsi), %ecx
 addl %r11d, %r10d
 movl 60(%rsi), %r11d
 sarl %cl, %r11d
 movl %r11d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r11d
 subl %ecx, %r11d
 movl 64(%rsi), %ecx
 addl %r10d, %r11d
 movl 68(%rsi), %r10d
 sarl %cl, %r10d
 movl %r10d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r10d
 subl %ecx, %r10d
 movl 72(%rsi), %ecx
 addl %r10d, %r11d
 movl 76(%rsi), %r10d
 sarl %cl, %r10d
 movl %r10d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r10d
 subl %ecx, %r10d
 movl 80(%rsi), %ecx
 addl %r11d, %r10d
 movl 84(%rsi), %r11d
 sarl %cl, %r11d
 movl %r11d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r11d
 subl %ecx, %r11d
 movl 88(%rsi), %ecx
 addl %r11d, %r10d
 movl 92(%rsi), %r11d
 sarl %cl, %r11d
 movl %r11d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r11d
 subl %ecx, %r11d
 movl 96(%rsi), %ecx
 addl %r10d, %r11d
 movl 100(%rsi), %r10d
 sarl %cl, %r10d
 movl %r10d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r10d
 subl %ecx, %r10d
 movl 104(%rsi), %ecx
 addl %r10d, %r11d
 movl 108(%rsi), %r10d
 sarl %cl, %r10d
 movl %r10d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r10d
 subl %ecx, %r10d
 movl 112(%rsi), %ecx
 addl %r11d, %r10d
 movl 116(%rsi), %r11d
 sarl %cl, %r11d
 movl %r11d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r11d
 subl %ecx, %r11d
 movl 120(%rsi), %ecx
 addl %r11d, %r10d
 movl 124(%rsi), %r11d
 sarl %cl, %r11d
 movl %r11d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r11d
 subl %ecx, %r11d
 movl 128(%rsi), %ecx
 addl %r10d, %r11d
 movl 132(%rsi), %r10d
 sarl %cl, %r10d
 movl %r10d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r10d
 subl %ecx, %r10d
 movl 136(%rsi), %ecx
 addl %r10d, %r11d
 movl 140(%rsi), %r10d
 sarl %cl, %r10d
 movl %r10d, %ecx
 sarl $31, %ecx
 xorl %ecx, %r10d
 subl %ecx, %r10d
 movl 144(%rsi), %ecx
 addl %r11d, %r10d
 movl 148(%rsi), %r11d
 sarl %cl, %r11d
 movl %r11d, %ecx
 sarl $31, %r11d
 xorl %r11d, %ecx
 subl %r11d, %ecx
 addl %ecx, %r10d
 movl 152(%rsi), %ecx
 movl 156(%rsi), %esi
 sarl %cl, %esi
 movl %esi, %ecx
 sarl $31, %ecx
 xorl %ecx, %esi
 subl %ecx, %esi
 movl 152(%rdx), %ecx
 movl 156(%rdx), %edx
 addl %r10d, %esi
 sarl %cl, %edx
 movl %edx, %ecx
 sarl $31, %ecx
 xorl %ecx, %edx
 subl %ecx, %edx
 addl %r9d, %edx
 cmpl %edx, %esi
 cmovl %edx, %esi
 cmpl %esi, %eax
 cmovl %esi, %eax
 addq $16, %rdi
 cmpq %rdi, %r8
 jne .L166
 rep ret
 .cfi_endproc
.LFE72:
 .size computeConditionNumber, .-computeConditionNumber
 .section .rodata.str1.1
.LC7:
 .string "Error, need input filename."
.LC8:
 .string "r"
 .section .rodata.str1.8
 .align 8
.LC9:
 .string "Error, incorrect matrix size. Must be a %dX%d matrix.\n"
 .section .rodata.str1.1
.LC10:
 .string " Matrix size = %d, argc: %d\n"
 .section .rodata.str1.8
 .align 8
.LC11:
 .string "Condition number of the matrix: %f\n"
 .align 8
.LC13:
 .string "Input matix is not well-conditioned. Exiting program."
 .section .rodata.str1.1
.LC14:
 .string "Input Matrix"
.LC15:
 .string "Inverted Matrix"
 .section .text.startup,"ax",@progbits
 .p2align 4,,15
 .globl main
 .type main, @function
main:
.LFB73:
 .cfi_startproc
 pushq %r14
 .cfi_def_cfa_offset 16
 .cfi_offset 14, -16
 pushq %r13
 .cfi_def_cfa_offset 24
 .cfi_offset 13, -24
 pushq %r12
 .cfi_def_cfa_offset 32
 .cfi_offset 12, -32
 pushq %rbp
 .cfi_def_cfa_offset 40
 .cfi_offset 6, -40
 pushq %rbx
 .cfi_def_cfa_offset 48
 .cfi_offset 3, -48
 subq $288, %rsp
 .cfi_def_cfa_offset 336
 movq %fs:40, %rax
 movq %rax, 280(%rsp)
 xorl %eax, %eax
 cmpl $2, %edi
 jne .L183
 movq 8(%rsi), %rdi
 leaq .LC8(%rip), %rsi
 call fopen@PLT
 leaq 16(%rsp), %rdi
 movq %rax, %rdx
 movl $255, %esi
 movq %rax, %r12
 call fgets@PLT
 xorl %esi, %esi
 movl $10, %edx
 movq %rax, %rdi
 call strtol@PLT
 cmpl $20, %eax
 movl $20, %ecx
 jne .L184
 leaq .LC10(%rip), %rsi
 movl $2, %edx
 movl $1, %edi
 xorl %eax, %eax
 call __printf_chk@PLT
 movl $160, %edi
 call malloc@PLT
 leaq 160(%rax), %r13
 movq %rax, %rbp
 movq %rax, %rbx
 .p2align 4,,10
 .p2align 3
.L172:
 movl $160, %edi
 addq $8, %rbx
 call malloc@PLT
 movq %rax, -8(%rbx)
 cmpq %rbx, %r13
 jne .L172
 movq %rbp, %rsi
 movq %r12, %rdi
 call buildMatrix
 movq %rbp, %rdi
 call computeConditionNumber
 pxor %xmm1, %xmm1
 leaq .LC11(%rip), %rsi
 movl $1, %edi
 cvtsi2sd %eax, %xmm1
 movl $1, %eax
 movapd %xmm1, %xmm0
 movsd %xmm1, 8(%rsp)
 call __printf_chk@PLT
 movsd 8(%rsp), %xmm1
 ucomisd .LC12(%rip), %xmm1
 jnb .L185
 leaq .LC14(%rip), %rdi
 call puts@PLT
 movq %rbp, %rdi
 call printMatrix
 movl $160, %edi
 call malloc@PLT
 leaq 160(%rax), %r13
 movq %rax, %r14
 movq %rax, %rbx
 .p2align 4,,10
 .p2align 3
.L175:
 movl $160, %edi
 addq $8, %rbx
 call malloc@PLT
 movq %rax, -8(%rbx)
 cmpq %r13, %rbx
 jne .L175
 movq %r14, %rsi
 movq %rbp, %rdi
 call invertMatrix
 leaq .LC15(%rip), %rdi
 call puts@PLT
 movq %r14, %rdi
 call printMatrix
 movq %r12, %rdi
 call fclose@PLT
 movq %rbp, %rdi
 call free@PLT
 movq %r14, %rdi
 call free@PLT
 xorl %eax, %eax
.L168:
 movq 280(%rsp), %rcx
 xorq %fs:40, %rcx
 jne .L186
 addq $288, %rsp
 .cfi_remember_state
 .cfi_def_cfa_offset 48
 popq %rbx
 .cfi_def_cfa_offset 40
 popq %rbp
 .cfi_def_cfa_offset 32
 popq %r12
 .cfi_def_cfa_offset 24
 popq %r13
 .cfi_def_cfa_offset 16
 popq %r14
 .cfi_def_cfa_offset 8
 ret
.L183:
 .cfi_restore_state
 leaq .LC7(%rip), %rdi
 call puts@PLT
.L170:
 orl $-1, %eax
 jmp .L168
.L184:
 leaq .LC9(%rip), %rsi
 movl $20, %edx
 movl $1, %edi
 xorl %eax, %eax
 call __printf_chk@PLT
 jmp .L170
.L185:
 movq %r12, %rdi
 call fclose@PLT
 movq %rbp, %rdi
 call free@PLT
 leaq .LC13(%rip), %rdi
 call puts@PLT
 jmp .L170
.L186:
 call __stack_chk_fail@PLT
 .cfi_endproc
.LFE73:
 .size main, .-main
 .section .rodata.cst8,"aM",@progbits,8
 .align 8
.LC0:
 .long 0
 .long 0
 .align 8
.LC1:
 .long 0
 .long 1084227584
 .align 8
.LC12:
 .long 0
 .long 1077477376
 .ident "GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
 .section .note.GNU-stack,"",@progbits
[crdunn@seng440 SENG440-Final-Project]$ arm-linux-gcc -static -O3 -S -o MatrixInversion.exe MatrixInversion1.S
arm-none-linux-gnueabi-gcc: MatrixInversion1.S: No such file or directory
arm-none-linux-gnueabi-gcc: no input files
[crdunn@seng440 SENG440-Final-Project]$ arm-linux-gcc -static -O3 -S -o MatrixInversion1.S
arm-none-linux-gnueabi-gcc: no input files
[crdunn@seng440 SENG440-Final-Project]$ arm-linux-gcc -static -O3 -S -o MatrixInversion1.S
arm-none-linux-gnueabi-gcc: no input files
[crdunn@seng440 SENG440-Final-Project]$ arm-linux-gcc -static -O3 -S -o MatrixInversion1.S MatrixInversion.c
[crdunn@seng440 SENG440-Final-Project]$ ls
InputMatrices     MatrixInversion1.S  MatrixInversion.exe  README.md
InvertedMatrices  MatrixInversion.c   MatrixInversion.S
[crdunn@seng440 SENG440-Final-Project]$ git status
# On branch hardware-implemented
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	MatrixInversion.exe
#	MatrixInversion1.S
nothing added to commit but untracked files present (use "git add" to track)
[crdunn@seng440 SENG440-Final-Project]$ rm MatrixInversion.exe 
[crdunn@seng440 SENG440-Final-Project]$ git status
# On branch hardware-implemented
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	MatrixInversion1.S
nothing added to commit but untracked files present (use "git add" to track)
[crdunn@seng440 SENG440-Final-Project]$ git add MatrixInversion1.S
[crdunn@seng440 SENG440-Final-Project]$ git commit -m "Compile assebly properly" 
[hardware-implemented ea33e67] Compile assebly properly
 1 file changed, 1545 insertions(+)
 create mode 100644 MatrixInversion1.S
[crdunn@seng440 SENG440-Final-Project]$ git push
Username for 'https://github.com': crdunn@shaw.ca
Password for 'https://crdunn@shaw.ca@github.com': 
remote: Support for password authentication was removed on August 13, 2021. Please use a personal access token instead.
remote: Please see https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/ for more information.
fatal: unable to access 'https://github.com/SENG440-Group9/SENG440-Final-Project.git/': The requested URL returned error: 403
[crdunn@seng440 SENG440-Final-Project]$ cat MatrixInversion1.S 
	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 18, 4
	.file	"MatrixInversion.c"
	.global	__aeabi_i2d
	.global	__aeabi_ddiv
	.text
	.align	2
	.global	fixedToFloat
	.type	fixedToFloat, %function
fixedToFloat:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, lr}
	sub	sp, sp, #12
	mov	r3, sp
	stmia	r3, {r0, r1}
	mov	r0, r1
	bl	__aeabi_i2d
	ldr	r3, [sp, #0]
	mov	r4, r0
	mov	r0, #1
	mov	r0, r0, asl r3
	mov	r5, r1
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	add	sp, sp, #12
	ldmfd	sp!, {r4, r5, lr}
	bx	lr
	.size	fixedToFloat, .-fixedToFloat
	.global	__aeabi_dcmpeq
	.global	__aeabi_dmul
	.global	__aeabi_d2iz
	.align	2
	.global	floatToFixed
	.type	floatToFixed, %function
floatToFixed:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	mov	r4, r2
	mov	r5, r3
	mov	r6, r0
	mov	r2, #0
	mov	r3, #0
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_dcmpeq
	cmp	r0, #0
	beq	.L11
	ldr	r3, .L12
	ldmia	r3, {r0, r1}
	stmia	r6, {r0, r1}
.L3:
	mov	r0, r6
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
.L11:
	mov	r3, #11
	str	r3, [r6, #0]
	mov	r3, #1073741824
	mov	r2, #0
	add	r3, r3, #10485760
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_dmul
	bl	__aeabi_d2iz
	str	r0, [r6, #4]
	b	.L3
.L13:
	.align	2
.L12:
	.word	.LANCHOR0
	.size	floatToFixed, .-floatToFixed
	.align	2
	.global	generateIdentityMatrix
	.type	generateIdentityMatrix, %function
generateIdentityMatrix:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7, r8}
	mov	r4, #0
	mov	r8, r0
	mov	r5, r4
	mov	r7, #2048
	mov	r6, #11
.L15:
	ldr	ip, [r8, r4, asl #2]
	mov	r3, r4, asl #3
	mov	r1, #0
	add	r0, ip, r3
	mov	r2, r1
.L18:
	cmp	r4, r1
	add	r3, ip, r2
	add	r1, r1, #1
	strne	r5, [ip, r2]
	streq	r7, [r0, #4]
	streq	r6, [r0, #0]
	strne	r5, [r3, #4]
	cmp	r1, #20
	add	r2, r2, #8
	bne	.L18
	add	r4, r4, #1
	cmp	r4, #20
	bne	.L15
	ldmfd	sp!, {r4, r5, r6, r7, r8}
	bx	lr
	.size	generateIdentityMatrix, .-generateIdentityMatrix
	.align	2
	.global	divideRow
	.type	divideRow, %function
divideRow:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6}
	sub	sp, sp, #12
	mov	r3, sp
	stmia	r3, {r0, r1}
	mov	r6, r2
	mov	r0, r1
	ldr	r4, [sp, #0]
	mov	r1, r2
	add	r5, r2, #160
	b	.L29
.L24:
	ldr	r3, [r1, #0]
#APP
@ 114 "MatrixInversion.c" 1
	SDR r2, r2, r0
@ 0 "" 2
	add	r3, r3, #11
	rsb	ip, r4, r3
	cmp	r2, #0
	str	ip, [r1, #0]
	str	r2, [r1, #4]
	beq	.L23
	cmp	ip, #11
	subgt	r3, ip, #11
	movgt	r2, r2, asr r3
	rsbgt	r3, r3, ip
	strgt	r2, [r1, #4]
	strgt	r3, [r1, #0]
	bgt	.L23
	rsbne	r3, ip, #11
	movne	r2, r2, asl r3
	addne	r3, ip, r3
	strne	r2, [r1, #4]
	strne	r3, [r1, #0]
.L23:
	ldr	r2, [r1, #12]
	cmp	r2, #0
	beq	.L26
	cmp	r0, #1024
	beq	.L33
.L27:
	ldr	r3, [r1, #8]
#APP
@ 139 "MatrixInversion.c" 1
	SDR r2, r2, r0
@ 0 "" 2
	add	r3, r3, #11
	rsb	ip, r4, r3
	cmp	r2, #0
	str	ip, [r1, #8]
	str	r2, [r1, #12]
	beq	.L26
	cmp	ip, #11
	subgt	r3, ip, #11
	movgt	r2, r2, asr r3
	rsbgt	r3, r3, ip
	strgt	r2, [r1, #12]
	strgt	r3, [r1, #8]
	bgt	.L26
	rsbne	r3, ip, #11
	movne	r2, r2, asl r3
	addne	r3, ip, r3
	strne	r2, [r1, #12]
	strne	r3, [r1, #8]
.L26:
	add	r1, r1, #16
	cmp	r1, r5
	beq	.L34
.L29:
	ldr	r2, [r1, #4]
	cmp	r2, #0
	beq	.L23
	cmp	r0, #1024
	bne	.L24
	cmp	r4, #11
	bne	.L24
	b	.L23
.L33:
	cmp	r4, #11
	bne	.L27
	add	r1, r1, #16
	cmp	r1, r5
	bne	.L29
.L34:
	mov	r0, r6
	add	sp, sp, #12
	ldmfd	sp!, {r4, r5, r6}
	bx	lr
	.size	divideRow, .-divideRow
	.align	2
	.global	subtractRowTimes
	.type	subtractRowTimes, %function
subtractRowTimes:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7, r8, sl}
	sub	sp, sp, #8
	mov	ip, sp
	stmia	ip, {r0, r1}
	mov	r7, r1
	mov	sl, r2
	mov	r8, r0
	mov	r5, r3
	mov	r1, r2
	mov	r6, #1
	b	.L46
.L51:
	ldr	r2, [r1, #4]
	rsb	r3, r0, ip
	mov	r2, r2, asl r3
	str	ip, [r1, #0]
	str	r2, [r1, #4]
	mov	r3, r4
.L39:
	rsb	r2, r3, r2
	cmp	r2, #0
	str	r2, [r1, #4]
	beq	.L37
	ldr	ip, [r1, #0]
	cmp	ip, #11
	subgt	r3, ip, #11
	movgt	r2, r2, asr r3
	rsbgt	r3, r3, ip
	strgt	r2, [r1, #4]
	strgt	r3, [r1, #0]
	bgt	.L37
	rsbne	r3, ip, #11
	movne	r2, r2, asl r3
	addne	r3, ip, r3
	strne	r2, [r1, #4]
	strne	r3, [r1, #0]
.L37:
	ldr	r3, [r5, #12]
	cmp	r3, #0
	beq	.L36
	mul	r2, r3, r7
	ldr	r3, [r5, #8]
	ldr	r0, [r1, #8]
	add	r3, r8, r3
	sub	ip, r3, #11
	cmp	ip, r0
	mov	r4, r2, asr #11
	ble	.L42
	ldr	r2, [r1, #12]
	rsb	r3, r0, ip
	mov	r2, r2, asl r3
	str	ip, [r1, #8]
	str	r2, [r1, #12]
	mov	r3, r4
.L43:
	rsb	r2, r3, r2
	cmp	r2, #0
	str	r2, [r1, #12]
	beq	.L36
	ldr	ip, [r1, #8]
	cmp	ip, #11
	subgt	r3, ip, #11
	movgt	r2, r2, asr r3
	rsbgt	r3, r3, ip
	strgt	r2, [r1, #12]
	strgt	r3, [r1, #8]
	bgt	.L36
	rsbne	r3, ip, #11
	movne	r2, r2, asl r3
	addne	r3, ip, r3
	strne	r2, [r1, #12]
	strne	r3, [r1, #8]
.L36:
	add	r6, r6, #2
	cmp	r6, #21
	add	r5, r5, #16
	add	r1, r1, #16
	beq	.L50
.L46:
	cmp	r7, #0
	beq	.L36
	ldr	r3, [r5, #4]
	cmp	r3, #0
	beq	.L37
	mul	r2, r3, r7
	ldr	r3, [r5, #0]
	ldr	r0, [r1, #0]
	add	r3, r8, r3
	sub	ip, r3, #11
	cmp	ip, r0
	mov	r4, r2, asr #11
	bgt	.L51
	rsblt	r3, ip, r0
	movge	r3, r4
	ldrge	r2, [r1, #4]
	movlt	r3, r4, asl r3
	ldrlt	r2, [r1, #4]
	b	.L39
.L42:
	rsblt	r3, ip, r0
	movge	r3, r4
	ldrge	r2, [r1, #12]
	movlt	r3, r4, asl r3
	ldrlt	r2, [r1, #12]
	b	.L43
.L50:
	mov	r0, sl
	add	sp, sp, #8
	ldmfd	sp!, {r4, r5, r6, r7, r8, sl}
	bx	lr
	.size	subtractRowTimes, .-subtractRowTimes
	.align	2
	.global	getSwapRow
	.type	getSwapRow, %function
getSwapRow:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cmp	r1, #19
	stmfd	sp!, {r4, r5, r6, r7, r8}
	movgt	r8, #0
	bgt	.L54
	add	r3, r1, #1
	mov	r3, r3, asl #2
	mov	r2, r1, asl #2
	mov	r6, #0
	add	r7, r0, r3
	add	r5, r0, r2
	mov	ip, r1
	mov	r4, r1, asl #3
	mov	r8, r6
.L57:
	ldr	r0, [r5, #0]
	add	r3, r0, r4
	ldr	r1, [r0, r4]
	ldr	r2, [r3, #4]
	mov	r2, r2, asr r1
	ldr	r0, [r7, #0]
	cmp	r2, #0
	rsblt	r2, r2, #0
	cmp	r2, r6
	add	r3, r0, r4
	movgt	r6, r2
	ldr	r1, [r0, r4]
	ldr	r2, [r3, #4]
	mov	r2, r2, asr r1
	movgt	r8, ip
	cmp	r2, #0
	rsblt	r2, r2, #0
	cmp	r6, r2
	add	r3, ip, #1
	add	ip, ip, #2
	movlt	r6, r2
	movlt	r8, r3
	cmp	ip, #19
	add	r5, r5, #8
	add	r7, r7, #8
	ble	.L57
.L54:
	mov	r0, r8
	ldmfd	sp!, {r4, r5, r6, r7, r8}
	bx	lr
	.size	getSwapRow, .-getSwapRow
	.align	2
	.global	computeConditionNumber
	.type	computeConditionNumber, %function
computeConditionNumber:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 176
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	sub	sp, sp, #176
	str	r0, [sp, #168]
	ldr	r1, [sp, #168]
	mov	r0, #0
	add	r1, r1, #80
	str	r0, [sp, #172]
	str	r1, [sp, #8]
.L61:
	ldr	r2, [sp, #168]
	ldr	r3, [r2, #0]
	ldr	r1, [r3, #44]
	ldr	r4, [r3, #36]
	ldr	r5, [r3, #52]
	ldr	r0, [r3, #40]
	ldr	r2, [r3, #32]
	ldr	ip, [r3, #48]
	mov	r0, r1, asr r0
	mov	r2, r4, asr r2
	mov	ip, r5, asr ip
	ldr	r4, [r3, #60]
	ldr	r5, [r3, #68]
	ldr	r6, [r3, #76]
	str	r0, [sp, #0]
	str	r2, [sp, #144]
	ldr	r0, [r3, #64]
	ldr	r2, [r3, #56]
	str	ip, [sp, #140]
	ldr	ip, [r3, #72]
	mov	r2, r4, asr r2
	mov	r0, r5, asr r0
	mov	ip, r6, asr ip
	ldr	r7, [sp, #168]
	ldr	r4, [r3, #84]
	ldr	r6, [r3, #92]
	ldr	r1, [r3, #100]
	str	r2, [sp, #136]
	str	r0, [sp, #132]
	ldr	r2, [r7, #4]
	ldr	r0, [r3, #80]
	ldr	r7, [r3, #96]
	str	ip, [sp, #128]
	ldr	ip, [r3, #88]
	mov	r0, r4, asr r0
	mov	ip, r6, asr ip
	mov	r7, r1, asr r7
	ldr	r5, [r2, #48]
	ldr	fp, [r2, #60]
	ldr	r9, [r3, #8]
	ldr	r4, [r2, #56]
	ldr	r6, [r3, #12]
	ldr	sl, [r3, #0]
	ldr	r8, [r3, #104]
	str	r0, [sp, #124]
	str	ip, [sp, #120]
	ldr	r0, [r2, #52]
	ldr	ip, [r2, #40]
	str	r7, [sp, #116]
	ldr	r7, [r3, #4]
	mov	sl, r7, asr sl
	str	sl, [sp, #164]
	ldr	sl, [r2, #44]
	mov	ip, sl, asr ip
	ldr	r1, [r3, #124]
	str	ip, [sp, #60]
	ldr	ip, [r3, #28]
	str	r1, [sp, #96]
	str	ip, [sp, #148]
	add	r1, r3, #16
	ldmia	r1, {r1, ip}	@ phole ldm
	mov	ip, ip, asr r1
	ldr	r1, [r3, #112]
	str	ip, [sp, #160]
	ldr	ip, [r3, #116]
	mov	r4, fp, asr r4
	mov	ip, ip, asr r1
	ldr	fp, [r3, #128]
	ldr	r1, [r3, #132]
	mov	fp, r1, asr fp
	mov	r6, r6, asr r9
	ldr	r9, [r3, #108]
	mov	r0, r0, asr r5
	mov	r8, r9, asr r8
	ldr	r5, [r2, #32]
	ldr	r9, [r3, #24]
	ldr	r1, [sp, #148]
	str	fp, [sp, #92]
	ldr	fp, [r2, #36]
	mov	r9, r1, asr r9
	mov	r5, fp, asr r5
	ldr	r7, [r3, #148]
	str	r4, [sp, #64]
	str	ip, [sp, #108]
	ldr	r4, [r3, #140]
	ldr	ip, [r3, #136]
	ldr	fp, [r3, #156]
	mov	r4, r4, asr ip
	ldr	sl, [r3, #120]
	ldr	ip, [r2, #72]
	str	r8, [sp, #112]
	str	r7, [sp, #84]
	ldr	r8, [r3, #144]
	ldr	r7, [r2, #64]
	str	r5, [sp, #56]
	ldr	r5, [r3, #152]
	str	r9, [sp, #152]
	ldr	r3, [sp, #96]
	mov	sl, r3, asr sl
	str	sl, [sp, #100]
	ldr	sl, [r2, #68]
	mov	r7, sl, asr r7
	ldr	r1, [r2, #92]
	ldr	r3, [r2, #80]
	ldr	sl, [r2, #88]
	str	r7, [sp, #52]
	ldr	r7, [r2, #84]
	ldr	r9, [sp, #84]
	mov	r5, fp, asr r5
	mov	r3, r7, asr r3
	ldr	fp, [r2, #76]
	ldr	r7, [r2, #0]
	mov	sl, r1, asr sl
	ldr	r1, [r2, #4]
	mov	r8, r9, asr r8
	mov	ip, fp, asr ip
	mov	r7, r1, asr r7
	ldr	r9, [r2, #24]
	ldr	fp, [r2, #100]
	str	r5, [sp, #80]
	str	r3, [sp, #44]
	ldr	r5, [r2, #28]
	ldr	r3, [r2, #96]
	mov	r5, r5, asr r9
	mov	r3, fp, asr r3
	ldr	r9, [r2, #20]
	ldr	fp, [r2, #108]
	str	r8, [sp, #88]
	str	ip, [sp, #48]
	ldr	r8, [r2, #16]
	ldr	ip, [r2, #8]
	str	sl, [sp, #40]
	str	r7, [sp, #72]
	ldr	sl, [r2, #104]
	ldr	r7, [r2, #12]
	mov	r8, r9, asr r8
	mov	ip, r7, asr ip
	mov	sl, fp, asr sl
	ldr	r9, [r2, #112]
	str	r8, [sp, #76]
	str	ip, [sp, #68]
	ldr	r8, [r2, #128]
	ldr	ip, [r2, #140]
	str	r3, [sp, #36]
	ldr	r3, [r2, #136]
	str	sl, [sp, #32]
	ldr	r1, [r2, #124]
	str	r1, [sp, #20]
	ldr	r1, [r2, #116]
	mov	r9, r1, asr r9
	mov	ip, ip, asr r3
	ldr	sl, [r2, #120]
	ldr	r3, [r2, #132]
	str	r9, [sp, #28]
	ldr	r9, [sp, #20]
	add	r7, r2, #144
	ldmia	r7, {r7, fp}	@ phole ldm
	mov	r8, r3, asr r8
	mov	sl, r9, asr sl
	mov	r7, fp, asr r7
	ldr	r3, [r2, #152]
	ldr	fp, [sp, #144]
	str	r8, [sp, #16]
	str	sl, [sp, #24]
	ldr	r8, [r2, #156]
	ldr	sl, [sp, #0]
	str	r7, [sp, #12]
	ldr	r7, [sp, #140]
	mov	r8, r8, asr r3
	ldr	r9, [sp, #136]
	eor	r1, sl, sl, asr #31
	eor	r3, fp, fp, asr #31
	sub	r3, r3, fp, asr #31
	sub	r1, r1, sl, asr #31
	eor	r2, r7, r7, asr #31
	ldr	sl, [sp, #132]
	ldr	fp, [sp, #128]
	sub	r2, r2, r7, asr #31
	add	r1, r1, r3
	eor	r3, r9, r9, asr #31
	ldr	r7, [sp, #124]
	sub	r3, r3, r9, asr #31
	add	r1, r1, r2
	eor	r2, sl, sl, asr #31
	sub	r2, r2, sl, asr #31
	add	r1, r1, r3
	eor	r3, fp, fp, asr #31
	sub	r3, r3, fp, asr #31
	add	r1, r1, r2
	ldr	fp, [sp, #64]
	eor	r2, r7, r7, asr #31
	sub	r2, r2, r7, asr #31
	add	r1, r1, r3
	ldr	r9, [sp, #120]
	ldr	sl, [sp, #116]
	add	r1, r1, r2
	eor	r2, fp, fp, asr #31
	sub	r2, r2, fp, asr #31
	ldr	fp, [sp, #112]
	eor	r3, r9, r9, asr #31
	eor	r7, sl, sl, asr #31
	sub	r3, r3, r9, asr #31
	sub	r7, r7, sl, asr #31
	ldr	r9, [sp, #164]
	cmp	r0, #0
	eor	sl, fp, fp, asr #31
	sub	sl, sl, fp, asr #31
	rsblt	r0, r0, #0
	ldr	fp, [sp, #60]
	add	r1, r1, r3
	add	r0, r0, r2
	eor	r3, r9, r9, asr #31
	ldr	r2, [sp, #160]
	cmp	r6, #0
	sub	r3, r3, r9, asr #31
	add	r1, r1, r7
	eor	r9, fp, fp, asr #31
	ldr	r7, [sp, #108]
	sub	r9, r9, fp, asr #31
	rsblt	r6, r6, #0
	ldr	fp, [sp, #92]
	cmp	r2, #0
	rsblt	r2, r2, #0
	add	r6, r6, r3
	cmp	r7, #0
	ldr	r3, [sp, #152]
	rsblt	r7, r7, #0
	str	r2, [sp, #156]
	cmp	r4, #0
	eor	r2, fp, fp, asr #31
	sub	r2, r2, fp, asr #31
	rsblt	r4, r4, #0
	ldr	fp, [sp, #56]
	cmp	r3, #0
	rsblt	r3, r3, #0
	str	r7, [sp, #104]
	add	r0, r0, r9
	str	r3, [sp, #4]
	eor	r7, fp, fp, asr #31
	ldr	r9, [sp, #100]
	sub	r7, r7, fp, asr #31
	ldr	fp, [sp, #88]
	ldr	r3, [sp, #52]
	add	r1, r1, sl
	eor	sl, r9, r9, asr #31
	sub	sl, sl, r9, asr #31
	eor	r9, fp, fp, asr #31
	sub	r9, r9, fp, asr #31
	eor	fp, r3, r3, asr #31
	sub	fp, fp, r3, asr #31
	ldr	r3, [sp, #156]
	add	r6, r6, r3
	ldr	r3, [sp, #104]
	add	r0, r0, r7
	ldr	r7, [sp, #80]
	add	r1, r1, r3
	ldr	r3, [sp, #48]
	add	r4, r4, r2
	eor	r2, r7, r7, asr #31
	sub	r2, r2, r7, asr #31
	eor	r7, r3, r3, asr #31
	sub	r7, r7, r3, asr #31
	add	r4, r4, r9
	ldr	r3, [sp, #4]
	ldr	r9, [sp, #44]
	add	r1, r1, sl
	ldr	sl, [sp, #40]
	add	r6, r6, r3
	add	r0, r0, fp
	eor	r3, r9, r9, asr #31
	sub	r3, r3, r9, asr #31
	add	r4, r4, r2
	add	r0, r0, r7
	eor	r2, sl, sl, asr #31
	sub	r2, r2, sl, asr #31
	ldr	r9, [sp, #72]
	add	r0, r0, r3
	ldr	r3, [sp, #76]
	add	r6, r6, r1
	ldr	fp, [sp, #172]
	add	r0, r0, r2
	ldr	r2, [sp, #36]
	add	r4, r4, r6
	eor	r1, r3, r3, asr #31
	eor	r7, r9, r9, asr #31
	cmp	r4, fp
	movlt	r4, fp
	sub	r1, r1, r3, asr #31
	ldr	fp, [sp, #68]
	sub	r7, r7, r9, asr #31
	eor	r3, r2, r2, asr #31
	ldr	r9, [sp, #32]
	sub	r3, r3, r2, asr #31
	eor	sl, fp, fp, asr #31
	add	r0, r0, r3
	eor	r3, r9, r9, asr #31
	sub	sl, sl, fp, asr #31
	sub	r3, r3, r9, asr #31
	ldr	fp, [sp, #28]
	ldr	r9, [sp, #16]
	eor	r6, fp, fp, asr #31
	eor	r2, r9, r9, asr #31
	cmp	r5, #0
	sub	r6, r6, fp, asr #31
	sub	r2, r2, r9, asr #31
	ldr	fp, [sp, #24]
	ldr	r9, [sp, #12]
	rsblt	r5, r5, #0
	cmp	ip, #0
	rsblt	ip, ip, #0
	add	r5, r5, r1
	add	r0, r0, r3
	eor	r1, r9, r9, asr #31
	eor	r3, fp, fp, asr #31
	cmp	r8, #0
	sub	r3, r3, fp, asr #31
	sub	r1, r1, r9, asr #31
	add	r5, r5, r7
	add	r0, r0, r6
	add	ip, ip, r2
	rsblt	r8, r8, #0
	add	r5, r5, sl
	add	r0, r0, r3
	ldr	sl, [sp, #168]
	add	ip, ip, r1
	add	r5, r5, r0
	add	ip, ip, r8
	ldr	fp, [sp, #8]
	add	sl, sl, #8
	add	ip, ip, r5
	cmp	r4, ip
	movlt	r4, ip
	cmp	sl, fp
	str	sl, [sp, #168]
	str	r4, [sp, #172]
	bne	.L61
	mov	r0, r4
	add	sp, sp, #176
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	bx	lr
	.size	computeConditionNumber, .-computeConditionNumber
	.align	2
	.global	buildMatrix
	.type	buildMatrix, %function
buildMatrix:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 272
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	cmp	r0, #0
	sub	sp, sp, #276
	addne	fp, sp, #16
	str	r0, [sp, #4]
	mov	sl, r1
	subne	fp, fp, #3
	movne	r8, #0
	addne	r9, sp, #268
	beq	.L74
.L70:
	mov	r1, #255
	ldr	r2, [sp, #4]
	mov	r0, fp
	bl	fgets
	mov	r0, fp
	ldr	r1, .L76
	bl	strtok
	subs	r4, r0, #0
	beq	.L75
.L66:
	mov	r6, #0
.L69:
	ldr	r3, [sl, r8]
	mov	r0, r4
	mov	r1, r9
	add	r7, r3, r6
	bl	strtod
	mov	r3, #0
	mov	r2, #0
	mov	r4, r0
	mov	r5, r1
	bl	__aeabi_dcmpeq
	cmp	r0, #0
	movne	r0, #0
	movne	r3, r0
	bne	.L68
	mov	r3, #1073741824
	add	r3, r3, #10485760
	mov	r2, #0
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_dmul
	bl	__aeabi_d2iz
	mov	r3, #11
.L68:
	str	r0, [r7, #4]
	str	r3, [r7, #0]
	mov	r0, #0
	ldr	r1, .L76
	bl	strtok
	add	r6, r6, #8
	cmp	r6, #160
	mov	r4, r0
	bne	.L69
	add	r8, r8, #4
	cmp	r8, #80
	bne	.L70
	add	sp, sp, #276
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L75:
	ldr	r0, .L76+4
	bl	puts
	b	.L66
.L74:
	ldr	r0, .L76+8
	bl	puts
	mvn	r0, #0
	bl	exit
.L77:
	.align	2
.L76:
	.word	.LC1
	.word	.LC2
	.word	.LC0
	.size	buildMatrix, .-buildMatrix
	.align	2
	.global	printMatrix
	.type	printMatrix, %function
printMatrix:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	sub	sp, sp, #36
	str	r0, [sp, #28]
	mov	fp, #0
	mov	sl, #1
.L79:
	ldr	r3, [sp, #28]
	ldr	r6, [r3, fp]
	ldr	r0, [r6, #4]
	bl	__aeabi_i2d
	mov	r4, r0
	ldr	r0, [r6, #0]
	mov	r0, sl, asl r0
	mov	r5, r1
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	add	r7, r6, #8
	mov	r8, r0
	ldr	r0, [r7, #4]
	mov	r9, r1
	bl	__aeabi_i2d
	mov	r4, r0
	ldr	r0, [r6, #8]
	mov	r0, sl, asl r0
	mov	r5, r1
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	stmia	sp, {r0-r1}
	add	r3, r6, #16
	ldr	r0, [r3, #4]
	bl	__aeabi_i2d
	mov	r4, r0
	ldr	r0, [r6, #16]
	mov	r0, sl, asl r0
	mov	r5, r1
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	str	r0, [sp, #8]
	str	r1, [sp, #12]
	add	r3, r6, #24
	ldr	r0, [r3, #4]
	bl	__aeabi_i2d
	mov	r4, r0
	ldr	r0, [r6, #24]
	mov	r0, sl, asl r0
	mov	r5, r1
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	mov	r2, r8
	str	r0, [sp, #16]
	str	r1, [sp, #20]
	mov	r3, r9
	ldr	r0, .L82
	bl	printf
	ldr	r3, [sp, #28]
	ldr	r6, [r3, fp]
	ldr	r0, [r6, #36]
	bl	__aeabi_i2d
	mov	r4, r0
	ldr	r0, [r6, #32]
	mov	r0, sl, asl r0
	mov	r5, r1
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	add	r7, r6, #40
	mov	r8, r0
	ldr	r0, [r7, #4]
	mov	r9, r1
	bl	__aeabi_i2d
	mov	r4, r0
	ldr	r0, [r6, #40]
	mov	r0, sl, asl r0
	mov	r5, r1
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	stmia	sp, {r0-r1}
	add	r3, r6, #48
	ldr	r0, [r3, #4]
	bl	__aeabi_i2d
	mov	r4, r0
	ldr	r0, [r6, #48]
	mov	r0, sl, asl r0
	mov	r5, r1
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	str	r0, [sp, #8]
	str	r1, [sp, #12]
	add	r3, r6, #56
	ldr	r0, [r3, #4]
	bl	__aeabi_i2d
	mov	r4, r0
	ldr	r0, [r6, #56]
	mov	r0, sl, asl r0
	mov	r5, r1
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	mov	r2, r8
	str	r0, [sp, #16]
	str	r1, [sp, #20]
	mov	r3, r9
	ldr	r0, .L82
	bl	printf
	ldr	r3, [sp, #28]
	ldr	r6, [r3, fp]
	ldr	r0, [r6, #68]
	bl	__aeabi_i2d
	mov	r4, r0
	ldr	r0, [r6, #64]
	mov	r0, sl, asl r0
	mov	r5, r1
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	add	r7, r6, #72
	mov	r8, r0
	ldr	r0, [r7, #4]
	mov	r9, r1
	bl	__aeabi_i2d
	mov	r4, r0
	ldr	r0, [r6, #72]
	mov	r0, sl, asl r0
	mov	r5, r1
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	stmia	sp, {r0-r1}
	add	r3, r6, #80
	ldr	r0, [r3, #4]
	bl	__aeabi_i2d
	mov	r4, r0
	ldr	r0, [r6, #80]
	mov	r0, sl, asl r0
	mov	r5, r1
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	str	r0, [sp, #8]
	str	r1, [sp, #12]
	add	r3, r6, #88
	ldr	r0, [r3, #4]
	bl	__aeabi_i2d
	mov	r4, r0
	ldr	r0, [r6, #88]
	mov	r0, sl, asl r0
	mov	r5, r1
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	mov	r2, r8
	str	r0, [sp, #16]
	str	r1, [sp, #20]
	mov	r3, r9
	ldr	r0, .L82
	bl	printf
	ldr	r3, [sp, #28]
	ldr	r6, [r3, fp]
	ldr	r0, [r6, #100]
	bl	__aeabi_i2d
	mov	r4, r0
	ldr	r0, [r6, #96]
	mov	r0, sl, asl r0
	mov	r5, r1
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	add	r7, r6, #104
	mov	r8, r0
	ldr	r0, [r7, #4]
	mov	r9, r1
	bl	__aeabi_i2d
	mov	r4, r0
	ldr	r0, [r6, #104]
	mov	r0, sl, asl r0
	mov	r5, r1
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	stmia	sp, {r0-r1}
	add	r3, r6, #112
	ldr	r0, [r3, #4]
	bl	__aeabi_i2d
	mov	r4, r0
	ldr	r0, [r6, #112]
	mov	r0, sl, asl r0
	mov	r5, r1
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	str	r0, [sp, #8]
	str	r1, [sp, #12]
	add	r3, r6, #120
	ldr	r0, [r3, #4]
	bl	__aeabi_i2d
	mov	r4, r0
	ldr	r0, [r6, #120]
	mov	r0, sl, asl r0
	mov	r5, r1
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	mov	r2, r8
	str	r0, [sp, #16]
	str	r1, [sp, #20]
	mov	r3, r9
	ldr	r0, .L82
	bl	printf
	ldr	r3, [sp, #28]
	ldr	r6, [r3, fp]
	ldr	r0, [r6, #132]
	bl	__aeabi_i2d
	mov	r4, r0
	ldr	r0, [r6, #128]
	mov	r0, sl, asl r0
	mov	r5, r1
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	add	r7, r6, #136
	mov	r8, r0
	ldr	r0, [r7, #4]
	mov	r9, r1
	bl	__aeabi_i2d
	mov	r4, r0
	ldr	r0, [r6, #136]
	mov	r0, sl, asl r0
	mov	r5, r1
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	stmia	sp, {r0-r1}
	add	r3, r6, #144
	ldr	r0, [r3, #4]
	bl	__aeabi_i2d
	mov	r4, r0
	ldr	r0, [r6, #144]
	mov	r0, sl, asl r0
	mov	r5, r1
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	str	r0, [sp, #8]
	str	r1, [sp, #12]
	add	r3, r6, #152
	ldr	r0, [r3, #4]
	bl	__aeabi_i2d
	mov	r4, r0
	ldr	r0, [r6, #152]
	mov	r0, sl, asl r0
	mov	r5, r1
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	mov	r2, r8
	str	r0, [sp, #16]
	str	r1, [sp, #20]
	mov	r3, r9
	ldr	r0, .L82
	bl	printf
	add	fp, fp, #4
	mov	r0, #10
	bl	putchar
	cmp	fp, #80
	bne	.L79
	add	sp, sp, #36
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L83:
	.align	2
.L82:
	.word	.LC3
	.size	printMatrix, .-printMatrix
	.align	2
	.global	invertMatrix
	.type	invertMatrix, %function
invertMatrix:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	sub	sp, sp, #44
	mov	ip, #0
	str	r0, [sp, #16]
	str	r1, [sp, #12]
	mov	r4, ip
	mov	r6, #2048
	mov	r5, #11
.L85:
	ldr	r1, [sp, #12]
	ldr	r0, [r1, ip, asl #2]
	mov	r3, ip, asl #3
	mov	r2, #0
	add	lr, r0, r3
	mov	r1, r2
.L88:
	cmp	ip, r2
	addne	r3, r0, r1
	add	r2, r2, #1
	strne	r4, [r0, r1]
	streq	r6, [lr, #4]
	streq	r5, [lr, #0]
	strne	r4, [r3, #4]
	cmp	r2, #20
	add	r1, r1, #8
	bne	.L88
	add	ip, ip, #1
	cmp	ip, #20
	bne	.L85
	ldr	r2, [sp, #16]
	add	r3, sp, #32
	ldr	fp, [sp, #12]
	str	r3, [sp, #4]
	add	r9, r2, #4
	mov	sl, #0
	add	r8, sp, #24
.L101:
	ldr	r1, [r9, #-4]
	mov	r7, sl, asl #3
	add	r3, r1, r7
	str	r1, [sp, #20]
	ldr	r2, [sp, #4]
	ldmia	r3, {r0, r1}
	stmia	r2, {r0, r1}
	ldr	r3, [sp, #36]
	cmp	r3, #0
	beq	.L90
	mov	r4, r3
	add	r3, r9, #4
	str	r3, [sp, #8]
	ldr	r2, [sp, #20]
	ldr	r3, [sp, #4]
.L91:
	str	r4, [sp, #36]
	ldmia	r3, {r0, r1}
	bl	divideRow
	str	r4, [sp, #36]
	ldr	r3, [sp, #4]
	str	r0, [r9, #-4]
	ldr	r2, [fp, #0]
	ldmia	r3, {r0, r1}
	bl	divideRow
	ldr	r6, [sp, #16]
	str	r0, [fp, #0]
	ldr	r5, [sp, #12]
	mov	r4, #0
.L100:
	cmp	sl, r4
	beq	.L98
	ldr	r2, [r6, #0]
	add	r3, r2, r7
	ldmia	r3, {r0, r1}
	ldr	r3, [r9, #-4]
	stmia	r8, {r0, r1}
	bl	subtractRowTimes
	str	r0, [r6, #0]
	ldr	r3, [fp, #0]
	ldr	r2, [r5, #0]
	ldmia	r8, {r0, r1}
	bl	subtractRowTimes
	str	r0, [r5, #0]
.L98:
	add	r3, r4, #1
	cmp	sl, r3
	beq	.L99
	ldr	r2, [r6, #4]
	add	r3, r2, r7
	ldmia	r3, {r0, r1}
	ldr	r3, [r9, #-4]
	stmia	r8, {r0, r1}
	bl	subtractRowTimes
	str	r0, [r6, #4]
	ldr	r3, [fp, #0]
	ldr	r2, [r5, #4]
	ldmia	r8, {r0, r1}
	bl	subtractRowTimes
	str	r0, [r5, #4]
.L99:
	add	r4, r4, #2
	cmp	r4, #20
	add	r6, r6, #8
	add	r5, r5, #8
	bne	.L100
	add	sl, sl, #1
	cmp	sl, #20
	add	fp, fp, #4
	ldr	r9, [sp, #8]
	bne	.L101
	mov	r0, #1
	add	sp, sp, #44
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L90:
	cmp	sl, #19
	bgt	.L92
	add	r1, r9, #4
	str	r1, [sp, #8]
	mov	r5, r1
	mov	r4, r3
	mov	ip, sl
	ldr	r1, [sp, #20]
	mov	lr, r9
	mov	r6, r3
	b	.L96
.L106:
	ldr	r1, [r5, #-8]
.L96:
	add	r3, r1, r7
	ldr	r2, [r3, #4]
	ldr	r1, [r1, r7]
	mov	r2, r2, asr r1
	cmp	r2, #0
	rsblt	r2, r2, #0
	ldr	r0, [lr, #0]
	cmp	r2, r4
	movgt	r4, r2
	add	r2, r0, r7
	ldr	r3, [r2, #4]
	ldr	r1, [r0, r7]
	mov	r3, r3, asr r1
	movgt	r6, ip
	cmp	r3, #0
	rsblt	r3, r3, #0
	cmp	r3, r4
	add	r2, ip, #1
	add	ip, ip, #2
	movgt	r4, r3
	movgt	r6, r2
	cmp	ip, #19
	add	r5, r5, #8
	add	lr, lr, #8
	ble	.L106
	cmp	r6, #0
	beq	.L92
	ldr	r2, [sp, #16]
	ldr	r3, [r2, r6, asl #2]
	str	r3, [r9, #-4]
	ldr	r3, [sp, #20]
	ldr	r1, [sp, #12]
	str	r3, [r2, r6, asl #2]
	ldr	r2, [fp, #0]
	ldr	r3, [r1, r6, asl #2]
	str	r3, [fp, #0]
	str	r2, [r1, r6, asl #2]
	ldr	r2, [r9, #-4]
	add	r3, r2, r7
	ldmia	r3, {r0, r1}
	ldr	r3, [sp, #4]
	stmia	r3, {r0, r1}
	str	r2, [sp, #20]
	ldr	r4, [sp, #36]
	b	.L91
.L92:
	mov	r1, sl
	ldr	r0, .L107
	bl	printf
	mvn	r0, #0
	bl	exit
.L108:
	.align	2
.L107:
	.word	.LC4
	.size	invertMatrix, .-invertMatrix
	.global	__aeabi_dcmpge
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 256
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	cmp	r0, #2
	sub	sp, sp, #256
	mov	r4, r0
	beq	.L110
	ldr	r0, .L123
	bl	puts
.L111:
	mvn	r0, #0
.L109:
	add	sp, sp, #256
	ldmfd	sp!, {r4, r5, r6, r7, r8, lr}
	bx	lr
.L110:
	ldr	r0, [r1, #4]
	ldr	r1, .L123+4
	bl	fopen
	mov	r1, #255
	mov	r2, r0
	mov	r8, r0
	add	r0, sp, #1
	bl	fgets
	mov	r1, #0
	mov	r2, #10
	bl	strtol
	cmp	r0, #20
	beq	.L112
	mov	r1, #20
	mov	r2, r1
	ldr	r0, .L123+8
	bl	printf
	b	.L111
.L112:
	mov	r2, r0
	mov	r1, r4
	ldr	r0, .L123+12
	bl	printf
	mov	r0, #80
	bl	malloc
	mov	r6, #0
	mov	r7, r0
.L113:
	mov	r0, #160
	bl	malloc
	str	r0, [r7, r6]
	add	r6, r6, #4
	cmp	r6, #80
	bne	.L113
	mov	r1, r7
	mov	r0, r8
	bl	buildMatrix
	mov	r0, r7
	bl	computeConditionNumber
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r4, r0
	ldr	r0, .L123+16
	mov	r5, r1
	bl	printf
	mov	r3, #1073741824
	mov	r0, r4
	mov	r1, r5
	mov	r2, #0
	add	r3, r3, #3735552
	bl	__aeabi_dcmpge
	cmp	r0, #0
	bne	.L122
	ldr	r0, .L123+20
	bl	puts
	mov	r0, r7
	bl	printMatrix
	mov	r0, r6
	bl	malloc
	mov	r4, #0
	mov	r6, r0
.L116:
	mov	r0, #160
	bl	malloc
	str	r0, [r6, r4]
	add	r4, r4, #4
	cmp	r4, #80
	bne	.L116
	mov	r1, r6
	mov	r0, r7
	bl	invertMatrix
	ldr	r0, .L123+24
	bl	puts
	mov	r0, r6
	bl	printMatrix
	mov	r0, r8
	bl	fclose
	mov	r0, r7
	bl	free
	mov	r0, r6
	bl	free
	b	.L109
.L122:
	mov	r0, r8
	bl	fclose
	mov	r0, r7
	bl	free
	ldr	r0, .L123+28
	bl	puts
	b	.L111
.L124:
	.align	2
.L123:
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.word	.LC11
	.word	.LC12
	.word	.LC10
	.size	main, .-main
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	C.14.3172, %object
	.size	C.14.3172, 8
C.14.3172:
	.space	8
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Error! Could not open file\000"
	.space	1
.LC1:
	.ascii	" \000"
	.space	2
.LC2:
	.ascii	" Null token\000"
.LC3:
	.ascii	"%f %f %f %f \000"
	.space	3
.LC4:
	.ascii	"Error! Matrix is not invertable. There is no usable"
	.ascii	" value to pivot in column %d\012\000"
	.space	3
.LC5:
	.ascii	"Error, need input filename.\000"
.LC6:
	.ascii	"r\000"
	.space	2
.LC7:
	.ascii	"Error, incorrect matrix size. Must be a %dX%d matri"
	.ascii	"x.\012\000"
	.space	1
.LC8:
	.ascii	" Matrix size = %d, argc: %d\012\000"
	.space	3
.LC9:
	.ascii	"Condition number of the matrix: %f\012\000"
.LC10:
	.ascii	"Input matix is not well-conditioned. Exiting progra"
	.ascii	"m.\000"
	.space	2
.LC11:
	.ascii	"Input Matrix\000"
	.space	3
.LC12:
	.ascii	"Inverted Matrix\000"
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits