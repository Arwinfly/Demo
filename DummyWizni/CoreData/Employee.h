//
//  Employee.h
//  DummyWizni
//
//  Created by arvind rawat on 26/07/15.
//  Copyright (c) 2015 rwin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Address;

@interface Employee : NSManagedObject

@property (nonatomic, retain) NSString * emailId;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * picName;
@property (nonatomic, retain) NSSet *employeeAddrress;

-(NSString *)getFullName;
@end

@interface Employee (CoreDataGeneratedAccessors)

- (void)addEmployeeAddrressObject:(Address *)value;
- (void)removeEmployeeAddrressObject:(Address *)value;
- (void)addEmployeeAddrress:(NSSet *)values;
- (void)removeEmployeeAddrress:(NSSet *)values;

@end
