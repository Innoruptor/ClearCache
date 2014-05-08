//
//  INNInsertionPolicy.h
//  ClearCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol INNInsertionPolicy <NSObject>

-(BOOL) shouldInsertObject:(id)object;

@end
