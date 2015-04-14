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
    @IBOutlet var iDoHaveButton: UIButton!
    @IBOutlet var iDontHaveButton: UIButton!
    
    var request: Request?
    var parent: RequestsVC?
    
    @IBAction func iDoHave(sender: AnyObject)
    {
        RequestDAO.respondRequest(request!, hasItem: true) { (request, error) -> Void in
            if error == nil
            {
            }
        }
      parent!.performSegueWithIdentifier("goToDealing", sender: self)
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()

        self.textField.delegate = self
        self.userName.textAlignment = .Left
    }
    
    override func setSelected(selected: Bool, animated: Bool)
    {
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        self.textField.resignFirstResponder()
        self.textField.userInteractionEnabled = false
        
        if textField.text == ""
        {
            self.textField.userInteractionEnabled = true
            let alert = UIAlertView()
            alert.title = "Ops!"
            alert.message = "Você esqueceu de preencher o nome do item!"
            alert.addButtonWithTitle("Ok")
            alert.show()
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
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        var shouldChange = false
        
        if count(textField.text) < 17
        {
            shouldChange = true
        }
        
        return shouldChange
    }
    
    func hideButton()
    {
        self.iDoHaveButton!.hidden = true
        self.iDontHaveButton!.hidden = true
    }
}
