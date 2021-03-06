//
//  GCDESomeBigTasksSerialVsConcurrentQueueViewController.h
//  GCDExperiments
//
//  Created by Aleksei Kolchanov on 7/2/20.
//  Copyright © 2020 Aleksei Kolchanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDETonsOfTasksOnGlobalQueueTest.h"

NS_ASSUME_NONNULL_BEGIN

@interface GCDESomeBigTasksSerialVsConcurrentQueueViewController: UIViewController

@property (nonatomic) GCDETonsOfTasksOnGlobalQueueTest *test0;
@property (nonatomic) GCDETonsOfTasksOnGlobalQueueTest *test1;


@end

NS_ASSUME_NONNULL_END
