//
//  MultiParameterTests.m
//  ProxyCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "INNTestService.h"
#import "INNClearCache.h"
#import "INNLRUMemoryCache.h"

@interface MultiParameterTests : XCTestCase{
  INNTestService *instance;
  INNClearCache *clearInstance;
}

@end

@implementation MultiParameterTests

- (void)setUp
{
    [super setUp];
  
  instance = [[INNTestService alloc] init];
  
  clearInstance = [INNClearCache clearCacheWithInstance:instance];
  instance = (INNTestService*)clearInstance;
  
  [clearInstance addMethodCache:@selector(stringWithParameter1:) cacheType:[[INNLRUMemoryCache alloc] initWithSize:4] parameterIndexes:@[@0]];
  [clearInstance addMethodCache:@selector(stringWithParameter1:parameter2:) cacheType:[[INNLRUMemoryCache alloc] initWithSize:4] parameterIndexes:@[@0]];
}

- (void)tearDown
{  
    [super tearDown];
}

- (void)testOneParameter
{
  NSString *stringReturnValue;
  
  //
  // one parameter tests
  //
  stringReturnValue = [instance stringWithParameter1:@"param1Val1"];
  XCTAssertTrue([stringReturnValue isEqualToString:@"param1Val1-value1"], @"retrieved param1Val1-value1 object return value from method");
  
  stringReturnValue = [instance stringWithParameter1:@"param1Val1"];
  XCTAssertTrue([stringReturnValue isEqualToString:@"param1Val1-value1"], @"retrieved param1Val1-value1 object return value from method");
  
  stringReturnValue = [instance stringWithParameter1:@"param1Val2"];
  XCTAssertTrue([stringReturnValue isEqualToString:@"param1Val2-value2"], @"retrieved param1Val2-value2 object return value from method");
  
  stringReturnValue = [instance stringWithParameter1:@"param1Val2"];
  XCTAssertTrue([stringReturnValue isEqualToString:@"param1Val2-value2"], @"retrieved param1Val2-value2 object return value from method");
  
  stringReturnValue = [instance stringWithParameter1:@"param1Val1"];
  XCTAssertTrue([stringReturnValue isEqualToString:@"param1Val1-value1"], @"retrieved param1Val1-value1 object return value from method");
}

- (void)testTwoParameters
{
  NSString *stringReturnValue;
  
  //
  // two parameter tests
  //
  stringReturnValue = [instance stringWithParameter1:@"param1Val1" parameter2:@"param2Val1"];
  XCTAssertTrue([stringReturnValue isEqualToString:@"param1Val1-param2Val1-value1"], @"retrieved param1Val1-param2Val1-value1 object return value from method");
  
  stringReturnValue = [instance stringWithParameter1:@"param1Val1" parameter2:@"param2Val1"];
  XCTAssertTrue([stringReturnValue isEqualToString:@"param1Val1-param2Val1-value1"], @"retrieved param1Val1-param2Val1-value1 object return value from method");
  
  stringReturnValue = [instance stringWithParameter1:@"param1Val2" parameter2:@"param2Val2"];
  XCTAssertTrue([stringReturnValue isEqualToString:@"param1Val2-param2Val2-value2"], @"retrieved param1Val2-param2Val2-value2 object return value from method");
  
  stringReturnValue = [instance stringWithParameter1:@"param1Val2" parameter2:@"param2Val2"];
  XCTAssertTrue([stringReturnValue isEqualToString:@"param1Val2-param2Val2-value2"], @"retrieved param1Val2-param2Val2-value2 object return value from method");
  
  stringReturnValue = [instance stringWithParameter1:@"param1Val1" parameter2:@"param2Val1"];
  XCTAssertTrue([stringReturnValue isEqualToString:@"param1Val1-param2Val1-value1"], @"retrieved param1Val1-param2Val1-value1 object return value from method");
  
}

- (void)testNilReturnValue
{
  NSString *stringReturnValue;
  
  //
  // nil test
  //
  stringReturnValue = [instance stringWithParameter1:@"param1Val3"];
  XCTAssertNil(stringReturnValue, @"should return nil");
  
  stringReturnValue = [instance stringWithParameter1:@"param1Val3"];
  XCTAssertNil(stringReturnValue, @"should return nil");
}

@end
