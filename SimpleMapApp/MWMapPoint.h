//
//  MWMapPoint.h
//  SimpleMapApp
//
//  Created by Jason Wertz on 2/7/13.
//  Copyright (c) 2013 Jason Wertz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MWMapPoint : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;

-(id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t;


@end
