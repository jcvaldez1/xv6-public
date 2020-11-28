
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
  11:	a1 ec 4c 00 00       	mov    0x4cec,%eax
  // main() is thread 0, which will make the first invocation to
  // thread_schedule().  it needs a stack so that the first thread_switch() can
  // save thread 0's state.  thread_schedule() won't run the main thread ever
  // again, because its state is set to RUNNING, and thread_schedule() selects
  // a RUNNABLE thread.
  current_thread = &all_thread[0];
  16:	c7 05 0c 8d 00 00 e0 	movl   $0xce0,0x8d0c
  1d:	0c 00 00 
  current_thread->state = RUNNING;
  20:	c7 05 e4 2c 00 00 01 	movl   $0x1,0x2ce4
  27:	00 00 00 
thread_create(void (*func)())
{
  thread_p t;

  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
    if (t->state == FREE) break;
  2a:	85 c0                	test   %eax,%eax
  2c:	0f 84 8b 00 00 00    	je     bd <main+0xbd>
  32:	a1 f4 6c 00 00       	mov    0x6cf4,%eax
  37:	85 c0                	test   %eax,%eax
  39:	0f 84 85 00 00 00    	je     c4 <main+0xc4>
void 
thread_create(void (*func)())
{
  thread_p t;

  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
  3f:	8b 0d fc 8c 00 00    	mov    0x8cfc,%ecx
  45:	ba f8 6c 00 00       	mov    $0x6cf8,%edx
  4a:	b8 00 8d 00 00       	mov    $0x8d00,%eax
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
  73:	b8 e0 0c 00 00       	mov    $0xce0,%eax
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
  87:	3d 00 8d 00 00       	cmp    $0x8d00,%eax
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
  bd:	b8 e8 2c 00 00       	mov    $0x2ce8,%eax
  c2:	eb 90                	jmp    54 <main+0x54>
  c4:	b8 f0 4c 00 00       	mov    $0x4cf0,%eax
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
  d1:	b8 e0 0c 00 00       	mov    $0xce0,%eax
  current_thread->state = RUNNING;
}

static void 
thread_schedule(void)
{
  d6:	89 e5                	mov    %esp,%ebp
  d8:	83 ec 08             	sub    $0x8,%esp
  db:	8b 15 0c 8d 00 00    	mov    0x8d0c,%edx
  thread_p t;

  /* Find another runnable thread. */
  next_thread = 0;
  e1:	c7 05 10 8d 00 00 00 	movl   $0x0,0x8d10
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
  f9:	3d 00 8d 00 00       	cmp    $0x8d00,%eax
  fe:	75 eb                	jne    eb <thread_schedule+0x1b>
      next_thread = t;
      break;
    }
  }

  if (t >= all_thread + MAX_THREAD && current_thread->state == RUNNABLE) {
 100:	83 ba 04 20 00 00 02 	cmpl   $0x2,0x2004(%edx)
 107:	74 57                	je     160 <thread_schedule+0x90>
 109:	a1 10 8d 00 00       	mov    0x8d10,%eax
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
 112:	39 05 0c 8d 00 00    	cmp    %eax,0x8d0c
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
 134:	3d 00 8d 00 00       	cmp    $0x8d00,%eax

  /* Find another runnable thread. */
  next_thread = 0;
  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
    if (t->state == RUNNABLE && t != current_thread) {
      next_thread = t;
 139:	a3 10 8d 00 00       	mov    %eax,0x8d10
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
 146:	68 20 09 00 00       	push   $0x920
 14b:	6a 02                	push   $0x2
 14d:	e8 ae 04 00 00       	call   600 <printf>
    exit();
 152:	e8 5b 03 00 00       	call   4b2 <exit>
 157:	89 f6                	mov    %esi,%esi
 159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  if (current_thread != next_thread) {         /* switch threads?  */
    next_thread->state = RUNNING;
    thread_switch();
  } else
    next_thread = 0;
 160:	c7 05 10 8d 00 00 00 	movl   $0x0,0x8d10
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
 17c:	68 48 09 00 00       	push   $0x948
 181:	6a 01                	push   $0x1
 183:	e8 78 04 00 00       	call   600 <printf>
 188:	83 c4 10             	add    $0x10,%esp
 18b:	90                   	nop
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for (i = 0; i < 100; i++) {
    printf(1, "my thread 0x%x\n", (int) current_thread);
 190:	83 ec 04             	sub    $0x4,%esp
 193:	ff 35 0c 8d 00 00    	pushl  0x8d0c
 199:	68 5b 09 00 00       	push   $0x95b
 19e:	6a 01                	push   $0x1
 1a0:	e8 5b 04 00 00       	call   600 <printf>
}

void 
thread_yield(void)
{
  current_thread->state = RUNNABLE;
 1a5:	a1 0c 8d 00 00       	mov    0x8d0c,%eax
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
 1c4:	68 6b 09 00 00       	push   $0x96b
 1c9:	6a 01                	push   $0x1
 1cb:	e8 30 04 00 00       	call   600 <printf>
  current_thread->state = FREE;
 1d0:	a1 0c 8d 00 00       	mov    0x8d0c,%eax
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
 1f1:	c7 05 0c 8d 00 00 e0 	movl   $0xce0,0x8d0c
 1f8:	0c 00 00 
  current_thread->state = RUNNING;
 1fb:	c7 05 e4 2c 00 00 01 	movl   $0x1,0x2ce4
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
 211:	b8 e0 0c 00 00       	mov    $0xce0,%eax
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
 227:	3d 00 8d 00 00       	cmp    $0x8d00,%eax
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
 250:	a1 0c 8d 00 00       	mov    0x8d0c,%eax
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
 * Use eax as a temporary register; it is caller saved.
 */
	.globl thread_switch
thread_switch:
	/* YOUR CODE HERE */
	ret				/* pop return address from stack */
 268:	c3                   	ret    
 269:	66 90                	xchg   %ax,%ax
 26b:	66 90                	xchg   %ax,%ax
 26d:	66 90                	xchg   %ax,%ax
 26f:	90                   	nop

00000270 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	53                   	push   %ebx
 274:	8b 45 08             	mov    0x8(%ebp),%eax
 277:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 27a:	89 c2                	mov    %eax,%edx
 27c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 280:	83 c1 01             	add    $0x1,%ecx
 283:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 287:	83 c2 01             	add    $0x1,%edx
 28a:	84 db                	test   %bl,%bl
 28c:	88 5a ff             	mov    %bl,-0x1(%edx)
 28f:	75 ef                	jne    280 <strcpy+0x10>
    ;
  return os;
}
 291:	5b                   	pop    %ebx
 292:	5d                   	pop    %ebp
 293:	c3                   	ret    
 294:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 29a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000002a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	56                   	push   %esi
 2a4:	53                   	push   %ebx
 2a5:	8b 55 08             	mov    0x8(%ebp),%edx
 2a8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 2ab:	0f b6 02             	movzbl (%edx),%eax
 2ae:	0f b6 19             	movzbl (%ecx),%ebx
 2b1:	84 c0                	test   %al,%al
 2b3:	75 1e                	jne    2d3 <strcmp+0x33>
 2b5:	eb 29                	jmp    2e0 <strcmp+0x40>
 2b7:	89 f6                	mov    %esi,%esi
 2b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 2c0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2c3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 2c6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2c9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 2cd:	84 c0                	test   %al,%al
 2cf:	74 0f                	je     2e0 <strcmp+0x40>
 2d1:	89 f1                	mov    %esi,%ecx
 2d3:	38 d8                	cmp    %bl,%al
 2d5:	74 e9                	je     2c0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 2d7:	29 d8                	sub    %ebx,%eax
}
 2d9:	5b                   	pop    %ebx
 2da:	5e                   	pop    %esi
 2db:	5d                   	pop    %ebp
 2dc:	c3                   	ret    
 2dd:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2e0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 2e2:	29 d8                	sub    %ebx,%eax
}
 2e4:	5b                   	pop    %ebx
 2e5:	5e                   	pop    %esi
 2e6:	5d                   	pop    %ebp
 2e7:	c3                   	ret    
 2e8:	90                   	nop
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002f0 <strlen>:

