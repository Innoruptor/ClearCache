//
//  INNLFUCache.m
//  ClearCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import "INNLFUMemoryCache.h"
#import "INNCacheMonitor.h"

@implementation INNLFUMemoryCache

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
    NSInteger index = [cacheArray indexOfObject:key];
    
    if(index!=NSNotFound){
      //
      // remove the current cache key so we can replace it
      //
      [self removeCacheValue:key];
    }
    
    //
    // if cache size+1 > max size, remove first item in array
    //
    if([cacheArray count]+1 > size){
      [cacheDictionary removeObjectForKey:cacheArray[0]];
      [cacheArray removeObjectAtIndex:0];
    }

    //
    // insert the new cachedObject at the bottom
    //
    value.accessedCount++;
    [cacheArray insertObject:key atIndex:0];
    [cacheDictionary setObject:value forKey:key];
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
          value.accessedCount++;
          
          //
          // balance the array so we are ordered by accessedCount
          //
          [self balanceCacheArray];
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

-(void) balanceCacheArray{
  //
  // rebalance the cache (not the best algorithm but good enough for small sets of data)
  //
  cacheArray = [cacheArray sortedArrayUsingComparator:
                ^NSComparisonResult(id obj1, id obj2) {
                  
                  INNCachedObject *cacheObj1 = [cacheDictionary objectForKey:(INNCachedObject *)obj1];
                  INNCachedObject *cacheObj2 = [cacheDictionary objectForKey:(INNCachedObject *)obj2];
                  
                  if (cacheObj1.accessedCount < cacheObj2.accessedCount) {
                    return NSOrderedAscending;
                  } else if (cacheObj1.accessedCount > cacheObj2.accessedCount) {
                    return NSOrderedDescending;
                  } else {
                    return NSOrderedSame;
                  }
                }].mutableCopy;
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
