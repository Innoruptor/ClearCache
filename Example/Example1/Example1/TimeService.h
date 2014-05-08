//
//  TimeService.h
//  Example1
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeService : NSObject

+ (TimeService *)sharedSingleton;
-(NSString *) getCurrentTime;

@end
