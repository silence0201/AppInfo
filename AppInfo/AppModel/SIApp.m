//
//  SIApp.m
//  AppInfo
//
//  Created by 杨晴贺 on 08/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "SIApp.h"
#import <Invoker/Invoker.h>


#pragma mark -  参考 PrivateHender/LSApplicationProxy
@interface Private_LSApplicationProxy

+ (id)applicationProxyForIdentifier:(id)arg1 ;

@property (nonatomic,readonly) NSString *localizedShortName ;
@property (nonatomic,readonly) NSString *localizedName ;
@property (nonatomic,readonly) NSString *bundleIdentifier ;
@property (nonatomic,readonly) NSArray *appTags ;

@property (nonatomic,readonly) NSString *applicationDSID ;
@property (nonatomic,readonly) NSString *applicationIdentifier ;
@property (nonatomic,readonly) NSString *applicationType ;

@property (nonatomic,readonly) NSArray *groupIdentifiers ;
@property (nonatomic,readonly) NSNumber *itemID ;
@property (nonatomic,readonly) NSString *itemName ;
@property (nonatomic,readonly) NSString *minimumSystemVersion ;
@property (nonatomic,readonly) NSArray *requiredDeviceCapabilities ;
@property (nonatomic,readonly) NSString *roleIdentifier ;
@property (nonatomic,readonly) NSString *sdkVersion ;
@property (nonatomic,readonly) NSString *shortVersionString ;
@property (nonatomic,readonly) NSString *sourceAppIdentifier ;
@property (nonatomic,readonly) NSNumber *staticDiskUsage ;
@property (nonatomic,readonly) NSNumber *dynamicDiskUsage ;
@property (nonatomic,readonly) NSString *teamID ;
@property (nonatomic,readonly) NSString *vendorName ;

@end

@implementation SIApp{
    Private_LSApplicationProxy *_applicationProxy ;
    UIImage *_icon ;
}

#pragma mark --- init Method
- (id)initWithPrivateProxy:(id)privateProxy{
    if (self = [super init]) {
        _applicationProxy = (Private_LSApplicationProxy *)privateProxy ;
    }
    return self ;
}

- (instancetype)initWithBundleIdentifier:(NSString* )bundleIdentifier{
    if(self = [super init]){
        _applicationProxy = [@"LSApplicationProxy" invokeClassMethod:@"applicationProxyForIdentifier:" arguments:@[bundleIdentifier]] ;
    }
    return self ;
}

+ (instancetype)appWithPrivateProxy:(id)privateProxy{
    return [[self alloc]initWithPrivateProxy:privateProxy] ;
}

+ (instancetype)appWithBundleIdentifier:(NSString *)bundleIdentifier{
    return [[self alloc]initWithBundleIdentifier:bundleIdentifier] ;
}

#pragma mark --- Property
- (NSString *)bundleIdentifier{
    return _applicationProxy.bundleIdentifier ;
}

- (NSString *)name{
    return _applicationProxy.localizedName ? _applicationProxy.localizedName : _applicationProxy.localizedShortName ;
}

- (UIImage *)icon{
    if (!_icon) {
        _icon = [UIImage invoke:@"_applicationIconImageForBundleIdentifier:format:scale:" arguments:@[self.bundleIdentifier,@(10),@(2.0)]] ;
    }
    return _icon ;
}

- (NSString *)applicationDSID{
    return _applicationProxy.applicationDSID ;
}

- (NSString *)applicationIdentifier{
    return _applicationProxy.applicationIdentifier ;
}

- (NSString *)applicationType{
    return _applicationProxy.applicationType ;
}

- (NSArray *)groupIdentifiers{
    return _applicationProxy.groupIdentifiers ;
}

- (NSNumber *)itemID{
    return _applicationProxy.itemID ;
}

- (NSString *)itemName{
    return _applicationProxy.itemName ;
}

- (NSString *)minimumSystemVersion{
    return _applicationProxy.minimumSystemVersion ;
}

- (NSArray *)requiredDeviceCapabilities{
    return _applicationProxy.requiredDeviceCapabilities ;
}

-(NSString *)roleIdentifier{
    return _applicationProxy.roleIdentifier ;
}

- (NSString *)sdkVersion{
    return _applicationProxy.sdkVersion ;
}

- (NSString *)shortVersionString{
    return _applicationProxy.shortVersionString ;
}

- (NSString *)sourceAppIdentifier{
    return _applicationProxy.sourceAppIdentifier ;
}

- (NSNumber *)staticDiskUsage{
    return _applicationProxy.staticDiskUsage ;
}

- (NSNumber *)dynamicDiskUsage{
    return _applicationProxy.dynamicDiskUsage ;
}

- (NSString *)teamID{
    return _applicationProxy.teamID ;
}

- (NSString *)vendorName{
    return _applicationProxy.vendorName ;
}

- (BOOL)isHiddenApp{
    return [[_applicationProxy appTags] indexOfObject:@"hidden"] != NSNotFound ;
}

@end
