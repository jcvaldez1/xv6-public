#ifndef _RW_SEMAPHORE_H
#define _RW_SEMAPHORE_H


struct rwsemaphore{
    struct spinlock splk;
    uint writelocked;
    uint readlocked;
    struct proc* head;
};


#endif

