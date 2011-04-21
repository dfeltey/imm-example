//
//  MZNHController.m
//  ImmExample
//
//  Created by Naren Hazareesingh on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MZNHController.h"


@implementation MZNHController

-(void)viewDidLoad {
    // infoView hides on tap
    UITapGestureRecognizer *singleTapRecognizer = [[UITapGestureRecognizer alloc]
												   initWithTarget:self action:@selector(hideInfo)];
	[singleTapRecognizer setNumberOfTapsRequired:1];
	[singleTapRecognizer setDelegate:self];
	[infoView addGestureRecognizer:singleTapRecognizer];
	[singleTapRecognizer release];
    
    // load celestial bodies from plist
    bodies = [[MZNHCelestialBody celestialBodiesFromPlist:@"CelestialBodyData"] retain];
    // store pointers to UIButton objects
    bodyViews = [[NSMutableArray alloc] init];
    
    for (int i=0;i<[bodies count];i++) {
        MZNHCelestialBody *body = [bodies objectAtIndex:i];
        // Apparently, UIButton is less expensive than a UIImageView configured for touches... I'm not sure if I believe that.
        UIButton *theView = [[UIButton alloc] initWithFrame:CGRectMake(body.origin.x, body.origin.y, 2*body.radius, 2*body.radius)];
        [theView setImage:body.image forState:UIControlStateNormal];
        theView.adjustsImageWhenHighlighted = NO;
        [theView addTarget:self action:@selector(displayInfo:) forControlEvents:UIControlEventTouchUpInside];
        theView.tag = i;
        
        [bodyViews addObject:theView];
        [self.view addSubview:theView];
        [self.view sendSubviewToBack:theView];
        
        [theView release];
    }
    
}

- (IBAction)animate:(id)sender {
    float t = 10;
    startButton.hidden=YES;
    progressDot.frame = CGRectMake(0,
                                   progressDot.frame.origin.y,
                                   progressDot.frame.size.width,
                                   progressDot.frame.size.height);
    for (int i=0; i<[bodies count]; i++) {
        MZNHCelestialBody *body = [bodies objectAtIndex:i];
        [self orbit:[bodyViews objectAtIndex:i] origin:body.origin o_rad:body.orbital_radius radius:body.radius time:t];
    }
    [UIView animateWithDuration:t delay:0
                        options:UIViewAnimationCurveLinear
                     animations:^{progressDot.frame = CGRectMake(progressDot.frame.origin.x+300,
                                                        progressDot.frame.origin.y,
                                                        progressDot.frame.size.width,
                                                        progressDot.frame.size.height);}
                     completion:^(BOOL finished){startButton.hidden=NO;}];
}

- (void)orbit:(UIView *)planet origin:(CGPoint)o o_rad:(float)R radius:(float)r time:(float)t {
    // Chained animations
    [UIView animateWithDuration:t/8
                          delay:0
                        options:(UIViewAnimationCurveLinear | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{planet.frame = CGRectMake(o.x-R, o.y, 2*r, 2*r);}
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:t/4
                                               delay:0
                                             options:(UIViewAnimationCurveLinear | UIViewAnimationOptionAllowUserInteraction)
                                          animations:^{planet.frame = CGRectMake(o.x-R, o.y+2*R, 2*r, 2*r);}
                                          completion:^(BOOL finished){
                                              [UIView animateWithDuration:t/4
                                                                    delay:0
                                                                  options:(UIViewAnimationCurveLinear | UIViewAnimationOptionAllowUserInteraction)
                                                               animations:^{planet.frame = CGRectMake(o.x+R, o.y+2*R, 2*r, 2*r);}
                                                               completion:^(BOOL finished){
                                                                   [UIView animateWithDuration:t/4 delay:0
                                                                                       options:(UIViewAnimationCurveLinear | UIViewAnimationOptionAllowUserInteraction)
                                                                                    animations:^{planet.frame = CGRectMake(o.x+R, o.y, 2*r, 2*r);}
                                                                                    completion:^(BOOL finished){
                                                                                        [UIView animateWithDuration:t/8
                                                                                                         animations:^{planet.frame = CGRectMake(o.x, o.y, 2*r, 2*r);}];
                                                                                    }];
                                                               }];
                                          }];
                     }];
}

- (void)displayInfo:(id)sender {
    UIButton* button = (UIButton *)sender;
    if (infoView.tag==button.tag && !infoView.hidden) infoView.hidden=YES;
    else {
        float maxX = 320-infoView.frame.size.width;
        float maxY = 480-infoView.frame.size.height;
        MZNHCelestialBody *body = [bodies objectAtIndex:button.tag];
        [infoView setFrame:CGRectMake(MIN(button.frame.origin.x + body.radius*1.6 + 2,maxX),
                                      MIN(button.frame.origin.y + body.radius*1.6 + 2,maxY),
                                      infoView.frame.size.width,
                                      infoView.frame.size.height)];
        infoView.tag = button.tag;
        nameLabel.text = body.name;
        tempLabel.text = [NSString stringWithFormat:@"%.1fºF", body.surface_temp];
        
        [self.view bringSubviewToFront:infoView];
        infoView.hidden=NO;
    }
}
- (void)hideInfo {
    infoView.hidden=YES;
}

- (void)dealloc {
    [infoView release];
    [timeScale release];
    [startButton release];
    [nameLabel release];
    [tempLabel release];
    [bodies release];
    [bodyViews release];
    [progressDot release];
    [super dealloc];
}

@end
