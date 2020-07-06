//
//  GCDETargetSerialQueueDeadlockBaseModel.h
//  GCDExperiments
//
//  Created by Aleksei Kolchanov on 7/2/20.
//  Copyright © 2020 Aleksei Kolchanov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCDETargetSerialQueueDeadlockBaseModel : NSObject

- (instancetype)initWithTargetQueue:(dispatch_queue_t)queue;

- (void)setSomeValue:(int)someValue;
- (int)getSomeValue;

- (void)calculateSomething:(void(^)(int))completion;

@end

NS_ASSUME_NONNULL_END
