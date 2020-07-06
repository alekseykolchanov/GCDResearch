//
//  GCDEFibonacci.c
//  GCDExperiments
//
//  Created by Aleksei Kolchanov on 7/2/20.
//  Copyright © 2020 Aleksei Kolchanov. All rights reserved.
//

#include "GCDEFibonacci.h"

int fib(int n) {
  int i, t1 = 0, t2 = 1, nextTerm;

  for (i = 1; i <= n; ++i) {
      nextTerm = t1 + t2;
      t1 = t2;
      t2 = nextTerm;
  }
  return t2;
}
