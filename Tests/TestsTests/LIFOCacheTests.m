//
//  LIFOCacheTests.m
//  ProxyCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "INNFIFOMemoryCache.h"
#import "INNCachedObject.h"
#import "TestUtils.h"

@interface SelectorMethods : NSObject
-(NSArray *) cacheKeys;
-(NSArray *) cacheValues;
@end

@interface LIFOCacheTests : XCTestCase

@end

@implementation LIFOCacheTests

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
  
  INNFIFOMemoryCache *cache = [[INNFIFOMemoryCache alloc] initWithSize:4];
  
  cachedObj = [[INNCachedObject alloc]init];
  cachedObj.value = @"One";
  
  [cache setCacheValue:cachedObj forKey:@"1"];
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:@[@"1"]], @"Expected {1}");
  
  cachedObj = [[INNCachedObject alloc]init];
  cachedObj.value = @"Two";
  
  [cache setCacheValue:cachedObj forKey:@"2"];
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  matchArray = @[@"2",@"1"];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:matchArray], @"Expected {2,1}");
  
  cachedObj = [[INNCachedObject alloc]init];
  cachedObj.value = @"Three";
  
  [cache setCacheValue:cachedObj forKey:@"3"];
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  matchArray = @[@"3",@"2",@"1"];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:matchArray], @"Expected {3,2,1}");
  
  cachedObj = [[INNCachedObject alloc]init];
  cachedObj.value = @"Four";
  
  [cache setCacheValue:cachedObj forKey:@"4"];
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  matchArray = @[@"4",@"3",@"2",@"1"];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:matchArray], @"Expected {4,3,2,1}");
  
  cachedObj = [[INNCachedObject alloc]init];
  cachedObj.value = @"Five";
  
  [cache setCacheValue:cachedObj forKey:@"5"];
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  matchArray = @[@"5",@"4",@"3",@"2"];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:matchArray], @"Expected {5,4,3,2}");
  
  cachedObj = [[INNCachedObject alloc]init];
  cachedObj.value = @"Six";
  
  [cache setCacheValue:cachedObj forKey:@"6"];
  
  keyArray = [cache performSelector:@selector(cacheKeys)];
  matchArray = @[@"6",@"5",@"4",@"3"];
  XCTAssertTrue([TestUtils arraysAreEqual:keyArray array2:matchArray], @"Expected {6,5,4,3}");
}

@end
