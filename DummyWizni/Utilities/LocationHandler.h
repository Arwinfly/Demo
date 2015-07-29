//
//  LocationHandler.h
//  DummyWizni
//
//  Created by arvind rawat on 29/07/15.
//  Copyright (c) 2015 rwin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

@interface LocationHandler : NSObject <CLLocationManagerDelegate>
+(LocationHandler *)sharedLocationHandler;
+(instancetype) alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));
-(instancetype) init __attribute__((unavailable("init not available, call sharedInstance instead")));
+(instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));
-(instancetype) copy __attribute__((unavailable("copy not available, call sharedInstance instead")));

-(void)callCurrentLocation :(callBackBlock)callbackFunction;



@end