//
//  INNCacheMonitor.m
//  ClearCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import "INNCacheMonitor.h"

static INNCacheMonitor *sharedInstance;

@implementation INNCacheMonitor

+(void) initialize{
  static BOOL initialized = NO;
  if(!initialized){
    initialized = YES;
    
    sharedInstance = [[INNCacheMonitor alloc] init];
  }
}

+(INNCacheMonitor *) sharedInstance{
  return sharedInstance;
}

+(BOOL) active{
  return [INNCacheMonitor sharedInstance].active;
}

+(void) logMessage:(NSString *)message{
  return [[INNCacheMonitor sharedInstance] logMessage:message];
}

-(id) init {
  self = [super init];
  if (self) {
    
  }
  return self;
}

-(void) logMessage:(NSString *)message{
  if(self.active){
    NSLog(@"%@", message);
  }
}

@end
