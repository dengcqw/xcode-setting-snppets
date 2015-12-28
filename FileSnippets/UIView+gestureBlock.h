//
//  UIView+gestureBlock.h
//
//  Created by DengJinlong on 12/7/14.
//  Copyright (c) 2014 . All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GestureBlock)(id gesture);

@interface UIView (gestureBlock)

/**
 *  @brief  添加带代码块的一个手势
 *
 *  @param gesture 要添加到当前视图的手势
 *  @param action  要执行的代码块
 */
- (void)addGesture:(UIGestureRecognizer *)gesture action:(GestureBlock)action;
/**
 *  @brief  单指划动
 */
- (void)addPanGestureWithAction:(GestureBlock)action;
/**
 *  @brief  单指触摸
 */
- (void)addTapGestureWithAction:(GestureBlock)action;
/**
 *  @brief  单指连击两次
 */
- (void)addDoubleTapGestureWithAction:(GestureBlock)action;
/**
 *  @brief  多指同时触摸
 *
 *  @param touches 手指数
 */
- (void)addTapGestureWithTouches:(NSUInteger)touches action:(GestureBlock)action;
/**
 *  @brief  多指同时划动
 *
 *  @param touches 至少需要的手指数
 */
- (void)addPanGestureWithMiniTouches:(NSUInteger)touches action:(GestureBlock)action;

@end
