//
//  Employee.m
//  DummyWizni
//
//  Created by arvind rawat on 26/07/15.
//  Copyright (c) 2015 rwin. All rights reserved.
//

#import "Employee.h"
#import "Address.h"


@implementation Employee

@dynamic emailId;
@dynamic firstName;
@dynamic lastName;
@dynamic phoneNumber;
@dynamic picName;
@dynamic employeeAddrress;
-(NSString *)getFullName
{
    return [NSString stringWithFormat:@"%@ %@",self.firstName,self.lastName];
}
@end
