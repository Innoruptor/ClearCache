//
//  INNCacheMonitor.h
//  ClearCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#define LOG_CLEARCACHE(fmt,...) if([INNCacheMonitor active]) [[INNCacheMonitor sharedInstance] logMessage:[NSString stringWithFormat:fmt, ##__VA_ARGS__]];

#import <Foundation/Foundation.h>

@interface INNCacheMonitor : NSObject

@property (assign) BOOL active;

+(INNCacheMonitor *) sharedInstance;
+(BOOL) active;
+(void) logMessage:(NSString *)message;

-(void) logMessage:(NSString *)message;

@end
