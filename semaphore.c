#include "semaphore.h"
#include "types.h"
#include "defs.h"
#include "param.h"
#include "x86.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "spinlock.h"
#include "sleeplock.h"

// set the maximum threads to count and initialize anything you need
void initsema(struct semaphore *lk, int count){
	initsleeplock(&lk->lock, "semaphore");
    lk->max = count;
    lk->open = count;
    lk->head = 0;
}

// Similar with acquiring the lock, but need to check how many threads are in there.
// Return the number of remained threads that can access the section. 
int downsema(struct semaphore *lk){

    int current_place = lk->max + 1;
    struct proc *temp, *cur_proc;
    cur_proc = myproc();

    // modify semaphore head
    acquiresleep(&lk->lock);
    cur_proc->next = lk->head;
    lk->head = cur_proc;
    if(!holdingsleep(&lk->lock)){
    	panic("semaphore LL edit without sleeplock");
    }
    releasesleep(&lk->lock);

    // check whether there are enough spaces
    while(current_place > lk->max){
    	current_place = 0;
        temp = cur_proc;
        while(temp != 0 && current_place <= lk->max){
       	  temp = temp->next;
       	  current_place++;
        }
    }
    return (lk->max - current_place);
}

// Similar with releasing the lock. Return the number of remained threads that can access the section.
int upsema(struct semaphore *lk){
	struct proc *temp, *cur_proc, *pre_cur;
	int remaining = lk->max;
	cur_proc = myproc();

	// modify the proc linked list
    acquiresleep(&lk->lock);
    temp = lk->head;
    pre_cur = 0;
    while(temp != 0){
    	if(temp->next == cur_proc) pre_cur = temp;
    	temp = temp->next;
    	if(remaining > 0) remaining--;
    }
    if(pre_cur == 0){
    	panic("cur_proc not found in LL");
    }
    // remove cur_proc from the linked list
    pre_cur->next = cur_proc->next;
    if(!holdingsleep(&lk->lock)){
    	panic("semaphore LL edit without sleeplock");
    }
    releasesleep(&lk->lock);

    return (remaining + 1);
}
