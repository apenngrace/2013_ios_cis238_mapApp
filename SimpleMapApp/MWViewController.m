//
//  MWViewController.m
//  SimpleMapApp
//
//  Created by Jason Wertz on 2/7/13.
//  Copyright (c) 2013 Jason Wertz. All rights reserved.
//
//*****************************************
//Andrew Grace, Homework for Feb 21, 2013
//******************************************

#import "MWViewController.h"
#import "MWMapPoint.h"

@interface MWViewController ()

@end

@implementation MWViewController

#pragma mark - Map Stuff

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    CLLocationCoordinate2D location2d = [userLocation coordinate];                              //default map location is user location
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location2d, 200, 200);

    [self.mapView setRegion:region];
}

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.mapView setShowsUserLocation:YES];    

}

//*********************************************************************
//Methods added by Andrew Grace below
//*********************************************************************

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //Find the location and then show on map
    [self searchLocations];
    
    
    //finish up
    [textField resignFirstResponder];
    return YES;
}

//Searches user string to search continents names, creates a MWMapPoint with coordinates, selects map zoom level
//Then calls method goToLocation with a MWMapPoint & zoom level to move the map into place
-(void)searchLocations
{
    //Named int constants for the switch statement below to define zoom levels
    const int AFRICA = 0;
    const int ANTARCTICA = 1;
    const int ASIA = 2;
    const int AUSTRALIA = 3;
    const int EUROPE = 4;
    const int NORTH_AMERICA = 5;
    const int SOUTH_AMERICA = 6;
    
    //Array of MWMapPoints to define the center points of continents in the world
    locationArray = @[ [[MWMapPoint alloc] initWithCoordinate:CLLocationCoordinate2DMake(9.882275,19.248047) title:@"Africa"],
                       [[MWMapPoint alloc] initWithCoordinate:CLLocationCoordinate2DMake(-71.187754,28.125) title:@"Antarctica"],
                       [[MWMapPoint alloc] initWithCoordinate:CLLocationCoordinate2DMake(53.014783,100.195313) title:@"Asia"],
                       [[MWMapPoint alloc] initWithCoordinate:CLLocationCoordinate2DMake(-25.562265,134.648438) title:@"Australia"],
                       [[MWMapPoint alloc] initWithCoordinate:CLLocationCoordinate2DMake(55.321911,17.337891) title:@"Europe"],
                       [[MWMapPoint alloc] initWithCoordinate:CLLocationCoordinate2DMake(56.739861,-111.25) title:@"North America"],
                       [[MWMapPoint alloc] initWithCoordinate:CLLocationCoordinate2DMake(-27.068777,-58.798828) title:@"South America"] ];

    //Find MWMapPoint in array that matches the user's input
    //No location found if index remains -1
    
    int locationIndex = -1;
    for (int i = 0; i < [locationArray count]; i++)
    {
        //Change input & array of names to uppercase to simplify matching.
        //Work on copies to avoid accidentally changing variables.

        NSString *searchedText = [[locationTextField text] copy];
        NSString *testString = [[[locationArray objectAtIndex:i] title] copy];
        
        searchedText = [searchedText uppercaseString];
        testString = [testString uppercaseString];
        
        if ([searchedText isEqualToString:testString])
        {
            locationIndex = i;
        }
    }
    
    //Save list of zoom levels
    long zoomLevelMeters = 0;

    //Using switch to customize zoom levels for each continent
    //Zoom level calculated using powers of 10
    switch (locationIndex)
    {
        case AFRICA:
            zoomLevelMeters = pow(10,6.7);
            break;
        case ANTARCTICA:
            zoomLevelMeters = pow(10,6.5);
            break;
        case ASIA:
            zoomLevelMeters = pow(10,6.58);
            break;
        case AUSTRALIA:
            zoomLevelMeters = pow(10,6.5);
            break;
        case EUROPE:
            zoomLevelMeters = pow(10,6.5);
            break;
        case NORTH_AMERICA:
            zoomLevelMeters = pow(10,6.7);
            break;
        case SOUTH_AMERICA:
            zoomLevelMeters = pow(10,6.5);
            break;
    }
    
    //Check if the continent was found or not.  If not, do nothing and print console message.
    if (locationIndex != -1)
    {
        //Call method to show map point on the map
        NSLog(@"Found Continent: %@", [[locationArray objectAtIndex:locationIndex] title]);
        [self goToLocation:[locationArray objectAtIndex:locationIndex] withZoomLevel:zoomLevelMeters];
    }
    else
    {
        NSLog(@"Continent '%@' does not exist", [locationTextField text]);
    }
}

-(void)goToLocation:(MWMapPoint *)myMapPoint withZoomLevel:(long)myZoomLevel
{   
    //Create annotation on map
    [self.mapView addAnnotation:myMapPoint];
    
    //Formatting the number to appear in NSLog
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    NSString *numberAsString = [numberFormatter stringFromNumber:[NSNumber numberWithLong:myZoomLevel]];
    
    NSLog(@"Zoom Level is %@ meters wide.", numberAsString);
   
    //Save region info
    MKCoordinateRegion myRegion = MKCoordinateRegionMakeWithDistance([myMapPoint coordinate], myZoomLevel, myZoomLevel);

    //Go to region on the map
    [self.mapView setRegion:myRegion animated:YES];
}


@end
