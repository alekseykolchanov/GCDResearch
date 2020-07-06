//
//  GCDETonsOfTasksOnGlobalQueueTest.m
//  GCDExperiments
//
//  Created by Aleksei Kolchanov on 7/2/20.
//  Copyright © 2020 Aleksei Kolchanov. All rights reserved.
//

#import "GCDETonsOfTasksOnGlobalQueueTest.h"
#import "GCDEFibonacci.h"
#import "GCDEStopWatch.h"

@implementation GCDETonsOfTasksOnGlobalQueueTest {
  int _fibonacciN;
  int _numberOfTasks;
}

- (instancetype)initWithFibonacciN:(int)fibonacciN numberOfTasks:(int)tasksN {
  if (self = [super init]) {
    _fibonacciN = fibonacciN;
    _numberOfTasks = tasksN;
    _status = GCDETestStatusNone;
  }
  return self;
}

- (void)startWithQueue:(dispatch_queue_t)queue {
  if (self.status == GCDETestStatusRunning) {
    return;
  }

  self.status = GCDETestStatusRunning;
  self.lastTime = 0.0;
  [self.delegate testDidChangeStatus];

  int fibN = _fibonacciN;

  dispatch_group_t group = dispatch_group_create();

  for (int i = 0; i < self->_numberOfTasks; i++) {
    dispatch_group_enter(group);

  }

  GCDEStopWatch *stopWatch = [GCDEStopWatch new];
  [stopWatch start];
  for (int i = 0; i < self->_numberOfTasks; i++) {
    dispatch_async(queue, ^{
      fib(fibN);
      dispatch_group_leave(group);
    });
  }

  __weak GCDETonsOfTasksOnGlobalQueueTest *weakSelf = self;
  dispatch_group_notify(group, dispatch_get_main_queue(), ^{
    [weakSelf setLastTime:[stopWatch currentTime]];
    [weakSelf setStatus: GCDETestStatusNone];
    [weakSelf.delegate testDidChangeStatus];
  });
}

@end
