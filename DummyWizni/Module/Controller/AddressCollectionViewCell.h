//
//  AddressCell.h
//  DummyWizni
//
//  Created by arvind rawat on 26/07/15.
//  Copyright (c) 2015 rwin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressCollectionViewCell : UICollectionViewCell
@property(nonatomic,weak) IBOutlet UITextField *streetName;
@property(nonatomic,weak) IBOutlet UITextField *cityName;
@property(nonatomic,weak) IBOutlet UITextField *CountryName;
@property(nonatomic,weak) IBOutlet UITextField *lattitude;
@property(nonatomic,weak) IBOutlet UITextField *longitude;

@property(nonatomic,weak) IBOutlet UIButton *useLocation;
@property(nonatomic,weak) IBOutlet UIButton *saveButton;
@end
