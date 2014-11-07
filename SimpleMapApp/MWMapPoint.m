//
//  MWMapPoint.m
//  SimpleMapApp
//
//  Created by Jason Wertz on 2/7/13.
//  Copyright (c) 2013 Jason Wertz. All rights reserved.
//

#import "MWMapPoint.h"

@implementation MWMapPoint


-(id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t {
    if((self = [super init])) {
        _coordinate = c;
        [self setTitle:t];
        
        // If you don't want to call get/sets in init
        // _title = [t copy];
    }
    
    return self;
}

-(id)init {
    return [self initWithCoordinate:CLLocationCoordinate2DMake(0.0, 0.0) title:@""];
}

@end
