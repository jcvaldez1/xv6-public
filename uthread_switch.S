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
	
	movl current_thread, %eax
	movl %esp, (%eax)

	pushal

	ret				/* pop return address from stack */
