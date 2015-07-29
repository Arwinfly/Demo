//
//  LocationHandler.m
//  DummyWizni
//
//  Created by arvind rawat on 29/07/15.
//  Copyright (c) 2015 rwin. All rights reserved.
//

#import "LocationHandler.h"

@implementation LocationHandler

CLLocationManager   *locationManager;
CLGeocoder          *_geocoder;
callBackBlock callBAck;
//+(instancetype) sharedInstance {
//    static dispatch_once_t pred;
//    static id shared = nil;
//    dispatch_once(&pred, ^{
//        shared = [[super alloc] initUniqueInstance];
//        
//      
//        
//    });
//    return shared;
//}

+(LocationHandler *)sharedLocationHandler{
    static dispatch_once_t pred;
    static id shared = nil;
    dispatch_once(&pred, ^{
        shared = [[super alloc] initUniqueInstance];
    });
    return shared;
}


-(instancetype) initUniqueInstance {
    return [super init];
}


////
#pragma mark - LocationManagerDelgate
-(void)callCurrentLocation :(callBackBlock)callbackFunction
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
    _geocoder = [[CLGeocoder alloc] init];
        // ** Don't forget to add NSLocationWhenInUseUsageDescription in MyApp-Info.plist and give it a string
    callBAck=callbackFunction;
}




- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil)
    {
        NSLog(@"Arv Lat :%@", [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]);
        NSLog(@"Arv Long:%@", [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
    }
    
    [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%f",newLocation.coordinate.latitude] forKey:@"Latitude"];
    [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%f",newLocation.coordinate.longitude] forKey:@"Longitude"];
    
    // Get addres by geocoding
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error == nil && [placemarks count] > 0)
         {
             CLPlacemark *placemark = [placemarks lastObject];
             NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
             [dict setValue:placemark.subThoroughfare forKey:@"street" ];
             [dict setValue:placemark.thoroughfare forKey:@"city" ];
             [dict setValue:placemark.administrativeArea forKey:@"country" ];
             [dict setValue:[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude] forKey:@"lattitude" ];
             [dict setValue:[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude] forKey:@"longitudeUser" ];
             callBAck(dict);
         }
     }];
    
    [self stopLocationActivity];
 
}

- (void)stopLocationActivity
{
    [locationManager stopUpdatingLocation];
    locationManager .delegate = nil;
    
}

@end
