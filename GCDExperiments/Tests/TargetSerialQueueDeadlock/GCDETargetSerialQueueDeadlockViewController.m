//
//  GCDETargetSerialQueueDeadlockViewController.m
//  GCDExperiments
//
//  Created by Aleksei Kolchanov on 7/2/20.
//  Copyright © 2020 Aleksei Kolchanov. All rights reserved.
//

#import "GCDETargetSerialQueueDeadlockViewController.h"


@interface GCDETargetSerialQueueDeadlockViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation GCDETargetSerialQueueDeadlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)actionButtonTapped:(id)sender {

  [self.activityIndicator startAnimating];
  [self.dependency calculateSomething:^(int value) {
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.activityIndicator stopAnimating];
    });
  }];
}

@end
