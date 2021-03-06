//
//  LoginVC.swift
//  LocalSharing
//
//  Created by Ana Carolina Cabral on 16/03/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class LoginVC: UIViewController
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        if UserDAO.getCurrentUser() != nil
        {
            UserDAO.login { (user, error) -> Void in }
            self.performSegueWithIdentifier("goToRequests", sender: UIButton())
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginButton(sender: UIButton)
    {
        UserDAO.login { (user, error) -> Void in
            if error == nil
            {
                self.performSegueWithIdentifier("goToRequests", sender: sender)
            }
            
        }
        
    }
}
