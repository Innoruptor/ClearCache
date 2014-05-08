//
//  INNCache.h
//  ClearCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INNInsertionPolicy.h"
#import "INNExpirationPolicy.h"
#import "INNExpirationTrigger.h"

@protocol INNCache <NSObject>

-(void) setCacheValue:(id)value forKey:(NSString *)key;
-(BOOL) shouldInsertObject:(id)object;
-(id) getCacheValue:(NSString *)key;
-(void) removeCacheValue:(NSString *)key;
-(void) clearCache;

@property (assign,nonatomic) NSString *name;
@property (strong,nonatomic) id<INNInsertionPolicy> insertionPolicy;
@property (strong,nonatomic) id<INNExpirationPolicy> expirationPolicy;
@property (strong,nonatomic) INNExpirationTrigger *expirationTrigger;

@end
