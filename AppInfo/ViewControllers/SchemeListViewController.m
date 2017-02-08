//
//  SchemeListViewController.m
//  AppInfo
//
//  Created by 杨晴贺 on 08/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "SchemeListViewController.h"
#import "SIAppController.h"

static NSString *cellIdentifier = @"SchemeCellIdentifier" ;
@interface SchemeListViewController ()

@property (nonatomic,assign) NSInteger schemeType;
@property (nonatomic,strong) NSArray *publicURLSchemes;
@property (nonatomic,strong) NSArray *privateURLSchemes;

@end

@implementation SchemeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.publicURLSchemes = [[SIAppController sharedInstance] publicURLSchemes] ;
    self.privateURLSchemes = [[SIAppController sharedInstance] privateURLSchemes] ;
}

- (IBAction)schemeTypeChanged:(UISegmentedControl *)sender {
    self.schemeType = sender.selectedSegmentIndex ;
    [self.tableView reloadData] ;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.schemeType == 0) {
        return [self.publicURLSchemes count];
    } else {
        return [self.privateURLSchemes count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (self.schemeType == 0) {
        cell.textLabel.text = self.publicURLSchemes[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.textLabel.text = self.privateURLSchemes[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.schemeType == 0) {
        NSString *url = [NSString stringWithFormat:@"%@://app/", self.publicURLSchemes[indexPath.row]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    } else {
        NSString *url = [NSString stringWithFormat:@"%@://app/", self.privateURLSchemes[indexPath.row]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}

@end
