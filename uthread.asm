
_uthread:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
}


int 
main(int argc, char *argv[]) 
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
thread_create(void (*func)())
{
  thread_p t;

  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
    if (t->state == FREE) break;
  11:	a1 6c 4d 00 00       	mov    0x4d6c,%eax
  // main() is thread 0, which will make the first invocation to
  // thread_schedule().  it needs a stack so that the first thread_switch() can
  // save thread 0's state.  thread_schedule() won't run the main thread ever
  // again, because its state is set to RUNNING, and thread_schedule() selects
  // a RUNNABLE thread.
  current_thread = &all_thread[0];
  16:	c7 05 8c 8d 00 00 60 	movl   $0xd60,0x8d8c
  1d:	0d 00 00 
  current_thread->state = RUNNING;
  20:	c7 05 64 2d 00 00 01 	movl   $0x1,0x2d64
  27:	00 00 00 
thread_create(void (*func)())
{
  thread_p t;

  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
    if (t->state == FREE) break;
  2a:	85 c0                	test   %eax,%eax
  2c:	0f 84 8b 00 00 00    	je     bd <main+0xbd>
  32:	a1 74 6d 00 00       	mov    0x6d74,%eax
  37:	85 c0                	test   %eax,%eax
  39:	0f 84 85 00 00 00    	je     c4 <main+0xc4>
void 
thread_create(void (*func)())
{
  thread_p t;

  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
  3f:	8b 0d 7c 8d 00 00    	mov    0x8d7c,%ecx
  45:	ba 78 6d 00 00       	mov    $0x6d78,%edx
  4a:	b8 80 8d 00 00       	mov    $0x8d80,%eax
  4f:	85 c9                	test   %ecx,%ecx
  51:	0f 44 c2             	cmove  %edx,%eax
    if (t->state == FREE) break;
  }
  t->sp = (int) (t->stack + STACK_SIZE);   // set sp to the top of the stack
  t->sp -= 4;                              // space for return address
  54:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
  * (int *) (t->sp) = (int)func;           // push return address on stack
  5a:	c7 80 00 20 00 00 70 	movl   $0x170,0x2000(%eax)
  61:	01 00 00 
  t->sp -= 32;                             // space for registers that thread_switch expects
  t->state = RUNNABLE;
  64:	c7 80 04 20 00 00 02 	movl   $0x2,0x2004(%eax)
  6b:	00 00 00 

  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
    if (t->state == FREE) break;
  }
  t->sp = (int) (t->stack + STACK_SIZE);   // set sp to the top of the stack
  t->sp -= 4;                              // space for return address
  6e:	89 10                	mov    %edx,(%eax)
  * (int *) (t->sp) = (int)func;           // push return address on stack
  t->sp -= 32;                             // space for registers that thread_switch expects
  70:	83 28 20             	subl   $0x20,(%eax)
void 
thread_create(void (*func)())
{
  thread_p t;

  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
  73:	b8 60 0d 00 00       	mov    $0xd60,%eax
    if (t->state == FREE) break;
  78:	8b 90 04 20 00 00    	mov    0x2004(%eax),%edx
  7e:	85 d2                	test   %edx,%edx
  80:	74 0c                	je     8e <main+0x8e>
void 
thread_create(void (*func)())
{
  thread_p t;

  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
  82:	05 08 20 00 00       	add    $0x2008,%eax
  87:	3d 80 8d 00 00       	cmp    $0x8d80,%eax
  8c:	75 ea                	jne    78 <main+0x78>
    if (t->state == FREE) break;
  }
  t->sp = (int) (t->stack + STACK_SIZE);   // set sp to the top of the stack
  t->sp -= 4;                              // space for return address
  8e:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
  * (int *) (t->sp) = (int)func;           // push return address on stack
  94:	c7 80 00 20 00 00 70 	movl   $0x170,0x2000(%eax)
  9b:	01 00 00 
  t->sp -= 32;                             // space for registers that thread_switch expects
  t->state = RUNNABLE;
  9e:	c7 80 04 20 00 00 02 	movl   $0x2,0x2004(%eax)
  a5:	00 00 00 

  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
    if (t->state == FREE) break;
  }
  t->sp = (int) (t->stack + STACK_SIZE);   // set sp to the top of the stack
  t->sp -= 4;                              // space for return address
  a8:	89 10                	mov    %edx,(%eax)
  * (int *) (t->sp) = (int)func;           // push return address on stack
  t->sp -= 32;                             // space for registers that thread_switch expects
  aa:	83 28 20             	subl   $0x20,(%eax)
main(int argc, char *argv[]) 
{
  thread_init();
  thread_create(mythread);
  thread_create(mythread);
  thread_schedule();
  ad:	e8 1e 00 00 00       	call   d0 <thread_schedule>
  return 0;
}
  b2:	83 c4 04             	add    $0x4,%esp
  b5:	31 c0                	xor    %eax,%eax
  b7:	59                   	pop    %ecx
  b8:	5d                   	pop    %ebp
  b9:	8d 61 fc             	lea    -0x4(%ecx),%esp
  bc:	c3                   	ret    
void 
thread_create(void (*func)())
{
  thread_p t;

  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
  bd:	b8 68 2d 00 00       	mov    $0x2d68,%eax
  c2:	eb 90                	jmp    54 <main+0x54>
  c4:	b8 70 4d 00 00       	mov    $0x4d70,%eax
  c9:	eb 89                	jmp    54 <main+0x54>
  cb:	66 90                	xchg   %ax,%ax
  cd:	66 90                	xchg   %ax,%ax
  cf:	90                   	nop

000000d0 <thread_schedule>:
  current_thread->state = RUNNING;
}

static void 
thread_schedule(void)
{
  d0:	55                   	push   %ebp
  thread_p t;

  /* Find another runnable thread. */
  next_thread = 0;
  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
  d1:	b8 60 0d 00 00       	mov    $0xd60,%eax
  current_thread->state = RUNNING;
}

static void 
thread_schedule(void)
{
  d6:	89 e5                	mov    %esp,%ebp
  d8:	83 ec 08             	sub    $0x8,%esp
  db:	8b 15 8c 8d 00 00    	mov    0x8d8c,%edx
  thread_p t;

  /* Find another runnable thread. */
  next_thread = 0;
  e1:	c7 05 90 8d 00 00 00 	movl   $0x0,0x8d90
  e8:	00 00 00 
  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
    if (t->state == RUNNABLE && t != current_thread) {
  eb:	83 b8 04 20 00 00 02 	cmpl   $0x2,0x2004(%eax)
  f2:	74 3c                	je     130 <thread_schedule+0x60>
{
  thread_p t;

  /* Find another runnable thread. */
  next_thread = 0;
  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
  f4:	05 08 20 00 00       	add    $0x2008,%eax
  f9:	3d 80 8d 00 00       	cmp    $0x8d80,%eax
  fe:	75 eb                	jne    eb <thread_schedule+0x1b>
      next_thread = t;
      break;
    }
  }

  if (t >= all_thread + MAX_THREAD && current_thread->state == RUNNABLE) {
 100:	83 ba 04 20 00 00 02 	cmpl   $0x2,0x2004(%edx)
 107:	74 57                	je     160 <thread_schedule+0x90>
 109:	a1 90 8d 00 00       	mov    0x8d90,%eax
    /* The current thread is the only runnable thread; run it. */
    next_thread = current_thread;
  }

  if (next_thread == 0) {
 10e:	85 c0                	test   %eax,%eax
 110:	74 32                	je     144 <thread_schedule+0x74>
    printf(2, "thread_schedule: no runnable threads\n");
    exit();
  }

  if (current_thread != next_thread) {         /* switch threads?  */
 112:	39 05 8c 8d 00 00    	cmp    %eax,0x8d8c
 118:	74 46                	je     160 <thread_schedule+0x90>
    next_thread->state = RUNNING;
 11a:	c7 80 04 20 00 00 01 	movl   $0x1,0x2004(%eax)
 121:	00 00 00 
    thread_switch();
  } else
    next_thread = 0;
}
 124:	c9                   	leave  
    exit();
  }

  if (current_thread != next_thread) {         /* switch threads?  */
    next_thread->state = RUNNING;
    thread_switch();
 125:	e9 3e 01 00 00       	jmp    268 <thread_switch>
 12a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  thread_p t;

  /* Find another runnable thread. */
  next_thread = 0;
  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
    if (t->state == RUNNABLE && t != current_thread) {
 130:	39 c2                	cmp    %eax,%edx
 132:	74 c0                	je     f4 <thread_schedule+0x24>
      next_thread = t;
      break;
    }
  }

  if (t >= all_thread + MAX_THREAD && current_thread->state == RUNNABLE) {
 134:	3d 80 8d 00 00       	cmp    $0x8d80,%eax

  /* Find another runnable thread. */
  next_thread = 0;
  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
    if (t->state == RUNNABLE && t != current_thread) {
      next_thread = t;
 139:	a3 90 8d 00 00       	mov    %eax,0x8d90
      break;
    }
  }

  if (t >= all_thread + MAX_THREAD && current_thread->state == RUNNABLE) {
 13e:	73 c0                	jae    100 <thread_schedule+0x30>
    /* The current thread is the only runnable thread; run it. */
    next_thread = current_thread;
  }

  if (next_thread == 0) {
 140:	85 c0                	test   %eax,%eax
 142:	75 d6                	jne    11a <thread_schedule+0x4a>
    printf(2, "thread_schedule: no runnable threads\n");
 144:	50                   	push   %eax
 145:	50                   	push   %eax
 146:	68 a0 09 00 00       	push   $0x9a0
 14b:	6a 02                	push   $0x2
 14d:	e8 2e 05 00 00       	call   680 <printf>
    exit();
 152:	e8 db 03 00 00       	call   532 <exit>
 157:	89 f6                	mov    %esi,%esi
 159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  if (current_thread != next_thread) {         /* switch threads?  */
    next_thread->state = RUNNING;
    thread_switch();
  } else
    next_thread = 0;
 160:	c7 05 90 8d 00 00 00 	movl   $0x0,0x8d90
 167:	00 00 00 
}
 16a:	c9                   	leave  
 16b:	c3                   	ret    
 16c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000170 <mythread>:
  thread_schedule();
}

