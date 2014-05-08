//
//  TimeService.m
//  Example1
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import "TimeService.h"
#import "INNClearCache.h"
#import "INNLRUMemoryCache.h"
#import "INNOlderThanExpirationPolicy.h"
#import "INNNotificationExpirationTrigger.h"

static TimeService *sharedSingleton;

@implementation TimeService

+ (void)initialize{
  static BOOL initialized = NO;
  if(!initialized){
    initialized = YES;
    
    sharedSingleton = [[TimeService alloc] init];
    
#ifndef ClearCacheOff
    INNClearCache *clearCache = [INNClearCache clearCacheWithInstance:sharedSingleton];
    
    //
    // configure cache
    //
    INNLRUMemoryCache *cache = [[INNLRUMemoryCache alloc] initWithSize:5];
    
    cache.name = @"TimeCache";
    cache.expirationPolicy = [[INNOlderThanExpirationPolicy alloc] initWithTimeout:5.0];
    cache.expirationTrigger = [[INNNotificationExpirationTrigger alloc]initWithNotification:UIApplicationWillResignActiveNotification];
    
    //
    // add rules for
    //
    [clearCache addMethodCache:@selector(getCurrentTime) cacheType:cache parameterIndexes:nil];
    
    //
    // point singleton variable at proxy
    //
    sharedSingleton = (id)clearCache;
#endif
  }
}

+ (TimeService *)sharedSingleton{
  return sharedSingleton;
}

- (id)init {
  self = [super init];
  if (self) {
    
  }
  return self;
}

-(NSString *) getCurrentTime{
  NSLog(@"%s retrieve time from service call",__PRETTY_FUNCTION__);
  
  NSDate *now = [NSDate date];
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateStyle:NSDateFormatterShortStyle];
  [formatter setTimeStyle:NSDateFormatterLongStyle];
  [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Australia/Sydney"]];

  return [formatter stringFromDate:now];
}

@end
