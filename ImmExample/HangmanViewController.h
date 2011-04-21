//
//  HangmanViewController.h
//  ImmExample
//
//  Created by Sam Quinan on 4/18/11.
//  Copyright 2011 University of Chicago. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImExController.h"
#import "HangmanGame.h"

@interface HangmanViewController :  ImExController {
    
    IBOutlet NSMutableSet *hiddenItems;
    IBOutlet UIView *view;
    IBOutlet UIImageView *winScreen;
    IBOutlet UIImageView *loseScreen;
    IBOutlet HangmanGame *game;
    BOOL gameEnded;
    
    //it would have been cleaner to add these programatically but I ran out of time.
    NSArray *charLabels;
    IBOutlet UILabel *char1;
    IBOutlet UILabel *char2;
    IBOutlet UILabel *char3;
    IBOutlet UILabel *char4;
    IBOutlet UILabel *char5;
    IBOutlet UILabel *char6;
    IBOutlet UILabel *char7;
    IBOutlet UILabel *char8;
    IBOutlet UILabel *char9;
    IBOutlet UILabel *char10;
    
    NSArray *lineLabels;
    IBOutlet UILabel *line1;
    IBOutlet UILabel *line2;
    IBOutlet UILabel *line3;
    IBOutlet UILabel *line4;
    IBOutlet UILabel *line5;
    IBOutlet UILabel *line6;
    IBOutlet UILabel *line7;
    IBOutlet UILabel *line8;
    IBOutlet UILabel *line9;
    IBOutlet UILabel *line10;
    
    //I was planning on trying to draw using quartz 2d, but again I didn't have enough time to work out the bugs
    NSArray *bodyParts;
    IBOutlet UIImageView *body1;
    IBOutlet UIImageView *body2;
    IBOutlet UIImageView *body3;
    IBOutlet UIImageView *body4;
    IBOutlet UIImageView *body5;
    IBOutlet UIImageView *body6;
    
}

@property (nonatomic, retain) IBOutlet UIView *view;
@property (nonatomic, retain) IBOutlet NSMutableSet *hiddenItems;
@property (nonatomic, retain) IBOutlet HangmanGame *game;
@property (nonatomic, retain) IBOutlet UIImageView *winScreen;
@property (nonatomic, retain) IBOutlet UIImageView *loseScreen;

@property (nonatomic, retain) NSArray *charLabels;
@property (nonatomic, retain) IBOutlet UILabel *char1;
@property (nonatomic, retain) IBOutlet UILabel *char2;
@property (nonatomic, retain) IBOutlet UILabel *char3;
@property (nonatomic, retain) IBOutlet UILabel *char4;
@property (nonatomic, retain) IBOutlet UILabel *char5;
@property (nonatomic, retain) IBOutlet UILabel *char6;
@property (nonatomic, retain) IBOutlet UILabel *char7;
@property (nonatomic, retain) IBOutlet UILabel *char8;
@property (nonatomic, retain) IBOutlet UILabel *char9;
@property (nonatomic, retain) IBOutlet UILabel *char10;

@property (nonatomic, retain) NSArray *lineLabels;
@property (nonatomic, retain) IBOutlet UILabel *line1;
@property (nonatomic, retain) IBOutlet UILabel *line2;
@property (nonatomic, retain) IBOutlet UILabel *line3;
@property (nonatomic, retain) IBOutlet UILabel *line4;
@property (nonatomic, retain) IBOutlet UILabel *line5;
@property (nonatomic, retain) IBOutlet UILabel *line6;
@property (nonatomic, retain) IBOutlet UILabel *line7;
@property (nonatomic, retain) IBOutlet UILabel *line8;
@property (nonatomic, retain) IBOutlet UILabel *line9;
@property (nonatomic, retain) IBOutlet UILabel *line10;

@property (nonatomic, retain) NSArray *bodyParts;
@property (nonatomic, retain) IBOutlet UIImageView *body1;
@property (nonatomic, retain) IBOutlet UIImageView *body2;
@property (nonatomic, retain) IBOutlet UIImageView *body3;
@property (nonatomic, retain) IBOutlet UIImageView *body4;
@property (nonatomic, retain) IBOutlet UIImageView *body5;
@property (nonatomic, retain) IBOutlet UIImageView *body6;


- (IBAction)buttonPress:(id)sender;

-(void)reset;

-(void)resetKeyboard;

-(void)newGame;

-(void)reveal:(NSString *) ichar;

-(void) newGameHandler: (id)sender;

-(void) viewDidLoad;

-(void) win;

-(void) lose;


@end