static void 
mythread(void)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	53                   	push   %ebx
  int i;
  printf(1, "my thread running\n");
 174:	bb 64 00 00 00       	mov    $0x64,%ebx
  thread_schedule();
}

static void 
mythread(void)
{
 179:	83 ec 0c             	sub    $0xc,%esp
  int i;
  printf(1, "my thread running\n");
 17c:	68 c8 09 00 00       	push   $0x9c8
 181:	6a 01                	push   $0x1
 183:	e8 f8 04 00 00       	call   680 <printf>
 188:	83 c4 10             	add    $0x10,%esp
 18b:	90                   	nop
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for (i = 0; i < 100; i++) {
    printf(1, "my thread 0x%x\n", (int) current_thread);
 190:	83 ec 04             	sub    $0x4,%esp
 193:	ff 35 8c 8d 00 00    	pushl  0x8d8c
 199:	68 db 09 00 00       	push   $0x9db
 19e:	6a 01                	push   $0x1
 1a0:	e8 db 04 00 00       	call   680 <printf>
}

void 
thread_yield(void)
{
  current_thread->state = RUNNABLE;
 1a5:	a1 8c 8d 00 00       	mov    0x8d8c,%eax
 1aa:	c7 80 04 20 00 00 02 	movl   $0x2,0x2004(%eax)
 1b1:	00 00 00 
  thread_schedule();
 1b4:	e8 17 ff ff ff       	call   d0 <thread_schedule>
static void 
mythread(void)
{
  int i;
  printf(1, "my thread running\n");
  for (i = 0; i < 100; i++) {
 1b9:	83 c4 10             	add    $0x10,%esp
 1bc:	83 eb 01             	sub    $0x1,%ebx
 1bf:	75 cf                	jne    190 <mythread+0x20>
    printf(1, "my thread 0x%x\n", (int) current_thread);
    thread_yield();
  }
  printf(1, "my thread: exit\n");
 1c1:	83 ec 08             	sub    $0x8,%esp
 1c4:	68 eb 09 00 00       	push   $0x9eb
 1c9:	6a 01                	push   $0x1
 1cb:	e8 b0 04 00 00       	call   680 <printf>
  current_thread->state = FREE;
 1d0:	a1 8c 8d 00 00       	mov    0x8d8c,%eax
  thread_schedule();
 1d5:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < 100; i++) {
    printf(1, "my thread 0x%x\n", (int) current_thread);
    thread_yield();
  }
  printf(1, "my thread: exit\n");
  current_thread->state = FREE;
 1d8:	c7 80 04 20 00 00 00 	movl   $0x0,0x2004(%eax)
 1df:	00 00 00 
  thread_schedule();
}
 1e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1e5:	c9                   	leave  
    printf(1, "my thread 0x%x\n", (int) current_thread);
    thread_yield();
  }
  printf(1, "my thread: exit\n");
  current_thread->state = FREE;
  thread_schedule();
 1e6:	e9 e5 fe ff ff       	jmp    d0 <thread_schedule>
 1eb:	90                   	nop
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001f0 <thread_init>:
thread_p  next_thread;
extern void thread_switch(void);

