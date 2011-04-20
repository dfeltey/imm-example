//
//  TestController.m
//  ImmExample
//
//  Created by Sam Quinan on 4/14/11.
//  Copyright 2011 University of Chicago. All rights reserved.
//

#import "TestController.h"


@implementation TestController

@synthesize label, userInput;

- (void)dealloc {
    [label release];
    [userInput release];
    [super dealloc];
}

/*
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    // update label to reflect contents of userInput
    label.text = textField.text;
    [textField resignFirstResponder];
    return YES;
}

@end
