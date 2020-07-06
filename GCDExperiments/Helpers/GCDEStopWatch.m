//
//  GCDEStopWatch.m
//  GCDExperiments
//
//  Created by Aleksei Kolchanov on 7/2/20.
//  Copyright © 2020 Aleksei Kolchanov. All rights reserved.
//

#import "GCDEStopWatch.h"
#import <QuartzCore/QuartzCore.h>

@implementation GCDEStopWatch {
  CFTimeInterval _startTime;
}

- (void)start {
  _startTime = CACurrentMediaTime();
}
- (NSTimeInterval)currentTime {
  return CACurrentMediaTime() - _startTime;
}

@end
