//
//  INNTestService.h
//  ProxyCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INNTestObject.h"

@interface INNTestService : NSObject{
  NSInteger counter;
  NSString *lastMethodCalled;
}

-(char) charValue;
-(int) intValue;
-(short) shortValue;
-(long) longValue;
-(long long) longLongValue;
-(unsigned char) unsignedCharValue;
-(unsigned int) unsignedIntValue;
-(unsigned short) unsignedShortValue;
-(unsigned long) unsignedLongValue;
-(unsigned long long) unsignedLongLongValue;
-(float) floatValue;
-(double) doubleValue;
-(void) voidValue;
-(INNTestObject *) objectValue;
-(Class) classValue;
-(SEL) selectorValue;

-(NSString *) stringWithParameter1:(NSString *)parameter1;
-(NSString *) stringWithParameter1:(NSString *)parameter1 parameter2:(NSString *)parameter2;

-(int) incrementCounter;

-(void) clearLastMethodCalled;
-(NSString *)getLastMethodCalled;

-(NSString *) getStringWithChar:(char)param;
-(NSString *) getStringWithInt:(int)param;
-(NSString *) getStringWithShort:(short)param;
-(NSString *) getStringWithLong:(long)param;
-(NSString *) getStringWithLongLong:(long long)param;

-(NSString *) getStringWithUnsignedChar:(unsigned char)param;
-(NSString *) getStringWithUnsignedInt:(unsigned int)param;
-(NSString *) getStringWithUnsignedShort:(unsigned short)param;
-(NSString *) getStringWithUnsignedLong:(unsigned long)param;
-(NSString *) getStringWithUnsignedLongLong:(unsigned long long)param;

-(NSString *) getStringWithFloat:(float)param;
-(NSString *) getStringWithDouble:(double)param;

-(NSString *) getStringWithObject:(id)param;

@end
