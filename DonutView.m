//
//  DonutView.m
//
//  Created by Mecklenburg, William on 1/7/16.
//  Copyright © 2016 Capital One. All rights reserved.
//

#import "DonutView.h"

@implementation DonutView {
    CGFloat _x;
    CGFloat _y;
    UIBezierPath* _path;
}


+ (Class)layerClass
{
    return [CAShapeLayer class];
}


- (void) createRing:(CGFloat) x andY:(CGFloat) y {
    _x = x;
    _y = y;
    CGRect smallBounds = CGRectMake(x - 10, y - 10, 20, 20);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:smallBounds];
    _path = path;
    
    CAShapeLayer *layer = (id)self.layer;
    [layer setPath:path.CGPath];
    [layer setStrokeColor:[UIColor redColor].CGColor];
    [layer setFillColor:[UIColor clearColor].CGColor];
    [layer setLineWidth:10];
    [layer setOpacity:0.0];
}

- (void) addAnimations {
    CGRect largeBounds = CGRectMake(_x - 20, _y - 20, 40, 40);
    
    CAAnimationGroup *animations = [CAAnimationGroup animation];
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.fromValue = (__bridge id _Nullable)([_path CGPath]);
    anim.toValue = (__bridge id _Nullable)([[UIBezierPath bezierPathWithOvalInRect:largeBounds] CGPath]);
    anim.autoreverses = NO;
    anim.duration = 0.25;
    
    CABasicAnimation *fadeInAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeInAnim.fromValue = [NSNumber numberWithFloat:0.0];
    fadeInAnim.toValue = [NSNumber numberWithFloat:0.3];
    fadeInAnim.autoreverses = YES;
    fadeInAnim.duration = 0.12;
    
    animations.animations = [NSArray arrayWithObjects:anim, fadeInAnim, nil];
    animations.removedOnCompletion = NO;
    animations.duration = 0.24;
    animations.fillMode  = kCAFillModeForwards;
    
    animations.delegate = self;
    
    [self.layer addAnimation:animations forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        [self removeFromSuperview];
    }
}


@end
