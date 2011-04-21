//
//  ImmExampleViewController.m
//  ImmExample
//
//  Created by Fritz Anderson on 4/7/11.
//  Copyright 2011 Trustees of the University of Chicago. All rights reserved.
//

//	This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported license.
//	If you use this work (use must be consistent with the license), include the following language
//	in a user-accessible view, either in the application itself; in a panel in a Settings bundle identified
//	with your work; or in distribution labeling (such as package copy or App Store descriptions) that must
//	inevitably be seen by the end user:
///////////////////////////////////////////
//	Portions are copyright by the University of Chicago, and licensed under the Creative Commons
//	Attribution-NonCommercial-ShareAlike 3.0 Unported license. For details, see 
//	http://creativecommons.org/licenses/by-nc-sa/3.0/ and links therefrom.
//	The University of Chicago has provided its work on an "AS-IS" basis, and its work comes with
//	ABSOLUTELY NO WARRANTY, INCLUDING THOSE OF MERCHANTABILITY OR FITNESS FOR ANY PURPOSE.


#import "ImmExampleViewController.h"
#import "ImExController.h"

NSArray *		gExampleControllerNames	= nil;

@interface ImmExampleViewController ()
///	An array of ImExController objects.
@property(nonatomic, retain) NSMutableArray *			controllers;
@end


@implementation ImmExampleViewController
@synthesize scrollView;
@synthesize controllers;

+ (void) initialize
{
	//	On first reference to this class, fill the global array of controller class names.
	if (! gExampleControllerNames) {
		gExampleControllerNames = [[NSArray alloc] initWithObjects:
							   @"FAExampleController",
                               @"HangmanViewController",
							   @"MZNHController",
							   nil];
	}
}

- (void) dealloc
{
	[scrollView release];
	[controllers release];
    [super dealloc];
}

- (void) didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) viewDidLoad
{
    [super viewDidLoad];
	
	self.controllers = [NSMutableArray array];
	
	CGRect			totalContentRect = self.scrollView.bounds;
	totalContentRect.size.height = 0;
	
	for (NSString * name in gExampleControllerNames) {
		//	Instantiate each controller from its name.
		Class				controllerClass = NSClassFromString(name);
		NSAssert2(controllerClass, @"%s: Can't get class %@", __PRETTY_FUNCTION__, name);
		ImExController *	controller = [[controllerClass alloc] init];
		
		//	Calculate the view's size and position in the scroller.
		CGRect				viewFrame = controller.view.frame;
		viewFrame.origin.x = CGRectGetMinX(totalContentRect);
		viewFrame.origin.y = CGRectGetMaxY(totalContentRect);
		viewFrame.size.width = totalContentRect.size.width;
		
		//	Set the size and position and add the view to the scroller.
		controller.view.frame = viewFrame;
		[self.scrollView addSubview: controller.view];
		
		//	Increment the bounding rectangle.
		totalContentRect.size.height = CGRectGetMaxY(viewFrame);
		[self.controllers addObject: controller];
		[controller release];
	}
	//	Make the scrolling area correspond to the bounding rect.
	self.scrollView.contentSize = totalContentRect.size;
}

- (void) viewDidUnload
{
	self.controllers = nil;
	[self setScrollView:nil];
    [super viewDidUnload];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
