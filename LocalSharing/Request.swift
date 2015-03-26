//
//  Request.swift
//  LocalSharing
//
//  Created by Ana Carolina Cabral on 17/03/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class Request {
    var id: String!
    var author: User!
    var helper: User?
    var item: Item!
    var lastMessage: [Message]! = []
    var dealing: Bool!
    var closed: Bool!
    var expired: Bool!

    init(id: String!, author: User!, item: Item!, dealing: Bool!, closed: Bool!, expired: Bool!)
    {
        self.id = id
        self.author = author
        self.item = item
        self.dealing = dealing
        self.closed = closed
        self.expired = expired
    }
}