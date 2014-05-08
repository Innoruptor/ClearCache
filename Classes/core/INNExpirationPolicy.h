//
//  INNExpirationPolicy.h
//  ClearCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INNCachedObject.h"

@protocol INNExpirationPolicy <NSObject>

-(void) checkExpiration:(INNCachedObject *) cachedObject;

@end
