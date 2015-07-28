//
//  EmployeeCellTableViewCell.h
//  DummyWizni
//
//  Created by arvind rawat on 28/07/15.
//  Copyright (c) 2015 rwin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmployeeCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *empIoyeeImage;
@property (weak, nonatomic) IBOutlet UILabel *emplyeeName;
@property (weak, nonatomic) IBOutlet UILabel *mobile;
@property (weak, nonatomic) IBOutlet UILabel *emailId;

@end
