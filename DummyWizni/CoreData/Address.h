//
//  Address.h
//  DummyWizni
//
//  Created by arvind rawat on 26/07/15.
//  Copyright (c) 2015 rwin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Employee;

@interface Address : NSManagedObject

@property (nonatomic, retain) NSString * cityName;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * lattitude;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * streetName;
@property (nonatomic, retain) NSSet *addressOfEmployee;
@end

@interface Address (CoreDataGeneratedAccessors)

- (void)addAddressOfEmployeeObject:(Employee *)value;
- (void)removeAddressOfEmployeeObject:(Employee *)value;
- (void)addAddressOfEmployee:(NSSet *)values;
- (void)removeAddressOfEmployee:(NSSet *)values;

@end
