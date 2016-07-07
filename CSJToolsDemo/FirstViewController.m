//
//  FirstViewController.m
//  CSJToolsDemo
//
//  Created by 曹 盛杰 on 14-6-1.
//  Copyright (c) 2014年 曹 盛杰. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    NSLog(@"viewWillAppear");
    [self fenleiDataIntoDocument];
    
    [self setupFetchedResultsController];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    NSLog(@"viewDidAppear");
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"First View";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - setupFetchedResultsController
-(void)setupFetchedResultsController{
    self.fetchedResultsController = [Firstdata fetchAllGroupedBy:nil withPredicate:[NSPredicate predicateWithFormat:@"firstTitle != nil"] sortedBy:@"firstTitle" ascending:YES];
}

#pragma mark - data
-(NSArray *)fenleiDataResource{
    NSArray *arr = [[NSArray alloc]init];
    NSDictionary *dict1 = @{@"firstdataId":@"001",@"firstTitle":@"push"};
    NSDictionary *dict2 = @{@"firstdataId":@"002",@"firstTitle":@"push2"};
    arr = @[dict1,dict2];
    return arr;
}

-(void)fenleiDataIntoDocument{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        NSArray *array = [self fenleiDataResource];
        [Firstdata MR_importFromArray:array inContext:localContext];
    } completion:^(BOOL success, NSError *error) {
        NSLog(@"成功 Error:%@",error);
    }];
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
*/
 

///*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell"];
    Firstdata *first = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = first.firstTitle;
    return cell;
}
//*/

#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SecondViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    Firstdata *first = [self.fetchedResultsController objectAtIndexPath:indexPath];
    vc.title = first.firstTitle;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
