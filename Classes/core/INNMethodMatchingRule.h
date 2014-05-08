//
//  INNMethodMatchingRule.h
//  ClearCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INNCache.h"

@interface INNMethodMatchingRule : NSObject{
  NSArray *parameterIndexes;
}

@property (assign) SEL selector;
@property (strong) id<INNCache> cacheType;

-(void) setParameterIndexes:(NSArray *)indexes;
-(NSArray *)parameterIndexes;
-(NSInteger) parameterCount;
-(NSInteger) parameterIndexAtIndex:(NSInteger)index;

@end
