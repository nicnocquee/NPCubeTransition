//
//  UIView+NPCubeTransition.h
//  NPCubeTransition
//
//  Created by Nico Prananta on 8/15/12.
//  Copyright (c) 2012 Nico Prananta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "CALayer+NPAnchorPosition.h"

#define PERSPECTIVE_LAYER @"PERSPECTIVE_LAYER"
#define IS_ANIMATING @"IS_ANIMATING"

typedef enum {
    CubeTransitionDirectionUp,
    CubeTransitionDirectionDown
} CubeTransitionDirection;

@interface UIView (NPCubeTransition)

+ (void)cubeTransitionFromView:(UIView *)view1 toView:(UIView *)view2 direction:(CubeTransitionDirection)direction;
+ (void)cubeTransitionFromView:(UIView *)view1 toView:(UIView *)view2 direction:(CubeTransitionDirection)direction duration:(float)duration;

@end
