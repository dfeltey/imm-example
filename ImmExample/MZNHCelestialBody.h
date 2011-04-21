//
//  MZNHCelestialBody.h
//  ImmExample
//
//  Created by Michael Zink on 11.04.20.
//  Copyright 2011 Baconfeet & Associates. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MZNHCelestialBody : NSObject

// Position/behavior information
@property CGPoint               origin;
@property(readonly)             CGPoint position;
@property float                 orbital_radius;
@property float                 angular_velocity;
@property float                 surface_temp;
@property float                 angle;

// Other information
@property(retain) NSString *    name;
@property(retain) UIImage *    image;
@property float                 mass;
@property float                 radius;

- (void) advance: (NSTimeInterval) interval;

+ (NSArray *) celestialBodiesFromPlist: (NSString *) fileName;
+ (MZNHCelestialBody *) celestialBodyWithName: (NSString *) name dictionary: (NSDictionary *) dict;

@end
