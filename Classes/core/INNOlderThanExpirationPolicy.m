//
//  INNOlderThanExpirationPolicy.m
//  ClearCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import "INNOlderThanExpirationPolicy.h"
#import "INNCachedObject.h"
#import "INNCacheMonitor.h"

@implementation INNOlderThanExpirationPolicy

- (id)initWithTimeout:(NSTimeInterval)initTimeout{
  self = [super init];
  if (self) {
    timeout = initTimeout;
  }
  return self;
}

-(NSTimeInterval) timeout{
  return timeout;
}

-(void) checkExpiration:(INNCachedObject *) cachedObject{
  NSTimeInterval timeInterval = [[NSDate new] timeIntervalSinceDate:cachedObject.creationDate];
  
  if(timeInterval>timeout){
    cachedObject.expired = YES;
    
    LOG_CLEARCACHE(@"%s mark cachedObject as expired.", __PRETTY_FUNCTION__);
  }
}

@end
