//
//  GCDETargetSerialQueueDeadlockViewController.h
//  GCDExperiments
//
//  Created by Aleksei Kolchanov on 7/2/20.
//  Copyright © 2020 Aleksei Kolchanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDETargetSerialQueueDeadlockNextModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GCDETargetSerialQueueDeadlockViewController : UIViewController

@property (nonatomic, strong) GCDETargetSerialQueueDeadlockNextModel *dependency;

@end

NS_ASSUME_NONNULL_END
