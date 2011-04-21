//
//  HangmanGame.m
//  DFHangman
//
//  Created by Daniel Feltey on 4/19/11.
//  Copyright 2011 University of Chicago. All rights reserved.
//

#import "HangmanGame.h"
#import <stdlib.h>
#import <time.h>

@implementation HangmanGame
@synthesize wordToGuess, remaining_guesses;

-(void) StartGame
{
    
    
     srandom((unsigned) time(NULL));
    
     NSString *filepath = [[NSBundle mainBundle] pathForResource:@"hangmanwords" ofType:@"txt"];
     NSError *error;
     NSString *all_words = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
     if (all_words == nil) NSAssert(NO,  @"%s: invalid file", NSStringFromSelector(_cmd));
     
    word_list = [[all_words componentsSeparatedByString:@"\n"] retain];
    unsigned long num_words = [word_list count];
    word = [word_list objectAtIndex:random()%num_words];
    
    remaining = [[NSMutableSet alloc] init];
    for (int i=0; i< [word length]; i++)
    {
        [remaining addObject:[word substringWithRange:NSMakeRange(i,1)]];
    }
    
    remaining_guesses = 6;
    
    wordToGuess = [[NSMutableArray alloc]initWithCapacity:[word length]];
    for(int i=0;i<[word length];i++)
    {
        [wordToGuess insertObject:[word substringWithRange:NSMakeRange(i,1)] atIndex:i];
    }
    
    
    
  //  NSString *all_words = [[NSString alloc] initWithContentsOfFile:@"words"];
    
    
    
    
    
 /*   show_word = [NSMutableString stringWithCapacity:[word length]];
    for (int i =0; i<[word length];i++)
    {
        [show_word insertString:@"-" atIndex:i]; 
    }*/    
    
    
    
    
}

-(void) NewGame
{
    unsigned long num_words = [word_list count];
    word = [word_list objectAtIndex:random()%num_words];
    remaining_guesses = 6;
    [remaining removeAllObjects];
    for (int i=0; i< [word length]; i++)
    {
        [remaining addObject:[word substringWithRange:NSMakeRange(i,1)]];
    }
    
    [wordToGuess removeAllObjects];
    for (int i=0;i<[word length]; i++) {
        [wordToGuess    addObject:[word substringWithRange:NSMakeRange(i,1)]];
    }
    
    /*show_word = [NSMutableString stringWithCapacity:[word length]];
    for (int i =0; i<[word length];i++)
    {
        [show_word insertString:@"-" atIndex:i]; 
    }*/
    
}

-(BOOL) CheckLetter:(NSString *)letter
{
    if([remaining containsObject:letter])
    {
        [remaining removeObject:letter];
        /*for(int i=0;i<[word length];i++)
        {
            if ([letter characterAtIndex:0] == [word characterAtIndex:i])
            {
                [show_word replaceCharactersInRange:NSMakeRange(i,1) withString:letter];   
            }
        }*/
        return YES;
    }
    
    else 
    {
        remaining_guesses--;
        return NO;
    }
    
}

-(int) WinOrLose
{
    if ([remaining count] == 0)
        return 1;
    else if(remaining_guesses == 0)
        return  -1;
    else
        return 0;
}

- (void)dealloc {
    [wordToGuess release];
    [word_list release];
    [remaining release];
    [super dealloc];
}


@end
