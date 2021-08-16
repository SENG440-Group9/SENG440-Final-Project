	.file	"MatrixInversion.c"
	.text
	.p2align 4,,15
	.globl	fixedToFloat
	.type	fixedToFloat, @function
fixedToFloat:
.LFB63:
	.cfi_startproc
	pxor	%xmm0, %xmm0
	movq	%rdi, %rax
	sarq	$32, %rax
	pxor	%xmm1, %xmm1
	movl	%edi, %ecx
	cvtsi2sd	%eax, %xmm0
	movl	$1, %eax
	sall	%cl, %eax
	cvtsi2sd	%eax, %xmm1
	divsd	%xmm1, %xmm0
	ret
	.cfi_endproc
.LFE63:
	.size	fixedToFloat, .-fixedToFloat
	.p2align 4,,15
	.globl	floatToFixed
	.type	floatToFixed, @function
floatToFixed:
.LFB64:
	.cfi_startproc
	ucomisd	.LC0(%rip), %xmm0
	jp	.L7
	jne	.L7
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L7:
	mulsd	.LC1(%rip), %xmm0
	cvttsd2si	%xmm0, %eax
	salq	$32, %rax
	orq	$11, %rax
	ret
	.cfi_endproc
.LFE64:
	.size	floatToFixed, .-floatToFixed
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"%f %f %f %f "
	.text
	.p2align 4,,15
	.globl	printMatrix
	.type	printMatrix, @function
printMatrix:
.LFB65:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	leaq	160(%rdi), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rdi, %r13
	movl	$1, %ebp
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	.p2align 4,,10
	.p2align 3
.L10:
	movl	$24, %ebx
.L11:
	movq	0(%r13), %rax
	pxor	%xmm3, %xmm3
	pxor	%xmm6, %xmm6
	pxor	%xmm5, %xmm5
	leaq	(%rax,%rbx), %rcx
	leaq	-8(%rax,%rbx), %rdi
	leaq	-16(%rax,%rbx), %rsi
	leaq	-24(%rax,%rbx), %rdx
	movl	%ebp, %eax
	addq	$32, %rbx
	cvtsi2sd	4(%rcx), %xmm3
	movl	(%rcx), %ecx
	pxor	%xmm4, %xmm4
	pxor	%xmm7, %xmm7
	pxor	%xmm2, %xmm2
	sall	%cl, %eax
	movl	(%rdi), %ecx
	cvtsi2sd	%eax, %xmm6
	movl	%ebp, %eax
	pxor	%xmm1, %xmm1
	cvtsi2sd	4(%rdi), %xmm2
	movl	$1, %edi
	sall	%cl, %eax
	movl	(%rsi), %ecx
	cvtsi2sd	%eax, %xmm5
	movl	%ebp, %eax
	pxor	%xmm0, %xmm0
	cvtsi2sd	4(%rsi), %xmm1
	leaq	.LC2(%rip), %rsi
	sall	%cl, %eax
	movl	(%rdx), %ecx
	cvtsi2sd	%eax, %xmm4
	movl	%ebp, %eax
	cvtsi2sd	4(%rdx), %xmm0
	sall	%cl, %eax
	cvtsi2sd	%eax, %xmm7
	movl	$4, %eax
	divsd	%xmm6, %xmm3
	divsd	%xmm7, %xmm0
	divsd	%xmm5, %xmm2
	divsd	%xmm4, %xmm1
	call	__printf_chk@PLT
	cmpq	$184, %rbx
	jne	.L11
	movl	$10, %edi
	addq	$8, %r13
	call	putchar@PLT
	cmpq	%r13, %r12
	jne	.L10
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE65:
	.size	printMatrix, .-printMatrix
	.section	.rodata.str1.1
.LC3:
	.string	"Error! Could not open file"
.LC4:
	.string	" "
.LC5:
	.string	" Null token"
	.text
	.p2align 4,,15
	.globl	buildMatrix
	.type	buildMatrix, @function
buildMatrix:
.LFB66:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$312, %rsp
	.cfi_def_cfa_offset 368
	movq	%fs:40, %rax
	movq	%rax, 296(%rsp)
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.L30
	leaq	160(%rsi), %r15
	leaq	32(%rsp), %r13
	leaq	24(%rsp), %r12
	movq	%rdi, %r14
	movq	%rsi, %rbp
	.p2align 4,,10
	.p2align 3
.L23:
	movq	%r14, %rdx
	movl	$255, %esi
	movq	%r13, %rdi
	call	fgets@PLT
	leaq	.LC4(%rip), %rsi
	movq	%r13, %rdi
	call	strtok@PLT
	testq	%rax, %rax
	movq	%rax, %rdx
	je	.L31
.L17:
	xorl	%ebx, %ebx
	jmp	.L18
	.p2align 4,,10
	.p2align 3
.L25:
	mulsd	.LC1(%rip), %xmm0
	movl	$11, (%rdx)
	cvttsd2si	%xmm0, %eax
	movl	%eax, 4(%rdx)
.L29:
	leaq	.LC4(%rip), %rsi
	xorl	%edi, %edi
	addq	$8, %rbx
	call	strtok@PLT
	cmpq	$160, %rbx
	movq	%rax, %rdx
	je	.L32
