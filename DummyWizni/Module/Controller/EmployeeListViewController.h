//
//  EmployeeListViewController.h
//  DummyWizni
//
//  Created by arvind rawat on 27/07/15.
//  Copyright (c) 2015 rwin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface EmployeeListViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

