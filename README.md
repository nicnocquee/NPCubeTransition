Requirement: **iOS 6**

**Screenshot**

![](http://f.cl.ly/items/1m0S2N102f0L3b1M3U1T/Screen%20Shot%202012-08-15%20at%201.07.33%20AM.png)

**How to use**

1. Add folder NPCubeTransition to your project in XCode.
2. Link binary with QuartzCore.framework
3. 		#import "UIView+NPCubeTransition.h"
4. Add this line in your code to animate

		[UIView cubeTransitionFromView:view1 toView:view2 direction:direction];
		
where direction can be either `CubeTransitionDirectionUp` or `CubeTransitionDirectionDown`.