//
//  SIApp.h
//  AppInfo
//
//  Created by 杨晴贺 on 08/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SIApp : NSObject

@property (nonatomic,readonly) NSString *bundleIdentifier ;
@property (nonatomic,readonly) NSString *name ;
@property (nonatomic,readonly) UIImage *icon ;

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

@property (nonatomic,readonly) BOOL isHiddenApp ;

+ (instancetype)appWithPrivateProxy:(id)privateProxy;
+ (instancetype)appWithBundleIdentifier:(NSString*)bundleIdentifier;

@end
