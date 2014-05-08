//
//  INNTestService.m
//  ProxyCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import "INNTestService.h"

@implementation INNTestService

- (id)init{
  self = [super init];
  if (self) {
    counter = 0;
    lastMethodCalled = nil;
  }
  return self;
}

-(char) charValue{
  lastMethodCalled = NSStringFromSelector(_cmd);
  
  return 'a';
}

-(int) intValue{
  lastMethodCalled = NSStringFromSelector(_cmd);
  
  return 1;
}

-(short) shortValue{
  lastMethodCalled = NSStringFromSelector(_cmd);
  
  return 2;
}

-(long) longValue{
  lastMethodCalled = NSStringFromSelector(_cmd);
  
  return 3;
}

-(long long) longLongValue{
  lastMethodCalled = NSStringFromSelector(_cmd);
  
  return 4;
}

-(unsigned char) unsignedCharValue{
  lastMethodCalled = NSStringFromSelector(_cmd);
  
  return 'e';
}

-(unsigned int) unsignedIntValue{
  lastMethodCalled = NSStringFromSelector(_cmd);
  
  return 6;
}

-(unsigned short) unsignedShortValue{
  lastMethodCalled = NSStringFromSelector(_cmd);
  
  return 7;
}

-(unsigned long) unsignedLongValue{
  lastMethodCalled = NSStringFromSelector(_cmd);
  
  return 8;
}

-(unsigned long long) unsignedLongLongValue{
  lastMethodCalled = NSStringFromSelector(_cmd);
  
  return 9;
}

-(float) floatValue{
  lastMethodCalled = NSStringFromSelector(_cmd);
  
  return 10.1;
}

-(double) doubleValue{
  lastMethodCalled = NSStringFromSelector(_cmd);
  
  return 11.11;
}

-(void) voidValue{
  lastMethodCalled = NSStringFromSelector(_cmd);
}

-(INNTestObject *) objectValue{
  lastMethodCalled = NSStringFromSelector(_cmd);
  
  INNTestObject *obj = [[INNTestObject alloc]init];
  obj.value = @"Hello";
  
  return obj;
}

-(Class) classValue{
  lastMethodCalled = NSStringFromSelector(_cmd);
  
  return [NSObject class];
}

-(SEL) selectorValue{
  lastMethodCalled = NSStringFromSelector(_cmd);
  
  return @selector(selectorValue);
}

-(NSString *) stringWithParameter1:(NSString *)parameter1{
  if([parameter1 isEqualToString:@"param1Val1"]){
    return @"param1Val1-value1";
  }
  else if([parameter1 isEqualToString:@"param1Val2"]){
    return @"param1Val2-value2";
  }
  
  return nil;
}

-(NSString *) stringWithParameter1:(NSString *)parameter1 parameter2:(NSString *)parameter2{
  if(([parameter1 isEqualToString:@"param1Val1"])&&([parameter2 isEqualToString:@"param2Val1"])){
    return @"param1Val1-param2Val1-value1";
  }
  else if(([parameter1 isEqualToString:@"param1Val2"])&&([parameter2 isEqualToString:@"param2Val2"])){
    return @"param1Val2-param2Val2-value2";
  }
  
  return nil;
}

-(int) incrementCounter{
  return ++counter;
}

-(void) clearLastMethodCalled{
  lastMethodCalled = nil;
}

-(NSString *) getLastMethodCalled{
  return lastMethodCalled;
}

// ----------

-(NSString *) getStringWithChar:(char)param{
  return @"";
}

-(NSString *) getStringWithInt:(int)param{
  return @"";
}

-(NSString *) getStringWithShort:(short)param{
  return @"";
}

-(NSString *) getStringWithLong:(long)param{
  return @"";
}

-(NSString *) getStringWithLongLong:(long long)param{
  return @"";
}

-(NSString *) getStringWithUnsignedChar:(unsigned char)param{
  return @"";
}

-(NSString *) getStringWithUnsignedInt:(unsigned int)param{
  return @"";
}

-(NSString *) getStringWithUnsignedShort:(unsigned short)param{
  return @"";
}

-(NSString *) getStringWithUnsignedLong:(unsigned long)param{
  return @"";
}

-(NSString *) getStringWithUnsignedLongLong:(unsigned long long)param{
  return @"";
}

-(NSString *) getStringWithFloat:(float)param{
  return @"";
}

-(NSString *) getStringWithDouble:(double)param{
  return @"";
}

-(NSString *) getStringWithObject:(id)param{
  return @"";
}



@end
