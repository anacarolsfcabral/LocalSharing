//
//  RequestTVCell.swift
//  LocalSharing
//
//  Created by Ana Carolina Cabral on 17/03/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class RequestTVCell: UITableViewCell, UITextFieldDelegate
{
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPicture: UIImageView!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        //userPicture = self.imageViewShapedAsHexagon()
        self.textField.delegate = self
    }
    
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        
        println("typing")
    }
    
    func imageViewShapedAsHexagon () -> UIImageView
    {
        var image: UIImageView
        image = UIImageView(frame:CGRectMake(100.0, 100.0, 100.0, 100.0))
        image.backgroundColor = UIColor.greenColor()
        var rect: CGRect = image.frame
        var hexagonMask: CAShapeLayer = CAShapeLayer()
        var hexagonBorder: CAShapeLayer = CAShapeLayer()
        hexagonBorder.frame = image.layer.bounds
        var hexagonPath: UIBezierPath = UIBezierPath()
        var sideWidth: CGFloat = 2 * (0.5 * rect.size.width / 2)
        var lCollumn: CGFloat = (rect.size.width - sideWidth) / 2
        var rCollumn: CGFloat = rect.size.width - lCollumn
        var height: CGFloat = 0.866025 * rect.size.height
        var y: CGFloat = (rect.size.height - height) / 2
        var by: CGFloat = rect.size.height - y
        var midy: CGFloat = rect.size.height / 2
        var rightMost: CGFloat = rect.size.width
        hexagonPath.moveToPoint(CGPointMake(lCollumn, y))
        hexagonPath.addLineToPoint(CGPointMake(rCollumn, y))
        hexagonPath.addLineToPoint(CGPointMake(rightMost, midy))
        hexagonPath.addLineToPoint(CGPointMake(rCollumn, by))
        hexagonPath.addLineToPoint(CGPointMake(lCollumn, by))
        hexagonPath.addLineToPoint(CGPointMake(0, midy))
        hexagonPath.addLineToPoint(CGPointMake(lCollumn, y))
        hexagonMask.path = hexagonPath.CGPath
        hexagonBorder.path = hexagonPath.CGPath
        hexagonBorder.fillColor = UIColor.clearColor().CGColor
        hexagonBorder.strokeColor = UIColor.blackColor().CGColor
        hexagonBorder.lineWidth = 5
        image.layer.mask = hexagonMask
        image.layer.addSublayer(hexagonBorder)
        
        return image
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        
        self.textField.resignFirstResponder()
//        PFCloud.callFunctionInBackground("request", withParameters:["item" : textField.text])
//            {
//            (result: AnyObject!, error: NSError!) -> Void in
//            
//            if error == nil{
//                
//            }
//            else{
//                println(error)
//            }
//        }
        self.textField.userInteractionEnabled = false
        
        return true
    }
}
