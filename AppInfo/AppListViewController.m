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

@interface AppListViewController ()

@property (nonatomic,strong) NSArray<SIApp *> *apps ;

@end

@implementation AppListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.apps = [SIAppController sharedInstance].installedApplications ;
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


@end