uint
strlen(const char *s)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 2f6:	80 39 00             	cmpb   $0x0,(%ecx)
 2f9:	74 12                	je     30d <strlen+0x1d>
 2fb:	31 d2                	xor    %edx,%edx
 2fd:	8d 76 00             	lea    0x0(%esi),%esi
 300:	83 c2 01             	add    $0x1,%edx
 303:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 307:	89 d0                	mov    %edx,%eax
 309:	75 f5                	jne    300 <strlen+0x10>
    ;
  return n;
}
 30b:	5d                   	pop    %ebp
 30c:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 30d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 30f:	5d                   	pop    %ebp
 310:	c3                   	ret    
 311:	eb 0d                	jmp    320 <memset>
 313:	90                   	nop
 314:	90                   	nop
 315:	90                   	nop
 316:	90                   	nop
 317:	90                   	nop
 318:	90                   	nop
 319:	90                   	nop
 31a:	90                   	nop
 31b:	90                   	nop
 31c:	90                   	nop
 31d:	90                   	nop
 31e:	90                   	nop
 31f:	90                   	nop

00000320 <memset>:

void*
memset(void *dst, int c, uint n)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	57                   	push   %edi
 324:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 327:	8b 4d 10             	mov    0x10(%ebp),%ecx
 32a:	8b 45 0c             	mov    0xc(%ebp),%eax
 32d:	89 d7                	mov    %edx,%edi
 32f:	fc                   	cld    
 330:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 332:	89 d0                	mov    %edx,%eax
 334:	5f                   	pop    %edi
 335:	5d                   	pop    %ebp
 336:	c3                   	ret    
 337:	89 f6                	mov    %esi,%esi
 339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000340 <strchr>:

