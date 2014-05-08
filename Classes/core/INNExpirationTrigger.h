//
//  INNExpirationTrigger.h
//  ClearCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class INNCache;

@interface INNExpirationTrigger : NSObject

@property (weak,nonatomic) INNCache *cache;

@end
