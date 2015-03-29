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
    var dao: DAO = DAOFactory.getDAO()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if dao.getCurrentUser() != nil {
            dao.login(then: {
                (user, error) in
                if error == nil {
                    self.performSegueWithIdentifier("goToRequests", sender: UIButton())
                }
            })
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginButton(sender: UIButton)
    {
        dao.login(then: {
            (user, error) in
            if error == nil {
                self.performSegueWithIdentifier("goToRequests", sender: sender)
            }
        })
    }

}
