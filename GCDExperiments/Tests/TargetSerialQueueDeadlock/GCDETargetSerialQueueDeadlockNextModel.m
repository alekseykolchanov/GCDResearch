//
//  GCDETargetSerialQueueDeadlockNextModel.m
//  GCDExperiments
//
//  Created by Aleksei Kolchanov on 7/2/20.
//  Copyright © 2020 Aleksei Kolchanov. All rights reserved.
//

#import "GCDETargetSerialQueueDeadlockNextModel.h"

@implementation GCDETargetSerialQueueDeadlockNextModel {
  dispatch_queue_t _syncQueue;
  int _localInt0;
  int _localInt1;
  GCDETargetSerialQueueDeadlockBaseModel *_dependency;
}

- (instancetype)initWithTargetQueue:(dispatch_queue_t)queue
                         dependency:(GCDETargetSerialQueueDeadlockBaseModel *)dependency {
  if (self = [super init]) {
    _syncQueue = dispatch_queue_create_with_target("Another Sync Queue", DISPATCH_QUEUE_SERIAL, queue);
    _localInt0 = 14;
    _localInt1 = 15;
    _dependency = dependency;
  }
  return self;
}

- (void)calculateSomething:(void(^)(int))completion {
  dispatch_async(_syncQueue, ^{
    int result = self->_localInt0 + self->_localInt1 + [self->_dependency getSomeValue];
    [self->_dependency setSomeValue: result];
    if (completion) {
      completion(result);
    }
  });
}
@end
