// set the maximum threads to count and initialize anything you need
void initrwsema(struct rwsemaphore *lk){
    return 1;
}

// acquire shared lock
int downreadsema(struct rwsemaphore *lk){
    return 1;
}

// release shared lock
int upreadsema(struct rwsemaphore *lk){
    return 1;
}

// acquire exclusivelock
int downwritesema(struct rwsemaphore *lk){
    return 1;
}

// release exclusive lock
int upwritesema(struct rwsemaphore *lk){
    return 1;
}
