//
//  MainTableViewController.m
//  Objective-C
//
//  Created by QianTuFD on 2017/2/21.
//  Copyright © 2017年 fandy. All rights reserved.
//

#import "MainTableViewController.h"
#import "MenuTableViewCell.h"

#import "CallViewController.h"
#import "FontTableViewController.h"
#import "ScreenshotsViewController.h"

static NSString * const kCellIdentifier = @"mainCellIdentifier";

@interface MainTableViewController ()

@property (nonatomic, strong) NSArray *items;

@end

@implementation MainTableViewController

#pragma mark - lazy

- (NSArray *)items {
    if (_items == nil) {
        _items = @[@[@"Call", [CallViewController class]],
                   @[@"Font-Names", [FontTableViewController class]],
                   @[@"Screenshots", [ScreenshotsViewController class]],
                   ];
    }
    return _items;
}

#pragma mark - View 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Routine";
    [self configureTableView];
    [self configureTitleView];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = [self viewControllerForRowAtIndexPath:indexPath];
    viewController.title = [self titleForRowAtIndexPath:indexPath];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [self titleForRowAtIndexPath:indexPath];
    return cell;
}

#pragma mark - Private instance methods

- (void)configureTableView {
    [self.tableView registerClass:[MenuTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 50.f;
}

- (void)configureTitleView {
    UILabel *headlinelabel = [[UILabel alloc] init];
    headlinelabel.font = [UIFont fontWithName:@"Zapfino" size:28];
    headlinelabel.textAlignment = NSTextAlignmentCenter;
    headlinelabel.textColor = [UIColor grayColor];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.title];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor redColor]
                             range:NSMakeRange(1, 1)];
    
    headlinelabel.attributedText = attributedString;
    [headlinelabel sizeToFit];
    
    [self.navigationItem setTitleView:headlinelabel];
}

- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.items[indexPath.row] firstObject];
}

- (UIViewController *)viewControllerForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[[self.items[indexPath.row] lastObject] alloc] init];
}

@end
