//
//  CommonUtilities.m
//  DummyWizni
//
//  Created by arvind rawat on 28/07/15.
//  Copyright (c) 2015 rwin. All rights reserved.
//

#import "CommonUtilities.h"

@implementation CommonUtilities


+(NSString*)getDocumentsPath
{
 // Get Document Directory Path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    return documentsPath;
}

/************************************************
 *
 *          Photo Read and Write in/From path
 *
 *************************************************/

+(void)saveImageToDocument :(NSString *)name image:(UIImage *)image
{
    //Write the file
    NSData *pngData = UIImagePNGRepresentation(image);
    NSString *filePath = [[self getDocumentsPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",name]]; //Add the file name
    [pngData writeToFile:filePath atomically:YES];
}

+(UIImage*)getImageFromLocalDirectory :(NSString *)name{
    //Reading File
     NSString *filePath = [[self getDocumentsPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",name]]; //Add the file name
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:pngData];
    return image;
    
}



@end
