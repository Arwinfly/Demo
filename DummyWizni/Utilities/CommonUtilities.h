//
//  CommonUtilities.h
//  DummyWizni
//
//  Created by arvind rawat on 28/07/15.
//  Copyright (c) 2015 rwin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonUtilities : NSObject
+(void)saveImageToDocument :(NSString *)name image:(UIImage *)image;
+(UIImage*)getImageFromLocalDirectory :(NSString *)name;
@end
