.extern rand
.global main
.section .text
.balign 4

fill_array:
	stp  x29, x30, [sp, -16]!
	add  x29, sp, 0

	mov x27, #SIZE
	ldr x28, =array

loop:
	bl rand
	and x8, x0, #0xFF
	str x8, [x28], #datum_size

	subs x27, x27, #1
	cmp x27, #0
	beq exit
	b loop

exit:
	ldp  x29, x30, [sp], 16
	ret

print_array:
	stp  x29, x30, [sp, -16]!
	add  x29, sp, 0

	mov x26, #SIZE  /* load array size to x26 */
	ldr x28, =array /* load array address to x28 */
	mov x27, #0     /* load array index to r27 */

loop1:
	mov x1, x27                /* load array index to x1 */
	ldr x2, [x28], #datum_size /* load value of array item to x2 and increment x28 */
	ldr x0, =print_array_str   /* load format string to x0 */
	bl printf                  /* call printf() */

	add x27, x27, #1  /* increment array index */
	subs x26, x26, #1 /* decrement array size */
	cmp x26, #0       /* if array size equals zero */
	beq exit1         /* then go to exit lable */
	b loop1           /* else go to next iteration */

exit1:
	ldp  x29, x30, [sp], 16
	ret

do_bubble:
	stp  x29, x30, [sp, -16]!
	add  x29, sp, 0

	sub x5, x1, #1 /* need n-1 comparisons */
	mov x4, x0     /* initialise current pointer */
	mov x6, #0     /* this register set when we swap */

loop_start:
	ldr w7, [x4], #datum_size /* load one element */
	ldr w8, [x4]              /* and next one */
	cmp w7, w8                /* compare them */
	ble no_swap               /* branch if second greater */

	mov x6, #1              /* set keep_going flag */
	sub x4, x4, #datum_size /* reset pointer to first element */

	str w8, [x4]               /* store value of w8 in address of x4 */
	str w7, [x4, #datum_size]! /* store value of w7 in address of (x4 + 4) */

no_swap:
	subs x5, x5, #1 /* decrement counter */
	bne loop_start  /* and restart loop if more needed */

end_inner:
	cmp x6, #0    /* check keep_going flag */
	beq end_outer /* and leave if not set */

	mov x6, #0     /* clear keep_going flag  */
	mov x4, x0     /* reset pointer */
	sub x5, x1, #1 /* reset counter */
	b loop_start   /* start another iteration */

end_outer:
	ldp  x29, x30, [sp], 16
	ret

main:
	stp  x29, x30, [sp, -16]!
	add  x29, sp, 0

	ldr x0, =message1 /* load address of message1 to x0 */
	bl   printf       /* call printf() */

	bl fill_array  /* fill array by values (rand() && 0xFF) */
	bl print_array /* print array */

	ldr x0, =message2 /* load address of message2 to x0 */
	bl   printf       /* call printf() */

	ldr x0, =array /* the start of the vector */
	mov x1, #SIZE  /* how many elements to sort */
	bl do_bubble   /* call the sort routine */
	bl print_array /* print sorted array */

	mov w0, 0 /* set returned value to zero */

	ldp  x29, x30, [sp], 16
	ret

.section .rodata
.balign 4

message1:
	.asciz "Before sort:\n\0"

message2:
	.asciz "After sort:\n\0"

.equ datum_size,4   /* works with 4 byte (32 bit) words */
.equ SIZE, 10      /* size of array */

.section .data
array:             /* allow room for 40 integers (4*40) */
	.skip 160

print_array_str:
	.ascii "v[%d] = %d\n\0"


