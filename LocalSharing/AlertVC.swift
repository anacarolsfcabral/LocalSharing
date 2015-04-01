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
        var alertView: CGRect = CGRectMake(view.frame.size.width/2-125, view.frame.size.height/2-160, 250, 200)
        var screen: UIView = UIView(frame: alertView)
        screen.layer.cornerRadius = 10
        screen.backgroundColor = UIColor.greenColor()
     
        var button   = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.frame = CGRectMake(100, 100, 100, 50)
        button.backgroundColor = UIColor.redColor()
        button.setTitle("Button", forState: UIControlState.Normal)
        button.addTarget(self, action: "Action:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
//        screen.backgroundColor = UIColor(red: 235, green: 241, blue: 240, alpha: 1)
        
        view.addSubview(screen)
//        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[screen]-|", options: nil, metrics: nil, views: ["screen": screen]))
    }
    

}

