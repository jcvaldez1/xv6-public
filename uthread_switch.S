	.text

/* Switch from current_thread to next_thread. Make next_thread
 * the current_thread, and set next_thread to 0.
 * Use eax as a temporary register; it is caller saved.
 */
	.globl thread_switch
thread_switch:

	movl (current_thread), %eax
	add $0x2000, %eax
	movl %eax, %esp
	pushal
	movl current_thread, %eax
	movl %esp, (%eax)				# current_thread done
	
	movl (next_thread), %eax  # switch to next_thread
	movl (%eax), %esp 		  # retrieve value of next_threadad->sp
	popal

	movl %esp, %eax
	sub $0x2000,%eax
	movl %eax, (current_thread)
	# switch to next_thread
	ret				/* pop return address from stack */
