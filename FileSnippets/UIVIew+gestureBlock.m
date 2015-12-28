//
//  UIView+gestureBlock.m
//
//  Created by DengJinlong on 12/7/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import "UIView+gestureBlock.h"
#import <objc/runtime.h>

static void *kAssociatedKey = &kAssociatedKey;

#pragma mark - block wrapper

@interface UIGestureBlockWrapper : NSObject

@property (copy, nonatomic) GestureBlock block;

- (void)handleGesture:(id)gesture;

@end

@implementation UIGestureBlockWrapper

- (void)handleGesture:(id)gesture {
    if (self.block) {
        self.block(gesture);
    } else {
        NSLog(@"%s block should not be nil",__FUNCTION__);
    }
}

@end

#pragma mark - catogery imp

@implementation UIView (gestureBlock)

- (void)addGesture:(UIGestureRecognizer *)gesture action:(GestureBlock)action {
    if (!action) {
        NSLog(@"%s block should not be nil",__FUNCTION__);
        return;
    }
    
    self.userInteractionEnabled = YES;
    
    UIGestureBlockWrapper *wrapper = [UIGestureBlockWrapper new];
    wrapper.block = action;
    
    [gesture addTarget:wrapper action:@selector(handleGesture:)];
    [self addGestureRecognizer:gesture];
    objc_setAssociatedObject(self, kAssociatedKey, wrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)addPanGestureWithAction:(GestureBlock)action {
    UIPanGestureRecognizer *panGesture = [UIPanGestureRecognizer new];
    [self addGesture:panGesture action:action];
}

- (void)addTapGestureWithAction:(GestureBlock)action {
    UITapGestureRecognizer *tapGesture = [UITapGestureRecognizer new];
    [self addGesture:tapGesture action:action];
}

- (void)addDoubleTapGestureWithAction:(GestureBlock)action {
    UITapGestureRecognizer *tapGesture = [UITapGestureRecognizer new];
    tapGesture.numberOfTapsRequired = 2;
    [self addGesture:tapGesture action:action];
}

- (void)addTapGestureWithTouches:(NSUInteger)touches action:(GestureBlock)action {
    UITapGestureRecognizer *tapGesture = [UITapGestureRecognizer new];
    tapGesture.numberOfTouchesRequired = touches;
    [self addGesture:tapGesture action:action];
}

- (void)addPanGestureWithMiniTouches:(NSUInteger)touches action:(GestureBlock)action {
    UIPanGestureRecognizer *panGesture = [UIPanGestureRecognizer new];
    panGesture.minimumNumberOfTouches = touches;
    [self addGesture:panGesture action:action];
}

@end
