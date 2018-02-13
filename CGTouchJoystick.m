//
//  CGTouchJoystick.m
//  
//
//  Created by Chris Galzerano on 9/13/15.
//
//

#import "CGTouchJoystick.h"

@interface CGTouchJoystick () <UIGestureRecognizerDelegate>

@end

@implementation CGTouchJoystick {
    UIView *containerView;
    UIView *joystickKnob;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat containerSize = frame.size.width/1.5f;
        
        containerView = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width-containerSize)/2.0f, (self.frame.size.height-containerSize)/2.0f, containerSize, containerSize)];
        containerView.layer.cornerRadius = containerSize/2.0f;
        containerView.layer.masksToBounds = NO;
        containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5f];
        //containerView.center = CGPointMake(self.frame.size.width/2.0f, self.frame.size.height/2.0f);
        [self addSubview:containerView];
        
        joystickKnob = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerSize/2.0f, containerSize/2.0f)];
        joystickKnob.layer.cornerRadius = containerSize/4.0f;
        joystickKnob.layer.masksToBounds = YES;
        joystickKnob.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
        joystickKnob.center = containerView.center;
        [self addSubview:joystickKnob];
        
        [NSTimer scheduledTimerWithTimeInterval:1/60.0f target:self selector:@selector(updateJoystick) userInfo:nil repeats:YES];
        
        
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
}

- (CGPoint)formatTouchLocation:(CGPoint)point {
    CGFloat x = point.x;
    CGFloat y = point.y;
    if (x < 0) x = 0;
    if (x > self.frame.size.width) x = self.frame.size.width;
    if (y < 0) y = 0;
    if (y > self.frame.size.height) y = self.frame.size.height;
    return CGPointMake(x, y);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = touches.anyObject;
    CGPoint touchLocation = [touch locationInView:self];
    joystickKnob.center = [self formatTouchLocation:touchLocation];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    [self touchesStopped];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self touchesStopped];
}

- (void)touchesStopped {
    [UIView animateWithDuration:0.3 animations:^{
        joystickKnob.center = containerView.center;
    }];
}

- (void)updateJoystick {
    CGFloat difference = self.frame.size.width/2.0f;
    CGFloat accelerationX = (joystickKnob.center.x-difference)/difference;
    CGFloat accelerationY = ((joystickKnob.center.y*-1)+difference)/difference;
    if ([self.delegate respondsToSelector:@selector(joystickAccelerationUpdate:andY:)])
        [self.delegate joystickAccelerationUpdate:accelerationX andY:accelerationY];
}

@end
