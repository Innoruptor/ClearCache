//
//  INNLRUCache.h
//  ClearCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INNCache.h"
#import "INNExpirationPolicy.h"
#import "INNExpirationTrigger.h"

@interface INNLRUMemoryCache : NSObject<INNCache>{
  NSInteger size;
  NSMutableArray *cacheArray;
  NSMutableDictionary *cacheDictionary;
  NSObject *lock;
}

@property (assign,nonatomic) NSString *name;
@property (strong,nonatomic) id<INNInsertionPolicy> insertionPolicy;
@property (strong,nonatomic) id<INNExpirationPolicy> expirationPolicy;
@property (strong,nonatomic) INNExpirationTrigger *expirationTrigger;

- (id)initWithSize:(NSInteger)aSize;

@end
