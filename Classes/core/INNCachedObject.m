//
//  INNCachedObject.m
//  ClearCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import "INNCachedObject.h"
#import "INNCacheMonitor.h"

@implementation INNCachedObject

- (id)initWithValue:(id)value{
  self = [super init];
  if (self) {
    self.creationDate = [NSDate new];
    self.value = value;
  }
  return self;
}

- (NSString *) description{
  return [NSString stringWithFormat:@"{%@,%@,%@,%li}",self.value, self.creationDate, self.lastAccessedDate, (long)self.accessedCount];
}

-(void) setValue:(id)value{
  self.creationDate = [NSDate new];
  _value = value;
}

-(void) setAccessedCount:(NSInteger)accessedCount{
  _accessedCount = accessedCount;
  
  if([INNCacheMonitor active]) [[INNCacheMonitor sharedInstance] logMessage:@"aaa"];
}

@end
