//
//  ViewController.m
//  Lesson_16
//
//  Created by Andrey Proskurin on 03.10.17.
//  Copyright © 2017 Andrey Proskurin. All rights reserved.
//

#import "ViewController.h"
#import "HeaderView.h"

static NSString *const cellIdentifier = @"cell";
static NSString *const headerIdentifier = @"header";
static NSString *const footerIdentifier = @"footer";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSArray *headerDataArray;
@property (strong, nonatomic) NSArray *footerDataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[@"String1", @"String2", @"String3"];
    self.headerDataArray = @[@"header1", @"header2", @"header3"];
    self.footerDataArray = @[@"footer1", @"footer2", @"footer3"];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"My Name" forKey:@"Key1"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateInterface:)
                                                 name:@"Key2"
                                               object:nil]; // 1
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Key2" object:@{@"name" : @"John"}]; // 2
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self]; // 3
}

- (void)updateInterface:(NSNotification *)notification {
    
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // так как у массива хедеров и футеров одинаковое колличество элементов в массиве, можно ссылаться на любой массив (headerDataArray, footerDataArray)
    return self.headerDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    
    // Если ячейка не была добавлена в сториборде ---
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    // ----------------------------------------------
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 90.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
   
    // тоже самое, как и с ячейкой ----------------
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerIdentifier];
        
//        headerView.contentView.backgroundColor = [UIColor redColor];
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(130, 0, tableView.frame.size.width, 90)];
//        [headerView.contentView addSubview:label];
        
        HeaderView *header = [[HeaderView alloc] init];
        [headerView.contentView addSubview:header];
    }
    
//    UILabel *textLabel = headerView.contentView.subviews.firstObject;
//    textLabel.text = [self.headerDataArray objectAtIndex:section];

    HeaderView *header = headerView.contentView.subviews.firstObject;
    
    header.titleLabel.text = [self.headerDataArray objectAtIndex:section];
    [header.button setTitle:@"HI" forState:UIControlStateNormal];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerIdentifier];
    
    if (!footerView) {
        footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:footerIdentifier];
        footerView.contentView.backgroundColor = [UIColor greenColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(130, 0, tableView.frame.size.width, 50)];
        [footerView.contentView addSubview:label];
        
    }
    
    UILabel *textLabel = footerView.contentView.subviews.firstObject;
    textLabel.text = [self.footerDataArray objectAtIndex:section];
    
    return footerView;
}



@end

















