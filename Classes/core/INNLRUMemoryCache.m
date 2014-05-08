//
//  INNLRUCache.m
//  ClearCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import "INNLRUMemoryCache.h"
#import "INNCacheMonitor.h"
#import "INNCachedObject.h"

@implementation INNLRUMemoryCache

- (id)initWithSize:(NSInteger)aSize{
  self = [super init];
  if (self) {
    size = aSize;
    cacheArray = [[NSMutableArray alloc]init];
    cacheDictionary = [[NSMutableDictionary alloc]init];
    lock = [[NSObject alloc]init];
  }
  return self;
}

-(void) setCacheValue:(INNCachedObject *)value forKey:(NSString *)key{
  LOG_CLEARCACHE(@"%s key (%@), value (%@).", __PRETTY_FUNCTION__, key, value);
  
  if(![self shouldInsertObject:value]){
    LOG_CLEARCACHE(@"%s failed insertionPolicy--> key (%@), value (%@).", __PRETTY_FUNCTION__, key, value);
    
    return; // failed insertionPolicy
  }
  
  @synchronized(lock){
    if([cacheArray indexOfObject:key]>-1){
      // move cache key to the top of the array
      [cacheDictionary setObject:value forKey:key];
    }
    else{
      [cacheArray addObject:key];
      [cacheDictionary setObject:value forKey:key];
      
      if([cacheArray count]>size){
        // need to remove the least recently used from cache
        [cacheDictionary removeObjectForKey:cacheArray[0]];
        [cacheArray removeObjectAtIndex:0];
      }
    }
  }
}

-(BOOL) shouldInsertObject:(id)object{
  if(self.insertionPolicy==nil){
    return YES;
  }
  
  return [self.insertionPolicy shouldInsertObject:object];
}

-(INNCachedObject *) getCacheValue:(NSString *)key{
  LOG_CLEARCACHE(@"%s key (%@).", __PRETTY_FUNCTION__, key);
  
  INNCachedObject *value = nil;
  
  @synchronized(lock){
    NSInteger keyIndex = [cacheArray indexOfObject:key];
    
    if(keyIndex != NSNotFound){
      value = [cacheDictionary objectForKey:key];
      
      if(value!=nil){
        LOG_CLEARCACHE(@"%s CacheObject found for key (%@).", __PRETTY_FUNCTION__, key);
        
        //
        // check if expired
        //
        if(self.expirationPolicy!=nil){
          [self.expirationPolicy checkExpiration:value];
        }
      
        if(value.expired){
          LOG_CLEARCACHE(@"%s CacheObject is expired, remove key (%@).", __PRETTY_FUNCTION__, key);
          
          [self removeCacheValue:key];
          
          value = nil;
        }
        else{

          //
          // balance LRU Cache
          //
          if(([cacheArray count]>1)&&(keyIndex!=[cacheArray count]-1)){
            //
            // move key to the end of the cache
            //
            [cacheArray removeObjectAtIndex:keyIndex];
            [cacheArray addObject:key];
          }
        }
      }
      else{
        LOG_CLEARCACHE(@"%s No cacheObject found for key (%@).", __PRETTY_FUNCTION__, key);
      }
    }
  }

  return value;
}

-(void) removeCacheValue:(NSString *)key{
  LOG_CLEARCACHE(@"%s key (%@).", __PRETTY_FUNCTION__, key);
  
  @synchronized(lock){
    NSInteger keyIndex = [cacheArray indexOfObject:key];
    
    if(keyIndex != NSNotFound){
      [cacheDictionary removeObjectForKey:key];
      [cacheArray removeObject:key];
    }
  }
}

-(void) dealloc{
  cacheArray = nil;
  cacheDictionary = nil;
}

-(void) clearCache{
  LOG_CLEARCACHE(@"%s", __PRETTY_FUNCTION__);
  
  @synchronized(lock){
    for(NSString *key in cacheArray){
      [cacheDictionary removeObjectForKey:key];
    }
    
    [cacheArray removeAllObjects];
  }
}

-(void) setExpirationTrigger:(INNExpirationTrigger *)expirationTrigger{
  _expirationTrigger = expirationTrigger;
  _expirationTrigger.cache = (INNCache *)self;
}

-(NSString *) description{
  return [NSString stringWithFormat:@"<%@: %p '%@'>", [self class], self, self.name==nil ? @"" : self.name];
}

// methods for unit testing

-(NSArray *) cacheKeys{
  @synchronized(lock){
    return cacheArray.copy;
  }
}

-(NSArray *) cacheValues{
  @synchronized(lock){
    return cacheDictionary.allValues.copy;
  }
}

@end