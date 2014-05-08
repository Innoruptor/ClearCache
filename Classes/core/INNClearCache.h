//
//  INNClearCache.h
//  ClearCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INNCache.h"

@interface INNClearCache : NSProxy{
  NSMutableDictionary *methodCacheRulesDict;
}

+ (id)clearCacheWithInstance:(id) instance;
+ (id)clearCacheWithClass:(id) aClass;

- (id)initWithInstance:(id) instance;
- (id)initWithClass:(id) aClass;

- (void) addMethodCache:(SEL)selector cacheType:(id<INNCache>)cacheType parameterIndexes:(NSArray *)parameterIndexes;

@end