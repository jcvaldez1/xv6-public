	.text

/* Switch from current_thread to next_thread. Make next_thread
 * the current_thread, and set next_thread to 0.
 * Use eax as a temporary register; it is caller saved.
 */
	.globl thread_switch
thread_switch:

	pushal						# save GPRs
	movl current_thread, %eax   # extract current_thread address
	movl %esp, (%eax)			# current_thread now contains stack pointer  

	movl next_thread, %eax		# get address of next_thread
	movl %eax, current_thread	# current_thread now points to next_thread

	movl (next_thread), %eax  	# extract next_thread data
	movl (%eax), %esp 		  	# relocate stack pointer to new_thread's saved stack
	popal						# reload GPRs

	ret				/* pop return address from stack */