char*
strchr(const char *s, char c)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	53                   	push   %ebx
 344:	8b 45 08             	mov    0x8(%ebp),%eax
 347:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 34a:	0f b6 10             	movzbl (%eax),%edx
 34d:	84 d2                	test   %dl,%dl
 34f:	74 1d                	je     36e <strchr+0x2e>
    if(*s == c)
 351:	38 d3                	cmp    %dl,%bl
 353:	89 d9                	mov    %ebx,%ecx
 355:	75 0d                	jne    364 <strchr+0x24>
 357:	eb 17                	jmp    370 <strchr+0x30>
 359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 360:	38 ca                	cmp    %cl,%dl
 362:	74 0c                	je     370 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 364:	83 c0 01             	add    $0x1,%eax
 367:	0f b6 10             	movzbl (%eax),%edx
 36a:	84 d2                	test   %dl,%dl
 36c:	75 f2                	jne    360 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 36e:	31 c0                	xor    %eax,%eax
}
 370:	5b                   	pop    %ebx
 371:	5d                   	pop    %ebp
 372:	c3                   	ret    
 373:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000380 <gets>:

char*
gets(char *buf, int max)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	56                   	push   %esi
 385:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 386:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 388:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 38b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 38e:	eb 29                	jmp    3b9 <gets+0x39>
    cc = read(0, &c, 1);
 390:	83 ec 04             	sub    $0x4,%esp
 393:	6a 01                	push   $0x1
 395:	57                   	push   %edi
 396:	6a 00                	push   $0x0
 398:	e8 2d 01 00 00       	call   4ca <read>
    if(cc < 1)
 39d:	83 c4 10             	add    $0x10,%esp
 3a0:	85 c0                	test   %eax,%eax
 3a2:	7e 1d                	jle    3c1 <gets+0x41>
      break;
    buf[i++] = c;
 3a4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 3a8:	8b 55 08             	mov    0x8(%ebp),%edx
 3ab:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 3ad:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 3af:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 3b3:	74 1b                	je     3d0 <gets+0x50>
 3b5:	3c 0d                	cmp    $0xd,%al
 3b7:	74 17                	je     3d0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3b9:	8d 5e 01             	lea    0x1(%esi),%ebx
 3bc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3bf:	7c cf                	jl     390 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 3c1:	8b 45 08             	mov    0x8(%ebp),%eax
 3c4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 3c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3cb:	5b                   	pop    %ebx
 3cc:	5e                   	pop    %esi
 3cd:	5f                   	pop    %edi
 3ce:	5d                   	pop    %ebp
 3cf:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 3d0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3d3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 3d5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 3d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3dc:	5b                   	pop    %ebx
 3dd:	5e                   	pop    %esi
 3de:	5f                   	pop    %edi
 3df:	5d                   	pop    %ebp
 3e0:	c3                   	ret    
 3e1:	eb 0d                	jmp    3f0 <stat>
 3e3:	90                   	nop
 3e4:	90                   	nop
 3e5:	90                   	nop
 3e6:	90                   	nop
 3e7:	90                   	nop
 3e8:	90                   	nop
 3e9:	90                   	nop
 3ea:	90                   	nop
 3eb:	90                   	nop
 3ec:	90                   	nop
 3ed:	90                   	nop
 3ee:	90                   	nop
 3ef:	90                   	nop