void 
thread_init(void)
{
 1f0:	55                   	push   %ebp
  // main() is thread 0, which will make the first invocation to
  // thread_schedule().  it needs a stack so that the first thread_switch() can
  // save thread 0's state.  thread_schedule() won't run the main thread ever
  // again, because its state is set to RUNNING, and thread_schedule() selects
  // a RUNNABLE thread.
  current_thread = &all_thread[0];
 1f1:	c7 05 8c 8d 00 00 60 	movl   $0xd60,0x8d8c
 1f8:	0d 00 00 
  current_thread->state = RUNNING;
 1fb:	c7 05 64 2d 00 00 01 	movl   $0x1,0x2d64
 202:	00 00 00 
thread_p  next_thread;
extern void thread_switch(void);

void 
thread_init(void)
{
 205:	89 e5                	mov    %esp,%ebp
  // save thread 0's state.  thread_schedule() won't run the main thread ever
  // again, because its state is set to RUNNING, and thread_schedule() selects
  // a RUNNABLE thread.
  current_thread = &all_thread[0];
  current_thread->state = RUNNING;
}
 207:	5d                   	pop    %ebp
 208:	c3                   	ret    
 209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000210 <thread_create>:
    next_thread = 0;
}

void 
thread_create(void (*func)())
{
 210:	55                   	push   %ebp
  thread_p t;

  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
 211:	b8 60 0d 00 00       	mov    $0xd60,%eax
    next_thread = 0;
}

void 
thread_create(void (*func)())
{
 216:	89 e5                	mov    %esp,%ebp
  thread_p t;

  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
    if (t->state == FREE) break;
 218:	8b 90 04 20 00 00    	mov    0x2004(%eax),%edx
 21e:	85 d2                	test   %edx,%edx
 220:	74 0c                	je     22e <thread_create+0x1e>
void 
thread_create(void (*func)())
{
  thread_p t;

  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
 222:	05 08 20 00 00       	add    $0x2008,%eax
 227:	3d 80 8d 00 00       	cmp    $0x8d80,%eax
 22c:	75 ea                	jne    218 <thread_create+0x8>
    if (t->state == FREE) break;
  }
  t->sp = (int) (t->stack + STACK_SIZE);   // set sp to the top of the stack
  t->sp -= 4;                              // space for return address
 22e:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
  * (int *) (t->sp) = (int)func;           // push return address on stack
  t->sp -= 32;                             // space for registers that thread_switch expects
  t->state = RUNNABLE;
 234:	c7 80 04 20 00 00 02 	movl   $0x2,0x2004(%eax)
 23b:	00 00 00 

  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
    if (t->state == FREE) break;
  }
  t->sp = (int) (t->stack + STACK_SIZE);   // set sp to the top of the stack
  t->sp -= 4;                              // space for return address
 23e:	89 10                	mov    %edx,(%eax)
  * (int *) (t->sp) = (int)func;           // push return address on stack
 240:	8b 55 08             	mov    0x8(%ebp),%edx
  t->sp -= 32;                             // space for registers that thread_switch expects
 243:	83 28 20             	subl   $0x20,(%eax)
  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
    if (t->state == FREE) break;
  }
  t->sp = (int) (t->stack + STACK_SIZE);   // set sp to the top of the stack
  t->sp -= 4;                              // space for return address
  * (int *) (t->sp) = (int)func;           // push return address on stack
 246:	89 90 00 20 00 00    	mov    %edx,0x2000(%eax)
  t->sp -= 32;                             // space for registers that thread_switch expects
  t->state = RUNNABLE;
}
 24c:	5d                   	pop    %ebp
 24d:	c3                   	ret    
 24e:	66 90                	xchg   %ax,%ax

00000250 <thread_yield>:

void 
thread_yield(void)
{
  current_thread->state = RUNNABLE;
 250:	a1 8c 8d 00 00       	mov    0x8d8c,%eax
  t->state = RUNNABLE;
}

void 
thread_yield(void)
{
 255:	55                   	push   %ebp
 256:	89 e5                	mov    %esp,%ebp
  current_thread->state = RUNNABLE;
 258:	c7 80 04 20 00 00 02 	movl   $0x2,0x2004(%eax)
 25f:	00 00 00 
  thread_schedule();
}
 262:	5d                   	pop    %ebp

