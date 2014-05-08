//
//  LRUCacheTests.m
//  ProxyCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "INNCachedObject.h"
#import "INNLRUMemoryCache.h"
#import "TestUtils.h"

@interface SelectorMethods : NSObject
-(NSArray *) cacheKeys;
-(NSArray *) cacheValues;
@end

@interface LRUCacheTests : XCTestCase

@end

@implementation LRUCacheTests

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
  
  INNLRUMemoryCache *cache = [[INNLRUMemoryCache alloc] initWithSize:4];
  
  cachedObj = [[INNCachedObject alloc]init];
  cachedObj.value = @"One";
  
  [cache setCacheValue:cachedObj forKey:@"1"];
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  matchArray = @[@"1"];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:matchArray], @"Expected {1}");
  
  //
  
  cachedObj = [[INNCachedObject alloc]init];
  cachedObj.value = @"Two";
  
  [cache setCacheValue:cachedObj forKey:@"2"];
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  matchArray = @[@"1",@"2"];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:matchArray], @"Expected {1,2}");
  
  //
  
  cachedObj = [[INNCachedObject alloc]init];
  cachedObj.value = @"Three";
  
  [cache setCacheValue:cachedObj forKey:@"3"];
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  matchArray = @[@"1",@"2",@"3"];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:matchArray], @"Expected {1,2,3}");
  
  //
  
  cachedObj = [[INNCachedObject alloc]init];
  cachedObj.value = @"Four";
  
  [cache setCacheValue:cachedObj forKey:@"4"];
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  matchArray = @[@"1",@"2",@"3",@"4"];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:matchArray], @"Expected {1,2,3,4}");
  
  //
  
  cachedObj = [cache getCacheValue:@"1"];
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  matchArray = @[@"2",@"3",@"4",@"1"];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:matchArray], @"Expected {2,3,4,1}");
  
  //
  
  cachedObj = [cache getCacheValue:@"3"];
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  matchArray = @[@"2",@"4",@"1",@"3"];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:matchArray], @"Expected {2,4,1,3}");
  
  //
  
  cachedObj = [cache getCacheValue:@"1"];
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  matchArray = @[@"2",@"4",@"3",@"1"];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:matchArray], @"Expected {2,4,3,1}");
  
  //
  
  cachedObj = [[INNCachedObject alloc]init];
  cachedObj.value = @"Five";
  
  [cache setCacheValue:cachedObj forKey:@"5"];
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  matchArray = @[@"4",@"3",@"1",@"5"];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:matchArray], @"Expected {4,3,1,5}");
}

@end
