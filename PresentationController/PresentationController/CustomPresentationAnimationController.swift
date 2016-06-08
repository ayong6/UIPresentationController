//
//  CustomPresentationAnimationController.swift
//  PresentationController
//
//  Created by Ayong on 16/6/8.
//  Copyright © 2016年 Ayong. All rights reserved.
//

import UIKit

class CustomPresentationAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    let isPresenting: Bool
    let duration: NSTimeInterval = 0.5
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }
    
    // 过渡动画执行时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    // 过渡动画效果
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        if isPresenting {
            animatePresentationWithTransitionContext(transitionContext)
        } else {
            animateDismissWithTransitionContext(transitionContext)
        }
    }
    
    // MARK - 内部实现方法
    
    private func animatePresentationWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let presentedController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            let presentedControllerView = transitionContext.viewForKey(UITransitionContextToViewKey),
            let containerView = transitionContext.containerView()
        else {
            return
        }
        
        // 定位被呈现的view一开始位置，在屏幕顶部
        presentedControllerView.frame = transitionContext.finalFrameForViewController(presentedController)
        presentedControllerView.center.y -= containerView.bounds.size.height
        
        containerView.addSubview(presentedControllerView)
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .AllowUserInteraction, animations: { 
            presentedControllerView.center.y += containerView.bounds.size.height
        
        }) { (completed: Bool) in
            // 完成一定要调用此方法告诉系统动画完成
            transitionContext.completeTransition(completed)
        }
    }
    
    private func animateDismissWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            // 这里的key要注意是UITransitionContextFromViewKey，因为当被呈现的控制器呈现出来后，当前的控制器的view相对的就是fromViewKey。
            let presentedControllerView = transitionContext.viewForKey(UITransitionContextFromViewKey),
            let containerView = transitionContext.containerView()
        else {
            return
        }
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .AllowUserInteraction, animations: {
                presentedControllerView.center.y += containerView.bounds.size.height
            
            }) { (completed) in
                transitionContext.completeTransition(completed)
        }
    }
}
