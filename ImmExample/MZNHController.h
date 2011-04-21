//
//  MZNHController.h
//  ImmExample
//
//  Created by Naren Hazareesingh on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImExController.h"
#import "MZNHCelestialBody.h"

@interface MZNHController : ImExController <UIGestureRecognizerDelegate>{
    NSArray *bodies;
    NSMutableArray *bodyViews;
    IBOutlet UIView *infoView;
    IBOutlet UIProgressView *timeScale;
    IBOutlet UIButton *startButton;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *tempLabel;
    IBOutlet UIView *progressDot;
    
}
- (IBAction)animate:(id)sender;
- (void)displayInfo:(id)sender;
- (void)hideInfo;
- (void)orbit:(UIView *)planet origin:(CGPoint)o o_rad:(float)R radius:(float)r time:(float)t;
@end
