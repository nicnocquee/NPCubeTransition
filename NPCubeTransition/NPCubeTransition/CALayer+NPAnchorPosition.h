//
//  CALayer+NPAnchorPosition.h
//  NPCubeTransition
//
//  Created by Nico Prananta on 8/15/12.
//  Copyright (c) 2012 Nico Prananta. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (NPAnchorPosition)

- (void)setAnchorPointWhileMaintainingPosition:(CGPoint)anchorPoint;

@end
