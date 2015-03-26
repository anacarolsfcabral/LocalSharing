//
//  Message.swift
//  LocalSharing
//
//  Created by Giancarlo Diaz Cavalcante on 3/24/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class Message
{
    var id: String!
    var request: Request!
    var from: User!
    var content: String!
    var createdAt: NSDate?
    
    init (id: String!, request: Request!, from: User!, content: String!)
    {
        self.id = id
        self.request = request
        self.from = from
        self.content = content
    }
}