void 
thread_yield(void)
{
  current_thread->state = RUNNABLE;
  thread_schedule();
 263:	e9 68 fe ff ff       	jmp    d0 <thread_schedule>

00000268 <thread_switch>:
 * the current_thread, and set next_thread to 0.
 * Use eax as a temporary register; it is caller saved.
 */
	.globl thread_switch
thread_switch:
	movl current_thread, %eax		# eax now contains current_thread address
 268:	a1 8c 8d 00 00       	mov    0x8d8c,%eax
	movl %esp, (%eax)				# move sp to offset  0, 4  bytes taken
 26d:	89 20                	mov    %esp,(%eax)
	movl (%eax), %eax				# value of eax is now thread, not thread pointer
 26f:	8b 00                	mov    (%eax),%eax
	movl   $0x2,0x2004(%eax)
 271:	c7 80 04 20 00 00 02 	movl   $0x2,0x2004(%eax)
 278:	00 00 00 
	pushal
 27b:	60                   	pusha  
	add $0x20, %esp
 27c:	83 c4 20             	add    $0x20,%esp

	movl (%esp), %edx
 27f:	8b 14 24             	mov    (%esp),%edx
	movl %edx, (%eax)
 282:	89 10                	mov    %edx,(%eax)
	sub $0x4, %esp
 284:	83 ec 04             	sub    $0x4,%esp

	movl (%esp), %edx
 287:	8b 14 24             	mov    (%esp),%edx
	movl %edx, 0x400(%eax)
 28a:	89 90 00 04 00 00    	mov    %edx,0x400(%eax)
	sub $0x4, %esp
 290:	83 ec 04             	sub    $0x4,%esp

	movl (%esp), %edx
 293:	8b 14 24             	mov    (%esp),%edx
	movl %edx, 0x800(%eax)
 296:	89 90 00 08 00 00    	mov    %edx,0x800(%eax)
	sub $0x4, %esp
 29c:	83 ec 04             	sub    $0x4,%esp

	movl (%esp), %edx
 29f:	8b 14 24             	mov    (%esp),%edx
	movl %edx, 0xC00(%eax)
 2a2:	89 90 00 0c 00 00    	mov    %edx,0xc00(%eax)
	sub $0x4, %esp
 2a8:	83 ec 04             	sub    $0x4,%esp
	
	movl (%esp), %edx
 2ab:	8b 14 24             	mov    (%esp),%edx
	movl %edx, 0x1000(%eax)
 2ae:	89 90 00 10 00 00    	mov    %edx,0x1000(%eax)
	sub $0x4, %esp
 2b4:	83 ec 04             	sub    $0x4,%esp
	
	movl (%esp), %edx
 2b7:	8b 14 24             	mov    (%esp),%edx
	movl %edx, 0x1400(%eax)
 2ba:	89 90 00 14 00 00    	mov    %edx,0x1400(%eax)
	sub $0x4, %esp
 2c0:	83 ec 04             	sub    $0x4,%esp
	
	movl (%esp), %edx
 2c3:	8b 14 24             	mov    (%esp),%edx
	movl %edx, 0x1800(%eax)
 2c6:	89 90 00 18 00 00    	mov    %edx,0x1800(%eax)
	sub $0x4, %esp
 2cc:	83 ec 04             	sub    $0x4,%esp

	movl (%esp), %edx
 2cf:	8b 14 24             	mov    (%esp),%edx
	movl %edx, 0x1C00(%eax)
 2d2:	89 90 00 1c 00 00    	mov    %edx,0x1c00(%eax)
	sub $0x4, %esp
 2d8:	83 ec 04             	sub    $0x4,%esp
	
	popal
 2db:	61                   	popa   

	movl (next_thread), %eax			# current thread address now contains next thread address
 2dc:	a1 90 8d 00 00       	mov    0x8d90,%eax
	movl %eax, (current_thread)
 2e1:	a3 8c 8d 00 00       	mov    %eax,0x8d8c
	# movl %eax, %esp
	ret				/* pop return address from stack */
 2e6:	c3                   	ret    
 2e7:	66 90                	xchg   %ax,%ax
 2e9:	66 90                	xchg   %ax,%ax
 2eb:	66 90                	xchg   %ax,%ax
 2ed:	66 90                	xchg   %ax,%ax
 2ef:	90                   	nop

000002f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	53                   	push   %ebx
 2f4:	8b 45 08             	mov    0x8(%ebp),%eax
 2f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2fa:	89 c2                	mov    %eax,%edx
 2fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 300:	83 c1 01             	add    $0x1,%ecx
 303:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 307:	83 c2 01             	add    $0x1,%edx
 30a:	84 db                	test   %bl,%bl
 30c:	88 5a ff             	mov    %bl,-0x1(%edx)
 30f:	75 ef                	jne    300 <strcpy+0x10>
    ;
  return os;
}
 311:	5b                   	pop    %ebx
 312:	5d                   	pop    %ebp
 313:	c3                   	ret    
 314:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 31a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000320 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	56                   	push   %esi
 324:	53                   	push   %ebx
 325:	8b 55 08             	mov    0x8(%ebp),%edx
 328:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 32b:	0f b6 02             	movzbl (%edx),%eax
 32e:	0f b6 19             	movzbl (%ecx),%ebx
 331:	84 c0                	test   %al,%al
 333:	75 1e                	jne    353 <strcmp+0x33>
 335:	eb 29                	jmp    360 <strcmp+0x40>
 337:	89 f6                	mov    %esi,%esi
 339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 340:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 343:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 346:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 349:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 34d:	84 c0                	test   %al,%al
 34f:	74 0f                	je     360 <strcmp+0x40>
 351:	89 f1                	mov    %esi,%ecx
 353:	38 d8                	cmp    %bl,%al
 355:	74 e9                	je     340 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 357:	29 d8                	sub    %ebx,%eax
}
 359:	5b                   	pop    %ebx
 35a:	5e                   	pop    %esi
 35b:	5d                   	pop    %ebp
 35c:	c3                   	ret    
 35d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 360:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 362:	29 d8                	sub    %ebx,%eax
}
 364:	5b                   	pop    %ebx
 365:	5e                   	pop    %esi
 366:	5d                   	pop    %ebp
 367:	c3                   	ret    
 368:	90                   	nop
 369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000370 <strlen>:

uint
strlen(const char *s)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 376:	80 39 00             	cmpb   $0x0,(%ecx)
 379:	74 12                	je     38d <strlen+0x1d>
 37b:	31 d2                	xor    %edx,%edx
 37d:	8d 76 00             	lea    0x0(%esi),%esi
 380:	83 c2 01             	add    $0x1,%edx
 383:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 387:	89 d0                	mov    %edx,%eax
 389:	75 f5                	jne    380 <strlen+0x10>
    ;
  return n;
}
 38b:	5d                   	pop    %ebp
 38c:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 38d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 38f:	5d                   	pop    %ebp
 390:	c3                   	ret    
 391:	eb 0d                	jmp    3a0 <memset>
 393:	90                   	nop
 394:	90                   	nop
 395:	90                   	nop
 396:	90                   	nop
 397:	90                   	nop
 398:	90                   	nop
 399:	90                   	nop
 39a:	90                   	nop
 39b:	90                   	nop
 39c:	90                   	nop
 39d:	90                   	nop
 39e:	90                   	nop
 39f:	90                   	nop

000003a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ad:	89 d7                	mov    %edx,%edi
 3af:	fc                   	cld    
 3b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3b2:	89 d0                	mov    %edx,%eax
 3b4:	5f                   	pop    %edi
 3b5:	5d                   	pop    %ebp
 3b6:	c3                   	ret    
 3b7:	89 f6                	mov    %esi,%esi
 3b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003c0 <strchr>:

