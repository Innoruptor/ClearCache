//
//  INNCachedObject.h
//  ClearCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface INNCachedObject : NSObject

@property (strong,nonatomic) id value;
@property (strong,nonatomic) NSDate *creationDate;
@property (strong,nonatomic) NSDate *lastAccessedDate;
@property (assign,nonatomic) BOOL expired;
@property (assign,nonatomic) NSInteger accessedCount;

@end
