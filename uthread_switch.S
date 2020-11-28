	.text

/* Switch from current_thread to next_thread. Make next_thread
 * the current_thread, and set next_thread to 0.
 * Use eax as a temporary register; it is caller saved.
 */
	.globl thread_switch
thread_switch:
	movl current_thread, %eax		# eax now contains current_thread address
	movl %esp, (%eax)				# move sp to offset  0, 4  bytes taken
	pushal                          # push the 8 registers, 32 bytes taken
	movl 32(%esp), 4(%eax)
	movl 28(%esp), 8(%eax) 
	movl 24(%esp), 12(%eax) 
	movl 20(%esp), 16(%eax) 
	movl 16(%esp), 20(%eax) 
	movl 12(%esp), 24(%eax) 
	movl 8(%esp), 28(%eax) 
	movl 4(%esp), 32(%eax)   
	movl $0x2, 36(%eax) 
	popal
	
	movl next_thread, current_thread# current thread address now contains next thread address

	ret				/* pop return address from stack */
