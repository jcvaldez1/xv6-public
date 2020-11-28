	.text

/* Switch from current_thread to next_thread. Make next_thread
 * the current_thread, and set next_thread to 0.
 * Use eax as a temporary register; it is caller saved.
 */
	.globl thread_switch
thread_switch:
	movl current_thread, %eax		# eax now contains current_thread address
	movl %esp, (%eax)				# move sp to offset  0, 4  bytes taken
	movl (%eax), %eax				# value of eax is now thread, not thread pointer
	movl   $0x2,0x2004(%eax)
	pushal
	add $0x20, %esp

	movl (%esp), %edx
	movl %edx, (%eax)
	sub $0x4, %esp

	movl (%esp), %edx
	movl %edx, 0x400(%eax)
	sub $0x4, %esp

	movl (%esp), %edx
	movl %edx, 0x800(%eax)
	sub $0x4, %esp

	movl (%esp), %edx
	movl %edx, 0xC00(%eax)
	sub $0x4, %esp
	
	movl (%esp), %edx
	movl %edx, 0x1000(%eax)
	sub $0x4, %esp
	
	movl (%esp), %edx
	movl %edx, 0x1400(%eax)
	sub $0x4, %esp
	
	movl (%esp), %edx
	movl %edx, 0x1800(%eax)
	sub $0x4, %esp

	movl (%esp), %edx
	movl %edx, 0x1C00(%eax)
	sub $0x4, %esp
	
	popal

	movl (next_thread), %eax			# current thread address now contains next thread address
	movl %eax, (current_thread)
	# movl %eax, %esp
	ret				/* pop return address from stack */
