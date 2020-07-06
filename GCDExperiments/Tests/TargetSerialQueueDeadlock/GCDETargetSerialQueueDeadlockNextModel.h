//
//  GCDETargetSerialQueueDeadlockNextModel.h
//  GCDExperiments
//
//  Created by Aleksei Kolchanov on 7/2/20.
//  Copyright © 2020 Aleksei Kolchanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDETargetSerialQueueDeadlockBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GCDETargetSerialQueueDeadlockNextModel : NSObject

- (instancetype)initWithTargetQueue:(dispatch_queue_t)queue
                         dependency:(GCDETargetSerialQueueDeadlockBaseModel *)dependency;
- (void)calculateSomething:(void(^)(int))completion;

@end

NS_ASSUME_NONNULL_END
