//
//  NPViewController.h
//  NPCubeTransition
//
//  Created by Nico Prananta on 8/15/12.
//  Copyright (c) 2012 Nico Prananta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *redLabel;
@property (weak, nonatomic) IBOutlet UILabel *blueLabel;
- (IBAction)buttonPressed:(id)sender;

@end
