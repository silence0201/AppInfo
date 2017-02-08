//
//  AppListViewController.m
//  AppInfo
//
//  Created by 杨晴贺 on 08/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "AppListViewController.h"
#import "AppDetailViewController.h"
#import "SIAppController.h"

static NSString *cellIdentifier = @"AppListCellIdentifier" ;

@interface AppListViewController ()<UIViewControllerPreviewingDelegate>

@property (nonatomic,strong) NSArray<SIApp *> *apps ;

@end

@implementation AppListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.apps = [SIAppController sharedInstance].installedApplications ;
    [self registerForPreviewingWithDelegate:self sourceView:self.tableView] ;
}
- (IBAction)startRefresh:(UIRefreshControl *)sender {
    [sender endRefreshing];
    self.apps = [SIAppController sharedInstance].installedApplications;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.apps.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath] ;
    SIApp *app = self.apps[indexPath.row] ;
    cell.imageView.image = app.icon ;
    cell.textLabel.text = app.name ;
    cell.detailTextLabel.text = app.shortVersionString ;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
    return cell ;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender{
    if ([segue.destinationViewController isKindOfClass:[AppDetailViewController class]]) {
        AppDetailViewController *dvc = (AppDetailViewController *)segue.destinationViewController ;
        if([sender isKindOfClass:[UITableViewCell class]]){
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender] ;
            dvc.app = self.apps[indexPath.row] ;
        }
    }
}

#pragma mark -- UIViewControllerPreviewingDelegate
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    CGPoint point = [previewingContext.sourceView convertPoint:location toView:self.tableView] ;
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point] ;
    if([self.presentedViewController isKindOfClass:[AppDetailViewController class]]){
        return nil ;
    }else{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"AppDetailViewController"];
        AppDetailViewController *detailVc = (AppDetailViewController *)vc ;
        detailVc.app = self.apps[indexPath.row] ;
        return detailVc ;
    }
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:viewControllerToCommit{
    AppDetailViewController *dvc = (AppDetailViewController *)viewControllerToCommit ;
    [self.navigationController pushViewController:dvc animated:YES] ;
}


@end
