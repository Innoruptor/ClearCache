//
//  ParameterKeyTests.m
//  ProxyCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "INNTestService.h"
#import "INNFakeCache.h"
#import "INNClearCache.h"

@interface ParameterKeyTests : XCTestCase{
  INNTestService *instance;
  INNClearCache *clearInstance;
  INNFakeCache *fakeCache;
}

@end

@implementation ParameterKeyTests

- (void)setUp
{
  [super setUp];
  
  instance = [[INNTestService alloc] init];
  
  clearInstance = [INNClearCache clearCacheWithInstance:instance];
  instance = (INNTestService*)clearInstance;
  
  fakeCache = [[INNFakeCache alloc]init];
  
  [clearInstance addMethodCache:@selector(getStringWithChar:) cacheType:fakeCache parameterIndexes:@[@0]];
  [clearInstance addMethodCache:@selector(getStringWithInt:) cacheType:fakeCache parameterIndexes:@[@0]];
  [clearInstance addMethodCache:@selector(getStringWithShort:) cacheType:fakeCache parameterIndexes:@[@0]];
  [clearInstance addMethodCache:@selector(getStringWithLong:) cacheType:fakeCache parameterIndexes:@[@0]];
  [clearInstance addMethodCache:@selector(getStringWithLongLong:) cacheType:fakeCache parameterIndexes:@[@0]];
  [clearInstance addMethodCache:@selector(getStringWithUnsignedChar:) cacheType:fakeCache parameterIndexes:@[@0]];
  [clearInstance addMethodCache:@selector(getStringWithUnsignedInt:) cacheType:fakeCache parameterIndexes:@[@0]];
  [clearInstance addMethodCache:@selector(getStringWithUnsignedShort:) cacheType:fakeCache parameterIndexes:@[@0]];
  [clearInstance addMethodCache:@selector(getStringWithUnsignedLong:) cacheType:fakeCache parameterIndexes:@[@0]];
  [clearInstance addMethodCache:@selector(getStringWithUnsignedLongLong:) cacheType:fakeCache parameterIndexes:@[@0]];
  [clearInstance addMethodCache:@selector(getStringWithFloat:) cacheType:fakeCache parameterIndexes:@[@0]];
  [clearInstance addMethodCache:@selector(getStringWithDouble:) cacheType:fakeCache parameterIndexes:@[@0]];
  [clearInstance addMethodCache:@selector(getStringWithObject:) cacheType:fakeCache parameterIndexes:@[@0]];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMethodWithCharParameter
{
  [fakeCache clearLastKeyForSet];
  [instance getStringWithChar:'z'];
  
  XCTAssert([[fakeCache lastKeyForSet] isEqualToString:@"getStringWithChar:~122"], @"Key format and content is correct for type char.");
}

- (void)testMethodWithIntParameter
{
  [fakeCache clearLastKeyForSet];
  [instance getStringWithInt:567];
  
  XCTAssert([[fakeCache lastKeyForSet] isEqualToString:@"getStringWithInt:~567"], @"Key format and content is correct for type int.");
}

- (void)testMethodWithShortParameter
{
  [fakeCache clearLastKeyForSet];
  [instance getStringWithShort:343];
  
  XCTAssert([[fakeCache lastKeyForSet] isEqualToString:@"getStringWithShort:~343"], @"Key format and content is correct for type short.");
}

- (void)testMethodWithLongParameter
{
  [fakeCache clearLastKeyForSet];
  [instance getStringWithLong:334343];
  
  XCTAssert([[fakeCache lastKeyForSet] isEqualToString:@"getStringWithLong:~334343"], @"Key format and content is correct for type long.");
}

- (void)testMethodWithLongLongParameter
{
  [fakeCache clearLastKeyForSet];
  [instance getStringWithLongLong:3243423];
  
  XCTAssert([[fakeCache lastKeyForSet] isEqualToString:@"getStringWithLongLong:~3243423"], @"Key format and content is correct for type long long.");
}

- (void)testMethodWithUnsignedCharParameter
{
  [fakeCache clearLastKeyForSet];
  [instance getStringWithUnsignedChar:'q'];
  
  XCTAssert([[fakeCache lastKeyForSet] isEqualToString:@"getStringWithUnsignedChar:~113"], @"Key format and content is correct for type unsigned char.");
}

- (void)testMethodWithUnsignedIntParameter
{
  [fakeCache clearLastKeyForSet];
  [instance getStringWithUnsignedInt:23424];
  
  XCTAssert([[fakeCache lastKeyForSet] isEqualToString:@"getStringWithUnsignedInt:~23424"], @"Key format and content is correct for type unsigned int.");
}

- (void)testMethodWithUnsignedShortParameter
{
  [fakeCache clearLastKeyForSet];
  [instance getStringWithUnsignedShort:23454];
  
  XCTAssert([[fakeCache lastKeyForSet] isEqualToString:@"getStringWithUnsignedShort:~23454"], @"Key format and content is correct for type unsigned short.");
}

- (void)testMethodWithUnsignedLongParameter
{
  [fakeCache clearLastKeyForSet];
  [instance getStringWithUnsignedLong:123123];
  
  XCTAssert([[fakeCache lastKeyForSet] isEqualToString:@"getStringWithUnsignedLong:~123123"], @"Key format and content is correct for type unsigned long.");
}

- (void)testMethodWithUnsignedLongLongParameter
{
  [fakeCache clearLastKeyForSet];
  [instance getStringWithUnsignedLongLong:7645634];
  
  XCTAssert([[fakeCache lastKeyForSet] isEqualToString:@"getStringWithUnsignedLongLong:~7645634"], @"Key format and content is correct for type unsigned long long.");
}

- (void)testMethodWithFloatParameter
{
  [fakeCache clearLastKeyForSet];
  [instance getStringWithFloat:234.32423];
  
  XCTAssert([[fakeCache lastKeyForSet] isEqualToString:@"getStringWithFloat:~234.3242"], @"Key format and content is correct for type float.");
}

- (void)testMethodWithDoubleParameter
{
  [fakeCache clearLastKeyForSet];
  [instance getStringWithDouble:2342.423423];
  
  XCTAssert([[fakeCache lastKeyForSet] isEqualToString:@"getStringWithDouble:~2342.423423"], @"Key format and content is correct for type double.");
}

- (void)testMethodWithObjectParameter
{
  [fakeCache clearLastKeyForSet];
  [instance getStringWithObject:@"MyData"];
  
  XCTAssert([[fakeCache lastKeyForSet] isEqualToString:@"getStringWithObject:~MyData"], @"Key format and content is correct for type object (string)");
}

@end
