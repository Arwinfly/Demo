//
//  MapViewController.m
//  DummyWizni
//
//  Created by arvind rawat on 27/07/15.
//  Copyright (c) 2015 rwin. All rights reserved.
// CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(28.428051, 77.109683);




#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "AppDelegate.h"

@interface MapViewController ()
{
    MKPointAnnotation *annotation;
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation MapViewController
@synthesize coordinate;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mapView setShowsUserLocation:YES];
    
    
    
    
    // Dropping pin into specific Lat and Long
    [self setLatLongAndDropPinAtParticularPlace:coordinate];
    
    
    //user needs to press for 2 seconds
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.0;
    [self.mapView addGestureRecognizer:lpgr];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */




- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    [self setLatLongAndDropPinAtParticularPlace:touchMapCoordinate];
    
}

//Drop Pin at Particular Lat Long and set it
-(void)setLatLongAndDropPinAtParticularPlace :( CLLocationCoordinate2D )coord
{
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region = {coord, span};
    
    if (annotation==nil) {
         annotation = [[MKPointAnnotation alloc] init];
    }
    [annotation setCoordinate:coord];
    
    [self.mapView setRegion:region];
    [self.mapView addAnnotation:annotation];
}



@end

