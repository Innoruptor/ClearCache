//
//  INNFakeCache.h
//  ProxyCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INNCache.h"

@interface INNFakeCache : NSObject<INNCache>{
  NSString *lastKeyForSet;
}

@property (assign,nonatomic) NSString *name;
@property (strong,nonatomic) id<INNInsertionPolicy> insertionPolicy;
@property (strong,nonatomic) id<INNExpirationPolicy> expirationPolicy;
@property (strong,nonatomic) INNExpirationTrigger *expirationTrigger;

-(void) setCacheValue:(id)value forKey:(NSString *)key;
-(BOOL) shouldInsertObject:(id)object;
-(id) getCacheValue:(NSString *)key;
-(void) removeCacheValue:(NSString *)key;
-(void) clearCache;

-(NSString *) lastKeyForSet;
-(void) clearLastKeyForSet;

@end
