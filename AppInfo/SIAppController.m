//
//  SIAppController.m
//  AppInfo
//
//  Created by 杨晴贺 on 08/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "SIAppController.h"
#import "SIApp.h"
#import <Invoker/Invoker.h>

#pragma mark -  参考 PrivateHender/LSApplicationWorkspace
@interface Private_LSApplicationWorkspace

- (NSArray* )allInstalledApplications;
- (bool)openApplicationWithBundleID:(id)arg1;
- (NSArray* )privateURLSchemes;
- (NSArray* )publicURLSchemes;

@end

#pragma mark - 
@implementation SIAppController{
    Private_LSApplicationWorkspace *_workspace ;
    NSArray* _installedApplications;
}
#pragma mark --- init Method
- (instancetype)init{
    if (self = [super init]) {
        _workspace = [@"LSApplicationWorkspace" invokeClassMethod:@"new"] ;
    }
    return self ;
}

+ (instancetype)sharedInstance{
    static id sharedInstance ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init] ;
    });
    return sharedInstance ;
}

#pragma mark --- Public Method
- (BOOL)openAppWithBundleIdentifier:(NSString *)bundleIdentifier{
    return (BOOL)[_workspace openApplicationWithBundleID:bundleIdentifier] ;
}

- (NSArray *)privateURLSchemes{
    return [_workspace privateURLSchemes] ;
}

- (NSArray *)publicURLSchemes{
    return [_workspace publicURLSchemes] ;
}

#pragma mark --- Property
- (NSArray *)installedApplications{
    if (!_installedApplications) {
        _installedApplications = [self readApplications] ;
    }
    return _installedApplications ;
}

#pragma mark --- Private Method
- (NSArray *)readApplications{
    NSArray *allInstalledApplications = [_workspace allInstalledApplications] ;
    NSMutableArray *applications = [NSMutableArray arrayWithCapacity:allInstalledApplications.count] ;
    for (id proxy in allInstalledApplications){
        SIApp *app = [SIApp appWithPrivateProxy:proxy] ;
        if(!app.isHiddenApp){
            [applications addObject:app] ;
        }
    }
    return applications ;
}

@end
