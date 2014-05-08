//
//  INNNotificationExpirationTrigger.m
//  ClearCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import "INNNotificationExpirationTrigger.h"
#import "INNCacheMonitor.h"

@implementation INNNotificationExpirationTrigger

-(id) initWithNotification:(NSString *)notificationName{
  self = [super init];
  if (self) {
    self.notificationName = notificationName;
  }
  return self;
}

-(void) setCache:(INNCache *)cache{
  [super setCache:cache];
  
  if((cache!=nil)&&(self.notificationName!=nil)){
    if(!notifications){
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearCache:) name:self.notificationName object:nil];
    }
  }
  else{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
  }
}

-(void)clearCache:(NSNotification*)note{
  LOG_CLEARCACHE(@"%s clearCache (%@).", __PRETTY_FUNCTION__, self.cache);
  
  if(self.cache!=nil){
    id<INNCache> callbackCache = (id<INNCache>)self.cache;
    
    [callbackCache clearCache];
  }
}

-(void) dealloc{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(NSString *) description{
  return [NSString stringWithFormat:@"{notificationName: %@, cache: %@}", self.notificationName, self.cache];
}

@end
