//
//  PersonalInfoCollectionViewCell.h
//  DummyWizni
//
//  Created by arvind rawat on 26/07/15.
//  Copyright (c) 2015 rwin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalInfoCollectionViewCell : UICollectionViewCell
@property(nonatomic,weak) IBOutlet UITextField *firstName;
@property(nonatomic,weak) IBOutlet UITextField *lastName;
@property(nonatomic,weak) IBOutlet UITextField *emailId;
@property(nonatomic,weak) IBOutlet UITextField *mobileNumber;

@property (weak, nonatomic) IBOutlet UIButton *emplyeeImage;

@end