char*
strchr(const char *s, char c)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	53                   	push   %ebx
 3c4:	8b 45 08             	mov    0x8(%ebp),%eax
 3c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 3ca:	0f b6 10             	movzbl (%eax),%edx
 3cd:	84 d2                	test   %dl,%dl
 3cf:	74 1d                	je     3ee <strchr+0x2e>
    if(*s == c)
 3d1:	38 d3                	cmp    %dl,%bl
 3d3:	89 d9                	mov    %ebx,%ecx
 3d5:	75 0d                	jne    3e4 <strchr+0x24>
 3d7:	eb 17                	jmp    3f0 <strchr+0x30>
 3d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3e0:	38 ca                	cmp    %cl,%dl
 3e2:	74 0c                	je     3f0 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 3e4:	83 c0 01             	add    $0x1,%eax
 3e7:	0f b6 10             	movzbl (%eax),%edx
 3ea:	84 d2                	test   %dl,%dl
 3ec:	75 f2                	jne    3e0 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 3ee:	31 c0                	xor    %eax,%eax
}
 3f0:	5b                   	pop    %ebx
 3f1:	5d                   	pop    %ebp
 3f2:	c3                   	ret    
 3f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000400 <gets>:

char*
gets(char *buf, int max)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	56                   	push   %esi
 405:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 406:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 408:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 40b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 40e:	eb 29                	jmp    439 <gets+0x39>
    cc = read(0, &c, 1);
 410:	83 ec 04             	sub    $0x4,%esp
 413:	6a 01                	push   $0x1
 415:	57                   	push   %edi
 416:	6a 00                	push   $0x0
 418:	e8 2d 01 00 00       	call   54a <read>
    if(cc < 1)
 41d:	83 c4 10             	add    $0x10,%esp
 420:	85 c0                	test   %eax,%eax
 422:	7e 1d                	jle    441 <gets+0x41>
      break;
    buf[i++] = c;
 424:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 428:	8b 55 08             	mov    0x8(%ebp),%edx
 42b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 42d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 42f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 433:	74 1b                	je     450 <gets+0x50>
 435:	3c 0d                	cmp    $0xd,%al
 437:	74 17                	je     450 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 439:	8d 5e 01             	lea    0x1(%esi),%ebx
 43c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 43f:	7c cf                	jl     410 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 441:	8b 45 08             	mov    0x8(%ebp),%eax
 444:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 448:	8d 65 f4             	lea    -0xc(%ebp),%esp
 44b:	5b                   	pop    %ebx
 44c:	5e                   	pop    %esi
 44d:	5f                   	pop    %edi
 44e:	5d                   	pop    %ebp
 44f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 450:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 453:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 455:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 459:	8d 65 f4             	lea    -0xc(%ebp),%esp
 45c:	5b                   	pop    %ebx
 45d:	5e                   	pop    %esi
 45e:	5f                   	pop    %edi
 45f:	5d                   	pop    %ebp
 460:	c3                   	ret    
 461:	eb 0d                	jmp    470 <stat>
 463:	90                   	nop
 464:	90                   	nop
 465:	90                   	nop
 466:	90                   	nop
 467:	90                   	nop
 468:	90                   	nop
 469:	90                   	nop
 46a:	90                   	nop
 46b:	90                   	nop
 46c:	90                   	nop
 46d:	90                   	nop
 46e:	90                   	nop
 46f:	90                   	nop

00000470 <stat>:

int
stat(const char *n, struct stat *st)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	56                   	push   %esi
 474:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 475:	83 ec 08             	sub    $0x8,%esp
 478:	6a 00                	push   $0x0
 47a:	ff 75 08             	pushl  0x8(%ebp)
 47d:	e8 f0 00 00 00       	call   572 <open>
  if(fd < 0)
 482:	83 c4 10             	add    $0x10,%esp
 485:	85 c0                	test   %eax,%eax
 487:	78 27                	js     4b0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 489:	83 ec 08             	sub    $0x8,%esp
 48c:	ff 75 0c             	pushl  0xc(%ebp)
 48f:	89 c3                	mov    %eax,%ebx
 491:	50                   	push   %eax
 492:	e8 f3 00 00 00       	call   58a <fstat>
 497:	89 c6                	mov    %eax,%esi
  close(fd);
 499:	89 1c 24             	mov    %ebx,(%esp)
 49c:	e8 b9 00 00 00       	call   55a <close>
  return r;
 4a1:	83 c4 10             	add    $0x10,%esp
 4a4:	89 f0                	mov    %esi,%eax
}
 4a6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4a9:	5b                   	pop    %ebx
 4aa:	5e                   	pop    %esi
 4ab:	5d                   	pop    %ebp
 4ac:	c3                   	ret    
 4ad:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 4b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4b5:	eb ef                	jmp    4a6 <stat+0x36>
 4b7:	89 f6                	mov    %esi,%esi
 4b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004c0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	53                   	push   %ebx
 4c4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4c7:	0f be 11             	movsbl (%ecx),%edx
 4ca:	8d 42 d0             	lea    -0x30(%edx),%eax
 4cd:	3c 09                	cmp    $0x9,%al
 4cf:	b8 00 00 00 00       	mov    $0x0,%eax
 4d4:	77 1f                	ja     4f5 <atoi+0x35>
 4d6:	8d 76 00             	lea    0x0(%esi),%esi
 4d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 4e0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 4e3:	83 c1 01             	add    $0x1,%ecx
 4e6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4ea:	0f be 11             	movsbl (%ecx),%edx
 4ed:	8d 5a d0             	lea    -0x30(%edx),%ebx
 4f0:	80 fb 09             	cmp    $0x9,%bl
 4f3:	76 eb                	jbe    4e0 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 4f5:	5b                   	pop    %ebx
 4f6:	5d                   	pop    %ebp
 4f7:	c3                   	ret    
 4f8:	90                   	nop
 4f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000500 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	56                   	push   %esi
 504:	53                   	push   %ebx
 505:	8b 5d 10             	mov    0x10(%ebp),%ebx
 508:	8b 45 08             	mov    0x8(%ebp),%eax
 50b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 50e:	85 db                	test   %ebx,%ebx
 510:	7e 14                	jle    526 <memmove+0x26>
 512:	31 d2                	xor    %edx,%edx
 514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 518:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 51c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 51f:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 522:	39 da                	cmp    %ebx,%edx
 524:	75 f2                	jne    518 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 526:	5b                   	pop    %ebx
 527:	5e                   	pop    %esi
 528:	5d                   	pop    %ebp
 529:	c3                   	ret    

