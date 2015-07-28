//
//  EmployeeCollectionViewController.h
//  DummyWizni
//
//  Created by arvind rawat on 27/07/15.
//  Copyright (c) 2015 rwin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface EmployeeCollectionViewController : UICollectionViewController <CLLocationManagerDelegate ,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate >
- (IBAction)addNewEmplyee:(id)sender;
@property(assign,nonatomic)BOOL NewEmployeeBool;
@property (strong, nonatomic) id detailItem;
@end
