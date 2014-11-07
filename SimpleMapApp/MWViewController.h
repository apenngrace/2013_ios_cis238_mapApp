//
//  MWViewController.h
//  SimpleMapApp
//
//  Created by Jason Wertz on 2/7/13.
//  Copyright (c) 2013 Jason Wertz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MWViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate>
{
    IBOutlet UITextField *locationTextField;    //the text field at the top of the app
    NSArray *locationArray;                     //array of continents and coordinates
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;



@end
