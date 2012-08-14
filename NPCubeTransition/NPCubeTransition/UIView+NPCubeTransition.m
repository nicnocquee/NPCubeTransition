//
//  UIView+NPCubeTransition.m
//  NPCubeTransition
//
//  Created by Nico Prananta on 8/15/12.
//  Copyright (c) 2012 Nico Prananta. All rights reserved.
//

#import "UIView+NPCubeTransition.h"

@implementation UIView (NPCubeTransition)

+ (void)cubeTransitionFromView:(UIView *)view1 toView:(UIView *)view2 direction:(CubeTransitionDirection)direction duration:(float)duration {
    if ([[view1.layer valueForKey:IS_ANIMATING] boolValue] || [[view2.layer valueForKey:IS_ANIMATING] boolValue]) {
        return;
    }
    [view1.layer setValue:@YES forKey:IS_ANIMATING];
    [view2.layer setValue:@YES forKey:IS_ANIMATING];
    
    [view1 setHidden:NO];
    [view2 setHidden:NO];
    UIGraphicsBeginImageContext(view1.frame.size);
    [[view1 layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *view1Image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(view2.frame.size);
    [[view2 layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *view2Image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [view1 setHidden:YES];
    [view2 setHidden:YES];
    
    UIView *view1Copy = [[UIView alloc] initWithFrame:view1.bounds];
    [view1Copy setBackgroundColor:[UIColor colorWithPatternImage:view1Image]];
    UIView *view2Copy = [[UIView alloc] initWithFrame:view2.bounds];
    [view2Copy setBackgroundColor:[UIColor colorWithPatternImage:view2Image]];
    
    for (CALayer *sublayer in view1.superview.layer.sublayers) {
        if ([sublayer.name isEqualToString:PERSPECTIVE_LAYER]) {
            [sublayer removeAllAnimations];
            [sublayer removeFromSuperlayer];
            break;
        }
    }
    
    CALayer *perspectiveLayer = [CALayer layer];
    [perspectiveLayer setName:PERSPECTIVE_LAYER];
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/200.0;
    perspectiveLayer.sublayerTransform = transform;
    perspectiveLayer.frame = view1.frame;
    [view1.superview.layer addSublayer:perspectiveLayer];
    
    CATransformLayer *firstJointLayer = [CATransformLayer layer];
    [firstJointLayer setFrame:view1Copy.bounds];
    [perspectiveLayer addSublayer:firstJointLayer];
    [firstJointLayer addSublayer:view1Copy.layer];
    [firstJointLayer setAnchorPointWhileMaintainingPosition:(direction == CubeTransitionDirectionUp)?CGPointMake(0.5, 1.f):CGPointMake(0.5, 0.f)];
    
    CATransformLayer *secondJointLayer = [CATransformLayer layer];
    [secondJointLayer setFrame:view2Copy.bounds];
    [perspectiveLayer addSublayer:secondJointLayer];
    [secondJointLayer addSublayer:view2Copy.layer];
    
    CGRect frame = secondJointLayer.frame;
    if (direction == CubeTransitionDirectionDown) {
        frame.origin.y = firstJointLayer.frame.origin.y - frame.size.height;
        frame.origin.x = firstJointLayer.frame.origin.x;
    } else if (direction == CubeTransitionDirectionUp) {
        frame.origin.y = firstJointLayer.frame.origin.y + firstJointLayer.frame.size.height;
        frame.origin.x = firstJointLayer.frame.origin.x;
    }
    secondJointLayer.frame = frame;
    
    view2.frame = view1.frame;
    
    [secondJointLayer setAnchorPointWhileMaintainingPosition:(direction == CubeTransitionDirectionDown)?CGPointMake(0.5, 1.f):CGPointMake(0.5, 0.f)];
    
    double rotation = M_PI/2;
    CABasicAnimation* animation ;
    
    animation = [CABasicAnimation animationWithKeyPath:@"sublayerTransform.translation.y"];
    [animation setDuration:duration];
    [animation setAutoreverses:NO];
    [animation setRepeatCount:1];
    [animation setFromValue:[NSNumber numberWithDouble:0]];
    [animation setToValue:[NSNumber numberWithDouble:(direction==CubeTransitionDirectionDown)?CGRectGetHeight(view1Copy.frame):-CGRectGetHeight(view1Copy.frame)]];
    animation.removedOnCompletion = NO;
    animation.fillMode = (direction==CubeTransitionDirectionDown)?kCAFillModeRemoved:kCAFillModeForwards;
    [firstJointLayer addAnimation:animation forKey:nil];
    
    animation = [CABasicAnimation animationWithKeyPath:@"sublayerTransform.rotation.x"];
    [animation setDuration:duration];
    [animation setAutoreverses:NO];
    [animation setRepeatCount:1];
    [animation setFromValue:[NSNumber numberWithDouble:0]];
    [animation setToValue:[NSNumber numberWithDouble:(direction==CubeTransitionDirectionDown)?-rotation:rotation]];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [firstJointLayer addAnimation:animation forKey:nil];
    
    animation = [CABasicAnimation animationWithKeyPath:@"sublayerTransform.rotation.x"];
    [animation setDuration:duration];
    [animation setAutoreverses:NO];
    [animation setRepeatCount:1];
    [animation setFromValue:[NSNumber numberWithDouble:(direction==CubeTransitionDirectionDown)?rotation:-rotation]];
    [animation setToValue:[NSNumber numberWithDouble:0]];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [secondJointLayer addAnimation:animation forKey:nil];
    
    animation = [CABasicAnimation animationWithKeyPath:@"sublayerTransform.translation.y"];
    [animation setDuration:duration];
    [animation setAutoreverses:NO];
    [animation setRepeatCount:1];
    [animation setFromValue:[NSNumber numberWithDouble:0]];
    [animation setToValue:[NSNumber numberWithDouble:(direction==CubeTransitionDirectionDown)?CGRectGetHeight(view2Copy.frame):-CGRectGetHeight(view2Copy.frame)]];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [secondJointLayer addAnimation:animation forKey:nil];
    
    int64_t delayInSeconds = duration+0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [view2 setHidden:NO];
        [view1.layer setValue:@NO forKey:IS_ANIMATING];
        [view2.layer setValue:@NO forKey:IS_ANIMATING];
        [perspectiveLayer removeFromSuperlayer];
    });
}

+ (void)cubeTransitionFromView:(UIView *)view1 toView:(UIView *)view2 direction:(CubeTransitionDirection)direction {
    [self cubeTransitionFromView:view1 toView:view2 direction:direction duration:0.5];
}

@end
