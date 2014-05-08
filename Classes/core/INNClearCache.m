//
//  INNClearCache.m
//  ClearCache
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import "INNClearCache.h"
#import "INNMethodMatchingRule.h"
#import "INNCachedObject.h"
#import "INNCacheMonitor.h"

@interface INNClearCache ()

@property (nonatomic, retain) id instance;
@property (assign) BOOL isInstance;

@end

@implementation INNClearCache

+ (id)clearCacheWithInstance:(id) instance{
  return [[[self class] alloc] initWithInstance:instance];
}

+ (id)clearCacheWithClass:(id) aClass{
  return [[[self class] alloc] initWithClass:aClass];
}

- (id)initWithInstance:(id) instance{
  _instance = instance;
  methodCacheRulesDict = [[NSMutableDictionary alloc]init];
  self.isInstance = YES;
  
  return self;
}

- (id)initWithClass:(id) aClass{
  _instance = aClass;
  methodCacheRulesDict = [[NSMutableDictionary alloc]init];
  self.isInstance = NO;
  
  return self;
}

- (void) addMethodCache:(SEL)selector cacheType:(id<INNCache>)cacheType parameterIndexes:(NSArray *)parameterIndexes{
  
  INNMethodMatchingRule *rule = [[INNMethodMatchingRule alloc]init];
  
  [rule setParameterIndexes:parameterIndexes];
  rule.selector = selector;
  rule.cacheType = cacheType;
  
  [methodCacheRulesDict setObject:rule forKey:NSStringFromSelector(selector)];
}

- (void)dealloc{
  [methodCacheRulesDict removeAllObjects];
  methodCacheRulesDict = nil;
  self.instance = nil;
}

//
// Apple NSProxy methods
//

