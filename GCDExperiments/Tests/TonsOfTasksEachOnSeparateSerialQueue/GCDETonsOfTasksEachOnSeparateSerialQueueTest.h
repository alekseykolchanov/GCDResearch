//
//  GCDETonsOfTasksEachOnSeparateSerialQueueTest.h
//  GCDExperiments
//
//  Created by Aleksei Kolchanov on 7/2/20.
//  Copyright © 2020 Aleksei Kolchanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDETestStatus.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GCDETonsOfTasksEachOnSeparateSerialQueueTestDelegate
  - (void)testDidChangeStatus;
@end

@interface GCDETonsOfTasksEachOnSeparateSerialQueueTest: NSObject

- (instancetype)initWithFibonacciN:(int)fibonacciN numberOfTasks:(int)tasksN;

@property (atomic) GCDETestStatus status;
@property (atomic) NSTimeInterval lastTime;

@property (nonatomic, weak) id<GCDETonsOfTasksEachOnSeparateSerialQueueTestDelegate> delegate;

- (void)startWithQoS:(dispatch_qos_class_t)qos;

@end

NS_ASSUME_NONNULL_END
