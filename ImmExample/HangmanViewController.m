//
//  HangmanViewController.m
//  ImmExample
//
//  Created by Sam Quinan on 4/18/11.
//  Copyright 2011 University of Chicago. All rights reserved.
//

#import "HangmanViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define INIT_X 30
#define INIT_Y 265
#define SPACING 29


@implementation HangmanViewController

@synthesize view, endGameScreen, label, hiddenItems, wordToGuess, charLabels, lineLabels;
@synthesize char1, char2, char3, char4, char5, char6, char7, char8, char9, char10, line1, line2, line3, line4, line5, line6, line7, line8, line9, line10;

- (void)dealloc {
    [label release];
    [super dealloc];
}

- (IBAction)buttonPress:(id)sender {
    [self reveal:[[sender titleLabel] text]];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:.4];
    //* gray out and disable
    [sender setEnabled:NO];
    [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [sender setAlpha:0.3];
    //*/
    [UIView commitAnimations];
    
    [hiddenItems addObject:sender];
    
    //update model
    label.text = [sender titleLabel].text;
    
}

- (IBAction)resetPressed:(id)sender {
    [self resetKeyboard];
    //reset Labels
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:.4];
    for (int i=0; i < [wordToGuess count]; i++){
        [(UILabel *)[charLabels objectAtIndex:i] setAlpha:0];
        [(UILabel *)[lineLabels objectAtIndex:i] setAlpha:0];
    }
    [UIView commitAnimations];
    [self performSelector:@selector(newGame:) withObject:@"itsworking" afterDelay:.4];
    //[self newGame:@"itsworking"];
}

-(void)resetKeyboard{
    UIColor *color = UIColorFromRGB(0x457CAA);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:.4];
    for (id object in hiddenItems){
        //undo
        [object setTitleColor:color forState:UIControlStateNormal];
        [object setAlpha:1.0];
        [object setEnabled:YES];
    }
    [UIView commitAnimations];
}

-(void)newGame:(NSString *) newWord{
    
    NSMutableArray *characters = [[NSMutableArray alloc] initWithCapacity:[newWord length]];
    for (int i=0; i < [newWord length]; i++)
    {
        NSString *ichar = [[NSString stringWithFormat:@"%c", [newWord characterAtIndex:i ]] uppercaseString];
        [characters addObject:ichar];
        [(UILabel *)[charLabels objectAtIndex:i] setText:ichar];
        
    }
    self.wordToGuess = characters;
    [characters autorelease];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:.4];
    for (int i=0; i < 10; i++){
        if (i < [wordToGuess count]){
            [(UILabel *)[lineLabels objectAtIndex:i] setAlpha:1];
        }
    }
    [UIView commitAnimations];

}

-(void)reveal:(NSString *) ichar {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:.4];
    for (int i=0; i < [wordToGuess count]; i++){
        if ([ichar isEqualToString:(NSString *)[wordToGuess objectAtIndex:i]]){
            [(UILabel *)[charLabels objectAtIndex:i] setAlpha:1];
        }
    }
    [UIView commitAnimations];
}

-(void)newGameHandler:(id)sender{
    UIButton *button = (UIButton *)sender;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:.4];
    button.alpha = 0;
    [UIView commitAnimations];
    [self resetPressed:nil];
    [self performSelector:@selector(clearScreen:) withObject:button afterDelay:.4];
}

-(void)clearScreen:(UIButton *)button{
    [button removeFromSuperview];
}

-(void) win{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"New Game" forState:UIControlStateNormal];
    button.frame = CGRectMake(100.0, 100.0, 90.0, 30.0);
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.textColor = UIColorFromRGB(0x457CAA);
    [button addTarget:self action:@selector(newGameHandler:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
}


-(void) lose{
    //add button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"New Game" forState:UIControlStateNormal];
    button.frame = CGRectMake(100.0, 100.0, 90.0, 30.0);
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.textColor = UIColorFromRGB(0x457CAA);
    button.alpha = 0;
    [button addTarget:self action:@selector(newGameHandler:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
     
    //fade in
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:1];
    button.alpha = 1;
    [UIView commitAnimations];
}

- (void) viewDidLoad{
    self.charLabels = [NSArray arrayWithObjects: char1, char2, char3, char4, char5, char6, char7, char8, char9, char10, nil];
    self.lineLabels = [NSArray arrayWithObjects: line1, line2, line3, line4, line5, line6,  line7, line8, line9, line10, nil];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:.4];
    for (int i=0; i < 10; i++){
        [(UILabel *)[charLabels objectAtIndex:i] setAlpha:0];
        [(UILabel *)[lineLabels objectAtIndex:i] setAlpha:0];
    }
    [UIView commitAnimations];
    [super viewDidLoad];
    [self newGame:@"testing"];
    [self lose];
}

@end