.L18:
	movq	%rdx, %rdi
	movq	%r12, %rsi
	call	strtod@PLT
	movq	0(%rbp), %rdx
	pxor	%xmm1, %xmm1
	addq	%rbx, %rdx
	ucomisd	%xmm1, %xmm0
	jp	.L25
	jne	.L25
	movq	$0, (%rdx)
	jmp	.L29
.L31:
	leaq	.LC5(%rip), %rdi
	movq	%rax, 8(%rsp)
	call	puts@PLT
	movq	8(%rsp), %rdx
	jmp	.L17
	.p2align 4,,10
	.p2align 3
.L32:
	addq	$8, %rbp
	cmpq	%rbp, %r15
	jne	.L23
	movq	296(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L33
	addq	$312, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L30:
	.cfi_restore_state
	leaq	.LC3(%rip), %rdi
	call	puts@PLT
	orl	$-1, %edi
	call	exit@PLT
.L33:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE66:
	.size	buildMatrix, .-buildMatrix
	.p2align 4,,15
	.globl	generateIdentityMatrix
	.type	generateIdentityMatrix, @function
generateIdentityMatrix:
.LFB67:
	.cfi_startproc
	xorl	%esi, %esi
	.p2align 4,,10
	.p2align 3
.L38:
	movq	(%rdi,%rsi,8), %rdx
	movl	%esi, %ecx
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L37:
	cmpl	%eax, %ecx
	je	.L35
	movl	$0, (%rdx,%rax,8)
	movl	$0, 4(%rdx,%rax,8)
.L36:
	addq	$1, %rax
	cmpq	$20, %rax
	jne	.L37
	addq	$1, %rsi
	cmpq	$20, %rsi
	jne	.L38
	rep ret
	.p2align 4,,10
	.p2align 3
.L35:
	movl	$11, (%rdx,%rax,8)
	movl	$2048, 4(%rdx,%rax,8)
	jmp	.L36
	.cfi_endproc
.LFE67:
	.size	generateIdentityMatrix, .-generateIdentityMatrix
	.p2align 4,,15
	.globl	divideRow
	.type	divideRow, @function
divideRow:
.LFB68:
	.cfi_startproc
	movq	%rdi, %rdx
	movq	%rsi, %rax
	leaq	160(%rsi), %r10
	sarq	$32, %rdx
	cmpl	$11, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	setne	%r11b
	cmpl	$1024, %edx
	movl	%edx, %r8d
	setne	%dl
	movl	%edi, %r9d
	orl	%edx, %r11d
	movq	%rsi, %rdx
	movl	$11, %esi
	jmp	.L51
	.p2align 4,,10
	.p2align 3
.L49:
#APP
# 139 "MatrixInversion.c" 1
	SDR %edi, %ecx, %r8d
# 0 "" 2
#NO_APP
	movl	8(%rdx), %ecx
	movl	%edi, 12(%rdx)
	addl	$11, %ecx
	subl	%r9d, %ecx
	testl	%edi, %edi
	movl	%ecx, 8(%rdx)
	je	.L48
	cmpl	$11, %ecx
	jle	.L50
	subl	$11, %ecx
	movl	$11, 8(%rdx)
	sarl	%cl, %edi
	movl	%edi, 12(%rdx)
	.p2align 4,,10
	.p2align 3
.L48:
	addq	$16, %rdx
	cmpq	%rdx, %r10
	je	.L73
.L51:
	movl	4(%rdx), %ecx
	testl	%ecx, %ecx
	je	.L43
	testb	%r11b, %r11b
	je	.L48
#APP
# 114 "MatrixInversion.c" 1
	SDR %edi, %ecx, %r8d
# 0 "" 2
#NO_APP
	movl	(%rdx), %ecx
	movl	%edi, 4(%rdx)
	addl	$11, %ecx
	subl	%r9d, %ecx
	testl	%edi, %edi
	movl	%ecx, (%rdx)
	je	.L43
	cmpl	$11, %ecx
	jle	.L46
	subl	$11, %ecx
	movl	$11, (%rdx)
	sarl	%cl, %edi
	movl	%edi, 4(%rdx)
	.p2align 4,,10
	.p2align 3
.L43:
	movl	12(%rdx), %ecx
	testl	%ecx, %ecx
	je	.L48
	cmpl	$1024, %r8d
	jne	.L49
	cmpl	$11, %r9d
	jne	.L49
	addq	$16, %rdx
	cmpq	%rdx, %r10
	jne	.L51
.L73:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L46:
	.cfi_restore_state
	je	.L43
	movl	%esi, %ebx
	movl	$11, (%rdx)
	subl	%ecx, %ebx
	movl	%ebx, %ecx
	sall	%cl, %edi
	movl	%edi, 4(%rdx)
	jmp	.L43
	.p2align 4,,10
	.p2align 3
.L50:
	je	.L48
	movl	%esi, %ebx
	movl	$11, 8(%rdx)
	subl	%ecx, %ebx
	movl	%ebx, %ecx
	sall	%cl, %edi
	movl	%edi, 12(%rdx)
	jmp	.L48
	.cfi_endproc
.LFE68:
	.size	divideRow, .-divideRow
	.p2align 4,,15
	.globl	subtractRowTimes
	.type	subtractRowTimes, @function
subtractRowTimes:
.LFB69:
	.cfi_startproc
	movl	%edi, %r10d
	movq	%rsi, %rax
	shrq	$32, %rdi
	xorl	%r8d, %r8d
	movl	$11, %r11d
	.p2align 4,,10
	.p2align 3
.L106:
	testl	%edi, %edi
	je	.L112
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
.L107:
	movl	4(%rdx,%r8), %ecx
	testl	%ecx, %ecx
	je	.L81
	movl	(%rdx,%r8), %ebx
	movl	(%rax,%r8), %ebp
	imull	%edi, %ecx
	movl	4(%rax,%r8), %esi
	addl	%r10d, %ebx
	subl	$11, %ebx
	sarl	$11, %ecx
	cmpl	%ebx, %ebp
	movl	%ecx, %r9d
	jge	.L78
	movl	%ebx, %ecx
	movl	%ebx, (%rax,%r8)
	subl	%ebp, %ecx
	movl	%ebx, %ebp
	sall	%cl, %esi
.L79:
	subl	%r9d, %esi
	testl	%esi, %esi
	movl	%esi, 4(%rax,%r8)
	je	.L81
	cmpl	$11, %ebp
	jle	.L80
	leal	-11(%rbp), %ecx
	movl	$11, (%rax,%r8)
	sarl	%cl, %esi
	movl	%esi, 4(%rax,%r8)
	.p2align 4,,10
	.p2align 3
.L81:
	movl	12(%rdx,%r8), %ecx
	testl	%ecx, %ecx
	je	.L76
	movl	8(%rdx,%r8), %ebx
	movl	8(%rax,%r8), %ebp
	imull	%edi, %ecx
	movl	12(%rax,%r8), %esi
	addl	%r10d, %ebx
	subl	$11, %ebx
	sarl	$11, %ecx
	cmpl	%ebx, %ebp
	movl	%ecx, %r9d
	jge	.L82
	movl	%ebx, %ecx
	movl	%ebx, 8(%rax,%r8)
	subl	%ebp, %ecx
	movl	%ebx, %ebp
	sall	%cl, %esi
.L83:
	subl	%r9d, %esi
	testl	%esi, %esi
	movl	%esi, 12(%rax,%r8)
	je	.L76
	cmpl	$11, %ebp
	jle	.L85
	leal	-11(%rbp), %ecx
	movl	$11, 8(%rax,%r8)
	sarl	%cl, %esi
	movl	%esi, 12(%rax,%r8)
	.p2align 4,,10
	.p2align 3
.L76:
	addq	$16, %r8
	cmpq	$160, %r8
	je	.L113
.L86:
	testl	%edi, %edi
	jne	.L107
	addq	$16, %r8
	cmpq	$160, %r8
	jne	.L86
.L113:
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L112:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 14
	addq	$16, %r8
	cmpq	$160, %r8
	jne	.L106
	rep ret
	.p2align 4,,10
	.p2align 3
.L78:
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 14, -16
	movl	%ebp, %ecx
	movl	%r9d, %r14d
	subl	%ebx, %ecx
	sall	%cl, %r14d
	cmpl	%ebx, %ebp
	cmovg	%r14d, %r9d
	jmp	.L79
	.p2align 4,,10
	.p2align 3
.L82:
	movl	%ebp, %ecx
	movl	%r9d, %r14d
	subl	%ebx, %ecx
	sall	%cl, %r14d
	cmpl	%ebx, %ebp
	cmovg	%r14d, %r9d
	jmp	.L83
	.p2align 4,,10
	.p2align 3
.L85:
	je	.L76
	movl	%r11d, %ecx
	movl	$11, 8(%rax,%r8)
	subl	%ebp, %ecx
	sall	%cl, %esi
	movl	%esi, 12(%rax,%r8)
	jmp	.L76
	.p2align 4,,10
	.p2align 3
.L80:
	je	.L81
	movl	%r11d, %ecx
	movl	$11, (%rax,%r8)
	subl	%ebp, %ecx
	sall	%cl, %esi
	movl	%esi, 4(%rax,%r8)
	jmp	.L81
	.cfi_endproc
.LFE69:
	.size	subtractRowTimes, .-subtractRowTimes
	.p2align 4,,15
	.globl	getSwapRow
	.type	getSwapRow, @function
getSwapRow:
.LFB70:
	.cfi_startproc
	cmpl	$19, %esi
	jg	.L119
	movslq	%esi, %r8
	movl	$19, %r11d
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subq	%rsi, %r11
	leaq	2(%r8), %rsi
	leaq	0(,%r8,8), %r10
	andl	$4294967294, %r11d
	xorl	%eax, %eax
	xorl	%r9d, %r9d
	addq	%rsi, %r11
	jmp	.L118
	.p2align 4,,10
	.p2align 3
.L125:
	addq	$2, %rsi
.L118:
	movq	(%rdi,%r8,8), %rdx
	addq	%r10, %rdx
	movl	(%rdx), %ecx
	movl	4(%rdx), %edx
	sarl	%cl, %edx
	movl	%edx, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %edx
	subl	%ecx, %edx
	cmpl	%r9d, %edx
	jle	.L116
	movl	%r8d, %eax
	movl	%edx, %r9d
.L116:
	movq	8(%rdi,%r8,8), %rdx
	leal	1(%r8), %ebx
	addq	%r10, %rdx
	movl	(%rdx), %ecx
	movl	4(%rdx), %edx
	sarl	%cl, %edx
	movl	%edx, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %edx
	subl	%ecx, %edx
	cmpl	%r9d, %edx
	jle	.L117
	movl	%ebx, %eax
	movl	%edx, %r9d
.L117:
	cmpq	%rsi, %r11
	movq	%rsi, %r8
	jne	.L125
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L119:
	.cfi_restore 3
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE70:
	.size	getSwapRow, .-getSwapRow
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC6:
	.string	"Error! Matrix is not invertable. There is no usable value to pivot in column %d\n"
	.text
	.p2align 4,,15
	.globl	invertMatrix
	.type	invertMatrix, @function
invertMatrix:
.LFB71:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbp
	movq	%rsi, %rbx
	xorl	%esi, %esi
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	.p2align 4,,10
	.p2align 3
.L130:
	movq	(%rbx,%rsi,8), %rdx
	movl	%esi, %ecx
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L129:
	cmpl	%eax, %ecx
	je	.L127
	movl	$0, (%rdx,%rax,8)
	movl	$0, 4(%rdx,%rax,8)
.L128:
	addq	$1, %rax
	cmpq	$20, %rax
	jne	.L129
	addq	$1, %rsi
	cmpq	$20, %rsi
	jne	.L130
	movq	%rbp, %r12
	movq	%rbx, 8(%rsp)
	movq	$0, 24(%rsp)
	.p2align 4,,10
	.p2align 3
.L156:
	movq	24(%rsp), %rdi
	movq	(%r12), %rsi
	leaq	0(,%rdi,8), %r13
	movl	%edi, 20(%rsp)
	leaq	(%rsi,%r13), %rax
	movl	4(%rax), %edx
	movq	(%rax), %rcx
	movq	%rdi, %rax
	addl	$1, %eax
	testl	%edx, %edx
	jne	.L132
	movq	8(%r12), %rdx
	addq	%r13, %rdx
	movl	(%rdx), %ecx
	movl	4(%rdx), %r8d
	sarl	%cl, %r8d
	testl	%r8d, %r8d
	je	.L157
	movl	%r8d, %edx
	sarl	$31, %edx
	xorl	%edx, %r8d
	subl	%edx, %r8d
.L133:
	leal	2(%rdi), %r9d
	cmpl	$19, %r9d
	ja	.L134
	movq	16(%r12), %rdx
	addq	%r13, %rdx
	movl	(%rdx), %ecx
	movl	4(%rdx), %edx
	sarl	%cl, %edx
	movl	%edx, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %edx
	subl	%ecx, %edx
	cmpl	%edx, %r8d
	jl	.L135
	movl	%eax, %r9d
	movl	%r8d, %edx
.L135:
	movq	24(%r12), %r8
	leal	3(%rdi), %eax
	addq	%r13, %r8
	movl	(%r8), %ecx
	movl	4(%r8), %r8d
	sarl	%cl, %r8d
	movl	%r8d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r8d
	subl	%ecx, %r8d
	cmpl	%r8d, %edx
	jl	.L136
	movl	%r9d, %eax
	movl	%edx, %r8d
.L136:
	leal	4(%rdi), %r10d
	cmpl	$19, %r10d
	ja	.L134
	movq	32(%r12), %rdx
	addq	%r13, %rdx
	movl	(%rdx), %ecx
	movl	4(%rdx), %r9d
	sarl	%cl, %r9d
	movl	%r9d, %edx
	sarl	$31, %edx
	xorl	%edx, %r9d
	subl	%edx, %r9d
	cmpl	%r9d, %r8d
	jl	.L137
	movl	%eax, %r10d
	movl	%r8d, %r9d
.L137:
	movq	40(%r12), %rdx
	leal	5(%rdi), %eax
	addq	%r13, %rdx
	movl	(%rdx), %ecx
	movl	4(%rdx), %edx
	sarl	%cl, %edx
	movl	%edx, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %edx
	subl	%ecx, %edx
	cmpl	%edx, %r9d
	jl	.L138
	movl	%r10d, %eax
	movl	%r9d, %edx
.L138:
	leal	6(%rdi), %r9d
	cmpl	$19, %r9d
	ja	.L134
	movq	48(%r12), %r8
	addq	%r13, %r8
	movl	(%r8), %ecx
	movl	4(%r8), %r8d
	sarl	%cl, %r8d
	movl	%r8d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r8d
	subl	%ecx, %r8d
	cmpl	%r8d, %edx
	jl	.L139
	movl	%eax, %r9d
	movl	%edx, %r8d
.L139:
	movq	56(%r12), %rdx
	leal	7(%rdi), %eax
	addq	%r13, %rdx
	movl	(%rdx), %ecx
	movl	4(%rdx), %edx
	sarl	%cl, %edx
	movl	%edx, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %edx
	subl	%ecx, %edx
	cmpl	%edx, %r8d
	jl	.L140
	movl	%r9d, %eax
	movl	%r8d, %edx
.L140:
	leal	8(%rdi), %r9d
	cmpl	$19, %r9d
	ja	.L134
	movq	64(%r12), %r8
	addq	%r13, %r8
	movl	(%r8), %ecx
	movl	4(%r8), %r8d
	sarl	%cl, %r8d
	movl	%r8d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r8d
	subl	%ecx, %r8d
	cmpl	%r8d, %edx
	jl	.L141
	movl	%eax, %r9d
	movl	%edx, %r8d
.L141:
	movq	72(%r12), %rdx
	leal	9(%rdi), %eax
	addq	%r13, %rdx
	movl	(%rdx), %ecx
	movl	4(%rdx), %edx
	sarl	%cl, %edx
	movl	%edx, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %edx
	subl	%ecx, %edx
	cmpl	%edx, %r8d
	jl	.L142
	movl	%r9d, %eax
	movl	%r8d, %edx
.L142:
	leal	10(%rdi), %r9d
	cmpl	$19, %r9d
	ja	.L134
	movq	80(%r12), %r8
	addq	%r13, %r8
	movl	(%r8), %ecx
	movl	4(%r8), %r8d
	sarl	%cl, %r8d
	movl	%r8d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r8d
	subl	%ecx, %r8d
	cmpl	%r8d, %edx
	jl	.L143
	movl	%eax, %r9d
	movl	%edx, %r8d
.L143:
	movq	88(%r12), %rdx
	leal	11(%rdi), %eax
	addq	%r13, %rdx
	movl	(%rdx), %ecx
	movl	4(%rdx), %edx
	sarl	%cl, %edx
	movl	%edx, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %edx
	subl	%ecx, %edx
	cmpl	%edx, %r8d
	jl	.L144
	movl	%r9d, %eax
	movl	%r8d, %edx
.L144:
	leal	12(%rdi), %r9d
	cmpl	$19, %r9d
	ja	.L134
	movq	96(%r12), %r8
	addq	%r13, %r8
	movl	(%r8), %ecx
	movl	4(%r8), %r8d
	sarl	%cl, %r8d
	movl	%r8d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r8d
	subl	%ecx, %r8d
	cmpl	%r8d, %edx
	jl	.L145
	movl	%eax, %r9d
	movl	%edx, %r8d
.L145:
	movq	104(%r12), %rdx
	leal	13(%rdi), %eax
	addq	%r13, %rdx
	movl	(%rdx), %ecx
	movl	4(%rdx), %edx
	sarl	%cl, %edx
	movl	%edx, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %edx
	subl	%ecx, %edx
	cmpl	%edx, %r8d
	jl	.L146
	movl	%r9d, %eax
	movl	%r8d, %edx
.L146:
	leal	14(%rdi), %r9d
	cmpl	$19, %r9d
	ja	.L134
	movq	112(%r12), %r8
	addq	%r13, %r8
	movl	(%r8), %ecx
	movl	4(%r8), %r8d
	sarl	%cl, %r8d
	movl	%r8d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r8d
	subl	%ecx, %r8d
	cmpl	%r8d, %edx
	jl	.L147
	movl	%eax, %r9d
	movl	%edx, %r8d
.L147:
	movq	120(%r12), %rdx
	leal	15(%rdi), %eax
	addq	%r13, %rdx
	movl	(%rdx), %ecx
	movl	4(%rdx), %edx
	sarl	%cl, %edx
	movl	%edx, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %edx
	subl	%ecx, %edx
	cmpl	%edx, %r8d
	jl	.L148
	movl	%r9d, %eax
	movl	%r8d, %edx
.L148:
	leal	16(%rdi), %r9d
	cmpl	$19, %r9d
	ja	.L134
	movq	128(%r12), %r8
	addq	%r13, %r8
	movl	(%r8), %ecx
	movl	4(%r8), %r8d
	sarl	%cl, %r8d
	movl	%r8d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r8d
	subl	%ecx, %r8d
	cmpl	%r8d, %edx
	jl	.L149
	movl	%eax, %r9d
	movl	%edx, %r8d
.L149:
	movq	136(%r12), %rax
	leal	17(%rdi), %r10d
	addq	%r13, %rax
	movl	(%rax), %ecx
	movl	4(%rax), %edx
	sarl	%cl, %edx
	movl	%edx, %eax
	sarl	$31, %eax
	xorl	%eax, %edx
	subl	%eax, %edx
	cmpl	%edx, %r8d
	jl	.L150
	movl	%r9d, %r10d
	movl	%r8d, %edx
.L150:
	leal	18(%rdi), %eax
	cmpl	$19, %eax
	ja	.L158
	movq	144(%r12), %r8
	addq	%r13, %r8
	movl	(%r8), %ecx
	movl	4(%r8), %r8d
	sarl	%cl, %r8d
	movl	%r8d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r8d
	subl	%ecx, %r8d
	cmpl	%r8d, %edx
	jl	.L151
	movl	%r10d, %eax
	movl	%edx, %r8d
.L151:
	movq	152(%r12), %rdx
	addl	$19, %edi
	addq	%r13, %rdx
	movl	(%rdx), %ecx
	movl	4(%rdx), %edx
	sarl	%cl, %edx
	movl	%edx, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %edx
	subl	%ecx, %edx
	cmpl	%edx, %r8d
	jge	.L134
	movl	%edi, %eax
	.p2align 4,,10
	.p2align 3
.L152:
	cltq
	movq	8(%rsp), %rdi
	salq	$3, %rax
	leaq	0(%rbp,%rax), %rdx
	addq	%rbx, %rax
	movq	(%rdx), %rcx
	movq	%rcx, (%r12)
	movq	%rsi, (%rdx)
	movq	(%rax), %rcx
	movq	(%rdi), %rdx
	movq	%rcx, (%rdi)
	movq	%rdx, (%rax)
	movq	(%r12), %rsi
	leaq	(%rsi,%r13), %rax
	movq	(%rax), %rcx
	movl	4(%rax), %edx
.L132:
	movq	%rdx, %rax
	movl	%ecx, %edx
	salq	$32, %rax
	orq	%rax, %rdx
	movq	%rdx, %rdi
	movq	%rdx, %r15
	call	divideRow
	movq	8(%rsp), %r14
	movq	%rax, (%r12)
	movq	%r15, %rdi
	xorl	%r15d, %r15d
	movq	(%r14), %rsi
	call	divideRow
	movq	%rax, (%r14)
	.p2align 4,,10
	.p2align 3
.L155:
	cmpl	%r15d, 20(%rsp)
	je	.L153
	movq	0(%rbp,%r15,8), %rsi
	movq	(%r12), %rdx
	movq	(%rsi,%r13), %r14
	movq	%r14, %rdi
	call	subtractRowTimes
	movq	%rax, 0(%rbp,%r15,8)
	movq	8(%rsp), %rax
	movq	%r14, %rdi
	movq	(%rbx,%r15,8), %rsi
	movq	(%rax), %rdx
	call	subtractRowTimes
	movq	%rax, (%rbx,%r15,8)
.L153:
	leal	1(%r15), %eax
	cmpl	20(%rsp), %eax
	je	.L154
	movq	8(%rbp,%r15,8), %rsi
	movq	(%r12), %rdx
	movq	(%rsi,%r13), %r14
	movq	%r14, %rdi
	call	subtractRowTimes
	movq	%rax, 8(%rbp,%r15,8)
	movq	8(%rsp), %rax
	movq	%r14, %rdi
	movq	8(%rbx,%r15,8), %rsi
	movq	(%rax), %rdx
	call	subtractRowTimes
	movq	%rax, 8(%rbx,%r15,8)
.L154:
	addq	$2, %r15
	cmpq	$20, %r15
	jne	.L155
	addq	$1, 24(%rsp)
	addq	$8, %r12
	addq	$8, 8(%rsp)
	movq	24(%rsp), %rax
	cmpq	$20, %rax
	jne	.L156
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	$1, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L158:
	.cfi_restore_state
	movl	%r10d, %eax
	.p2align 4,,10
	.p2align 3
.L134:
	testl	%eax, %eax
	jne	.L152
	movl	20(%rsp), %edx
	leaq	.LC6(%rip), %rsi
	movl	$1, %edi
	call	__printf_chk@PLT
	orl	$-1, %edi
	call	exit@PLT
	.p2align 4,,10
	.p2align 3
.L157:
	xorl	%eax, %eax
	jmp	.L133
	.p2align 4,,10
	.p2align 3
.L127:
	movl	$11, (%rdx,%rax,8)
	movl	$2048, 4(%rdx,%rax,8)
	jmp	.L128
	.cfi_endproc
.LFE71:
	.size	invertMatrix, .-invertMatrix
	.p2align 4,,15
	.globl	computeConditionNumber
	.type	computeConditionNumber, @function
computeConditionNumber:
.LFB72:
	.cfi_startproc
	leaq	160(%rdi), %r8
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L166:
	movq	(%rdi), %rdx
	movl	(%rdx), %ecx
	movl	4(%rdx), %r9d
	movl	12(%rdx), %r10d
	sarl	%cl, %r9d
	movl	%r9d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r9d
	subl	%ecx, %r9d
	movl	8(%rdx), %ecx
	sarl	%cl, %r10d
	movl	%r10d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r10d
	subl	%ecx, %r10d
	movl	16(%rdx), %ecx
	addl	%r9d, %r10d
	movl	20(%rdx), %r9d
	sarl	%cl, %r9d
	movl	%r9d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r9d
	subl	%ecx, %r9d
	movl	24(%rdx), %ecx
	addl	%r10d, %r9d
	movl	28(%rdx), %r10d
	sarl	%cl, %r10d
	movl	%r10d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r10d
	subl	%ecx, %r10d
	movl	32(%rdx), %ecx
	addl	%r10d, %r9d
	movl	36(%rdx), %r10d
	sarl	%cl, %r10d
	movl	%r10d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r10d
	subl	%ecx, %r10d
	movl	40(%rdx), %ecx
	addl	%r9d, %r10d
	movl	44(%rdx), %r9d
	sarl	%cl, %r9d
	movl	%r9d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r9d
	subl	%ecx, %r9d
	movl	48(%rdx), %ecx
	addl	%r9d, %r10d
	movl	52(%rdx), %r9d
	sarl	%cl, %r9d
	movl	%r9d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r9d
	subl	%ecx, %r9d
	movl	56(%rdx), %ecx
	addl	%r10d, %r9d
	movl	60(%rdx), %r10d
	sarl	%cl, %r10d
	movl	%r10d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r10d
	subl	%ecx, %r10d
	movl	64(%rdx), %ecx
	addl	%r10d, %r9d
	movl	68(%rdx), %r10d
	sarl	%cl, %r10d
	movl	%r10d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r10d
	subl	%ecx, %r10d
	movl	72(%rdx), %ecx
	addl	%r9d, %r10d
	movl	76(%rdx), %r9d
	sarl	%cl, %r9d
	movl	%r9d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r9d
	subl	%ecx, %r9d
	movl	80(%rdx), %ecx
	addl	%r9d, %r10d
	movl	84(%rdx), %r9d
	sarl	%cl, %r9d
	movl	%r9d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r9d
	subl	%ecx, %r9d
	movl	88(%rdx), %ecx
	addl	%r10d, %r9d
	movl	92(%rdx), %r10d
	sarl	%cl, %r10d
	movl	%r10d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r10d
	subl	%ecx, %r10d
	movl	96(%rdx), %ecx
	addl	%r10d, %r9d
	movl	100(%rdx), %r10d
	sarl	%cl, %r10d
	movl	%r10d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r10d
	subl	%ecx, %r10d
	movl	104(%rdx), %ecx
	addl	%r9d, %r10d
	movl	108(%rdx), %r9d
	sarl	%cl, %r9d
	movl	%r9d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r9d
	subl	%ecx, %r9d
	movl	112(%rdx), %ecx
	addl	%r9d, %r10d
	movl	116(%rdx), %r9d
	sarl	%cl, %r9d
	movl	%r9d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r9d
	subl	%ecx, %r9d
	movl	120(%rdx), %ecx
	addl	%r10d, %r9d
	movl	124(%rdx), %r10d
	movq	8(%rdi), %rsi
	sarl	%cl, %r10d
	movl	12(%rsi), %r11d
	movl	%r10d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r10d
	subl	%ecx, %r10d
	movl	128(%rdx), %ecx
	addl	%r10d, %r9d
	movl	132(%rdx), %r10d
	sarl	%cl, %r10d
	movl	%r10d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r10d
	subl	%ecx, %r10d
	movl	136(%rdx), %ecx
	addl	%r9d, %r10d
	movl	140(%rdx), %r9d
	sarl	%cl, %r9d
	movl	%r9d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r9d
	subl	%ecx, %r9d
	movl	144(%rdx), %ecx
	addl	%r9d, %r10d
	movl	148(%rdx), %r9d
	sarl	%cl, %r9d
	movl	%r9d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r9d
	subl	%ecx, %r9d
	movl	(%rsi), %ecx
	addl	%r10d, %r9d
	movl	4(%rsi), %r10d
	sarl	%cl, %r10d
	movl	%r10d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r10d
	subl	%ecx, %r10d
	movl	8(%rsi), %ecx
	sarl	%cl, %r11d
	movl	%r11d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r11d
	subl	%ecx, %r11d
	movl	16(%rsi), %ecx
	addl	%r11d, %r10d
	movl	20(%rsi), %r11d
	sarl	%cl, %r11d
	movl	%r11d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r11d
	subl	%ecx, %r11d
	movl	24(%rsi), %ecx
	addl	%r11d, %r10d
	movl	28(%rsi), %r11d
	sarl	%cl, %r11d
	movl	%r11d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r11d
	subl	%ecx, %r11d
	movl	32(%rsi), %ecx
	addl	%r10d, %r11d
	movl	36(%rsi), %r10d
	sarl	%cl, %r10d
	movl	%r10d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r10d
	subl	%ecx, %r10d
	movl	40(%rsi), %ecx
	addl	%r10d, %r11d
	movl	44(%rsi), %r10d
	sarl	%cl, %r10d
	movl	%r10d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r10d
	subl	%ecx, %r10d
	movl	48(%rsi), %ecx
	addl	%r11d, %r10d
	movl	52(%rsi), %r11d
	sarl	%cl, %r11d
	movl	%r11d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r11d
	subl	%ecx, %r11d
	movl	56(%rsi), %ecx
	addl	%r11d, %r10d
	movl	60(%rsi), %r11d
	sarl	%cl, %r11d
	movl	%r11d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r11d
	subl	%ecx, %r11d
	movl	64(%rsi), %ecx
	addl	%r10d, %r11d
	movl	68(%rsi), %r10d
	sarl	%cl, %r10d
	movl	%r10d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r10d
	subl	%ecx, %r10d
	movl	72(%rsi), %ecx
	addl	%r10d, %r11d
	movl	76(%rsi), %r10d
	sarl	%cl, %r10d
	movl	%r10d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r10d
	subl	%ecx, %r10d
	movl	80(%rsi), %ecx
	addl	%r11d, %r10d
	movl	84(%rsi), %r11d
	sarl	%cl, %r11d
	movl	%r11d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r11d
	subl	%ecx, %r11d
	movl	88(%rsi), %ecx
	addl	%r11d, %r10d
	movl	92(%rsi), %r11d
	sarl	%cl, %r11d
	movl	%r11d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r11d
	subl	%ecx, %r11d
	movl	96(%rsi), %ecx
	addl	%r10d, %r11d
	movl	100(%rsi), %r10d
	sarl	%cl, %r10d
	movl	%r10d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r10d
	subl	%ecx, %r10d
	movl	104(%rsi), %ecx
	addl	%r10d, %r11d
	movl	108(%rsi), %r10d
	sarl	%cl, %r10d
	movl	%r10d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r10d
	subl	%ecx, %r10d
	movl	112(%rsi), %ecx
	addl	%r11d, %r10d
	movl	116(%rsi), %r11d
	sarl	%cl, %r11d
	movl	%r11d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r11d
	subl	%ecx, %r11d
	movl	120(%rsi), %ecx
	addl	%r11d, %r10d
	movl	124(%rsi), %r11d
	sarl	%cl, %r11d
	movl	%r11d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r11d
	subl	%ecx, %r11d
	movl	128(%rsi), %ecx
	addl	%r10d, %r11d
	movl	132(%rsi), %r10d
	sarl	%cl, %r10d
	movl	%r10d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r10d
	subl	%ecx, %r10d
	movl	136(%rsi), %ecx
	addl	%r10d, %r11d
	movl	140(%rsi), %r10d
	sarl	%cl, %r10d
	movl	%r10d, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %r10d
	subl	%ecx, %r10d
	movl	144(%rsi), %ecx
	addl	%r11d, %r10d
	movl	148(%rsi), %r11d
	sarl	%cl, %r11d
	movl	%r11d, %ecx
	sarl	$31, %r11d
	xorl	%r11d, %ecx
	subl	%r11d, %ecx
	addl	%ecx, %r10d
	movl	152(%rsi), %ecx
	movl	156(%rsi), %esi
	sarl	%cl, %esi
	movl	%esi, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %esi
	subl	%ecx, %esi
	movl	152(%rdx), %ecx
	movl	156(%rdx), %edx
	addl	%r10d, %esi
	sarl	%cl, %edx
	movl	%edx, %ecx
	sarl	$31, %ecx
	xorl	%ecx, %edx
	subl	%ecx, %edx
	addl	%r9d, %edx
	cmpl	%edx, %esi
	cmovl	%edx, %esi
	cmpl	%esi, %eax
	cmovl	%esi, %eax
	addq	$16, %rdi
	cmpq	%rdi, %r8
	jne	.L166
	rep ret
	.cfi_endproc
.LFE72:
	.size	computeConditionNumber, .-computeConditionNumber
	.section	.rodata.str1.1
.LC7:
	.string	"Error, need input filename."
.LC8:
	.string	"r"
	.section	.rodata.str1.8
	.align 8
.LC9:
	.string	"Error, incorrect matrix size. Must be a %dX%d matrix.\n"
	.align 8
.LC11:
	.string	"Input matix is not well-conditioned. Exiting program."
	.section	.rodata.str1.1
.LC12:
	.string	"Input Matrix"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB73:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	subq	$272, %rsp
	.cfi_def_cfa_offset 320
	movq	%fs:40, %rax
	movq	%rax, 264(%rsp)
	xorl	%eax, %eax
	cmpl	$2, %edi
	jne	.L183
	movq	8(%rsi), %rdi
	leaq	.LC8(%rip), %rsi
	call	fopen@PLT
	movq	%rsp, %rdi
	movq	%rax, %rdx
	movl	$255, %esi
	movq	%rax, %r12
	call	fgets@PLT
	xorl	%esi, %esi
	movl	$10, %edx
	movq	%rax, %rdi
	call	strtol@PLT
	cmpl	$20, %eax
	jne	.L184
	movl	$160, %edi
	call	malloc@PLT
	leaq	160(%rax), %r13
	movq	%rax, %rbp
	movq	%rax, %rbx
	.p2align 4,,10
	.p2align 3
.L172:
	movl	$160, %edi
	addq	$8, %rbx
	call	malloc@PLT
	movq	%rax, -8(%rbx)
	cmpq	%rbx, %r13
	jne	.L172
	movq	%rbp, %rsi
	movq	%r12, %rdi
	call	buildMatrix
	movq	%rbp, %rdi
	call	computeConditionNumber
	pxor	%xmm0, %xmm0
	cvtsi2sd	%eax, %xmm0
	ucomisd	.LC10(%rip), %xmm0
	jnb	.L185
	leaq	.LC12(%rip), %rdi
	call	puts@PLT
	movq	%rbp, %rdi
	call	printMatrix
	movl	$160, %edi
	call	malloc@PLT
	leaq	160(%rax), %r13
	movq	%rax, %r14
	movq	%rax, %rbx
	.p2align 4,,10
	.p2align 3
.L175:
	movl	$160, %edi
	addq	$8, %rbx
	call	malloc@PLT
	movq	%rax, -8(%rbx)
	cmpq	%r13, %rbx
	jne	.L175
	movq	%r14, %rsi
	movq	%rbp, %rdi
	call	invertMatrix
	movq	%r14, %rdi
	call	printMatrix
	movq	%r12, %rdi
	call	fclose@PLT
	movq	%rbp, %rdi
	call	free@PLT
	movq	%r14, %rdi
	call	free@PLT
	xorl	%eax, %eax
.L168:
	movq	264(%rsp), %rcx
	xorq	%fs:40, %rcx
	jne	.L186
	addq	$272, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L183:
	.cfi_restore_state
	leaq	.LC7(%rip), %rdi
	call	puts@PLT
.L170:
	orl	$-1, %eax
	jmp	.L168
.L184:
	leaq	.LC9(%rip), %rsi
	movl	$20, %ecx
	movl	$20, %edx
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L170
.L185:
	movq	%r12, %rdi
	call	fclose@PLT
	movq	%rbp, %rdi
	call	free@PLT
	leaq	.LC11(%rip), %rdi
	call	puts@PLT
	jmp	.L170
.L186:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE73:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	0
	.align 8
.LC1:
	.long	0
	.long	1084227584
	.align 8
.LC10:
	.long	0
	.long	1077477376
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
