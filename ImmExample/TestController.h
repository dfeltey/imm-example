//
//  TestController.h
//  ImmExample
//
//  Created by Sam Quinan on 4/14/11.
//  Copyright 2011 University of Chicago. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImExController.h"


@interface TestController : ImExController <UITextFieldDelegate>
{
    UILabel *label;
    UITextField *userInput;
    
}
//IB Outlets

@property (nonatomic, retain) IBOutlet UILabel *label;

@property (nonatomic, retain) IBOutlet UITextField *userInput;

//- (void)textFieldDidBeginEditing:(UITextField *)textField;

- (BOOL)textFieldShouldReturn:(UITextField *)textField;


@end
