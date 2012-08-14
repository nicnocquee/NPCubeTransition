//
//  NPViewController.m
//  NPCubeTransition
//
//  Created by Nico Prananta on 8/15/12.
//  Copyright (c) 2012 Nico Prananta. All rights reserved.
//

#import "NPViewController.h"
#import "UIView+NPCubeTransition.h"

@interface NPViewController () {
    BOOL alternate;
}

@end

@implementation NPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    UIButton *button = (UIButton *)sender;
    CubeTransitionDirection direction = CubeTransitionDirectionDown;
    if (button.tag == 12) {
        direction = CubeTransitionDirectionUp;
    }
    
    [UIView cubeTransitionFromView:(alternate)?self.redLabel:self.blueLabel toView:(alternate)?self.blueLabel:self.redLabel direction:direction];
    alternate = !alternate;
}
@end
