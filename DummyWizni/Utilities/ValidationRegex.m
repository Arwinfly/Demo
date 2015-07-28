//
//  ValidationRegex.m
//  DummyWizni
//
//  Created by arvind rawat on 28/07/15.
//  Copyright (c) 2015 rwin. All rights reserved.
//

#import "ValidationRegex.h"

@implementation ValidationRegex
+ (BOOL)validateEmailWithString:(NSString*)emailText{
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9]+\\.[A-Za-z]{2,4}$";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        if (![emailTest evaluateWithObject:emailText]) {
            NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
            NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
            return [emailTest evaluateWithObject:emailText];
        }
        return [emailTest evaluateWithObject:emailText];
}

+ (BOOL)validateMobileNumber:(NSString *)phoneNumber{
          // NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
        NSString *phoneRegex = @"[0-9]{6,14}$";
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
        
        return [phoneTest evaluateWithObject:phoneNumber];
}


+(void)showAlert:(NSString *)title message:(NSString *)msgString{
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:msgString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}
@end
