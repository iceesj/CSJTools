//
//  CSJ_CoredataTableViewController.h
//  CSJToolsDemo
//
//  Created by 曹 盛杰 on 14-2-22.
//  Copyright (c) 2014年 曹 盛杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface CSJ_CoredataTableViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@end
