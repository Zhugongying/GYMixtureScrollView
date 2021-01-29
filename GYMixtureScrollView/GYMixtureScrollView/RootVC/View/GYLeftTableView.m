//
//  GYLeftTableView.m
//  GYBaseKit
//
//  Created by zhugy781 on 2021/1/29.
//

#import "GYLeftTableView.h"

@implementation GYLeftTableView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (CGPathIsEmpty(self.path.CGPath)) {
        return YES;
    } else if (CGPathContainsPoint(self.path.CGPath, nil, point, nil)) {
        return YES;
    } else {
        return NO;
    }
}

@end
