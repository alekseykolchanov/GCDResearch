//
//  GCDEFibonacci.c
//  GCDExperiments
//
//  Created by Aleksei Kolchanov on 7/2/20.
//  Copyright © 2020 Aleksei Kolchanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDEStopWatch.h"

int fib(int n) {
  int i, t1 = 0, t2 = 1, nextTerm;
//  int intermedTerm = 0;

  for (i = 1; i <= n; ++i) {

//    MAKE IT SLOWER
//    for (int j=1; j<=n; ++j) {
//      for (int k=1; k<=n; ++k) {
//        for (int l=1; l<=n; ++l) {
//          intermedTerm = t1 * t2 - intermedTerm;
//        }
//      }
//    }


//    MAKE OPERATION TO WAIT
//    GCDEStopWatch *stopWatch = [GCDEStopWatch new];
//    [stopWatch start];
//    __block int counter = 0;
//    dispatch_sync(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
//      while ([stopWatch currentTime] < 1) {
//        counter++;
//      }
//    });


    nextTerm = t1 + t2;
    t1 = t2;
    t2 = nextTerm;
  }
  return t2;
}
