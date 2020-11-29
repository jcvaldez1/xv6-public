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
	# add $0x4, %eax	  # edit value of current_thread->state
	# movl $0x2, (%eax)
	movl current_thread, %eax
	movl %esp, (%eax)				# current_thread done
	
	

	movl next_thread, %eax		# get address of next_thread
	movl %eax, current_thread	# next_thread address now points to current
	# assume current_thread already has correct position
	

	movl (next_thread), %eax  # switch to next_thread
	movl %eax, %esp 		  # retrieve value of next_threadad->sp
	popal
	movl current_thread, %eax
	movl %esp, (%eax)
	# switch to next_thread
	ret				/* pop return address from stack */
