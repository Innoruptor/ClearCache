//
//  INNMethodMatchingRule.m
//  ClearCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import "INNMethodMatchingRule.h"

@implementation INNMethodMatchingRule

- (id)init{
  self = [super init];
  if (self) {
    parameterIndexes = [[NSArray alloc]init];
  }
  return self;
}

-(void) setParameterIndexes:(NSArray *)indexes{
  parameterIndexes = indexes;
}

-(NSInteger) parameterCount{
  return [parameterIndexes count];
}

-(NSInteger) parameterIndexAtIndex:(NSInteger)index{
  return [parameterIndexes[index] integerValue];
}

-(NSArray *)parameterIndexes{
  return parameterIndexes;
}


@end
