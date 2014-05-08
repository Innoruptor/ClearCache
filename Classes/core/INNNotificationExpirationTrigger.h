//
//  INNNotificationExpirationTrigger.h
//  ClearCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INNCache.h"

@interface INNNotificationExpirationTrigger : INNExpirationTrigger{
  BOOL notifications;
}

@property (copy,nonatomic) NSString *notificationName;

-(id) initWithNotification:(NSString *)notificationName;

@end
