#include "types.h"
#include "defs.h"
#include "param.h"
#include "x86.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "semaphore.h"

void initsema(struct semaphore *lk, int count)
{
    lk->count = count;
    lk->CNT   = count;
}
int downsema(struct semaphore *lk)
{
    if(lk->count > 1)
    {
        lk->count--;
        return lk->count;
    }
    else
    {
       acquiresleep(&lk->slk);
       lk->count--;
       return lk->count;
    }
}
int upsema(struct semaphore *lk)
{
    acquire(&lk->spinlk);
    if(holdingsleep(&lk->slk))
    {
        if(lk->count < lk->CNT)lk->count++;
        releasesleep(&lk->slk);
        release(&lk->spinlk);
        return lk->count;
    }
    else
    {
        if(lk->count < lk->CNT)lk->count++;
        release(&lk->spinlk);
        return lk->count;
    }
}
