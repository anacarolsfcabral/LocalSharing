//
//  Request.swift
//  LocalSharing
//
//  Created by Ana Carolina Cabral on 17/03/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class Request
{
    var id: String?
    var author: User!
    var helper: User?
    var item: Item?
    var messages: [Message]! = []
    var dealing: Bool! = false
    var closed: Bool! = false
    var expired: Bool! = false
    var expiresAt: NSDate?

    init(id: String!, author: User!, helper: User?, item: Item!, dealing: Bool!, closed: Bool!, expired: Bool!, expiresAt: NSDate!)
    {
        self.id = id
        self.author = author
        self.helper = helper
        self.item = item
        self.dealing = dealing
        self.closed = closed
        self.expired = expired
        self.expiresAt = expiresAt
    }
    
    init(author: User!)
    {
        self.author = author
    }
}