000003f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	56                   	push   %esi
 3f4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3f5:	83 ec 08             	sub    $0x8,%esp
 3f8:	6a 00                	push   $0x0
 3fa:	ff 75 08             	pushl  0x8(%ebp)
 3fd:	e8 f0 00 00 00       	call   4f2 <open>
  if(fd < 0)
 402:	83 c4 10             	add    $0x10,%esp
 405:	85 c0                	test   %eax,%eax
 407:	78 27                	js     430 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 409:	83 ec 08             	sub    $0x8,%esp
 40c:	ff 75 0c             	pushl  0xc(%ebp)
 40f:	89 c3                	mov    %eax,%ebx
 411:	50                   	push   %eax
 412:	e8 f3 00 00 00       	call   50a <fstat>
 417:	89 c6                	mov    %eax,%esi
  close(fd);
 419:	89 1c 24             	mov    %ebx,(%esp)
 41c:	e8 b9 00 00 00       	call   4da <close>
  return r;
 421:	83 c4 10             	add    $0x10,%esp
 424:	89 f0                	mov    %esi,%eax
}
 426:	8d 65 f8             	lea    -0x8(%ebp),%esp
 429:	5b                   	pop    %ebx
 42a:	5e                   	pop    %esi
 42b:	5d                   	pop    %ebp
 42c:	c3                   	ret    
 42d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 430:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 435:	eb ef                	jmp    426 <stat+0x36>
 437:	89 f6                	mov    %esi,%esi
 439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000440 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	53                   	push   %ebx
 444:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 447:	0f be 11             	movsbl (%ecx),%edx
 44a:	8d 42 d0             	lea    -0x30(%edx),%eax
 44d:	3c 09                	cmp    $0x9,%al
 44f:	b8 00 00 00 00       	mov    $0x0,%eax
 454:	77 1f                	ja     475 <atoi+0x35>
 456:	8d 76 00             	lea    0x0(%esi),%esi
 459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 460:	8d 04 80             	lea    (%eax,%eax,4),%eax
 463:	83 c1 01             	add    $0x1,%ecx
 466:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 46a:	0f be 11             	movsbl (%ecx),%edx
 46d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 470:	80 fb 09             	cmp    $0x9,%bl
 473:	76 eb                	jbe    460 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 475:	5b                   	pop    %ebx
 476:	5d                   	pop    %ebp
 477:	c3                   	ret    
 478:	90                   	nop
 479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000480 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	56                   	push   %esi
 484:	53                   	push   %ebx
 485:	8b 5d 10             	mov    0x10(%ebp),%ebx
 488:	8b 45 08             	mov    0x8(%ebp),%eax
 48b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 48e:	85 db                	test   %ebx,%ebx
 490:	7e 14                	jle    4a6 <memmove+0x26>
 492:	31 d2                	xor    %edx,%edx
 494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 498:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 49c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 49f:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4a2:	39 da                	cmp    %ebx,%edx
 4a4:	75 f2                	jne    498 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 4a6:	5b                   	pop    %ebx
 4a7:	5e                   	pop    %esi
 4a8:	5d                   	pop    %ebp
 4a9:	c3                   	ret    

000004aa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4aa:	b8 01 00 00 00       	mov    $0x1,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <exit>:
SYSCALL(exit)
 4b2:	b8 02 00 00 00       	mov    $0x2,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    

000004ba <wait>:
SYSCALL(wait)
 4ba:	b8 03 00 00 00       	mov    $0x3,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <pipe>:
SYSCALL(pipe)
 4c2:	b8 04 00 00 00       	mov    $0x4,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <read>:
SYSCALL(read)
 4ca:	b8 05 00 00 00       	mov    $0x5,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <write>:
SYSCALL(write)
 4d2:	b8 10 00 00 00       	mov    $0x10,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <close>:
SYSCALL(close)
 4da:	b8 15 00 00 00       	mov    $0x15,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <kill>:
SYSCALL(kill)
 4e2:	b8 06 00 00 00       	mov    $0x6,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <exec>:
SYSCALL(exec)
 4ea:	b8 07 00 00 00       	mov    $0x7,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <open>:
SYSCALL(open)
 4f2:	b8 0f 00 00 00       	mov    $0xf,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <mknod>:
SYSCALL(mknod)
 4fa:	b8 11 00 00 00       	mov    $0x11,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <unlink>:
SYSCALL(unlink)
 502:	b8 12 00 00 00       	mov    $0x12,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <fstat>:
SYSCALL(fstat)
 50a:	b8 08 00 00 00       	mov    $0x8,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <link>:
SYSCALL(link)
 512:	b8 13 00 00 00       	mov    $0x13,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <mkdir>:
SYSCALL(mkdir)
 51a:	b8 14 00 00 00       	mov    $0x14,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <chdir>:
SYSCALL(chdir)
 522:	b8 09 00 00 00       	mov    $0x9,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    

0000052a <dup>:
SYSCALL(dup)
 52a:	b8 0a 00 00 00       	mov    $0xa,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <getpid>:
SYSCALL(getpid)
 532:	b8 0b 00 00 00       	mov    $0xb,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <sbrk>:
SYSCALL(sbrk)
 53a:	b8 0c 00 00 00       	mov    $0xc,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <sleep>:
SYSCALL(sleep)
 542:	b8 0d 00 00 00       	mov    $0xd,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <uptime>:
SYSCALL(uptime)
 54a:	b8 0e 00 00 00       	mov    $0xe,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret    
 552:	66 90                	xchg   %ax,%ax
 554:	66 90                	xchg   %ax,%ax
 556:	66 90                	xchg   %ax,%ax
 558:	66 90                	xchg   %ax,%ax
 55a:	66 90                	xchg   %ax,%ax
 55c:	66 90                	xchg   %ax,%ax
 55e:	66 90                	xchg   %ax,%ax

