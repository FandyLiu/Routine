//
//  FontTableViewController.m
//  Objective-C
//
//  Created by QianTuFD on 2017/2/22.
//  Copyright © 2017年 fandy. All rights reserved.
//  不同字体样式展现

#import "FontTableViewController.h"

static NSString * const kCellIdentifier = @"fontCellIdentifier";

@interface FontTableViewController ()

@property (nonatomic, strong) NSArray *items;

@end

@implementation FontTableViewController

#pragma mark - lazy

- (NSArray *)items {
    if (_items == nil) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSString *familyName in [UIFont familyNames]) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setObject:familyName forKey:@"familyName"];
            [dict setObject:[UIFont fontNamesForFamilyName:familyName] forKey:@"childrens"];
            [array addObject:dict];
        }
        _items = array;
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTableView];
    
    // 测试打印
    for (NSString *familyName in [UIFont familyNames]) {
        NSLog(@"字体族科 Font FamilyName = %@",familyName);
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            NSLog(@"\t 字样 %@",fontName);
        }
    }
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dict = self.items[section];
    NSArray *childrens = [dict valueForKey:@"childrens"];
    return childrens.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *detailTitle = @"中国 China FandyLau";
        cell.detailTextLabel.text = detailTitle;
    }
    NSString *title = [self titleForRowAtIndexPath:indexPath];
    cell.textLabel.text = title;
    cell.detailTextLabel.font = [UIFont fontWithName:title size:22];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.items[section] objectForKey:@"familyName"];
}

#pragma mark - Private instance methods

- (void)configureTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.rowHeight = 80.f;
}


- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.items[indexPath.section];
    NSArray *childrens = [dict valueForKey:@"childrens"];
    return childrens[indexPath.row];
}

@end
