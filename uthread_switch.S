	.text

/* Switch from current_thread to next_thread. Make next_thread
 * the current_thread, and set next_thread to 0.
 * Use eax as a temporary register; it is caller saved.
 */
	.globl thread_switch
thread_switch:

	# set &current_thread->sp to $esp - $0x2004
	movl %esp, %eax
	sub $0x2004,%eax      # %eax now contains &current_thread->sp
	movl %eax, (current_thread)
	pushal
	add $0x2004, %eax	  # edit value of current_thread->state
	movl $0x2, (%eax)
	movl current_thread, %eax
	movl %esp, (%eax)

	popal
	

	ret				/* pop return address from stack */
