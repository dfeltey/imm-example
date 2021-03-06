//
//  FAExampleController.m
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

#import "FAExampleController.h"
#import "FAModel.h"

#define TENSION_MIN		0.0
#define TENSION_MAX		100.0

#define DRAG_MIN		0.0
#define DRAG_MAX		10.0

#define POSITION_MIN	-100.0
#define POSITION_MAX	100.0

#define SPEED_MIN		-250.0
#define SPEED_MAX		250.0

@implementation FAExampleController

@synthesize tensionSlider;
@synthesize dragSlider;
@synthesize positionSlider;
@synthesize speedSlider;
@synthesize graphView;
@synthesize model;

- (void) dealloc
{
	[model release];
    [tensionSlider release];
    [dragSlider release];
    [positionSlider release];
    [speedSlider release];
	[graphView release];
	[super dealloc];
}

#pragma mark -
#pragma mark FAGraphViewDelegate

- (void) resetIterationForGraph: (FAGraphView *) graph
{
	[self.model reset];
}

- (double) nextValueForGraph: (FAGraphView *) graph
{
	return [self.model tick];
}

- (void) setSliders
{
	double		val;
	
#define SET_SLIDER(min, max, control, property) \
	val = self.model.property; \
	val = (val - min) / (max - min); \
	self.control.value = val;
	
	SET_SLIDER(TENSION_MIN, TENSION_MAX, tensionSlider, tension);
	SET_SLIDER(DRAG_MIN, DRAG_MAX, dragSlider, drag);
	SET_SLIDER(POSITION_MIN, POSITION_MAX, positionSlider, sZero);
	SET_SLIDER(SPEED_MIN, SPEED_MAX, speedSlider, sDotZero);
}

- (void) viewDidLoad
{
	[self setSliders];
}

#pragma mark -
#pragma mark IBAction

///	Repetitive content of the IBAction methods responding to the sliders.
///	Convert the slider's proportional value to the allowed range of the controlled
///	model property, set the model, and refresh the graph.
#define CHANGE_BODY(min, max, control, property) \
	double	value = min + [[self control] value] * (max - min); \
	self.model.property = value; \
	[self.graphView setNeedsDisplay];

- (IBAction) changeTension: (id) sender {
	CHANGE_BODY(TENSION_MIN, TENSION_MAX, tensionSlider, tension);
}

- (IBAction) changeDrag: (id) sender {
	CHANGE_BODY(DRAG_MIN, DRAG_MAX, dragSlider, drag);
}

- (IBAction) changeInitialPosition: (id) sender {
	CHANGE_BODY(POSITION_MIN, POSITION_MAX, positionSlider, sZero);
}

- (IBAction) changeInitialSpeed: (id) sender {
	CHANGE_BODY(SPEED_MIN, SPEED_MAX, speedSlider, sDotZero);
}


- (IBAction) doReset: (id) sender 
{
	[self.model zeroOut];
	[self setSliders];
	[self.graphView setNeedsDisplay];
}

@end