0000052a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 52a:	b8 01 00 00 00       	mov    $0x1,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <exit>:
SYSCALL(exit)
 532:	b8 02 00 00 00       	mov    $0x2,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <wait>:
SYSCALL(wait)
 53a:	b8 03 00 00 00       	mov    $0x3,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <pipe>:
SYSCALL(pipe)
 542:	b8 04 00 00 00       	mov    $0x4,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <read>:
SYSCALL(read)
 54a:	b8 05 00 00 00       	mov    $0x5,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret    

00000552 <write>:
SYSCALL(write)
 552:	b8 10 00 00 00       	mov    $0x10,%eax
 557:	cd 40                	int    $0x40
 559:	c3                   	ret    

0000055a <close>:
SYSCALL(close)
 55a:	b8 15 00 00 00       	mov    $0x15,%eax
 55f:	cd 40                	int    $0x40
 561:	c3                   	ret    

00000562 <kill>:
SYSCALL(kill)
 562:	b8 06 00 00 00       	mov    $0x6,%eax
 567:	cd 40                	int    $0x40
 569:	c3                   	ret    

0000056a <exec>:
SYSCALL(exec)
 56a:	b8 07 00 00 00       	mov    $0x7,%eax
 56f:	cd 40                	int    $0x40
 571:	c3                   	ret    

00000572 <open>:
SYSCALL(open)
 572:	b8 0f 00 00 00       	mov    $0xf,%eax
 577:	cd 40                	int    $0x40
 579:	c3                   	ret    

0000057a <mknod>:
SYSCALL(mknod)
 57a:	b8 11 00 00 00       	mov    $0x11,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <unlink>:
SYSCALL(unlink)
 582:	b8 12 00 00 00       	mov    $0x12,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <fstat>:
SYSCALL(fstat)
 58a:	b8 08 00 00 00       	mov    $0x8,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <link>:
SYSCALL(link)
 592:	b8 13 00 00 00       	mov    $0x13,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <mkdir>:
SYSCALL(mkdir)
 59a:	b8 14 00 00 00       	mov    $0x14,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    

000005a2 <chdir>:
SYSCALL(chdir)
 5a2:	b8 09 00 00 00       	mov    $0x9,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret    

000005aa <dup>:
SYSCALL(dup)
 5aa:	b8 0a 00 00 00       	mov    $0xa,%eax
 5af:	cd 40                	int    $0x40
 5b1:	c3                   	ret    

000005b2 <getpid>:
SYSCALL(getpid)
 5b2:	b8 0b 00 00 00       	mov    $0xb,%eax
 5b7:	cd 40                	int    $0x40
 5b9:	c3                   	ret    

000005ba <sbrk>:
SYSCALL(sbrk)
 5ba:	b8 0c 00 00 00       	mov    $0xc,%eax
 5bf:	cd 40                	int    $0x40
 5c1:	c3                   	ret    

000005c2 <sleep>:
SYSCALL(sleep)
 5c2:	b8 0d 00 00 00       	mov    $0xd,%eax
 5c7:	cd 40                	int    $0x40
 5c9:	c3                   	ret    

000005ca <uptime>:
SYSCALL(uptime)
 5ca:	b8 0e 00 00 00       	mov    $0xe,%eax
 5cf:	cd 40                	int    $0x40
 5d1:	c3                   	ret    
 5d2:	66 90                	xchg   %ax,%ax
 5d4:	66 90                	xchg   %ax,%ax
 5d6:	66 90                	xchg   %ax,%ax
 5d8:	66 90                	xchg   %ax,%ax
 5da:	66 90                	xchg   %ax,%ax
 5dc:	66 90                	xchg   %ax,%ax
 5de:	66 90                	xchg   %ax,%ax

