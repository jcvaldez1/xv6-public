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
#include "rwsemaphore.h"


void initrwsema(struct rwsemaphore *lk)
{
    lk->writelocked = 0;
    lk->readlocked = 0;
    lk->head = 0;
}



void downreadsema(struct rwsemaphore *lk)
{
    acquire(&lk->splk);
    while(lk->writelocked || lk->head != 0)
    {
         if(lk->head == 0){
            lk->head = myproc();
            lk->head->next = 0;
            lk->head->r_w = 1;
        }
        else{
            struct proc* temp = lk->head;
            while(temp->next != 0)temp = temp->next;
            temp->next = myproc();
            temp->next->r_w = 1;
            temp->next->next = 0;
        }
        sleep(lk,&lk->splk);
    }
    lk->readlocked++;
    release(&lk->splk);
}


void upreadsema(struct rwsemaphore *lk)
{
    acquire(&lk->splk);
    if(lk->readlocked == 1){
        lk->readlocked--;
        if(lk->head != 0 && lk->head->state == SLEEPING && lk->head->chan == lk){
            lk->head->state = RUNNABLE;
            lk->head = lk->head->next;
        }
    }else{
        lk->readlocked--;
    }
    release(&lk->splk);
}


void downwritesema(struct rwsemaphore *lk)
{
    acquire(&lk->splk);
    while(lk->writelocked || lk->readlocked)
    {
        if(lk->head == 0){
            lk->head = myproc();
            lk->head->next = 0;
            lk->head->r_w = 2;
        }
        else{
            struct proc* temp = lk->head;
            while(temp->next != 0)temp = temp->next;
            temp->next = myproc();
            temp->next->r_w = 2;
            temp->next->next = 0;
        }
        sleep(lk,&lk->splk);
    }
    lk->writelocked = 1;
    release(&lk->splk);
}


void upwritesema(struct rwsemaphore *lk)
{
    acquire(&lk->splk);
    if(lk->writelocked){
        lk->writelocked = 0;
        if(lk->head != 0){
            if(lk->head->r_w == 2){
                if(lk->head->state == SLEEPING && lk->head->chan == lk){
                    lk->head->state = RUNNABLE;
                    lk->head = lk->head->next;           
                }

            }else{
                while(lk->head->r_w == 1){
                    if(lk->head->state == SLEEPING && lk->head->chan == lk){
                        lk->head->state = RUNNABLE;
                        lk->head = lk->head->next;           
                    }       
                }
            }
        }
    }
    release(&lk->splk);
}
