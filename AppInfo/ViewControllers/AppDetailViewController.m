//
//  AppDetailViewController.m
//  AppInfo
//
//  Created by 杨晴贺 on 08/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "AppDetailViewController.h"
#import "SIAppController.h"
#import "TableViewCell.h"

@interface AppDetailViewController ()

@property (nonatomic,strong) NSString *appStoreUrl;
@property (nonatomic,strong) NSString *appStoreVersion;

@property (weak,nonatomic) IBOutlet UILabel *appStoreVersionLabel;
@property (weak,nonatomic) IBOutlet UIImageView *iconImage;
@property (weak,nonatomic) IBOutlet UILabel *appNameLabel;
@property (weak,nonatomic) IBOutlet UILabel *appVersionLabel;
@property (weak,nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak,nonatomic) IBOutlet UILabel *bundleIdentifierLabel;
@property (weak,nonatomic) IBOutlet UILabel *applicationTypeLabel;
@property (weak,nonatomic) IBOutlet UILabel *diskUsageLabel;
@property (weak,nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak,nonatomic) IBOutlet UILabel *minimumSystemVersionLabel;
@property (weak,nonatomic) IBOutlet UILabel *itemIDLabel;
@property (weak,nonatomic) IBOutlet UILabel *teamIDLabel;
@property (weak,nonatomic) IBOutlet UILabel *vendorNameLabel;
@property (weak,nonatomic) IBOutlet UILabel *sdkVersionLabel;

@end

@implementation AppDetailViewController{
    TableViewCell *_selectedCell ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI] ;
}

- (void)setupUI{
    self.sizeLabel.text = [NSString stringWithFormat:@"%.2fM", self.app.staticDiskUsage.doubleValue / 1024 / 1024] ;
    self.iconImage.image = self.app.icon ;
    self.appNameLabel.text = self.app.name ;
    self.appVersionLabel.text = [NSString stringWithFormat:@"Version %@", self.app.shortVersionString] ;
    self.bundleIdentifierLabel.text = self.app.bundleIdentifier ;
    self.applicationTypeLabel.text = self.app.applicationType ;
    self.diskUsageLabel.text = [NSString stringWithFormat:@"%.2fM", self.app.dynamicDiskUsage.doubleValue / 1024 / 1024] ;
    self.itemIDLabel.text = [NSString stringWithFormat:@"%@", self.app.itemID] ;
    self.itemNameLabel.text = self.app.itemName ;
    self.teamIDLabel.text = self.app.teamID ;
    self.vendorNameLabel.text = self.app.vendorName ;
    self.minimumSystemVersionLabel.text = self.app.minimumSystemVersion ;
    self.sdkVersionLabel.text = self.app.sdkVersion ;
    [self appInfo] ;
}

- (void)appInfo{
    NSString *urlStr = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@", self.app.itemID] ;
    NSURL *url = [NSURL URLWithString:urlStr] ;
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"error: %@", error);
            return;
        }
        NSError *jsonError = nil;
        NSDictionary *resultJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        if (jsonError != nil) {
            NSLog(@"jsonError: %@", jsonError);
            return;
        }
        NSLog(@"%@", resultJSON);
        NSArray *results = resultJSON[@"results"];
        if ([results count] == 0) {
            return;
        }
        NSDictionary *detail = results[0];
        self.appStoreVersion = detail[@"version"];
        self.appStoreUrl = detail[@"trackViewUrl"];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@", self.appStoreVersion);
            self.appStoreVersionLabel.text = self.appStoreVersion;
        });
    }] resume];
}

- (IBAction)actionClick:(id)sender {
    UIAlertController *actionController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [actionController addAction:[UIAlertAction actionWithTitle:@"open Application" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[SIAppController sharedInstance] openAppWithBundleIdentifier:self.app.bundleIdentifier];
    }]];
    [actionController addAction:[UIAlertAction actionWithTitle:@"open in App Store" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.appStoreUrl]];
    }]];
    [actionController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:actionController animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // menuControllerd的显示依赖第一相应者,当点击另外的cell时,当前cell取消第一响应者状态
    UIMenuController *menu = [UIMenuController sharedMenuController] ;
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES] ;
    }else{
        TableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath] ;
        _selectedCell = cell ;
        // 不设置为第一响应者无法显示
        [cell becomeFirstResponder] ;
        
        UIMenuItem * item0 = [[UIMenuItem alloc]initWithTitle:@"copy" action:@selector(myCopy:)];
        menu.menuItems = @[item0];
        
        [menu setTargetRect:CGRectMake(0, cell.frame.size.height * 0.5, cell.frame.size.width, cell.frame.size.height) inView:cell];
        
        [menu setMenuVisible:YES animated:YES];
    }

}

- (void)myCopy:(id)sender{
    // 复制文字到剪贴板
    UIPasteboard *paste = [UIPasteboard generalPasteboard] ;
    paste.string = _selectedCell.detailTextLabel.text ;
}

//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
//    if(action == @selector(cut:)
//       || action == @selector(copy:)
//       || action == @selector(myCut:)
//       || action == @selector(myPaste:)){
//        return YES ;
//    }
//    return NO ;
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}

@end
