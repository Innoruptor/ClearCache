//
//  ProxyCacheTests.m
//  ProxyCacheTests
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "INNTestService.h"
#import "INNClearCache.h"
#import "INNOlderThanExpirationPolicy.h"
#import "INNLRUMemoryCache.h"

@interface ProxyCacheTests : XCTestCase{
  INNTestService *instance;
  INNClearCache *clearInstance;
}

@end

@implementation ProxyCacheTests

- (void)setUp
{
  [super setUp];
  
  instance = [[INNTestService alloc] init];
  
  clearInstance = [INNClearCache clearCacheWithInstance:instance];
  instance = (INNTestService*)clearInstance;
  
  [clearInstance addMethodCache:@selector(charValue) cacheType:[[INNLRUMemoryCache alloc] initWithSize:4] parameterIndexes:nil];
  [clearInstance addMethodCache:@selector(intValue) cacheType:[[INNLRUMemoryCache alloc] initWithSize:4] parameterIndexes:nil];
  [clearInstance addMethodCache:@selector(shortValue) cacheType:[[INNLRUMemoryCache alloc] initWithSize:4] parameterIndexes:nil];
  [clearInstance addMethodCache:@selector(longValue) cacheType:[[INNLRUMemoryCache alloc] initWithSize:4] parameterIndexes:nil];
  [clearInstance addMethodCache:@selector(longLongValue) cacheType:[[INNLRUMemoryCache alloc] initWithSize:4] parameterIndexes:nil];
  [clearInstance addMethodCache:@selector(unsignedCharValue) cacheType:[[INNLRUMemoryCache alloc] initWithSize:4] parameterIndexes:nil];
  [clearInstance addMethodCache:@selector(unsignedIntValue) cacheType:[[INNLRUMemoryCache alloc] initWithSize:4] parameterIndexes:nil];
  [clearInstance addMethodCache:@selector(unsignedShortValue) cacheType:[[INNLRUMemoryCache alloc] initWithSize:4] parameterIndexes:nil];
  [clearInstance addMethodCache:@selector(unsignedLongValue) cacheType:[[INNLRUMemoryCache alloc] initWithSize:4] parameterIndexes:nil];
  [clearInstance addMethodCache:@selector(unsignedLongLongValue) cacheType:[[INNLRUMemoryCache alloc] initWithSize:4] parameterIndexes:nil];
  [clearInstance addMethodCache:@selector(floatValue) cacheType:[[INNLRUMemoryCache alloc] initWithSize:4] parameterIndexes:nil];
  [clearInstance addMethodCache:@selector(doubleValue) cacheType:[[INNLRUMemoryCache alloc] initWithSize:4] parameterIndexes:nil];
  [clearInstance addMethodCache:@selector(objectValue) cacheType:[[INNLRUMemoryCache alloc] initWithSize:4] parameterIndexes:nil];
}

- (void)tearDown
{
    [super tearDown];
}

-(void) testChar
{
    [instance clearLastMethodCalled];
    NSNumber *charNumber = [NSNumber numberWithChar:'a'];
    char valueChar = [instance charValue];
    XCTAssertTrue(valueChar==[charNumber charValue], @"retrieved char return value from method");
    XCTAssert([[instance getLastMethodCalled] isEqualToString:@"charValue"], @"method charValue was called");
  
    [instance clearLastMethodCalled];
    char valueChar2 = [instance charValue];
    XCTAssertTrue(valueChar2==[charNumber charValue], @"retrieved char return value from method");
    XCTAssertNil([instance getLastMethodCalled], @"method charValue was not called");
}
 
-(void) testInt
{
    [instance clearLastMethodCalled];
    NSNumber *intNumber = [NSNumber numberWithInteger:1];
    int valueInt = [instance intValue];
    XCTAssertTrue(valueInt==[intNumber integerValue], @"retrieved integer return value from method");
    XCTAssert([[instance getLastMethodCalled] isEqualToString:@"intValue"], @"method intValue was called");
  
    [instance clearLastMethodCalled];
    int valueInt2 = [instance intValue];
    XCTAssertTrue(valueInt2==[intNumber integerValue], @"retrieved integer return value from method");
    XCTAssertNil([instance getLastMethodCalled], @"method intValue was not called");
}

