//
//  GCDETonsOfTasksEachOnNewEternalSerialQueueViewController.m
//  GCDExperiments
//
//  Created by Aleksei Kolchanov on 7/2/20.
//  Copyright © 2020 Aleksei Kolchanov. All rights reserved.
//

#import "GCDETonsOfTasksEachOnNewEternalSerialQueueViewController.h"

@interface GCDETonsOfTasksEachOnNewEternalSerialQueueViewController ()<GCDETonsOfTasksEachOnNewEternalSerialQueueTestDelegate>

@property (weak, nonatomic) IBOutlet UILabel *testStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastTimeLabel;

@end

@implementation GCDETonsOfTasksEachOnNewEternalSerialQueueViewController
@synthesize test = _test;

- (void)viewDidLoad {
    [super viewDidLoad];
  [self updateTestUI];
}

- (void)setTest:(GCDETonsOfTasksEachOnNewEternalSerialQueueTest *)test {
  _test = test;
  _test.delegate = self;
  [self updateTestUI];
}

- (void)updateTestUI {
  if (!NSThread.isMainThread) {
    dispatch_async(dispatch_get_main_queue(), ^{
      [self updateTestUI];
    });
    return;
  }

  if (!self.test) {
    self.testStatusLabel.text = @"No Test Assigned";
    self.lastTimeLabel.text = @"-";
    return;
  }

  switch (self.test.status) {
    case GCDETestStatusNone:
      self.testStatusLabel.text = @"Not Running";
      break;
    case GCDETestStatusRunning:
      self.testStatusLabel.text = @"Running";
      break;
    default:
      break;
  }

  self.lastTimeLabel.text = [NSString stringWithFormat:@"%.6f sec", self.test.lastTime];
}

- (IBAction)startButtonClick:(id)sender {
  UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Pick QoS" message:nil preferredStyle:UIAlertControllerStyleActionSheet];

  __weak typeof(self) weakSelf = self;
  UIAlertAction *action = [UIAlertAction actionWithTitle:@"USER_INTERACTIVE"
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * _Nonnull action) {
    [weakSelf.test startWithQoS: QOS_CLASS_USER_INTERACTIVE];
    [weakSelf dismissViewControllerAnimated:YES completion:nil];
  }];
  [ac addAction:action];


  action = [UIAlertAction actionWithTitle:@"USER_INITIATED"
                                    style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * _Nonnull action) {

    [weakSelf.test startWithQoS: QOS_CLASS_USER_INITIATED];
    [weakSelf dismissViewControllerAnimated:YES completion:nil];
  }];
  [ac addAction:action];

  action = [UIAlertAction actionWithTitle:@"UTILITY"
                                    style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * _Nonnull action) {
    [weakSelf.test startWithQoS: QOS_CLASS_UTILITY];
    [weakSelf dismissViewControllerAnimated:YES completion:nil];
  }];
  [ac addAction:action];

  action = [UIAlertAction actionWithTitle:@"BACKGROUND"
                                    style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * _Nonnull action) {
    [weakSelf.test startWithQoS: QOS_CLASS_BACKGROUND];
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
