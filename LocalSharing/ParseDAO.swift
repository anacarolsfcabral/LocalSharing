//
//  ParseDAO.swift
//  LocalSharing
//
//  Created by Ana Carolina Cabral on 30/03/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//  DAO-DAO

import Foundation

class ParseDAO
{
    class func getUser(pfUser: PFUser?) -> User?
    {
        if let user = pfUser
        {
            return User(
                id: user.objectId,
                name: user["name"] as String,
                picture: UIImage(data: NSData(contentsOfURL: NSURL(string: user["photo"] as String)!)!),
                requestLimit: user["requestsLimit"] as Int
            )
        }
        else
        {
            return nil
        }
    }
    
    class func getRequest(pfRequest: PFObject) -> Request
    {
        return Request(
            id: pfRequest.objectId,
            author: getUser(pfRequest["author"] as? PFUser),
            helper: getUser(pfRequest["helper"] as? PFUser),
            item: getItem(pfRequest["item"] as PFObject),
            dealing: pfRequest["dealing"] as Bool,
            closed: pfRequest["closed"] as Bool,
            expired: pfRequest["expired"] as Bool,
            expiresAt: pfRequest["expiresAt"] as NSDate
        )
    }
    
    class func getItem(pfItem: PFObject) -> Item
    {
        return Item(id: pfItem.objectId, name: pfItem["name"] as String)
    }
    
    class func getMessage(pfMessage: PFObject) -> Message
    {
        return Message(
            id: pfMessage.objectId,
            request: getRequest(pfMessage["request"] as PFObject),
            from: getUser(pfMessage["from"] as? PFUser),
            content: pfMessage["content"] as String,
            createdAt: pfMessage.createdAt
        )
    }
}