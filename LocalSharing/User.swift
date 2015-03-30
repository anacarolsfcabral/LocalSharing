//
//  User.swift
//  LocalSharing
//
//  Created by Giancarlo Diaz Cavalcante on 3/24/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class User
{
    var id: String!
    var name: String!
    var picture: UIImage!
    var requestLimit: Int!
    
    init (id: String!, name: String!, picture: UIImage!, requestLimit: Int!)
    {
        self.id = id
        self.name = name
        self.requestLimit = requestLimit
        self.picture = picture
    }
}