000005e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	57                   	push   %edi
 5e4:	56                   	push   %esi
 5e5:	53                   	push   %ebx
 5e6:	89 c6                	mov    %eax,%esi
 5e8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5ee:	85 db                	test   %ebx,%ebx
 5f0:	74 7e                	je     670 <printint+0x90>
 5f2:	89 d0                	mov    %edx,%eax
 5f4:	c1 e8 1f             	shr    $0x1f,%eax
 5f7:	84 c0                	test   %al,%al
 5f9:	74 75                	je     670 <printint+0x90>
    neg = 1;
    x = -xx;
 5fb:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 5fd:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 604:	f7 d8                	neg    %eax
 606:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 609:	31 ff                	xor    %edi,%edi
 60b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 60e:	89 ce                	mov    %ecx,%esi
 610:	eb 08                	jmp    61a <printint+0x3a>
 612:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 618:	89 cf                	mov    %ecx,%edi
 61a:	31 d2                	xor    %edx,%edx
 61c:	8d 4f 01             	lea    0x1(%edi),%ecx
 61f:	f7 f6                	div    %esi
 621:	0f b6 92 04 0a 00 00 	movzbl 0xa04(%edx),%edx
  }while((x /= base) != 0);
 628:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 62a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 62d:	75 e9                	jne    618 <printint+0x38>
  if(neg)
 62f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 632:	8b 75 c0             	mov    -0x40(%ebp),%esi
 635:	85 c0                	test   %eax,%eax
 637:	74 08                	je     641 <printint+0x61>
    buf[i++] = '-';
 639:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 63e:	8d 4f 02             	lea    0x2(%edi),%ecx
 641:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 645:	8d 76 00             	lea    0x0(%esi),%esi
 648:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 64b:	83 ec 04             	sub    $0x4,%esp
 64e:	83 ef 01             	sub    $0x1,%edi
 651:	6a 01                	push   $0x1
 653:	53                   	push   %ebx
 654:	56                   	push   %esi
 655:	88 45 d7             	mov    %al,-0x29(%ebp)
 658:	e8 f5 fe ff ff       	call   552 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 65d:	83 c4 10             	add    $0x10,%esp
 660:	39 df                	cmp    %ebx,%edi
 662:	75 e4                	jne    648 <printint+0x68>
    putc(fd, buf[i]);
}
 664:	8d 65 f4             	lea    -0xc(%ebp),%esp
 667:	5b                   	pop    %ebx
 668:	5e                   	pop    %esi
 669:	5f                   	pop    %edi
 66a:	5d                   	pop    %ebp
 66b:	c3                   	ret    
 66c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 670:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 672:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 679:	eb 8b                	jmp    606 <printint+0x26>
 67b:	90                   	nop
 67c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000680 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 680:	55                   	push   %ebp
 681:	89 e5                	mov    %esp,%ebp
 683:	57                   	push   %edi
 684:	56                   	push   %esi
 685:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 686:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 689:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 68c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 68f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 692:	89 45 d0             	mov    %eax,-0x30(%ebp)
 695:	0f b6 1e             	movzbl (%esi),%ebx
 698:	83 c6 01             	add    $0x1,%esi
 69b:	84 db                	test   %bl,%bl
 69d:	0f 84 b0 00 00 00    	je     753 <printf+0xd3>
 6a3:	31 d2                	xor    %edx,%edx
 6a5:	eb 39                	jmp    6e0 <printf+0x60>
 6a7:	89 f6                	mov    %esi,%esi
 6a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6b0:	83 f8 25             	cmp    $0x25,%eax
 6b3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 6b6:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6bb:	74 18                	je     6d5 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6bd:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 6c0:	83 ec 04             	sub    $0x4,%esp
 6c3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 6c6:	6a 01                	push   $0x1
 6c8:	50                   	push   %eax
 6c9:	57                   	push   %edi
 6ca:	e8 83 fe ff ff       	call   552 <write>
 6cf:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 6d2:	83 c4 10             	add    $0x10,%esp
 6d5:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6d8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 6dc:	84 db                	test   %bl,%bl
 6de:	74 73                	je     753 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 6e0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 6e2:	0f be cb             	movsbl %bl,%ecx
 6e5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 6e8:	74 c6                	je     6b0 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6ea:	83 fa 25             	cmp    $0x25,%edx
 6ed:	75 e6                	jne    6d5 <printf+0x55>
      if(c == 'd'){
 6ef:	83 f8 64             	cmp    $0x64,%eax
 6f2:	0f 84 f8 00 00 00    	je     7f0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 6f8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 6fe:	83 f9 70             	cmp    $0x70,%ecx
 701:	74 5d                	je     760 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 703:	83 f8 73             	cmp    $0x73,%eax
 706:	0f 84 84 00 00 00    	je     790 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 70c:	83 f8 63             	cmp    $0x63,%eax
 70f:	0f 84 ea 00 00 00    	je     7ff <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 715:	83 f8 25             	cmp    $0x25,%eax
 718:	0f 84 c2 00 00 00    	je     7e0 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 71e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 721:	83 ec 04             	sub    $0x4,%esp
 724:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 728:	6a 01                	push   $0x1
 72a:	50                   	push   %eax
 72b:	57                   	push   %edi
 72c:	e8 21 fe ff ff       	call   552 <write>
 731:	83 c4 0c             	add    $0xc,%esp
 734:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 737:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 73a:	6a 01                	push   $0x1
 73c:	50                   	push   %eax
 73d:	57                   	push   %edi
 73e:	83 c6 01             	add    $0x1,%esi
 741:	e8 0c fe ff ff       	call   552 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 746:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 74a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 74d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 74f:	84 db                	test   %bl,%bl
 751:	75 8d                	jne    6e0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 753:	8d 65 f4             	lea    -0xc(%ebp),%esp
 756:	5b                   	pop    %ebx
 757:	5e                   	pop    %esi
 758:	5f                   	pop    %edi
 759:	5d                   	pop    %ebp
 75a:	c3                   	ret    
 75b:	90                   	nop
 75c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 760:	83 ec 0c             	sub    $0xc,%esp
 763:	b9 10 00 00 00       	mov    $0x10,%ecx
 768:	6a 00                	push   $0x0
 76a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 76d:	89 f8                	mov    %edi,%eax
 76f:	8b 13                	mov    (%ebx),%edx
 771:	e8 6a fe ff ff       	call   5e0 <printint>
        ap++;
 776:	89 d8                	mov    %ebx,%eax
 778:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 77b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 77d:	83 c0 04             	add    $0x4,%eax
 780:	89 45 d0             	mov    %eax,-0x30(%ebp)
 783:	e9 4d ff ff ff       	jmp    6d5 <printf+0x55>
 788:	90                   	nop
 789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 790:	8b 45 d0             	mov    -0x30(%ebp),%eax
 793:	8b 18                	mov    (%eax),%ebx
        ap++;
 795:	83 c0 04             	add    $0x4,%eax
 798:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 79b:	b8 fc 09 00 00       	mov    $0x9fc,%eax
 7a0:	85 db                	test   %ebx,%ebx
 7a2:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 7a5:	0f b6 03             	movzbl (%ebx),%eax
 7a8:	84 c0                	test   %al,%al
 7aa:	74 23                	je     7cf <printf+0x14f>
 7ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7b0:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7b3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 7b6:	83 ec 04             	sub    $0x4,%esp
 7b9:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 7bb:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7be:	50                   	push   %eax
 7bf:	57                   	push   %edi
 7c0:	e8 8d fd ff ff       	call   552 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7c5:	0f b6 03             	movzbl (%ebx),%eax
 7c8:	83 c4 10             	add    $0x10,%esp
 7cb:	84 c0                	test   %al,%al
 7cd:	75 e1                	jne    7b0 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7cf:	31 d2                	xor    %edx,%edx
 7d1:	e9 ff fe ff ff       	jmp    6d5 <printf+0x55>
 7d6:	8d 76 00             	lea    0x0(%esi),%esi
 7d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7e0:	83 ec 04             	sub    $0x4,%esp
 7e3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 7e6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 7e9:	6a 01                	push   $0x1
 7eb:	e9 4c ff ff ff       	jmp    73c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 7f0:	83 ec 0c             	sub    $0xc,%esp
 7f3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 7f8:	6a 01                	push   $0x1
 7fa:	e9 6b ff ff ff       	jmp    76a <printf+0xea>
 7ff:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 802:	83 ec 04             	sub    $0x4,%esp
 805:	8b 03                	mov    (%ebx),%eax
 807:	6a 01                	push   $0x1
 809:	88 45 e4             	mov    %al,-0x1c(%ebp)
 80c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 80f:	50                   	push   %eax
 810:	57                   	push   %edi
 811:	e8 3c fd ff ff       	call   552 <write>
 816:	e9 5b ff ff ff       	jmp    776 <printf+0xf6>
 81b:	66 90                	xchg   %ax,%ax
 81d:	66 90                	xchg   %ax,%ax
 81f:	90                   	nop

00000820 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 820:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 821:	a1 80 8d 00 00       	mov    0x8d80,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 826:	89 e5                	mov    %esp,%ebp
 828:	57                   	push   %edi
 829:	56                   	push   %esi
 82a:	53                   	push   %ebx
 82b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 82e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 830:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 833:	39 c8                	cmp    %ecx,%eax
 835:	73 19                	jae    850 <free+0x30>
 837:	89 f6                	mov    %esi,%esi
 839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 840:	39 d1                	cmp    %edx,%ecx
 842:	72 1c                	jb     860 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 844:	39 d0                	cmp    %edx,%eax
 846:	73 18                	jae    860 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 848:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 84a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 84c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 84e:	72 f0                	jb     840 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 850:	39 d0                	cmp    %edx,%eax
 852:	72 f4                	jb     848 <free+0x28>
 854:	39 d1                	cmp    %edx,%ecx
 856:	73 f0                	jae    848 <free+0x28>
 858:	90                   	nop
 859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 860:	8b 73 fc             	mov    -0x4(%ebx),%esi
 863:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 866:	39 d7                	cmp    %edx,%edi
 868:	74 19                	je     883 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 86a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 86d:	8b 50 04             	mov    0x4(%eax),%edx
 870:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 873:	39 f1                	cmp    %esi,%ecx
 875:	74 23                	je     89a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 877:	89 08                	mov    %ecx,(%eax)
  freep = p;
 879:	a3 80 8d 00 00       	mov    %eax,0x8d80
}
 87e:	5b                   	pop    %ebx
 87f:	5e                   	pop    %esi
 880:	5f                   	pop    %edi
 881:	5d                   	pop    %ebp
 882:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 883:	03 72 04             	add    0x4(%edx),%esi
 886:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 889:	8b 10                	mov    (%eax),%edx
 88b:	8b 12                	mov    (%edx),%edx
 88d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 890:	8b 50 04             	mov    0x4(%eax),%edx
 893:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 896:	39 f1                	cmp    %esi,%ecx
 898:	75 dd                	jne    877 <free+0x57>
    p->s.size += bp->s.size;
 89a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 89d:	a3 80 8d 00 00       	mov    %eax,0x8d80
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8a2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8a5:	8b 53 f8             	mov    -0x8(%ebx),%edx
 8a8:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 8aa:	5b                   	pop    %ebx
 8ab:	5e                   	pop    %esi
 8ac:	5f                   	pop    %edi
 8ad:	5d                   	pop    %ebp
 8ae:	c3                   	ret    
 8af:	90                   	nop

