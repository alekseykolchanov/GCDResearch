//
//  GCDESomeBigTasksSerialVsConcurrentQueueViewController.m
//  GCDExperiments
//
//  Created by Aleksei Kolchanov on 7/2/20.
//  Copyright © 2020 Aleksei Kolchanov. All rights reserved.
//

#import "GCDESomeBigTasksSerialVsConcurrentQueueViewController.h"

@interface GCDESomeBigTasksSerialVsConcurrentQueueViewController ()<GCDETonsOfTasksOnGlobalQueueTestDelegate>

@property (weak, nonatomic) IBOutlet UILabel *testStatusLabel0;
@property (weak, nonatomic) IBOutlet UILabel *lastTimeLabel0;

@property (weak, nonatomic) IBOutlet UILabel *testStatusLabel1;
@property (weak, nonatomic) IBOutlet UILabel *lastTimeLabel1;

@end

@implementation GCDESomeBigTasksSerialVsConcurrentQueueViewController
@synthesize test0 = _test0;
@synthesize test1 = _test1;

- (void)viewDidLoad {
    [super viewDidLoad];
  [self updateTestUI];
}

- (void)setTest0:(GCDETonsOfTasksOnGlobalQueueTest *)test0 {
  _test0 = test0;
  _test0.delegate = self;
  [self updateTestUI];
}

- (void)setTest1:(GCDETonsOfTasksOnGlobalQueueTest *)test1 {
  _test1 = test1;
  _test1.delegate = self;
  [self updateTestUI];
}

- (void)updateTestUI {
  if (!NSThread.isMainThread) {
    dispatch_async(dispatch_get_main_queue(), ^{
      [self updateTestUI];
    });
    return;
  }

  if (!self.test0) {
    self.testStatusLabel0.text = @"No Test Assigned";
    self.lastTimeLabel0.text = @"-";
  } else {
    switch (self.test0.status) {
      case GCDETestStatusNone:
        self.testStatusLabel0.text = @"Not Running";
        break;
      case GCDETestStatusRunning:
        self.testStatusLabel0.text = @"Running";
        break;
      default:
        break;
    }

    self.lastTimeLabel0.text = [NSString stringWithFormat:@"%.6f sec", self.test0.lastTime];
  }


  if (!self.test1) {
    self.testStatusLabel1.text = @"No Test Assigned";
    self.lastTimeLabel1.text = @"-";
  } else {
    switch (self.test1.status) {
      case GCDETestStatusNone:
        self.testStatusLabel1.text = @"Not Running";
        break;
      case GCDETestStatusRunning:
        self.testStatusLabel1.text = @"Running";
        break;
      default:
        break;
    }

    self.lastTimeLabel1.text = [NSString stringWithFormat:@"%.6f sec", self.test1.lastTime];
  }


}

- (IBAction)startButtonClick:(id)sender {
  UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Pick QoS" message:nil preferredStyle:UIAlertControllerStyleActionSheet];

  __weak typeof(self) weakSelf = self;
  UIAlertAction *action = [UIAlertAction actionWithTitle:@"USER_INTERACTIVE"
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * _Nonnull action) {

    dispatch_queue_attr_t conc_attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT,
                                                                         QOS_CLASS_USER_INTERACTIVE,
                                                                         0);
    dispatch_queue_t conc_queue = dispatch_queue_create("conc_queue", conc_attr);

    dispatch_queue_attr_t ser_attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL,
                                                                         QOS_CLASS_USER_INTERACTIVE,
                                                                         0);
    dispatch_queue_t ser_queue = dispatch_queue_create("conc_queue", ser_attr);

    [weakSelf.test0 startWithQueue:conc_queue];
    [weakSelf.test1 startWithQueue:ser_queue];
    [weakSelf dismissViewControllerAnimated:YES completion:nil];
  }];
  [ac addAction:action];


  action = [UIAlertAction actionWithTitle:@"USER_INITIATED"
                                    style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * _Nonnull action) {

    dispatch_queue_attr_t conc_attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT,
                                                                         QOS_CLASS_USER_INITIATED,
                                                                         0);
    dispatch_queue_t conc_queue = dispatch_queue_create("conc_queue", conc_attr);

    dispatch_queue_attr_t ser_attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL,
                                                                         QOS_CLASS_USER_INITIATED,
                                                                         0);
    dispatch_queue_t ser_queue = dispatch_queue_create("conc_queue", ser_attr);

    [weakSelf.test0 startWithQueue:conc_queue];
    [weakSelf.test1 startWithQueue:ser_queue];
    [weakSelf dismissViewControllerAnimated:YES completion:nil];
  }];
  [ac addAction:action];

  action = [UIAlertAction actionWithTitle:@"UTILITY"
                                    style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * _Nonnull action) {

    dispatch_queue_attr_t conc_attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT,
                                                                              QOS_CLASS_UTILITY,
                                                                              0);
    dispatch_queue_t conc_queue = dispatch_queue_create("conc_queue", conc_attr);

    dispatch_queue_attr_t ser_attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL,
                                                                             QOS_CLASS_UTILITY,
                                                                             0);
    dispatch_queue_t ser_queue = dispatch_queue_create("conc_queue", ser_attr);

    [weakSelf.test0 startWithQueue:conc_queue];
    [weakSelf.test1 startWithQueue:ser_queue];
    [weakSelf dismissViewControllerAnimated:YES completion:nil];
  }];
  [ac addAction:action];

  action = [UIAlertAction actionWithTitle:@"BACKGROUND"
                                    style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * _Nonnull action) {
    dispatch_queue_attr_t conc_attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT,
                                                                              QOS_CLASS_BACKGROUND,
                                                                              0);
    dispatch_queue_t conc_queue = dispatch_queue_create("conc_queue", conc_attr);

    dispatch_queue_attr_t ser_attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL,
                                                                             QOS_CLASS_BACKGROUND,
                                                                             0);
    dispatch_queue_t ser_queue = dispatch_queue_create("conc_queue", ser_attr);

    [weakSelf.test0 startWithQueue:conc_queue];
    [weakSelf.test1 startWithQueue:ser_queue];
    [weakSelf dismissViewControllerAnimated:YES completion:nil];
  }];
  [ac addAction:action];

  action = [UIAlertAction actionWithTitle:@"Cancel"
                                    style:UIAlertActionStyleCancel
                                  handler:^(UIAlertAction * _Nonnull action) {
    [weakSelf dismissViewControllerAnimated:YES completion:nil];
  }];
  [ac addAction:action];

  [self presentViewController:ac animated:YES completion:nil];
}

#pragma mark: - GCDETonsOfTasksOnGlobalQueueTestDelegate
- (void)testDidChangeStatus {
  [self updateTestUI];
}

@end
