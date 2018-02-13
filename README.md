# CGTouchJoystick

1. Import CGTouchJoystick.h
2. Add CGTouchJoystickDelegate to your class's supported delegates
3. Create an instance of CGTouchJoystick using the typical alloc/initWithFrame like any UIView
4. Set your frame, make sure the width and height are the same to get a view that looks correct
5. Set the delegate of the joystick
6. Add the delegate method defined in the header, which will return the acceleration of the joystick in the X and Y coordinates every update to touches

Works great with side-scroller games
