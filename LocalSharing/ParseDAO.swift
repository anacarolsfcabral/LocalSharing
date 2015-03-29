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
    func login() -> (user: User?, error: NSError?)
    {
        var user: User?
        var error: NSError?
        
        PFFacebookUtils.logInWithPermissions(["public_profile"],
        {
            (pfUser: PFUser!, pfError: NSError!) -> Void in
            if (pfUser != nil)
            {
                user = self.getUser(pfUser)
            }
            else
            {
                error = pfError
            }
        })
        
        return (user, error)
    }
    
    // Get current user
    func getCurrentUser() -> User
    {
        var pfUser = PFUser.currentUser()
        
        return getUser(pfUser)!
    }
    
    // Create request
    func createRequest(item: String!) -> (request: Request?, error: NSError?)
    {
        var request: Request?
        var error: NSError?
        
        PFCloud.callFunctionInBackground("createRequest", withParameters: ["item": item])
        {
            (pfResult: AnyObject!, pfError: NSError?) -> Void in
            if pfError == nil
            {
                request = self.getRequest(pfResult as PFObject)
            }
            else
            {
                error = pfError
            }
        }
        
        return (request, error)
    }
    
    // Get requests
    func getRequests(page: Int?, limit: Int?) -> (requests: [Request], error: NSError?)
    {
        var requests: [Request] = []
        var error: NSError?
        
        PFCloud.callFunctionInBackground("getRequests", withParameters: ["page": page ?? NSNull(), "limit": limit ?? NSNull()])
        {
            (pfResults: AnyObject!, pfError: NSError!) -> Void in
            if pfError == nil
            {
                for pfResult in pfResults as [AnyObject]
                {
                    requests.append(self.getRequest(pfResult as PFObject))
                }
            }
            else
            {
                error = pfError
            }
        }
        
        return (requests, error)
    }
    
    // Get user requests
    func getUserRequests(page: Int?, limit: Int?) -> (requests: [Request], error: NSError?)
    {
        var requests: [Request] = []
        var error: NSError?
        
        PFCloud.callFunctionInBackground("getUserRequests", withParameters: ["page": page ?? NSNull(), "limit": limit ?? NSNull()])
        {
            (pfResults: AnyObject!, pfError: NSError!) -> Void in
            if pfError == nil
            {
                for pfResult in pfResults as [AnyObject]
                {
                    requests.append(self.getRequest(pfResult as PFObject))
                }
            }
            else
            {
                error = pfError
            }
        }
        
        return (requests, error)
    }
    
    // Get dealing requests
    func getDealingRequests(page: Int?, limit: Int?) -> (requests: [Request], error: NSError?)
    {
        var requests: [Request] = []
        var error: NSError?
        
        PFCloud.callFunctionInBackground("getDealingRequests", withParameters: ["page": page ?? NSNull(), "limit": limit ?? NSNull()])
        {
            (pfResults: AnyObject!, pfError: NSError!) -> Void in
            if pfError == nil
            {
                for pfResult in pfResults as [AnyObject]
                {
                    requests.append(self.getRequest(pfResult as PFObject))
                }
            }
            else
            {
                error = pfError
            }
        }
        
        return (requests, error)
    }
    
    // Respond request
    func respondRequest(request: Request!, hasItem: Bool!) -> (request: Request, error: NSError?)
    {
        var error: NSError?
        
        PFCloud.callFunctionInBackground("respondRequest", withParameters: ["requestId": request.id, "hasItem": hasItem])
        {
            (pfResult: AnyObject!, pfError: NSError?) -> Void in
            if pfError == nil
            {
                // Get PFObject's
                let pfRequest   = pfResult as PFObject
                request.helper  = self.getUser(pfRequest["helper"] as? PFUser)
                request.dealing = true
            }
            else
            {
                error = pfError
            }
        }
        
        return (request, error)
    }
    
    // Close request
    func closeRequest(request: Request!, successful: Bool!) -> (request: Request, error: NSError?)
    {
        var error: NSError?
        
        PFCloud.callFunctionInBackground("closeRequest", withParameters: ["requestId": request.id, "successful": successful])
        {
            (pfResult: AnyObject!, pfError: NSError?) -> Void in
            if pfError == nil
            {
                // Get PFObject's
                let pfRequest   = pfResult as PFObject
                request.helper  = self.getUser(pfRequest["helper"] as? PFUser)
                request.dealing = false
                request.closed  = true
            }
            else
            {
                error = pfError
            }
        }
        
        return (request, error)
    }
    
    // Cancel deal
    func cancelDeal(request: Request!) -> (request: Request, error: NSError?)
    {
        var error: NSError?
        
        PFCloud.callFunctionInBackground("cancelDeal", withParameters: ["requestId": request.id])
        {
            (pfResult: AnyObject!, pfError: NSError?) -> Void in
            if pfError == nil
            {
                // Get PFObject's
                let pfRequest   = pfResult as PFObject
                request.helper  = nil
                request.dealing = false
            }
            else
            {
                error = pfError
            }
        }
        
        return (request, error)
    }
    
    // Send message
    func sendMessage(request: Request!, messageContent: String!) -> (message: Message?, error: NSError?)
    {
        var message: Message?
        var error: NSError?
        
        PFCloud.callFunctionInBackground("sendMessage", withParameters: ["requestId": request.id, "content": messageContent])
        {
            (pfResult: AnyObject!, pfError: NSError?) -> Void in
            if pfError == nil
            {
                message = self.getMessage(pfResult as PFObject)
            }
            else
            {
                error = pfError
            }
        }
        
        return (message, error)
    }
    
    // Get messages
    func getMessages(request: Request!, page: Int?, limit: Int?) -> (messages: [Message], error: NSError?)
    {
        var messages: [Message] = []
        var error: NSError?
        
        PFCloud.callFunctionInBackground("getMessages", withParameters: ["requestId": request.id, "page": page ?? NSNull(), "limit": limit ?? NSNull()])
        {
            (pfResults: AnyObject!, pfError: NSError?) -> Void in
            if pfError == nil
            {
                for pfResult in pfResults as [AnyObject]
                {
                    messages.append(self.getMessage(pfResult as PFObject))
                }
            }
            else
            {
                error = pfError
            }
        }
        
        return (messages, error)
    }
    
    // Get items
    func getItems(string: String!, limit: Int?) -> (items: [Item], error: NSError?)
    {
        var items: [Item] = []
        var error: NSError?
        
        PFCloud.callFunctionInBackground("getItems", withParameters: ["string": string, "limit": limit ?? NSNull()])
        {
            (pfResults: AnyObject!, pfError: NSError?) -> Void in
            if pfError == nil
            {
                for pfResult in pfResults as [AnyObject]
                {
                    items.append(self.getItem(pfResult as PFObject))
                }
            }
            else
            {
                error = pfError
            }
        }
        
        return (items, error)
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
