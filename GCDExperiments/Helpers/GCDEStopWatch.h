//
//  GCDEStopWatch.h
//  GCDExperiments
//
//  Created by Aleksei Kolchanov on 7/2/20.
//  Copyright © 2020 Aleksei Kolchanov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCDEStopWatch : NSObject

- (void)start;
- (NSTimeInterval)currentTime;

@end

NS_ASSUME_NONNULL_END
