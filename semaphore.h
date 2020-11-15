struct semaphore {
  struct cpu *cpu;   // The cpu holding the lock.
  int count;		 // Max amount of threads
};
