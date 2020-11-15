#include "semaphore.h"
#include "params.h"
#include "defs.h"
#include "sleeplock.h"

// set the maximum threads to count and initialize anything you need
void initsema(struct semaphore *lk, int count){
	initsleeplock(lk->sleeplock, "semaphore");
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
    acquiresleeplock(lk->sleeplock);
    cur_proc->next = lk->head;
    lk->head = cur_proc;
    if(!holdingsleep(lk->sleeplock)){
    	panic("semaphore LL edit without sleeplock");
    }
    releasesleep(lk->sleeplock);

    // check whether there are enough spaces
    while(current_place >= lk->max){
    	current_place = 0;
        temp = cur_proc;
        while(temp != 0 && current_place < lk->max){
       	  temp = temp->next;
       	  current_place++;
        }
    }
    return (lk->max - current_place + 1);
}

// Similar with releasing the lock. Return the number of remained threads that can access the section.
int upsema(struct semaphore *lk){
	struct proc *temp, *cur_proc, *pre_cur;
	int remaining = lk->max;
	cur_proc = myproc();

	// modify the proc linked list
    acquiresleeplock(lk->sleeplock);
    temp = lk->head;
    while(temp != 0){
    	if(temp->next == cur_proc) pre_cur = temp;
    	temp = temp->next;
    	if(remaining > 0) remaining--;
    }

    // remove cur_proc from the linked list
    pre_cur->next = cur_proc->next;
    if(!holdingsleep(lk->sleeplock)){
    	panic("semaphore LL edit without sleeplock");
    }
    releasesleep(lk->sleeplock);

    return (remaining + 1);
}
