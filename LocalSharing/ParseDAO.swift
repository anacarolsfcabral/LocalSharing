//
//  ParseDAO.swift
//  LocalSharing
//
//  Created by Giancarlo Diaz Cavalcante on 3/23/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class ParseDAO: DAO
{    
    // Login
    func login(then callback: (User?, NSError?) -> Void)
    {
        var user: User?
        
        PFFacebookUtils.logInWithPermissions(["public_profile"],
        {
            (pfUser, error) in
            if (pfUser != nil)
            {
                user = self.getUser(pfUser)
            }
            
            callback(user, error)
        })
    }
    
    // Get current user
    func getCurrentUser() -> User?
    {
        return getUser(PFUser.currentUser())
    }
    
    // Create request
    func createRequest(item: String!, then callback: (Request?, NSError?) -> Void)
    {
        var request: Request?
        
        PFCloud.callFunctionInBackground("createRequest", withParameters: ["item": item])
        {
            (pfResult, error) in
            if error == nil
            {
                request = self.getRequest(pfResult as PFObject)
            }
            
            callback(request, error)
        }
    }
    
    // Get requests
    func getRequests(page: Int?, limit: Int?, then callback: ([Request], NSError?) -> Void)
    {
        var requests: [Request] = []
        
        PFCloud.callFunctionInBackground("getRequests", withParameters: ["page": page ?? NSNull(), "limit": limit ?? NSNull()])
        {
            (pfResults, error) in
            if error == nil
            {
                for pfResult in pfResults as [AnyObject]
                {
                    requests.append(self.getRequest(pfResult as PFObject))
                }
            }
            
            callback(requests, error)
        }
    }
    
    // Get user requests
    func getUserRequests(page: Int?, limit: Int?, then callback: ([Request], NSError?) -> Void)
    {
        var requests: [Request] = []
        
        PFCloud.callFunctionInBackground("getUserRequests", withParameters: ["page": page ?? NSNull(), "limit": limit ?? NSNull()])
        {
            (pfResults, error) in
            if error == nil
            {
                for pfResult in pfResults as [AnyObject]
                {
                    requests.append(self.getRequest(pfResult as PFObject))
                }
            }
            
            callback(requests, error)
        }
    }
    
    // Get dealing requests
    func getDealingRequests(page: Int?, limit: Int?, then callback: ([Request], NSError?) -> Void)
    {
        var requests: [Request] = []
        
        PFCloud.callFunctionInBackground("getDealingRequests", withParameters: ["page": page ?? NSNull(), "limit": limit ?? NSNull()])
        {
            (pfResults, error) in
            if error == nil
            {
                for pfResult in pfResults as [AnyObject]
                {
                    requests.append(self.getRequest(pfResult as PFObject))
                }
            }
            
            callback(requests, error)
        }
    }
    
    // Respond request
    func respondRequest(request: Request!, hasItem: Bool!, then callback: (Request, NSError?) -> Void)
    {
        PFCloud.callFunctionInBackground("respondRequest", withParameters: ["requestId": request.id, "hasItem": hasItem])
        {
            (pfResult, error) in
            if error == nil
            {
                let pfRequest   = pfResult as PFObject
                request.helper  = self.getUser(pfRequest["helper"] as? PFUser)
                request.dealing = true
            }
            
            callback(request, error)
        }
    }
    
    // Close request
    func closeRequest(request: Request!, successful: Bool!, then callback: (Request, NSError?) -> Void)
    {
        PFCloud.callFunctionInBackground("closeRequest", withParameters: ["requestId": request.id, "successful": successful])
        {
            (pfResult, error) in
            if error == nil
            {
                let pfRequest   = pfResult as PFObject
                request.helper  = self.getUser(pfRequest["helper"] as? PFUser)
                request.dealing = false
                request.closed  = true
            }
            
            callback(request, error)
        }
    }
    
    // Cancel deal
    func cancelDeal(request: Request!, then callback: (Request, NSError?) -> Void)
    {
        PFCloud.callFunctionInBackground("cancelDeal", withParameters: ["requestId": request.id])
        {
            (pfResult, error) in
            if error == nil
            {
                let pfRequest   = pfResult as PFObject
                request.helper  = nil
                request.dealing = false
            }
            
            callback(request, error)
        }
    }
    
    // Send message
    func sendMessage(request: Request!, content: String!, then callback: (Message?, NSError?) -> Void)
    {
        var message: Message?
        
        PFCloud.callFunctionInBackground("sendMessage", withParameters: ["requestId": request.id, "content": content])
        {
            (pfResult, error) in
            if error == nil
            {
                message = self.getMessage(pfResult as PFObject)
            }
            
            callback(message, error)
        }
    }
    
    // Get messages
    func getMessages(request: Request!, page: Int?, limit: Int?, then callback: ([Message], NSError?) -> Void)
    {
        var messages: [Message] = []
        
        PFCloud.callFunctionInBackground("getMessages", withParameters: ["requestId": request.id, "page": page ?? NSNull(), "limit": limit ?? NSNull()])
        {
            (pfResults, error) in
            if error == nil
            {
                for pfResult in pfResults as [AnyObject]
                {
                    messages.append(self.getMessage(pfResult as PFObject))
                }
            }
            
            callback(messages, error)
        }
    }
    
    // Get items
    func getItems(string: String!, limit: Int?, then callback: ([Item], NSError?) -> Void)
    {
        var items: [Item] = []
        
        PFCloud.callFunctionInBackground("getItems", withParameters: ["string": string, "limit": limit ?? NSNull()])
        {
            (pfResults, error) in
            if error == nil
            {
                for pfResult in pfResults as [AnyObject]
                {
                    items.append(self.getItem(pfResult as PFObject))
                }
            }
            
            callback(items, error)
        }
    }
    
    private func getUser(pfUser: PFUser?) -> User?
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
    
    private func getRequest(pfRequest: PFObject) -> Request
    {
        let request = Request(
            id: pfRequest.objectId,
            author: getUser(pfRequest["author"] as? PFUser),
            helper: getUser(pfRequest["helper"] as? PFUser),
            item: getItem(pfRequest["item"] as PFObject),
            dealing: pfRequest["dealing"] as Bool,
            closed: pfRequest["closed"] as Bool,
            expired: pfRequest["expired"] as Bool,
            expiresAt: pfRequest["expiresAt"] as NSDate
        )
        
        return request
    }
    
    private func getItem(pfItem: PFObject) -> Item
    {
        return Item(id: pfItem.objectId, name: pfItem["name"] as String)
    }
    
    private func getMessage(pfMessage: PFObject) -> Message
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
