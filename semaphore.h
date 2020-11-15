struct semaphore {
  struct proc *head;            // head proc pointer
  struct sleeplock lock; // sleeplock for editing value
  int max;		                // Max amount of threads
  int open;                     // current amount of threads open
};
