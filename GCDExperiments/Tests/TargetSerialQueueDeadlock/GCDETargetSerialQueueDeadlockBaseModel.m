//
//  GCDETargetSerialQueueDeadlockBaseModel.m
//  GCDExperiments
//
//  Created by Aleksei Kolchanov on 7/2/20.
//  Copyright © 2020 Aleksei Kolchanov. All rights reserved.
//

#import "GCDETargetSerialQueueDeadlockBaseModel.h"

@implementation GCDETargetSerialQueueDeadlockBaseModel {
  dispatch_queue_t _syncQueue;
  int _localInt0;
  int _localInt1;
}

- (instancetype)initWithTargetQueue:(dispatch_queue_t)queue {
  if (self = [super init]) {
    _syncQueue = dispatch_queue_create_with_target("Some Sync Queue", DISPATCH_QUEUE_SERIAL, queue);
    _localInt0 = 4;
    _localInt1 = 5;
  }
  return self;
}

- (void)calculateSomething:(void(^)(int))completion {
  dispatch_async(_syncQueue, ^{
    int result = self->_localInt0 + self->_localInt1;
    if (completion) {
      completion(result);
    }
  });
}

- (void)setSomeValue:(int)someValue {
  dispatch_async(_syncQueue, ^{
    self->_localInt0 = someValue;
  });
}

- (int)getSomeValue {
  __block int result;
  dispatch_sync(_syncQueue, ^{
    result = self->_localInt0;
  });
  return result;
}

@end
