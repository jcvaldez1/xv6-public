#ifndef _SEMAPHORE_H
#define _SEMAPHORE_H


struct semaphore{
    struct sleeplock slk;
    struct spinlock spinlk;
    int count;
    int CNT;
};



#endif
