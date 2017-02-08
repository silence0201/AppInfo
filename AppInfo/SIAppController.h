//
//  SIAppController.h
//  AppInfo
//
//  Created by 杨晴贺 on 08/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIAppController : NSObject

+ (instancetype)sharedInstance ;

@property (nonatomic,readonly) NSArray *installedApplications ;

- (BOOL)openAppWithBundleIdentifier:(NSString* )bundleIdentifier;
- (NSArray* )privateURLSchemes;
- (NSArray* )publicURLSchemes;

@end
