//
//  ViewController.m
//  AppInfo
//
//  Created by 杨晴贺 on 08/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "ViewController.h"
#import "SIAppController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SIAppController *appController = [SIAppController sharedInstance] ;
    NSArray *array =  appController.installedApplications ;
    NSLog(@"%@",array) ;
}



@end
