//
//  ParseDAO.swift
//  LocalSharing
//
//  Created by Ana Carolina Cabral on 30/03/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//  DAO-DAO

import Foundation
import Parse

class ParseDAO
{
    class func getUser(pfUser: PFUser?) -> User?
    {
        var user: User?
        
        if pfUser != nil
        {
            let picture = pfUser!["photo"] as! String
            let url = NSURL(string: picture)!
            let data = NSData(contentsOfURL: url)!
            let image = UIImage(data: data)!
            
            user = User(
                id: pfUser!.objectId!,
                name: pfUser!["name"] as! String,
                picture: image,
                pictureLarge: UIImage(data: NSData(contentsOfURL: NSURL(string: picture + "?type=large")!)!)!,
                requestLimit: pfUser!["requestsLimit"] as! Int
            )
        }
        
        return user
    }
    
    class func getRequest(pfRequest: PFObject) -> Request
    {
        return Request(
            id: pfRequest.objectId,
            author: getUser(pfRequest["author"] as? PFUser),
            helper: getUser(pfRequest["helper"] as? PFUser),
            item: getItem(pfRequest["item"] as! PFObject),
            dealing: pfRequest["dealing"] as! Bool,
            closed: pfRequest["closed"] as! Bool,
            expired: pfRequest["expired"] as! Bool,
            expiresAt: pfRequest["expiresAt"] as! NSDate
        )
    }
    
    class func getItem(pfItem: PFObject) -> Item
    {
        return Item(id: pfItem.objectId, name: pfItem["name"] as! String)
    }
    
    class func getMessage(pfMessage: PFObject) -> Message
    {
        return Message(
            id: pfMessage.objectId,
            request: getRequest(pfMessage["request"] as! PFObject),
            from: getUser(pfMessage["from"] as? PFUser),
            content: pfMessage["content"] as! String,
            createdAt: pfMessage.createdAt
        )
    }
}