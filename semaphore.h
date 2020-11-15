struct semaphore {
  struct proc *head;            // head proc pointer
  struct sleeplock lock; // protects everything below here
  int max;		                // Max amount of threads
  int open;                     // current amount of threads open
};
