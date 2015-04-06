//
//  AlertVC.swift
//  LocalSharing
//
//  Created by Ana Carolina Cabral on 01/04/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

//import UIKit
//
//class AlertVC : UIViewController
//{
// 
//    override func viewDidLoad()
//    {
//        
//        let alertViewWidth: CGFloat = 250
//        let alertViewHeight: CGFloat = 200
//        
//        var alertView: CGRect = CGRectMake((view.frame.size.width - alertViewWidth) * 0.5, ((view.frame.size.height - alertViewHeight) * 0.5) - 80, alertViewWidth, alertViewHeight)
//        var screen: UIView = UIView(frame: alertView)
//        screen.layer.cornerRadius = 10
//        screen.layer.borderColor = UIColor(red: 41.0/255, green: 166.0/255, blue: 117.0/255, alpha: 1.0).CGColor
//        screen.layer.borderWidth = 3
//        screen.backgroundColor = UIColor(red: 235.0/255, green: 241.0/255, blue: 240.0/255, alpha: 0.95)
//        
//        var alertViewUpperPart: CGRect = CGRectMake((screen.frame.size.width - alertViewWidth) * 0.5, 0.0, alertViewWidth, alertViewHeight * 0.20)
//        var screenUpperPart: UIView = UIView(frame: alertViewUpperPart)
//        screenUpperPart.backgroundColor = UIColor(red: 41.0/255, green: 166.0/255, blue: 117.0/255, alpha: 1.0)
//        screenUpperPart.layer.cornerRadius = 10
//        
//        var alertViewUpperPartBackground: CGRect = CGRectMake((screen.frame.size.width - alertViewWidth) * 0.5 + 2.5, 7.0, alertViewWidth - 5.0, alertViewHeight * 0.20 - 7.0)
//        var screenUpperPartBackground: UIView = UIView(frame: alertViewUpperPartBackground)
//        screenUpperPartBackground.backgroundColor = UIColor(red: 41.0/255, green: 166.0/255, blue: 117.0/255, alpha: 1.0)
//     
//        var alertLabelTitle: UILabel = UILabel()
//        alertLabelTitle.frame = CGRectMake(100, 100, 200, 21)
//        alertLabelTitle.backgroundColor = UIColor.purpleColor()
//        alertLabelTitle.textColor = UIColor.whiteColor()
//        alertLabelTitle.textAlignment = NSTextAlignment.Center
//        alertLabelTitle.text = "Ops!"
//        alertLabelTitle.font = UIFont.boldSystemFontOfSize(16.0)
//        
//        var alertLabelText: UILabel = UILabel()
//        alertLabelText.frame = CGRectMake(50, 50, 300, 21)
//        alertLabelText.backgroundColor = UIColor.blueColor()
//        alertLabelText.textColor = UIColor.whiteColor()
//        alertLabelText.textAlignment = NSTextAlignment.Center
//        alertLabelText.text = "Você esqueceu de preencher o item!"
//        
//        var okButton   = UIButton.buttonWithType(UIButtonType.System) as UIButton
//        okButton.frame = CGRectMake((screen.frame.size.width - 30) * 0.5, (screen.frame.size.height - 30) * 0.5, 30, 30)
//        okButton.layer.cornerRadius = 10
//        okButton.backgroundColor = UIColor.redColor()
//        okButton.setTitle("Ok", forState: UIControlState.Normal)
//        okButton.addTarget(self, action: "Action:", forControlEvents: UIControlEvents.TouchUpInside)
//        
//        view.addSubview(screen)
//        screen.addSubview(screenUpperPartBackground)
//        screen.addSubview(screenUpperPart)
//        screen.addSubview(alertLabelTitle)
//        screen.addSubview(alertLabelText)
//        screen.addSubview(okButton)
//        
//    }
//    
    var alert = UIAlertController(title: "Ops!", message: "Você esqueceu de preencher o item!", preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
    self.presentViewController(alert, animated: true, completion: nil)

//
//}