-(void) testShort{
    [instance clearLastMethodCalled];
    NSNumber *shortNumber = [NSNumber numberWithShort:2];
    short valueShort = [instance shortValue];
    XCTAssertTrue(valueShort==[shortNumber shortValue], @"retrieved short return value from method");
    XCTAssert([[instance getLastMethodCalled] isEqualToString:@"shortValue"], @"method shortValue was called");
  
    [instance clearLastMethodCalled];
    int valueShort2 = [instance shortValue];
    XCTAssertTrue(valueShort2==[shortNumber shortValue], @"retrieved short return value from method");
    XCTAssertNil([instance getLastMethodCalled], @"method shortValue was not called");
}

-(void) testLong{
    [instance clearLastMethodCalled];
    NSNumber *longNumber = [NSNumber numberWithLong:3];
    short valueLong = [instance longValue];
    XCTAssertTrue(valueLong==[longNumber longValue], @"retrieved long return value from method");
    XCTAssert([[instance getLastMethodCalled] isEqualToString:@"longValue"], @"method longValue was called");
  
    [instance clearLastMethodCalled];
    int valueLong2 = [instance longValue];
    XCTAssertTrue(valueLong2==[longNumber longValue], @"retrieved long return value from method");
    XCTAssertNil([instance getLastMethodCalled], @"method longValue was not called");
}
  
-(void) testLongLong{
    [instance clearLastMethodCalled];
    NSNumber *longLongNumber = [NSNumber numberWithLongLong:4];
    long long valueLongLong = [instance longLongValue];
    XCTAssertTrue(valueLongLong==[longLongNumber longLongValue], @"retrieved long long return value from method");
    XCTAssert([[instance getLastMethodCalled] isEqualToString:@"longLongValue"], @"method longLongValue was called");
  
    [instance clearLastMethodCalled];
    long long valueLongLong2 = [instance longLongValue];
    XCTAssertTrue(valueLongLong2==[longLongNumber longLongValue], @"retrieved long long return value from method");
    XCTAssertNil([instance getLastMethodCalled], @"method longLongValue was not called");
}

-(void) testUnsignedChar{
    [instance clearLastMethodCalled];
    NSNumber *unsignedCharNumber = [NSNumber numberWithUnsignedChar:'e'];
    unsigned char valueUnsignedChar = [instance unsignedCharValue];
    XCTAssertTrue(valueUnsignedChar==[unsignedCharNumber unsignedCharValue], @"retrieved unsigned char return value from method");
    XCTAssert([[instance getLastMethodCalled] isEqualToString:@"unsignedCharValue"], @"method unsignedCharValue was called");
  
    [instance clearLastMethodCalled];
    unsigned char valueUnsignedChar2 = [instance unsignedCharValue];
    XCTAssertTrue(valueUnsignedChar2==[unsignedCharNumber unsignedCharValue], @"retrieved unsigned char return value from method");
    XCTAssertNil([instance getLastMethodCalled], @"method unsignedCharValue was not called");
}

-(void) testUnsignedInt{
    [instance clearLastMethodCalled];
    NSNumber *unsignedIntNumber = [NSNumber numberWithUnsignedInt:6];
    unsigned int valueUnsignedInt = [instance unsignedIntValue];
    XCTAssertTrue(valueUnsignedInt==[unsignedIntNumber unsignedIntValue], @"retrieved unsigned int return value from method");
    XCTAssert([[instance getLastMethodCalled] isEqualToString:@"unsignedIntValue"], @"method unsignedIntValue was called");
  
    [instance clearLastMethodCalled];
    unsigned int valueUnsignedInt2 = [instance unsignedIntValue];
    XCTAssertTrue(valueUnsignedInt2==[unsignedIntNumber unsignedIntValue], @"retrieved unsigned int return value from method");
    XCTAssertNil([instance getLastMethodCalled], @"method unsignedIntValue was not called");
}

-(void) testUnsignedShort{
    [instance clearLastMethodCalled];
    NSNumber *unsignedShortNumber = [NSNumber numberWithUnsignedShort:7];
    unsigned short valueUnsignedShort = [instance unsignedShortValue];
    XCTAssertTrue(valueUnsignedShort==[unsignedShortNumber unsignedShortValue], @"retrieved unsigned short return value from method");
    XCTAssert([[instance getLastMethodCalled] isEqualToString:@"unsignedShortValue"], @"method unsignedShortValue was called");
  
    [instance clearLastMethodCalled];
    unsigned short valueUnsignedShort2 = [instance unsignedShortValue];
    XCTAssertTrue(valueUnsignedShort2==[unsignedShortNumber unsignedShortValue], @"retrieved unsigned short return value from method");
    XCTAssertNil([instance getLastMethodCalled], @"method unsignedShortValue was not called");
}

