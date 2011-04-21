//
//  MZNHCelestialBody.m
//  ImmExample
//
//  Created by Michael Zink on 11.04.20.
//  Copyright 2011 Baconfeet & Associates. All rights reserved.
//

#import "MZNHCelestialBody.h"
//#import <math.h>

@implementation MZNHCelestialBody

@synthesize origin, orbital_radius, angular_velocity, angle, surface_temp;

@synthesize name, image, mass, radius;

// Simply calculate the current position based on the origin and current angle.
- (CGPoint) position {
    CGFloat x_offset = self.orbital_radius * cosf(self.angle);
    CGFloat y_offset = self.orbital_radius * sinf(self.angle);
    return CGPointMake(self.origin.x + x_offset, self.origin.y + y_offset);
}

- (void) advance: (NSTimeInterval) interval {
    self.angle += self.angular_velocity * interval;
}

+ (NSArray *) celestialBodiesFromPlist: (NSString *) fileName {
    NSMutableArray * bodies = [NSMutableArray array];
    NSString * plistPath = [[NSBundle mainBundle] pathForResource: fileName ofType: @"plist"];
    NSData *plistXML = [NSData dataWithContentsOfFile: plistPath];
    NSDictionary * plistDict = [NSPropertyListSerialization
                                propertyListFromData: plistXML
                                mutabilityOption: NSPropertyListImmutable
                                format: NULL
                                errorDescription: NULL];
    for (NSString * name in plistDict) {
        MZNHCelestialBody * body = [MZNHCelestialBody celestialBodyWithName: name dictionary: [plistDict objectForKey: name]];
        [bodies addObject: body];
        //NSLog(@"%f %f", body.position.x, body.position.y);
    }
    return bodies;
}

#define FLOAT_FROM_DICT(dict, key) ([[dict objectForKey: key] floatValue])

+ (MZNHCelestialBody *) celestialBodyWithName: (NSString *) name dictionary: (NSDictionary *) dict {
    MZNHCelestialBody * body = [[MZNHCelestialBody alloc] init];
    body.name = name;
    body.image = [UIImage imageNamed:[dict objectForKey:@"image"]];
    CGPoint origin = CGPointZero;
    origin.x = FLOAT_FROM_DICT([dict objectForKey: @"origin"], @"x");
    origin.y = FLOAT_FROM_DICT([dict objectForKey: @"origin"], @"y");
    body.origin = origin;
    body.orbital_radius = FLOAT_FROM_DICT(dict, @"orbital_radius");
    body.angular_velocity = FLOAT_FROM_DICT(dict, @"angular_velocity");
    body.surface_temp = FLOAT_FROM_DICT(dict, @"surface_temp");
    body.angle = FLOAT_FROM_DICT(dict, @"angle");
    body.mass = FLOAT_FROM_DICT(dict, @"mass");
    body.radius = FLOAT_FROM_DICT(dict, @"radius");
    return body;
}

@end
