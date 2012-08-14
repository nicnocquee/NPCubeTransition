//
//  CALayer+NPAnchorPosition.m
//  NPCubeTransition
//
//  Created by Nico Prananta on 8/15/12.
//  Copyright (c) 2012 Nico Prananta. All rights reserved.
//

#import "CALayer+NPAnchorPosition.h"

@implementation CALayer (NPAnchorPosition)

- (void)setAnchorPointWhileMaintainingPosition:(CGPoint)anchorPoint {
    [self setAnchorPoint:anchorPoint];
    [self setPosition:CGPointMake(self.position.x + self.bounds.size.width * (self.anchorPoint.x - 0.5), self.position.y + self.bounds.size.height * (self.anchorPoint.y - 0.5))];
}

@end
