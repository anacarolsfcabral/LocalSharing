//
//  Request.swift
//  LocalSharing
//
//  Created by Ana Carolina Cabral on 17/03/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class Request {
    var id: String?
    var author: User!
    var helper: User?
    var item: Item!
    var lastMessage: [Message]! = []
    var dealing: Bool!
    var closed: Bool!
    var expired: Bool!
    
//    func getExpireDate() -> NSDate {
//}

    init(author: User!, item: Item!, dealing: Bool!, closed: Bool!, expired: Bool!)
    {
        self.author = author
        self.item = item
        self.dealing = dealing
        self.closed = closed
        self.expired = expired
    }
        
    convenience init(author: User!, helper: User?, item: Item!, lastMessage: [Message]?, dealing: Bool!, closed: Bool!, expired: Bool!)
    {
        self.init(author: author, item: item, dealing: dealing, closed: closed, expired: expired);
        self.lastMessage = lastMessage
        self.helper = helper
    }
}