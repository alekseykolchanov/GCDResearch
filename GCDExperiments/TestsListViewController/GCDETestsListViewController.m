//
//  GCDETestsListViewController.m
//  GCDExperiments
//
//  Created by Aleksei Kolchanov on 7/2/20.
//  Copyright © 2020 Aleksei Kolchanov. All rights reserved.
//

#import "GCDETestsListViewController.h"

#import "GCDETonsOfTasksOnGlobalQueueViewController.h"
#import "GCDETonsOfTasksOnPrivateConcurrentQueueViewController.h"
#import "GCDETonsOfTasksOnGlobalQueueTest.h"

#import "GCDETonsOfTasksEachOnSeparateSerialQueueViewController.h"
#import "GCDETonsOfTasksEachOnSeparateSerialQueueTest.h"

#import "GCDESomeBigTasksSerialVsConcurrentQueueViewController.h"

#import "GCDETargetSerialQueueDeadlockViewController.h"
#import "GCDETargetSerialQueueDeadlockBaseModel.h"
#import "GCDETargetSerialQueueDeadlockNextModel.h"

#import "GCDETonsOfTasksOnOneSerialQueueViewController.h"

@interface GCDETestsListViewController ()

@end

@implementation GCDETestsListViewController {
  GCDETonsOfTasksOnGlobalQueueTest *_tonsOfTasksOnGlobalQueueTest;
  GCDETonsOfTasksOnGlobalQueueTest *_tonsOfTasksOnPrivateConcurrentQueueTest;
  GCDETonsOfTasksEachOnSeparateSerialQueueTest *_tonsOfTasksEachOnSeparateSerialQueueTest;

  GCDETonsOfTasksOnGlobalQueueTest *_someTasksOnConcurrentQueueTestPart0;
  GCDETonsOfTasksOnGlobalQueueTest *_someTasksOnConcurrentQueueTestPart1;

  GCDETonsOfTasksOnGlobalQueueTest *_tonsOfTasksOnSerialQueueTest;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  [self createTests];
}

- (void)createTests {

  _tonsOfTasksOnGlobalQueueTest = [[GCDETonsOfTasksOnGlobalQueueTest alloc]
                                   initWithFibonacciN:10000000
                                   numberOfTasks:10000];

  _tonsOfTasksOnPrivateConcurrentQueueTest = [[GCDETonsOfTasksOnGlobalQueueTest alloc]
                                              initWithFibonacciN:10000000
                                              numberOfTasks:10000];

  _tonsOfTasksEachOnSeparateSerialQueueTest = [[GCDETonsOfTasksEachOnSeparateSerialQueueTest alloc]
                                               initWithFibonacciN:10000000
                                               numberOfTasks:1000];



  _someTasksOnConcurrentQueueTestPart0 = [[GCDETonsOfTasksOnGlobalQueueTest alloc]
                                          initWithFibonacciN:100000000
                                          numberOfTasks:10];

  _someTasksOnConcurrentQueueTestPart1 = [[GCDETonsOfTasksOnGlobalQueueTest alloc]
                                          initWithFibonacciN:100000000
                                          numberOfTasks:10];

  _tonsOfTasksOnSerialQueueTest = [[GCDETonsOfTasksOnGlobalQueueTest alloc]
                                   initWithFibonacciN:1000000
                                   numberOfTasks:1000];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  [super prepareForSegue:segue sender:sender];

  if ([segue.identifier isEqualToString: @"ShowTonsOfTasksOnGlobalQueueSeque"]) {

    [(GCDETonsOfTasksOnGlobalQueueViewController *)segue.destinationViewController setTest:_tonsOfTasksOnGlobalQueueTest];

  } else if ([segue.identifier isEqualToString: @"ShowTonsOfTasksOnPrivateConcurrentQueueSeque"]) {

    [(GCDETonsOfTasksOnGlobalQueueViewController *)segue.destinationViewController setTest:_tonsOfTasksOnPrivateConcurrentQueueTest];

  } else if ([segue.identifier isEqualToString: @"ShowTonsOfTasksOnPrivateSerialQueueSeque"]) {

    [(GCDETonsOfTasksOnOneSerialQueueViewController *)segue.destinationViewController setTest:_tonsOfTasksOnSerialQueueTest];

  }else if ([segue.identifier isEqualToString: @"ShowTonsOfTasksEachOnSerialQueueSeque"]) {

     [(GCDETonsOfTasksEachOnSeparateSerialQueueViewController *)segue.destinationViewController setTest:_tonsOfTasksEachOnSeparateSerialQueueTest];

  } else if ([segue.identifier isEqualToString: @"ShowSomeBigTasksOnConcurrentVsSerialQueueSeque"]) {
    
    [(GCDESomeBigTasksSerialVsConcurrentQueueViewController *)segue.destinationViewController setTest0:_someTasksOnConcurrentQueueTestPart0];
    [(GCDESomeBigTasksSerialVsConcurrentQueueViewController *)segue.destinationViewController setTest1:_someTasksOnConcurrentQueueTestPart1];
  } else if ([segue.identifier isEqualToString:@"ShowTargetSerialQueueDeadlockSeque"]) {

    dispatch_queue_t targetQueue = dispatch_queue_create("Serial queue", DISPATCH_QUEUE_SERIAL);

    GCDETargetSerialQueueDeadlockBaseModel *baseModel = [[GCDETargetSerialQueueDeadlockBaseModel alloc]
                                                         initWithTargetQueue:targetQueue];
    GCDETargetSerialQueueDeadlockNextModel *nextModel = [[GCDETargetSerialQueueDeadlockNextModel alloc]
                                                         initWithTargetQueue:targetQueue
                                                         dependency:baseModel];
    [(GCDETargetSerialQueueDeadlockViewController *)segue.destinationViewController setDependency:nextModel];
  } else {

    NSAssert(NO, @"Unrecognized segue");
  }
}


@end
