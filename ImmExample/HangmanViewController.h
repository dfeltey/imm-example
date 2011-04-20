//
//  HangmanViewController.h
//  ImmExample
//
//  Created by Sam Quinan on 4/18/11.
//  Copyright 2011 University of Chicago. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImExController.h"

@interface HangmanViewController :  ImExController {
    
    IBOutlet UILabel *label;
    IBOutlet NSMutableSet *hiddenItems;
    NSMutableArray *wordToGuess;
    
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
    
}

@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet NSMutableSet *hiddenItems;
@property (nonatomic, retain) NSMutableArray *wordToGuess;

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

- (IBAction)buttonPress:(id)sender;

-(void)resetKeyboard;

-(void)newGame:(NSString *) newWord;

-(void)reveal:(NSString *) ichar;

-(void) viewDidLoad;


@end
