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
                // Instantiate user as User
                user = User(
                    id: pfUser.objectId,
                    name: pfUser["name"] as String,
                    picture: pfUser["photo"] as String,
                    requestLimit: pfUser["requestLimit"] as Int
                )
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
        var user: User
        var pfUser = PFUser.currentUser()
        
        // Instantiate user as User
        user = User(
            id: pfUser.objectId,
            name: pfUser["name"] as String,
            picture: pfUser["photo"] as String,
            requestLimit: pfUser["requestLimit"] as Int
        )
        
        return user
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
                // Get PFObject's
                let pfRequest   = pfResult as PFObject
                let pfAuthor    = pfRequest["author"] as PFObject
                let pfItem      = pfRequest["item"] as PFObject
                
                // Instantiate author as User
                let author = User(
                    id: pfAuthor.objectId,
                    name: pfAuthor["name"] as String,
                    picture: pfAuthor["photo"] as String,
                    requestLimit: pfAuthor["requestLimit"] as Int
                )
                
                // Instantiate item as Item
                let item = Item(id: pfItem.objectId, name: pfItem["name"] as String)
                
                // Finally, instantiate request as Request
                request = Request(
                    id: pfRequest.objectId,
                    author: author,
                    item: item,
                    expiresAt: pfRequest["expiresAt"] as NSDate
                )
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
                    // Get PFObject's
                    let pfRequest   = pfResult as PFObject
                    let pfAuthor    = pfRequest["author"] as PFObject
                    let pfItem      = pfRequest["item"] as PFObject
                    
                    // Instantiate author as User
                    let author = User(
                        id: pfAuthor.objectId,
                        name: pfAuthor["name"] as String,
                        picture: pfAuthor["photo"] as String,
                        requestLimit: pfAuthor["requestLimit"] as Int
                    )
                    
                    // Instantiate item as Item
                    let item = Item(id: pfItem.objectId, name: pfItem["name"] as String)
                    
                    // Finally, instantiate request as Request
                    let request = Request(
                        id: pfRequest.objectId,
                        author: author,
                        item: item,
                        expiresAt: pfRequest["expiresAt"] as NSDate
                    )
                    
                    requests.append(request)
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
                    // Get PFObject's
                    let pfRequest   = pfResult as PFObject
                    let pfAuthor    = pfRequest["author"] as PFObject
                    let pfItem      = pfRequest["item"] as PFObject
                    
                    // Instantiate author as User
                    let author = User(
                        id: pfAuthor.objectId,
                        name: pfAuthor["name"] as String,
                        picture: pfAuthor["photo"] as String,
                        requestLimit: pfAuthor["requestLimit"] as Int
                    )
                    
                    // Instantiate item as Item
                    let item = Item(id: pfItem.objectId, name: pfItem["name"] as String)
                    
                    // Instantiate request as Request
                    let request = Request(
                        id: pfRequest.objectId,
                        author: author,
                        item: item,
                        expiresAt: pfRequest["expiresAt"] as NSDate
                    )
                    
                    // Verify if helper was set
                    if let pfHelper = pfRequest["helper"] as? PFObject
                    {
                        // Instantiate helper as User
                        let helper = User(
                            id: pfHelper.objectId,
                            name: pfHelper["name"] as String,
                            picture: pfHelper["photo"] as String,
                            requestLimit: pfHelper["requestLimit"] as Int
                        )
                        
                        request.helper = helper
                    }
                    
                    request.dealing = pfRequest["dealing"] as Bool
                    request.closed  = pfRequest["closed"] as Bool
                    request.expired = pfRequest["expired"] as Bool
                    
                    requests.append(request)
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
                    // Get PFObject's
                    let pfRequest   = pfResult as PFObject
                    let pfAuthor    = pfRequest["author"] as PFObject
                    let pfHelper    = pfRequest["helper"] as PFObject
                    let pfItem      = pfRequest["item"] as PFObject
                    
                    // Instantiate author as User
                    let author = User(
                        id: pfAuthor.objectId,
                        name: pfAuthor["name"] as String,
                        picture: pfAuthor["photo"] as String,
                        requestLimit: pfAuthor["requestLimit"] as Int
                    )
                    
                    // Instantiate helper as User
                    let helper = User(
                        id: pfHelper.objectId,
                        name: pfHelper["name"] as String,
                        picture: pfHelper["photo"] as String,
                        requestLimit: pfHelper["requestLimit"] as Int
                    )
                    
                    // Instantiate item as Item
                    let item = Item(id: pfItem.objectId, name: pfItem["name"] as String)
                    
                    // Finally, instantiate request as Request
                    let request = Request(
                        id: pfRequest.objectId,
                        author: author,
                        item: item,
                        expiresAt: pfRequest["expiresAt"] as NSDate
                    )
                    
                    request.helper  = helper
                    request.dealing = pfRequest["dealing"] as Bool
                    request.closed  = pfRequest["closed"] as Bool
                    request.expired = pfRequest["expired"] as Bool
                    
                    requests.append(request)
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
                let pfRequest = pfResult as PFObject
                
                // Verify if helper was set
                if let pfHelper = pfRequest["helper"] as? PFObject
                {
                    // Instantiate helper as User
                    let helper = User(
                        id: pfHelper.objectId,
                        name: pfHelper["name"] as String,
                        picture: pfHelper["photo"] as String,
                        requestLimit: pfHelper["requestLimit"] as Int
                    )
                    
                    request.helper = helper
                }
                
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
                let pfRequest = pfResult as PFObject
                
                // Verify if helper was set
                if let pfHelper = pfRequest["helper"] as? PFObject
                {
                    // Instantiate helper as User
                    let helper = User(
                        id: pfHelper.objectId,
                        name: pfHelper["name"] as String,
                        picture: pfHelper["photo"] as String,
                        requestLimit: pfHelper["requestLimit"] as Int
                    )
                    
                    request.helper = helper
                }
                
                request.dealing = false
                request.closed = true
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
                let pfRequest = pfResult as PFObject
                
                // Verify if helper was set
                if let pfHelper = pfRequest["helper"] as? PFObject
                {
                    // Instantiate helper as User
                    let helper = User(
                        id: pfHelper.objectId,
                        name: pfHelper["name"] as String,
                        picture: pfHelper["photo"] as String,
                        requestLimit: pfHelper["requestLimit"] as Int
                    )
                    
                    request.helper = helper
                }
                
                request.dealing = true
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
                let pfMessage   = pfResult as PFObject
                let pfFrom      = pfMessage["from"] as PFObject
                let pfRequest   = pfMessage["request"] as PFObject
                let pfAuthor    = pfRequest["author"] as PFObject
                let pfHelper    = pfRequest["helper"] as PFObject
                let pfItem      = pfRequest["item"] as PFObject
                
                // Instantiate author as User
                let author = User(
                    id: pfAuthor.objectId,
                    name: pfAuthor["name"] as String,
                    picture: pfAuthor["photo"] as String,
                    requestLimit: pfAuthor["requestLimit"] as Int
                )
                
                // Instantiate helper as User
                let helper = User(
                    id: pfHelper.objectId,
                    name: pfHelper["name"] as String,
                    picture: pfHelper["photo"] as String,
                    requestLimit: pfHelper["requestLimit"] as Int
                )
                
                // Instantiate item as Item
                let item = Item(id: pfItem.objectId, name: pfItem["name"] as String)
                
                // Finally, instantiate request as Request
                let request = Request(
                    id: pfRequest.objectId,
                    author: author,
                    item: item,
                    expiresAt: pfRequest["expiresAt"] as NSDate
                )
                
                request.helper  = helper
                request.dealing = pfRequest["dealing"] as Bool
                request.closed  = pfRequest["closed"] as Bool
                request.expired = pfRequest["expired"] as Bool
                
                // Instantiate from as User
                let from = User(
                    id: pfFrom.objectId,
                    name: pfFrom["name"] as String,
                    picture: pfFrom["photo"] as String,
                    requestLimit: pfFrom["requestLimit"] as Int
                )
                
                // Instantiate message as Message
                message = Message(
                    id: pfMessage.objectId,
                    request: request,
                    from: from,
                    content: pfMessage["content"] as String,
                    createdAt: pfMessage.createdAt
                )
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
                    let pfMessage   = pfResult as PFObject
                    let pfFrom      = pfMessage["from"] as PFObject
                    let pfRequest   = pfMessage["request"] as PFObject
                    let pfAuthor    = pfRequest["author"] as PFObject
                    let pfHelper    = pfRequest["helper"] as PFObject
                    let pfItem      = pfRequest["item"] as PFObject
                    
                    // Instantiate author as User
                    let author = User(
                        id: pfAuthor.objectId,
                        name: pfAuthor["name"] as String,
                        picture: pfAuthor["photo"] as String,
                        requestLimit: pfAuthor["requestLimit"] as Int
                    )
                    
                    // Instantiate helper as User
                    let helper = User(
                        id: pfHelper.objectId,
                        name: pfHelper["name"] as String,
                        picture: pfHelper["photo"] as String,
                        requestLimit: pfHelper["requestLimit"] as Int
                    )
                    
                    // Instantiate item as Item
                    let item = Item(id: pfItem.objectId, name: pfItem["name"] as String)
                    
                    // Finally, instantiate request as Request
                    let request = Request(
                        id: pfRequest.objectId,
                        author: author,
                        item: item,
                        expiresAt: pfRequest["expiresAt"] as NSDate
                    )
                    
                    request.helper  = helper
                    request.dealing = pfRequest["dealing"] as Bool
                    request.closed  = pfRequest["closed"] as Bool
                    request.expired = pfRequest["expired"] as Bool
                    
                    // Instantiate from as User
                    let from = User(
                        id: pfFrom.objectId,
                        name: pfFrom["name"] as String,
                        picture: pfFrom["photo"] as String,
                        requestLimit: pfFrom["requestLimit"] as Int
                    )
                    
                    // Instantiate message as Message
                    let message = Message(
                        id: pfMessage.objectId,
                        request: request,
                        from: from,
                        content: pfMessage["content"] as String,
                        createdAt: pfMessage.createdAt
                    )
                    
                    messages.append(message)
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
                    let pfItem = pfResult as PFObject
                    let item = Item(id: pfItem.objectId, name: pfResult["name"] as String)
                    
                    items.append(item)
                }
            }
            else
            {
                error = pfError
            }
        }
        
        return (items, error)
    }

}
