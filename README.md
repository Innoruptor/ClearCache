# ClearCache

Mobile app developers spend a lot of time writing code to access remote data and assets (i.e. images) used within apps.  ClearCache aims to simplify the configuring and managing of caching layers within the app at the method level.


## What is ClearCache?

The ClearCache perspective on caching is to stay out of the way of building the app.  This is accomplished by allowing you to add in caching later without having to rewrite major areas of the code.  ClearCache leverages the NSProxy class which sits between your app code and the logic you use to calculate and retrieve data and assets.

The only requirement for using ClearCache is that your data to be cached sits behind a method call and is one of the supported data types defined below in the section "Data Types Supported."

Project Goals:
- add caching around any static or instance method
- configure the caching algorithm, expiration policy, and storage mechanism
- easily turn off caching for unit or integration testing
- monitor cache activities during debugging

Benefits:
- app code expects the same results from method calls regardless of the existence of a cache
- cache can be turned off and the app behaves the same
- different caching strategies can be configured on a per method basis
- can cache app specific objects and not just raw data (i.e. JSON) from service calls
 
## What's with the name?

When using ClearCache you can still see clear through to the methods on your classes.

## Caching in General

Questions to ask about your data:
- is the data static or dynamic?
- when does the data expire?
- can you predict the need for future resources?
- do you cache the raw data or higher level app objects?

Examples of what to cache:
- values that are time consuming to recreate or calculate
- images loaded from disk or server
- data loaded from disk or server
- large number of small objects that are used frequently
- small number of large objects that are used frequently

Some interesting mobile app caching use cases every developer needs to consider:
- apps rarely shut down completely
- when the app is terminated you can't do any clean up work
- long durations of time between app openings
- internet can be unavailable at any time including in the middle of an app session

### Testing with caches

Sometimes caching gets in the way when building and executing unit tests or integration tests.  Having the ability to turn caching on and off by configuration can be beneficial.  Your code executes exactly the same way with ClearCache on or off.

### Premature Optimizations

One school of thought is to not optimize your code for caching prematurely.  After you have built the first version of your system you will always learn something, and the areas to cache will become more obvious once you identify the hotspots in your app. 

## How to use ClearCache

### Create a ClearCache Instance

First, create a ClearCache reference by calling the clearCacheWithInstance: method with an object instance.  

A NSProxy object is created and is now wrapping your object instance.  The use of the NSProxy class enables ClearCache to intercept all methods before they reach your object instance.

```objective-c


INNClearCache *clearCache = [INNClearCache clearCacheWithInstance:sharedSingleton];

```

### Create a Cache Instance

The next step is to instantiate a cache type.  

A cache implementation must implement the INNCache.h protocol.

ClearCache currently comes with three built in caches:
- INNFIFOMemoryCache - First in First Out
- INNLFUMemoryCache - Least Frequently Used
- INNLRUMemoryCache - Least Recently Used 

** more cache types are coming **


```objective-c


INNLRUMemoryCache *cache = [[INNLRUMemoryCache alloc] initWithSize:5];

cache.name = @"WeatherServiceCache";

```

### Expiration Policy

An optional cache expiration policy can be set on the cache.  The role of the expiration policy is to check if the cached object has expired given the defined rule.  The INNOlderThanExpirationPolicy marks a cached item as expired if the timeout has been reached.

An expiration policy must implement the INNExpirationPolicy.h protocol. 


```objective-c


cache.expirationPolicy = [[INNOlderThanExpirationPolicy alloc] initWithTimeout:5.0];

```

The experiration policy is evaluated when a cached object is retrieved.

### Expiration Trigger

An optional expiration trigger can be set on the cache.  The role of the expiration trigger is to receive a NSNotification indicating that all cached objects in the cache should expire immediately.

The example below is setup so the cached objects will expire when the app is backgrounded.

An expiration trigger must inherit from INNExpirationTrigger.h.

```objective-c


cache.expirationTrigger = [[INNNotificationExpirationTrigger alloc]initWithNotification:UIApplicationWillResignActiveNotification];

```

### Insertion Policy

An optional insertion policy can be set on the cache.  The role of the insertion policy is to filter out objects to be cached before they are actually cached.  Imagine creating an insertion policy to filter out images greater than 30k.  

An insertion policy must implement the INNInsertionPolicy.h protocol.

** ClearCache doesn't provide concrete implementations of insertion policies at this time. **


The last step is to setup each method on the class with a cache.  The key for the cache is the method selector concatenated with the string representation of each parameter passed into the parameterIndexes parameter as an NSInteger array.  The parameters start at index 0.

Examples for what to pass into the parameterIndexes parameter:

|Scenario                           |Example   |
|-----------------------------------|----------|
|no parameters                      | nil      |
|use the first parameter            |@[@0]     |
|use the second and fourth parameters| @[@1,@3] |


```objective-c


[clearCache addMethodCache:@selector(weatherForLocation:) cacheType:cache parameterIndexes:@[@0]];

```

That's it!  You can share the same cache instance with each method but be aware that the rules apply to all cached objects as a whole.  A better approach might be to have a separate cache instance for each method.


## Data Types Supported

The data types supported are listed below:

| Data Type          | Return Type   | Method Parameter |
|--------------------|---------------|------------------|
| char               |      YES      |        YES       |
| int                |      YES      |        YES       |
| short              |      YES      |        YES       |
| long               |      YES      |        YES       |
| long long          |      YES      |        YES       |
| unsigned char      |      YES      |        YES       |
| unsigned int       |      YES      |        YES       |
| unsigned short     |      YES      |        YES       |
| unsigned long      |      YES      |        YES       |
| unsigned long long |      YES      |        YES       |
| float              |      YES      |        YES       |
| double             |      YES      |        YES       |
| object             |      YES      |        YES       |
| Class              |      YES      |        YES       |
| SEL                |      YES      |        YES       |
| void               |      YES      |        NA        |
| (char *)           |      NO      |        NO        |
| an array           |      NO      |        NO        |
| a structure        |      NO      |        NO        |
| a union            |      NO      |        NO        |
| a bit feild of num bits |      NO      |        NO        |
| a pointer type          |      NO      |        NO        |

The return type of a method can be void.  Why would you want to do this?  Maybe your cache is shared with other methods in the same class and this method updates the entire cache.  Don't worry about this scenario if it's not obvious how you might use it.

Method parameter values are used when generating the cache key.  All data types are converted to their string representation and the key is a concatenation of the method selector and selected method parameters.

The use of nil as a return value is valid and nil can be stored in the cache.

## Usage

### Example App

Have a look at the /Example folder.

## Requirements

Designed for iOS 6.0 and above, but I see no reason this shouldn't work with OSX 10.8 and above.

## Current Version

Release 0.1.0

## Installation

CocoaPods coming soon...

For now drop the files in the Classes folder into your project.

## TODO

- support CocoaPods (next on the list)
- more unit tests
- support caching to disk
- support caching to SQLite
- more, more, more


## Author

Michael Raber, michael@innoruptor.com, [@michaelraber]

## License

ClearCache is available under the BSD license. See the LICENSE file for more info.

[@michaelraber]:http://twitter.com/michaelraber
