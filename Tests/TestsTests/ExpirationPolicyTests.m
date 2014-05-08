//
//  ExpirationPolicyTests.m
//  ClearCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "INNTestService.h"
#import "INNClearCache.h"
#import "INNLRUMemoryCache.h"
#import "INNOlderThanExpirationPolicy.h"

@interface ExpirationPolicyTests : XCTestCase{
  INNTestService *instance;
  INNClearCache *proxyInstance;
}

@end

@implementation ExpirationPolicyTests

- (void)setUp
{
  [super setUp];
  
   instance = [[INNTestService alloc] init];
  
   proxyInstance = [INNClearCache clearCacheWithInstance:instance];
  instance = (INNTestService*)proxyInstance;
  
  
  INNLRUMemoryCache *lruCache = [[INNLRUMemoryCache alloc] initWithSize:4];
  INNOlderThanExpirationPolicy *expirationPolicy = [[INNOlderThanExpirationPolicy alloc]initWithTimeout:1.1];

  [lruCache setExpirationPolicy:expirationPolicy];
  
  [proxyInstance addMethodCache:@selector(incrementCounter) cacheType:lruCache parameterIndexes:nil];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testWithExpirationPolicy{
  int counter = [instance incrementCounter];
  NSLog(@"Counter: %i", counter);
  
  XCTAssertTrue(counter==1, @"counter should equal 1");
  
  counter = [instance incrementCounter];
  NSLog(@"Counter: %i", counter);
  XCTAssertTrue(counter==1, @"counter should equal 1");
  
  [NSThread sleepForTimeInterval:3.0];
  
  counter = [instance incrementCounter];
  NSLog(@"Counter: %i", counter);
  XCTAssertTrue(counter==2, @"counter should equal 2");
}

@end