000008b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8b0:	55                   	push   %ebp
 8b1:	89 e5                	mov    %esp,%ebp
 8b3:	57                   	push   %edi
 8b4:	56                   	push   %esi
 8b5:	53                   	push   %ebx
 8b6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 8bc:	8b 15 80 8d 00 00    	mov    0x8d80,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8c2:	8d 78 07             	lea    0x7(%eax),%edi
 8c5:	c1 ef 03             	shr    $0x3,%edi
 8c8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 8cb:	85 d2                	test   %edx,%edx
 8cd:	0f 84 a3 00 00 00    	je     976 <malloc+0xc6>
 8d3:	8b 02                	mov    (%edx),%eax
 8d5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 8d8:	39 cf                	cmp    %ecx,%edi
 8da:	76 74                	jbe    950 <malloc+0xa0>
 8dc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 8e2:	be 00 10 00 00       	mov    $0x1000,%esi
 8e7:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 8ee:	0f 43 f7             	cmovae %edi,%esi
 8f1:	ba 00 80 00 00       	mov    $0x8000,%edx
 8f6:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 8fc:	0f 46 da             	cmovbe %edx,%ebx
 8ff:	eb 10                	jmp    911 <malloc+0x61>
 901:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 908:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 90a:	8b 48 04             	mov    0x4(%eax),%ecx
 90d:	39 cf                	cmp    %ecx,%edi
 90f:	76 3f                	jbe    950 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 911:	39 05 80 8d 00 00    	cmp    %eax,0x8d80
 917:	89 c2                	mov    %eax,%edx
 919:	75 ed                	jne    908 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 91b:	83 ec 0c             	sub    $0xc,%esp
 91e:	53                   	push   %ebx
 91f:	e8 96 fc ff ff       	call   5ba <sbrk>
  if(p == (char*)-1)
 924:	83 c4 10             	add    $0x10,%esp
 927:	83 f8 ff             	cmp    $0xffffffff,%eax
 92a:	74 1c                	je     948 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 92c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 92f:	83 ec 0c             	sub    $0xc,%esp
 932:	83 c0 08             	add    $0x8,%eax
 935:	50                   	push   %eax
 936:	e8 e5 fe ff ff       	call   820 <free>
  return freep;
 93b:	8b 15 80 8d 00 00    	mov    0x8d80,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 941:	83 c4 10             	add    $0x10,%esp
 944:	85 d2                	test   %edx,%edx
 946:	75 c0                	jne    908 <malloc+0x58>
        return 0;
 948:	31 c0                	xor    %eax,%eax
 94a:	eb 1c                	jmp    968 <malloc+0xb8>
 94c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 950:	39 cf                	cmp    %ecx,%edi
 952:	74 1c                	je     970 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 954:	29 f9                	sub    %edi,%ecx
 956:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 959:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 95c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 95f:	89 15 80 8d 00 00    	mov    %edx,0x8d80
      return (void*)(p + 1);
 965:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 968:	8d 65 f4             	lea    -0xc(%ebp),%esp
 96b:	5b                   	pop    %ebx
 96c:	5e                   	pop    %esi
 96d:	5f                   	pop    %edi
 96e:	5d                   	pop    %ebp
 96f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 970:	8b 08                	mov    (%eax),%ecx
 972:	89 0a                	mov    %ecx,(%edx)
 974:	eb e9                	jmp    95f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 976:	c7 05 80 8d 00 00 84 	movl   $0x8d84,0x8d80
 97d:	8d 00 00 
 980:	c7 05 84 8d 00 00 84 	movl   $0x8d84,0x8d84
 987:	8d 00 00 
    base.s.size = 0;
 98a:	b8 84 8d 00 00       	mov    $0x8d84,%eax
 98f:	c7 05 88 8d 00 00 00 	movl   $0x0,0x8d88
 996:	00 00 00 
 999:	e9 3e ff ff ff       	jmp    8dc <malloc+0x2c>
