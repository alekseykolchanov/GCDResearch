//
//  GCDETonsOfTasksEachOnNewEternalSerialQueueTest.m
//  GCDExperiments
//
//  Created by Aleksei Kolchanov on 7/2/20.
//  Copyright © 2020 Aleksei Kolchanov. All rights reserved.
//

#import "GCDETonsOfTasksEachOnNewEternalSerialQueueTest.h"
#import "GCDEFibonacci.h"
#import "GCDEStopWatch.h"

@implementation GCDETonsOfTasksEachOnNewEternalSerialQueueTest {
  int _fibonacciN;
  int _numberOfTasks;
  NSMutableDictionary *_queuesDictionary;
}

- (instancetype)initWithFibonacciN:(int)fibonacciN numberOfTasks:(int)tasksN {
  if (self = [super init]) {
    _fibonacciN = fibonacciN;
    _numberOfTasks = tasksN;
    _status = GCDETestStatusNone;
    _queuesDictionary = [NSMutableDictionary new];
  }
  return self;
}

- (void)startWithQoS:(dispatch_qos_class_t)qos {
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

  NSMutableArray *queuesArray = [self queuesArrayForQoS:qos];
  GCDEStopWatch *stopWatch = [GCDEStopWatch new];
  [stopWatch start];
  for (int i = 0; i < self->_numberOfTasks; i++) {
    dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL,
                                                                         qos,
                                                                         0);
    NSString *name = [NSString stringWithFormat:@"Queue - %d", i];

    dispatch_queue_t queue = dispatch_queue_create(name.UTF8String, attr);
    [queuesArray addObject: queue];
    dispatch_async(queue, ^{
      fib(fibN);
      dispatch_group_leave(group);
    });
  }

  __weak GCDETonsOfTasksEachOnNewEternalSerialQueueTest *weakSelf = self;
  dispatch_group_notify(group, dispatch_get_main_queue(), ^{
    [weakSelf setLastTime:[stopWatch currentTime]];
    [weakSelf setStatus: GCDETestStatusNone];
    [weakSelf.delegate testDidChangeStatus];
  });
}

- (NSMutableArray *)queuesArrayForQoS:(dispatch_qos_class_t)qos {
  NSString *qosString = @"Unknown";
  switch (qos) {
    case QOS_CLASS_USER_INTERACTIVE:
      qosString = @"USER_INTERACTIVE";
      break;
    case QOS_CLASS_USER_INITIATED:
      qosString = @"USER_INITIATED";
      break;
    case QOS_CLASS_UTILITY:
      qosString = @"UTILITY";
      break;
    case QOS_CLASS_BACKGROUND:
      qosString = @"BACKGROUND";
      break;
    default:
      NSAssert(NO, @"Unknown qos");
      break;
  }

  if (_queuesDictionary[qosString]) {
    return (NSMutableArray *)_queuesDictionary[qosString];
  } else {
    NSMutableArray *newArray = [NSMutableArray new];
    _queuesDictionary[qosString] = newArray;
    return newArray;
  }
}

@end
