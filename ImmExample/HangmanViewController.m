//
//  HangmanViewController.m
//  ImmExample
//
//  Created by Sam Quinan on 4/18/11.
//  Copyright 2011 University of Chicago. All rights reserved.
//

#import "HangmanViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define WIN 1
#define LOSE -1


@implementation HangmanViewController

@synthesize view, game, hiddenItems, winScreen, loseScreen;
@synthesize charLabels, char1, char2, char3, char4, char5, char6, char7, char8, char9, char10;
@synthesize lineLabels, line1, line2, line3, line4, line5, line6, line7, line8, line9, line10;
@synthesize bodyParts, body1, body2, body3, body4, body5, body6;

- (void)dealloc {
    [super dealloc];
}

- (IBAction)buttonPress:(id)sender {
    
    if (gameEnded == NO){
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
        
        //check letter
        BOOL letterInWord = [game CheckLetter:[[sender titleLabel].text lowercaseString]];
        if (letterInWord == YES){
            [self reveal:[[sender titleLabel] text]];
        }
        else {
            //fade in next body part
            NSInteger index = [bodyParts count] - ([game remaining_guesses] + 1);// +1 b/c already decremented by CheckLetter call
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            [UIView setAnimationDuration:.4];
            [[bodyParts objectAtIndex:index] setAlpha:1];
            [UIView commitAnimations];
        }
        
    
        //check win/lose
        NSInteger win_lose = [game WinOrLose];
        switch (win_lose){
            case WIN:
                [self win];
                gameEnded = YES;
                break;
            case LOSE:
                [self lose];
                gameEnded = YES;
                break;
            default:
                break;
        }
    }
}

- (void)reset{
    [self resetKeyboard];
    //reset Labels
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:.4];
    for (int i=0; i < [game.wordToGuess count]; i++){
        [(UILabel *)[charLabels objectAtIndex:i] setAlpha:0];
        [(UILabel *)[lineLabels objectAtIndex:i] setAlpha:0];
    }
    [UIView commitAnimations];
    [self performSelector:@selector(newGame) withObject:nil afterDelay:.4];
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

-(void)newGame{
    [game NewGame];
    gameEnded = NO;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:.4];
    for (int i=0; i < 10; i++){
        if (i < [game.wordToGuess count]){
            [(UILabel *)[lineLabels objectAtIndex:i] setAlpha:1];
            [(UILabel *)[charLabels objectAtIndex:i] setText:[game.wordToGuess objectAtIndex:i]];
        }
    }
    [UIView commitAnimations];

}

-(void)reveal:(NSString *) ichar {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:.4];
    for (int i=0; i < [game.wordToGuess count]; i++){
        if ([ichar isEqualToString:(NSString *)[[game.wordToGuess objectAtIndex:i] uppercaseString]]){
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
    //fade out body if not faded out already (i.e. if you lost the game)
    if ([game WinOrLose] == LOSE){
        for (int i=0; i < [bodyParts count]; i++){
            [(UIImageView *)[bodyParts objectAtIndex:i] setAlpha: 0];
        }
    }
    winScreen.alpha = 0;
    loseScreen.alpha = 0;
    button.alpha = 0;
    [UIView commitAnimations];
    [self reset];
    [self performSelector:@selector(clearScreen:) withObject:button afterDelay:.4];
}

-(void)clearScreen:(UIButton *)button{
    [button removeFromSuperview];
}

-(void) win{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"New Game" forState:UIControlStateNormal];
    button.frame = CGRectMake(210.0, 50.0, 110.0, 43.0);
    button.backgroundColor = [UIColor clearColor];
    [button setTitleColor:UIColorFromRGB(0x457CAA) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    button.alpha = 0;
    [button addTarget:self action:@selector(newGameHandler:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    //fade in
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:1];
    for (int i=0; i < ([bodyParts count] - [game remaining_guesses]); i++){
        [(UIImageView *)[bodyParts objectAtIndex:i] setAlpha: 0];
    }
    winScreen.alpha = 1;
    button.alpha = 1;
    [UIView commitAnimations];
}


-(void) lose{
    //add button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"New Game" forState:UIControlStateNormal];
    button.frame = CGRectMake(210.0, 50.0, 110.0, 43.0);
    button.backgroundColor = [UIColor clearColor];
    [button setTitleColor:UIColorFromRGB(0x457CAA) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    button.alpha = 0;
    [button addTarget:self action:@selector(newGameHandler:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
     
    //fade in missed letters
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:.4];
    for (int i=0; i < [game.wordToGuess count]; i++){
        [(UILabel *)[charLabels objectAtIndex:i] setAlpha:1];
    }
    [UIView commitAnimations];
    //fade in lose screen
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:1.5];
    loseScreen.alpha = 1;
    button.alpha = 1;
    [UIView commitAnimations];
}

- (void) viewDidLoad{
    self.charLabels = [NSArray arrayWithObjects: char1, char2, char3, char4, char5, char6, char7, char8, char9, char10, nil];
    self.lineLabels = [NSArray arrayWithObjects: line1, line2, line3, line4, line5, line6,  line7, line8, line9, line10, nil];
    self.bodyParts = [NSArray arrayWithObjects: body1, body2, body4, body3, body6, body5, nil];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:.4];
    for (int i=0; i < 10; i++){
        [(UILabel *)[charLabels objectAtIndex:i] setAlpha:0];
        [(UILabel *)[lineLabels objectAtIndex:i] setAlpha:0];
    }
    [UIView commitAnimations];
    [super viewDidLoad];
    [game StartGame];
    [self newGame];
}

@end
