//
//  SIAppController.h
//  AppInfo
//
//  Created by 杨晴贺 on 08/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "SIApp.h"

@interface SIAppController : NSObject

+ (instancetype)sharedInstance ;

@property (nonatomic,readonly) NSArray<SIApp *> *installedApplications ;

- (BOOL)openAppWithBundleIdentifier:(NSString* )bundleIdentifier;
- (NSArray* )privateURLSchemes;
- (NSArray* )publicURLSchemes;

@end
