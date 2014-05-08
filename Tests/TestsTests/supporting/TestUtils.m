//
//  TestUtils.m
//  ProxyCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import "TestUtils.h"

@implementation TestUtils

+(BOOL) arraysAreEqual:(NSArray *)array1 array2:(NSArray *)array2{
  BOOL arraysContainTheSameObjects = YES;
  
  if([array1 count]!=[array2 count]){
    arraysContainTheSameObjects = NO;
  }
  else{
    NSEnumerator *otherEnum = [array1 objectEnumerator];
    for (NSString *myObject in array2) {
      if(![myObject isEqualToString:[otherEnum nextObject]]){
        //We have found a pair of two different objects.
        arraysContainTheSameObjects = NO;
        
        break;
      }
    }
  }
  
  return arraysContainTheSameObjects;
}

@end
