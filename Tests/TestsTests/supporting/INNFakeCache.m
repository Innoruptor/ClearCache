//
//  INNFakeCache.m
//  ProxyCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import "INNFakeCache.h"

@implementation INNFakeCache

-(void) setCacheValue:(id)value forKey:(NSString *)key{
  NSLog(@"INNFakeCache-->setCacheValue() key: %@", key);
  
  lastKeyForSet = key;
}

-(BOOL) shouldInsertObject:(id)object{
  return YES;
}

-(id) getCacheValue:(NSString *)key{
  return nil;
}

-(void) removeCacheValue:(NSString *)key{
  
}

-(void) clearCache{
  
}

-(NSString *) lastKeyForSet{
  return lastKeyForSet;
}

-(void) clearLastKeyForSet{
  lastKeyForSet = nil;
}


@end
