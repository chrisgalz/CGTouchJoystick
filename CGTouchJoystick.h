//
//  CGTouchJoystick.h
//  
//
//  Created by Chris Galzerano on 9/13/15.
//
//

#import <UIKit/UIKit.h>

@protocol CGTouchJoystickDelegate <NSObject>

- (void)joystickAccelerationUpdate:(CGFloat)x andY:(CGFloat)y;

@end

@interface CGTouchJoystick : UIView

@property (nonatomic, assign) id<CGTouchJoystickDelegate> delegate;

@end
