//
//  LFUCacheTests.m
//  ProxyCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "INNLFUMemoryCache.h"
#import "INNCachedObject.h"
#import "TestUtils.h"

@interface SelectorMethods : NSObject
-(NSArray *) cacheKeys;
-(NSArray *) cacheValues;
@end

@interface LFUCacheTests : XCTestCase

@end

@implementation LFUCacheTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testAddingKeys
{
  INNCachedObject *cachedObj;
  NSArray *keyArray;
  NSArray *matchArray;
  
  INNLFUMemoryCache *cache = [[INNLFUMemoryCache alloc] initWithSize:4];
  
  cachedObj = [[INNCachedObject alloc]init];
  cachedObj.value = @"One";
  
  [cache setCacheValue:cachedObj forKey:@"1"];
  
  NSLog(@"cacheValues: %@", [cache performSelector:@selector(cacheValues)]);
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  matchArray = @[@"1"];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:matchArray], @"Expected {1}");
  
  
  [cache getCacheValue:@"1"];
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  matchArray = @[@"1"];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:matchArray], @"Expected {1}");
  
  NSLog(@"cacheValues: %@", [cache performSelector:@selector(cacheValues)]);
  
  [cache getCacheValue:@"1"];
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  matchArray = @[@"1"];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:matchArray], @"Expected {1}");
  
  NSLog(@"cacheValues: %@", [cache performSelector:@selector(cacheValues)]);
  
  cachedObj = [[INNCachedObject alloc]init];
  cachedObj.value = @"Two";
  
  [cache setCacheValue:cachedObj forKey:@"2"];
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  matchArray = @[@"2",@"1"];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:matchArray], @"Expected {2,1}");
  
  [cache getCacheValue:@"2"];
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  matchArray = @[@"2",@"1"];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:matchArray], @"Expected {2,1}");
  
  [cache getCacheValue:@"2"];
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  matchArray = @[@"2",@"1"];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:matchArray], @"Expected {2,1}");
  
  [cache getCacheValue:@"2"];
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  matchArray = @[@"1",@"2"];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:matchArray], @"Expected {1,2}");
  
  [cache getCacheValue:@"2"];
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  matchArray = @[@"1",@"2"];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:matchArray], @"Expected {1,2}");
  
  cachedObj = [[INNCachedObject alloc]init];
  cachedObj.value = @"Three";
  
  [cache setCacheValue:cachedObj forKey:@"3"];
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  matchArray = @[@"3",@"1",@"2"];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:matchArray], @"Expected {3,1,2}");

  [cache getCacheValue:@"1"];
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  matchArray = @[@"3",@"1",@"2"];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:matchArray], @"Expected {3,1,2}");
  
  [cache getCacheValue:@"1"];
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  matchArray = @[@"3",@"1",@"2"];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:matchArray], @"Expected {3,1,2}");
  
  [cache getCacheValue:@"1"];
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  matchArray = @[@"3",@"2",@"1"];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:matchArray], @"Expected {3,2,1}");
}

@end
