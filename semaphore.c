#include "semaphore.h"
// set the maximum threads to count and initialize anything you need
void initsema(struct semaphore *lk, int count){
    lk->count = count;
}

// Similar with acquiring the lock, but need to check how many threads are in there.
// Return the number of remained threads that can access the section. 
int downsema(struct semaphore *lk){
	while(lk->count == 0)
		;
    return --lk->count;
}

// Similar with releasing the lock. Return the number of remained threads that can access the section.
int upsema(struct semaphore *lk){
    return ++lk->count;
}
