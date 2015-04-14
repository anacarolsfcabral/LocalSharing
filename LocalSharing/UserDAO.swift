//
//  UserDAO.swift
//  LocalSharing
//
//  Created by Giancarlo Diaz Cavalcante on 3/23/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit
import Parse

class UserDAO
{    
    // Login
    class func login(then callback: (User?, NSError?) -> Void)
    {
        var user: User?
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile"],
        block: {
            (pfUser, error) in
            if (pfUser != nil)
            {
                user = ParseDAO.getUser(pfUser)
            }
            
            callback(user, error)
        })
    }
    
    // Get current user
    class func getCurrentUser() -> User?
    {
        println(PFUser.currentUser())
        return ParseDAO.getUser(PFUser.currentUser())
    }
}