00000560 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
 564:	56                   	push   %esi
 565:	53                   	push   %ebx
 566:	89 c6                	mov    %eax,%esi
 568:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 56b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 56e:	85 db                	test   %ebx,%ebx
 570:	74 7e                	je     5f0 <printint+0x90>
 572:	89 d0                	mov    %edx,%eax
 574:	c1 e8 1f             	shr    $0x1f,%eax
 577:	84 c0                	test   %al,%al
 579:	74 75                	je     5f0 <printint+0x90>
    neg = 1;
    x = -xx;
 57b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 57d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 584:	f7 d8                	neg    %eax
 586:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 589:	31 ff                	xor    %edi,%edi
 58b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 58e:	89 ce                	mov    %ecx,%esi
 590:	eb 08                	jmp    59a <printint+0x3a>
 592:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 598:	89 cf                	mov    %ecx,%edi
 59a:	31 d2                	xor    %edx,%edx
 59c:	8d 4f 01             	lea    0x1(%edi),%ecx
 59f:	f7 f6                	div    %esi
 5a1:	0f b6 92 84 09 00 00 	movzbl 0x984(%edx),%edx
  }while((x /= base) != 0);
 5a8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 5aa:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 5ad:	75 e9                	jne    598 <printint+0x38>
  if(neg)
 5af:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 5b2:	8b 75 c0             	mov    -0x40(%ebp),%esi
 5b5:	85 c0                	test   %eax,%eax
 5b7:	74 08                	je     5c1 <printint+0x61>
    buf[i++] = '-';
 5b9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 5be:	8d 4f 02             	lea    0x2(%edi),%ecx
 5c1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 5c5:	8d 76 00             	lea    0x0(%esi),%esi
 5c8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5cb:	83 ec 04             	sub    $0x4,%esp
 5ce:	83 ef 01             	sub    $0x1,%edi
 5d1:	6a 01                	push   $0x1
 5d3:	53                   	push   %ebx
 5d4:	56                   	push   %esi
 5d5:	88 45 d7             	mov    %al,-0x29(%ebp)
 5d8:	e8 f5 fe ff ff       	call   4d2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5dd:	83 c4 10             	add    $0x10,%esp
 5e0:	39 df                	cmp    %ebx,%edi
 5e2:	75 e4                	jne    5c8 <printint+0x68>
    putc(fd, buf[i]);
}
 5e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5e7:	5b                   	pop    %ebx
 5e8:	5e                   	pop    %esi
 5e9:	5f                   	pop    %edi
 5ea:	5d                   	pop    %ebp
 5eb:	c3                   	ret    
 5ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5f0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5f2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 5f9:	eb 8b                	jmp    586 <printint+0x26>
 5fb:	90                   	nop
 5fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000600 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	57                   	push   %edi
 604:	56                   	push   %esi
 605:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 606:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 609:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 60c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 60f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 612:	89 45 d0             	mov    %eax,-0x30(%ebp)
 615:	0f b6 1e             	movzbl (%esi),%ebx
 618:	83 c6 01             	add    $0x1,%esi
 61b:	84 db                	test   %bl,%bl
 61d:	0f 84 b0 00 00 00    	je     6d3 <printf+0xd3>
 623:	31 d2                	xor    %edx,%edx
 625:	eb 39                	jmp    660 <printf+0x60>
 627:	89 f6                	mov    %esi,%esi
 629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 630:	83 f8 25             	cmp    $0x25,%eax
 633:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 636:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 63b:	74 18                	je     655 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 63d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 640:	83 ec 04             	sub    $0x4,%esp
 643:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 646:	6a 01                	push   $0x1
 648:	50                   	push   %eax
 649:	57                   	push   %edi
 64a:	e8 83 fe ff ff       	call   4d2 <write>
 64f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 652:	83 c4 10             	add    $0x10,%esp
 655:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 658:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 65c:	84 db                	test   %bl,%bl
 65e:	74 73                	je     6d3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 660:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 662:	0f be cb             	movsbl %bl,%ecx
 665:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 668:	74 c6                	je     630 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 66a:	83 fa 25             	cmp    $0x25,%edx
 66d:	75 e6                	jne    655 <printf+0x55>
      if(c == 'd'){
 66f:	83 f8 64             	cmp    $0x64,%eax
 672:	0f 84 f8 00 00 00    	je     770 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 678:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 67e:	83 f9 70             	cmp    $0x70,%ecx
 681:	74 5d                	je     6e0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 683:	83 f8 73             	cmp    $0x73,%eax
 686:	0f 84 84 00 00 00    	je     710 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 68c:	83 f8 63             	cmp    $0x63,%eax
 68f:	0f 84 ea 00 00 00    	je     77f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 695:	83 f8 25             	cmp    $0x25,%eax
 698:	0f 84 c2 00 00 00    	je     760 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 69e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 6a1:	83 ec 04             	sub    $0x4,%esp
 6a4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 6a8:	6a 01                	push   $0x1
 6aa:	50                   	push   %eax
 6ab:	57                   	push   %edi
 6ac:	e8 21 fe ff ff       	call   4d2 <write>
 6b1:	83 c4 0c             	add    $0xc,%esp
 6b4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 6b7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 6ba:	6a 01                	push   $0x1
 6bc:	50                   	push   %eax
 6bd:	57                   	push   %edi
 6be:	83 c6 01             	add    $0x1,%esi
 6c1:	e8 0c fe ff ff       	call   4d2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6c6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6ca:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6cd:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6cf:	84 db                	test   %bl,%bl
 6d1:	75 8d                	jne    660 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6d6:	5b                   	pop    %ebx
 6d7:	5e                   	pop    %esi
 6d8:	5f                   	pop    %edi
 6d9:	5d                   	pop    %ebp
 6da:	c3                   	ret    
 6db:	90                   	nop
 6dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 6e0:	83 ec 0c             	sub    $0xc,%esp
 6e3:	b9 10 00 00 00       	mov    $0x10,%ecx
 6e8:	6a 00                	push   $0x0
 6ea:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 6ed:	89 f8                	mov    %edi,%eax
 6ef:	8b 13                	mov    (%ebx),%edx
 6f1:	e8 6a fe ff ff       	call   560 <printint>
        ap++;
 6f6:	89 d8                	mov    %ebx,%eax
 6f8:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6fb:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 6fd:	83 c0 04             	add    $0x4,%eax
 700:	89 45 d0             	mov    %eax,-0x30(%ebp)
 703:	e9 4d ff ff ff       	jmp    655 <printf+0x55>
 708:	90                   	nop
 709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 710:	8b 45 d0             	mov    -0x30(%ebp),%eax
 713:	8b 18                	mov    (%eax),%ebx
        ap++;
 715:	83 c0 04             	add    $0x4,%eax
 718:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 71b:	b8 7c 09 00 00       	mov    $0x97c,%eax
 720:	85 db                	test   %ebx,%ebx
 722:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 725:	0f b6 03             	movzbl (%ebx),%eax
 728:	84 c0                	test   %al,%al
 72a:	74 23                	je     74f <printf+0x14f>
 72c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 730:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 733:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 736:	83 ec 04             	sub    $0x4,%esp
 739:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 73b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 73e:	50                   	push   %eax
 73f:	57                   	push   %edi
 740:	e8 8d fd ff ff       	call   4d2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 745:	0f b6 03             	movzbl (%ebx),%eax
 748:	83 c4 10             	add    $0x10,%esp
 74b:	84 c0                	test   %al,%al
 74d:	75 e1                	jne    730 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 74f:	31 d2                	xor    %edx,%edx
 751:	e9 ff fe ff ff       	jmp    655 <printf+0x55>
 756:	8d 76 00             	lea    0x0(%esi),%esi
 759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 760:	83 ec 04             	sub    $0x4,%esp
 763:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 766:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 769:	6a 01                	push   $0x1
 76b:	e9 4c ff ff ff       	jmp    6bc <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 770:	83 ec 0c             	sub    $0xc,%esp
 773:	b9 0a 00 00 00       	mov    $0xa,%ecx
 778:	6a 01                	push   $0x1
 77a:	e9 6b ff ff ff       	jmp    6ea <printf+0xea>
 77f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 782:	83 ec 04             	sub    $0x4,%esp
 785:	8b 03                	mov    (%ebx),%eax
 787:	6a 01                	push   $0x1
 789:	88 45 e4             	mov    %al,-0x1c(%ebp)
 78c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 78f:	50                   	push   %eax
 790:	57                   	push   %edi
 791:	e8 3c fd ff ff       	call   4d2 <write>
 796:	e9 5b ff ff ff       	jmp    6f6 <printf+0xf6>
 79b:	66 90                	xchg   %ax,%ax
 79d:	66 90                	xchg   %ax,%ax
 79f:	90                   	nop

000007a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a1:	a1 00 8d 00 00       	mov    0x8d00,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a6:	89 e5                	mov    %esp,%ebp
 7a8:	57                   	push   %edi
 7a9:	56                   	push   %esi
 7aa:	53                   	push   %ebx
 7ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ae:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7b0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b3:	39 c8                	cmp    %ecx,%eax
 7b5:	73 19                	jae    7d0 <free+0x30>
 7b7:	89 f6                	mov    %esi,%esi
 7b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 7c0:	39 d1                	cmp    %edx,%ecx
 7c2:	72 1c                	jb     7e0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7c4:	39 d0                	cmp    %edx,%eax
 7c6:	73 18                	jae    7e0 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 7c8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ca:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7cc:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ce:	72 f0                	jb     7c0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7d0:	39 d0                	cmp    %edx,%eax
 7d2:	72 f4                	jb     7c8 <free+0x28>
 7d4:	39 d1                	cmp    %edx,%ecx
 7d6:	73 f0                	jae    7c8 <free+0x28>
 7d8:	90                   	nop
 7d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 7e0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7e3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7e6:	39 d7                	cmp    %edx,%edi
 7e8:	74 19                	je     803 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7ea:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7ed:	8b 50 04             	mov    0x4(%eax),%edx
 7f0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7f3:	39 f1                	cmp    %esi,%ecx
 7f5:	74 23                	je     81a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7f7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 7f9:	a3 00 8d 00 00       	mov    %eax,0x8d00
}
 7fe:	5b                   	pop    %ebx
 7ff:	5e                   	pop    %esi
 800:	5f                   	pop    %edi
 801:	5d                   	pop    %ebp
 802:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 803:	03 72 04             	add    0x4(%edx),%esi
 806:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 809:	8b 10                	mov    (%eax),%edx
 80b:	8b 12                	mov    (%edx),%edx
 80d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 810:	8b 50 04             	mov    0x4(%eax),%edx
 813:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 816:	39 f1                	cmp    %esi,%ecx
 818:	75 dd                	jne    7f7 <free+0x57>
    p->s.size += bp->s.size;
 81a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 81d:	a3 00 8d 00 00       	mov    %eax,0x8d00
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 822:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 825:	8b 53 f8             	mov    -0x8(%ebx),%edx
 828:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 82a:	5b                   	pop    %ebx
 82b:	5e                   	pop    %esi
 82c:	5f                   	pop    %edi
 82d:	5d                   	pop    %ebp
 82e:	c3                   	ret    
 82f:	90                   	nop

