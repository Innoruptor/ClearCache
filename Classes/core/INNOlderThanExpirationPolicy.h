//
//  INNOlderThanExpirationPolicy.h
//  ClearCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INNExpirationPolicy.h"

@interface INNOlderThanExpirationPolicy : NSObject<INNExpirationPolicy>{
  NSTimeInterval timeout;
}

@property (assign,readonly) NSTimeInterval timeout;

- (id)initWithTimeout:(NSTimeInterval)initTimeout;

@end
