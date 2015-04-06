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

        self.textField.delegate = self
        self.userName.textAlignment = .Left;
    }
    
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        println("typing")
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        self.textField.resignFirstResponder()
        self.textField.userInteractionEnabled = false
        
        if textField.text == ""
        {
            self.textField.userInteractionEnabled = true
            NSNotificationCenter.defaultCenter().postNotificationName("goToAlert", object: nil);
        }
        else
        {
            RequestDAO.createRequest(textField.text, then: { (request, error) -> Void in
                if error == nil
                {
                    
                }
                
            })
        }
        
        return true
    }
}