00000830 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 830:	55                   	push   %ebp
 831:	89 e5                	mov    %esp,%ebp
 833:	57                   	push   %edi
 834:	56                   	push   %esi
 835:	53                   	push   %ebx
 836:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 839:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 83c:	8b 15 00 8d 00 00    	mov    0x8d00,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 842:	8d 78 07             	lea    0x7(%eax),%edi
 845:	c1 ef 03             	shr    $0x3,%edi
 848:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 84b:	85 d2                	test   %edx,%edx
 84d:	0f 84 a3 00 00 00    	je     8f6 <malloc+0xc6>
 853:	8b 02                	mov    (%edx),%eax
 855:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 858:	39 cf                	cmp    %ecx,%edi
 85a:	76 74                	jbe    8d0 <malloc+0xa0>
 85c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 862:	be 00 10 00 00       	mov    $0x1000,%esi
 867:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 86e:	0f 43 f7             	cmovae %edi,%esi
 871:	ba 00 80 00 00       	mov    $0x8000,%edx
 876:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 87c:	0f 46 da             	cmovbe %edx,%ebx
 87f:	eb 10                	jmp    891 <malloc+0x61>
 881:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 888:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 88a:	8b 48 04             	mov    0x4(%eax),%ecx
 88d:	39 cf                	cmp    %ecx,%edi
 88f:	76 3f                	jbe    8d0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 891:	39 05 00 8d 00 00    	cmp    %eax,0x8d00
 897:	89 c2                	mov    %eax,%edx
 899:	75 ed                	jne    888 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 89b:	83 ec 0c             	sub    $0xc,%esp
 89e:	53                   	push   %ebx
 89f:	e8 96 fc ff ff       	call   53a <sbrk>
  if(p == (char*)-1)
 8a4:	83 c4 10             	add    $0x10,%esp
 8a7:	83 f8 ff             	cmp    $0xffffffff,%eax
 8aa:	74 1c                	je     8c8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 8ac:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 8af:	83 ec 0c             	sub    $0xc,%esp
 8b2:	83 c0 08             	add    $0x8,%eax
 8b5:	50                   	push   %eax
 8b6:	e8 e5 fe ff ff       	call   7a0 <free>
  return freep;
 8bb:	8b 15 00 8d 00 00    	mov    0x8d00,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 8c1:	83 c4 10             	add    $0x10,%esp
 8c4:	85 d2                	test   %edx,%edx
 8c6:	75 c0                	jne    888 <malloc+0x58>
        return 0;
 8c8:	31 c0                	xor    %eax,%eax
 8ca:	eb 1c                	jmp    8e8 <malloc+0xb8>
 8cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 8d0:	39 cf                	cmp    %ecx,%edi
 8d2:	74 1c                	je     8f0 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 8d4:	29 f9                	sub    %edi,%ecx
 8d6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 8d9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 8dc:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 8df:	89 15 00 8d 00 00    	mov    %edx,0x8d00
      return (void*)(p + 1);
 8e5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8eb:	5b                   	pop    %ebx
 8ec:	5e                   	pop    %esi
 8ed:	5f                   	pop    %edi
 8ee:	5d                   	pop    %ebp
 8ef:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 8f0:	8b 08                	mov    (%eax),%ecx
 8f2:	89 0a                	mov    %ecx,(%edx)
 8f4:	eb e9                	jmp    8df <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 8f6:	c7 05 00 8d 00 00 04 	movl   $0x8d04,0x8d00
 8fd:	8d 00 00 
 900:	c7 05 04 8d 00 00 04 	movl   $0x8d04,0x8d04
 907:	8d 00 00 
    base.s.size = 0;
 90a:	b8 04 8d 00 00       	mov    $0x8d04,%eax
 90f:	c7 05 08 8d 00 00 00 	movl   $0x0,0x8d08
 916:	00 00 00 
 919:	e9 3e ff ff ff       	jmp    85c <malloc+0x2c>
