//
//  AYPresentedViewController.swift
//  PresentationController
//
//  Created by Ayong on 16/6/7.
//  Copyright © 2016年 Ayong. All rights reserved.
//

import UIKit

class PresentedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blueColor()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        print("commoninit")
        self.modalPresentationStyle = .Custom
        self.transitioningDelegate = self
    }
}

extension PresentedViewController: UIViewControllerTransitioningDelegate {
    
    // 返回一个负责过渡的外观对象
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        if presented == self {
            return CustomPresentationController(presentedViewController: presented, presentingViewController: presenting)
        } else {
            return nil
        }
    }
}

