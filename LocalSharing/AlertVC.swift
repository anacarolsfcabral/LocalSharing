//
//  AlertVC.swift
//  LocalSharing
//
//  Created by Ana Carolina Cabral on 01/04/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class AlertVC : UIViewController
{
 
    override func viewDidLoad()
    {
        let alertViewWidth: CGFloat = 250
        let alertViewHeight: CGFloat = 200
        
        var alertView: CGRect = CGRectMake((view.frame.size.width - alertViewWidth) * 0.5, ((view.frame.size.height - alertViewHeight) * 0.5) - 80, alertViewWidth, alertViewHeight)
        var screen: UIView = UIView(frame: alertView)
        screen.layer.cornerRadius = 10
        screen.backgroundColor = UIColor.greenColor()
     
        var button   = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.frame = CGRectMake((screen.frame.size.width - 30) * 0.5, (screen.frame.size.height - 30) * 0.5, 30, 30)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.redColor()
        button.setTitle("Ok", forState: UIControlState.Normal)
        button.addTarget(self, action: "Action:", forControlEvents: UIControlEvents.TouchUpInside)
        screen.addSubview(button)
        
//        screen.backgroundColor = UIColor(red: 235, green: 241, blue: 240, alpha: 1)
        
        view.addSubview(screen)
//        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[screen]-|", options: nil, metrics: nil, views: ["screen": screen]))
    }
    

}

