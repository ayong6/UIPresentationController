//
//  ViewController.swift
//  PresentationController
//
//  Created by Ayong on 16/6/7.
//  Copyright © 2016年 Ayong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        
    }

    @IBAction func buttomClick(sender: UIButton) {
        self.presentViewController(PresentedViewController(), animated: true, completion: nil)
    }
}