-(void) testUnsignedLong{
    [instance clearLastMethodCalled];
    NSNumber *unsignedLongNumber = [NSNumber numberWithUnsignedLong:8];
    unsigned long valueUnsignedLong = [instance unsignedLongValue];
    XCTAssertTrue(valueUnsignedLong==[unsignedLongNumber unsignedLongValue], @"retrieved unsigned long return value from method");
    XCTAssert([[instance getLastMethodCalled] isEqualToString:@"unsignedLongValue"], @"method unsignedLongValue was called");
  
    [instance clearLastMethodCalled];
    unsigned long valueUnsignedLong2 = [instance unsignedLongValue];
    XCTAssertTrue(valueUnsignedLong2==[unsignedLongNumber unsignedLongValue], @"retrieved unsigned long return value from method");
    XCTAssertNil([instance getLastMethodCalled], @"method unsignedLongValue was not called");
}

-(void) testUnsignedLongLong{
    [instance clearLastMethodCalled];
    NSNumber *unsignedLongLongNumber = [NSNumber numberWithUnsignedLongLong:9];
    unsigned long long valueUnsignedLongLong = [instance unsignedLongLongValue];
    XCTAssertTrue(valueUnsignedLongLong==[unsignedLongLongNumber unsignedLongLongValue], @"retrieved unsigned long long return value from method");
    XCTAssert([[instance getLastMethodCalled] isEqualToString:@"unsignedLongLongValue"], @"method unsignedLongLongValue was called");
  
    [instance clearLastMethodCalled];
    unsigned long long valueUnsignedLongLong2 = [instance unsignedLongLongValue];
    XCTAssertTrue(valueUnsignedLongLong2==[unsignedLongLongNumber unsignedLongLongValue], @"retrieved unsigned long long return value from method");
    XCTAssertNil([instance getLastMethodCalled], @"method unsignedLongLongValue was not called");
}

-(void) testFloat{
    [instance clearLastMethodCalled];
    NSNumber *floatNumber = [NSNumber numberWithFloat:10.1];
    float valueFloat = [instance floatValue];
    XCTAssertTrue(valueFloat==[floatNumber floatValue], @"retrieved float return value from method");
    XCTAssert([[instance getLastMethodCalled] isEqualToString:@"floatValue"], @"method floatValue was called");
  
    [instance clearLastMethodCalled];
    float valueFloat2 = [instance floatValue];
    XCTAssertTrue(valueFloat2==[floatNumber floatValue], @"retrieved float return value from method");
    XCTAssertNil([instance getLastMethodCalled], @"method floatNumber was not called");
}

-(void) testDouble{
    [instance clearLastMethodCalled];
    NSNumber *doubleNumber = [NSNumber numberWithDouble:11.11];
    double valueDouble = [instance doubleValue];
    XCTAssertTrue(valueDouble==[doubleNumber doubleValue], @"retrieved float return value from method");
    XCTAssert([[instance getLastMethodCalled] isEqualToString:@"doubleValue"], @"method doubleValue was called");
  
    [instance clearLastMethodCalled];
    double valueDouble2 = [instance doubleValue];
    XCTAssertTrue(valueDouble2==[doubleNumber doubleValue], @"retrieved float return value from method");
    XCTAssertNil([instance getLastMethodCalled], @"method doubleValue was not called");
}

-(void) testObject{
    [instance clearLastMethodCalled];
    INNTestObject *objectValue = [[INNTestObject alloc]init];
    objectValue.value = @"Hello";
    INNTestObject *valueObject = [instance objectValue];
    XCTAssertTrue([objectValue.value isEqualToString:valueObject.value], @"retrieved object return value from method");
    XCTAssert([[instance getLastMethodCalled] isEqualToString:@"objectValue"], @"method objectValue was called");
  
    [instance clearLastMethodCalled];
    INNTestObject *valueObject2 = [instance objectValue];
    XCTAssertTrue([valueObject2.value isEqualToString:valueObject.value], @"retrieved object return value from method");
    XCTAssertNil([instance getLastMethodCalled], @"method objectValue was not called");
}

@end
