//
//  AYPresentationController.swift
//  PresentationController
//
//  Created by Ayong on 16/6/7.
//  Copyright © 2016年 Ayong. All rights reserved.
//

import UIKit

class CustomPresentationController: UIPresentationController {
    
    lazy var dimmingView: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.redColor()
        btn.alpha = 0
        return btn
    }()
    
    override func presentationTransitionWillBegin() {
 
        guard
            let containerView = containerView
        else {
            return
        }
        
        dimmingView.frame = containerView.bounds
        dimmingView.addTarget(self, action: #selector(self.btnClick), forControlEvents: .TouchUpInside)
        
        // 将透明btnView添加到容器视图中
        containerView.addSubview(dimmingView)
        
        // 通过使用「负责呈现」的 controller 的 UIViewControllerTransitionCoordinator，我们可以确保我们的动画与其他动画一快播放。
        if let transitionCoordinator =  presentingViewController.transitionCoordinator() {
            transitionCoordinator.animateAlongsideTransition({ (context: UIViewControllerTransitionCoordinatorContext!) in
                self.dimmingView.alpha = 0.5
            }, completion: nil)
        }
    }
    
    override func presentationTransitionDidEnd(completed: Bool) {
        // 如果呈现没有完成，就移除背景view
        if !completed {
            print("呈现没有完成")
            dimmingView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        // 与过渡效果一起执行背景view的淡出效果
        if let transitionCoordinator = presentingViewController.transitionCoordinator() {
            transitionCoordinator.animateAlongsideTransition({ (context) in
                self.dimmingView.alpha = 0
            }, completion: nil)
        }
    }
    
    override func dismissalTransitionDidEnd(completed: Bool) {
        // 如果消失没有完成，那么把背景view移除
        if !completed {
            print("消失没有完成")
            dimmingView.removeFromSuperview()
        }
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        
        guard
            let containerView = containerView
        else {
            print("获取不到")
            return CGRect()
        }
        
        var frame = containerView.bounds
        frame = CGRectInset(frame, 50, 200)
        
        return frame
    }
    
    // MARK: - 内部方法实现
    @objc private func btnClick() {
        self.presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
