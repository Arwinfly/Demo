//
//  ValidationRegex.h
//  DummyWizni
//
//  Created by arvind rawat on 28/07/15.
//  Copyright (c) 2015 rwin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidationRegex : NSObject
+ (BOOL)validateEmailWithString:(NSString*)emailText;
+ (BOOL)validateMobileNumber:(NSString *)mobileNumber;
+(void)showAlert:(NSString *)title message:(NSString *)msgString;
@end