- (BOOL)isKindOfClass:(Class)aClass;{
  return [self.instance isKindOfClass:aClass];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol{
  return [self.instance conformsToProtocol:aProtocol];
}

- (BOOL)respondsToSelector:(SEL)aSelector{
  return [self.instance respondsToSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
  if ([self.instance respondsToSelector:aSelector]){
    return [self.instance methodSignatureForSelector:aSelector];
  }
  else{
    return [super methodSignatureForSelector:aSelector];
  }
}

-(NSString *)buildCacheIndex:(NSInvocation *)invocation parameterIndexes:(NSArray *)parameterIndexes{
  NSString *key = [NSString stringWithFormat:@"%@", NSStringFromSelector([invocation selector])];
  
  for(int i=0;i<parameterIndexes.count;i++){
    NSInteger index = [parameterIndexes[i] integerValue];
    
    key = [NSString stringWithFormat:@"%@~%@", key, [[self getArgumentAtIndexAsObject:2+index invocation:invocation] description]];
  }
  
  return key;
}

- (void)forwardInvocation:(NSInvocation *)invocation{
  SEL selector = [invocation selector];
  
  INNMethodMatchingRule *rule = [methodCacheRulesDict objectForKey:NSStringFromSelector(selector)];
  
  if(rule!=nil){
    NSString *cacheIndex = [self buildCacheIndex:invocation parameterIndexes:rule.parameterIndexes];
    
    const char *methodReturnType = [invocation.methodSignature methodReturnType];
    INNCachedObject *cachedReturnObject = [rule.cacheType getCacheValue:cacheIndex];
    
    if((cachedReturnObject!=nil)){
      if(cachedReturnObject.expired){
        [rule.cacheType removeCacheValue:cacheIndex];
        
        cachedReturnObject = nil;
      }
    }
    
    if(cachedReturnObject!=nil){
      LOG_CLEARCACHE(@"%s return cached object, selector (%@), key (%@), value from cache (%@).", __PRETTY_FUNCTION__, NSStringFromSelector([invocation selector]), cacheIndex, cachedReturnObject);
      
      [self setReturnValueForMethod:invocation returnType:[[NSString alloc] initWithUTF8String:methodReturnType] returnValue:cachedReturnObject.value];
    }
    else{
      if ([self.instance respondsToSelector:selector]){
        [invocation setTarget:self.instance];
        [invocation invoke];
        
        id result = [self getReturnValueForMethod:invocation returnType:[[NSString alloc] initWithUTF8String:methodReturnType]];
        
        if(result==nil){
          result = [NSNull null];
        }
        
        //
        // put return value in cache
        //
        INNCachedObject *cachedObject = [[INNCachedObject alloc]init];
        cachedObject.value = result;
        
        [rule.cacheType setCacheValue:cachedObject forKey:cacheIndex];
      }
    }
  }
  else{
    [invocation setTarget:self.instance];
    [invocation invoke];
  }
}

const char *OCMTypeWithoutQualifiers(const char *objCType)
{
  while(strchr("rnNoORV", objCType[0]) != NULL)
    objCType += 1;
  return objCType;
}

- (id) getReturnValueForMethod:(NSInvocation *)invocation returnType:(NSString *)returnType{
  //
  // supported cislqCISLQfd@#
  //
  const char *returnTypeChar = [returnType UTF8String];
  
  switch (returnTypeChar[0])
	{
		case 'c':
    {
      char result;
      [invocation getReturnValue:&result];
      
      return [NSNumber numberWithChar:result];
		}
    case 'i':
    {
      NSInteger result;
      [invocation getReturnValue:&result];
      
      return [NSNumber numberWithInteger:result];
		}
    case 's':
    {
      short result;
      [invocation getReturnValue:&result];
      
      return [NSNumber numberWithShort:result];
		}
    case 'l':
    {
      long result;
      [invocation getReturnValue:&result];
      
      return [NSNumber numberWithLong:result];
		}
    case 'q':
    {
      long long result;
      [invocation getReturnValue:&result];
      
      return [NSNumber numberWithLongLong:result];
		}
    case 'C':
    {
      unsigned char result;
      [invocation getReturnValue:&result];
      
      return [NSNumber numberWithUnsignedChar:result];
		}
    case 'I':
    {
      unsigned int result;
      [invocation getReturnValue:&result];
      
      return [NSNumber numberWithUnsignedInt:result];
		}
    case 'S':
    {
      unsigned short result;
      [invocation getReturnValue:&result];
      
      return [NSNumber numberWithUnsignedShort:result];
		}
    case 'L':
    {
      unsigned long result;
      [invocation getReturnValue:&result];
      
      return [NSNumber numberWithUnsignedLong:result];
		}
    case 'Q':
    {
      unsigned long long result;
      [invocation getReturnValue:&result];
      
      return [NSNumber numberWithUnsignedLongLong:result];
		}
    case 'f':
    {
      float result;
      [invocation getReturnValue:&result];
      
      return [NSNumber numberWithFloat:result];
		}
    case 'd':
    {
      double result;
      [invocation getReturnValue:&result];
      
      return [NSNumber numberWithDouble:result];
		}
		case '@':
		{
      CFTypeRef result = nil;
      
      [invocation getReturnValue:&result];
      
      if (result){
        CFRetain(result);
      }
      
      id value = (__bridge id)(result);
      
			return value;
		}
    case '#':
		{
      CFTypeRef result = nil;
      
      [invocation getReturnValue:&result];
      
      if (result){
        CFRetain(result);
      }
      
      Class value = (__bridge Class)(result);
      
			return value;
		}
  }
  
  return nil;
}

- (void)setReturnValueForMethod:(NSInvocation *)invocation returnType:(NSString *)returnType returnValue:(id)returnValue{
  //
  // supported cislqCISLQfd@#
  //
  const char *returnTypeChar = [returnType UTF8String];
  
  if((returnValue==nil)||([returnValue isKindOfClass:[NSNull class]])){
    return; // just don't set anything and we return a nil (is this safe?)
  }
  
  switch (returnTypeChar[0])
	{
		case 'c':
    {
      char value = [returnValue charValue];
      
      [invocation setReturnValue:&value];
      
      break;
		}
    case 'i':
    {
      NSInteger value = [returnValue intValue];
      
      [invocation setReturnValue:&value];
      
      break;
		}
    case 's':
    {
      short value = [returnValue shortValue];
      
      [invocation setReturnValue:&value];
      
      break;
		}
    case 'l':
    {
      long value = [returnValue longValue];
      
      [invocation setReturnValue:&value];
      
      break;
		}
    case 'q':
    {
      long long value = [returnValue longLongValue];
      
      [invocation setReturnValue:&value];
      
      break;
		}
    case 'C':
    {
      unsigned char value = [returnValue unsignedCharValue];
      
      [invocation setReturnValue:&value];
      
      break;
		}
    case 'I':
    {
      unsigned int value = [returnValue unsignedIntValue];
      
      [invocation setReturnValue:&value];
      
      break;
		}
    case 'S':
    {
      unsigned short value = [returnValue unsignedShortValue];
      
      [invocation setReturnValue:&value];
      
      break;
		}
    case 'L':
    {
      unsigned long value = [returnValue unsignedLongValue];
      
      [invocation setReturnValue:&value];
      
      break;
		}
    case 'Q':
    {
      unsigned long long value = [returnValue unsignedLongLongValue];
      
      [invocation setReturnValue:&value];
      
      break;
		}
    case 'f':
    {
      float value = [returnValue floatValue];
      
      [invocation setReturnValue:&value];
      
      break;
		}
    case 'd':
    {
      double value = [returnValue doubleValue];
      
      [invocation setReturnValue:&value];
      
      break;
		}
    case '@':
    {
      [invocation setReturnValue:&returnValue];
      
      break;
    }
    case '#':
    {
      [invocation setReturnValue:&returnValue];
      
      break;
		}
  }
}

- (id)getArgumentAtIndexAsObject:(int)argIndex invocation:(NSInvocation *)invocation{
  //
  // supported cislqCISLQfd@#
  //
  const char *argType = OCMTypeWithoutQualifiers([invocation.methodSignature getArgumentTypeAtIndex:argIndex]);
  
  switch (argType[0])
	{
		case 'c':
    {
      char value;
      [invocation getArgument:&value atIndex:argIndex];
      
      return [NSNumber numberWithChar:value];
		}
    case 'i':
    {
      NSInteger value;
      [invocation getArgument:&value atIndex:argIndex];
      
      return [NSNumber numberWithInteger:value];
		}
    case 's':
    {
      short value;
      [invocation getArgument:&value atIndex:argIndex];
      
      return [NSNumber numberWithShort:value];
		}
    case 'l':
    {
      long value;
      [invocation getArgument:&value atIndex:argIndex];
      
      return [NSNumber numberWithLong:value];
		}
    case 'q':
    {
      long long value;
      [invocation getArgument:&value atIndex:argIndex];
      
      return [NSNumber numberWithLongLong:value];
		}
    case 'C':
    {
      unsigned char value;
      [invocation getArgument:&value atIndex:argIndex];
      
      return [NSNumber numberWithUnsignedChar:value];
		}
    case 'I':
    {
      unsigned int value;
      [invocation getArgument:&value atIndex:argIndex];
      
      return [NSNumber numberWithUnsignedInt:value];
		}
    case 'S':
    {
      unsigned short value;
      [invocation getArgument:&value atIndex:argIndex];
      
      return [NSNumber numberWithUnsignedShort:value];
		}
    case 'L':
    {
      unsigned long value;
      [invocation getArgument:&value atIndex:argIndex];
      
      return [NSNumber numberWithUnsignedLong:value];
		}
    case 'Q':
    {
      unsigned long long value;
      [invocation getArgument:&value atIndex:argIndex];
      
      return [NSNumber numberWithUnsignedLongLong:value];
		}
    case 'f':
    {
      float value;
      [invocation getArgument:&value atIndex:argIndex];
      
      return [NSNumber numberWithFloat:value];
		}
    case 'd':
    {
      double value;
      [invocation getArgument:&value atIndex:argIndex];
      
      return [NSNumber numberWithDouble:value];
		}
		case '@':
		{
      id value;
			[invocation getArgument:&value atIndex:argIndex];
      
			return value;
		}
    case '#':
		{
      id value;
			[invocation getArgument:&value atIndex:argIndex];
      
			return value;
		}
  }
  
  return nil;
}

@end
