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
	addl $0x4, %eax
	addl $0x4, %esp
	movl (%esp), (%eax)
	#movl %edx, (%eax)
	# movl 0x20(%esp), 0x4(%eax)
	# movl 0x1C(%esp), 0x8(%eax) 
	# movl 0x18(%esp), 0xC(%eax) 
	# movl 0x14(%esp), 0x10(%eax) 
	# movl 0x10(%esp), 0x14(%eax) 
	# movl 0xC(%esp), 0x18(%eax) 
	# movl 0x8(%esp), 0x1C(%eax) 
	# movl 0x4(%esp), 0x20(%eax)   
	# movl $0x2, 0x24(%eax) 
	popal

	movl next_thread, current_thread# current thread address now contains next thread address

	ret				/* pop return address from stack */
