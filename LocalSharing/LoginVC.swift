//
//  LoginVC.swift
//  LocalSharing
//
//  Created by Ana Carolina Cabral on 16/03/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func loginButton(sender: UIButton) {
        PFFacebookUtils.logInWithPermissions(["public_profile"], {
            (user: PFUser!, error: NSError!) -> Void in
            if let user = user {
                if user.isNew {
                    println("User signed up and logged in through Facebook!")
                } else {
                    println("User logged in through Facebook!")
                }
                self.performSegueWithIdentifier("goToRequests", sender: self)
            } else {
                println("Uh oh. The user cancelled the Facebook login.")
            }
        })
        
        
    }

}
