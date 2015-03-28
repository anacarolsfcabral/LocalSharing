//
//  ParseDAO.swift
//  LocalSharing
//
//  Created by Giancarlo Diaz Cavalcante on 3/23/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

// DAO = Data Access Object

// Nessa classe... EXPLICA TUDO SOBRE O DAO AQUI!

import UIKit

class ParseDAO: DAO
{
    
    func login() -> (user: User?, error: NSError?)
    {
        var user: User?
        var error: NSError?
        
        PFFacebookUtils.logInWithPermissions(["public_profile"],
        {
            (pfUser: PFUser!, pfError: NSError!) -> Void in
            if (pfUser != nil)
            {
                let name = pfUser["name"] as String
                let picture = UIImage(data: NSData(contentsOfURL: NSURL(string: pfUser["photo"] as String)!)!)
                let requestLimit = pfUser["requestLimit"] as Int
                
                user = User(id: pfUser.objectId, name: name, picture: picture, requestLimit: requestLimit)
            }
            else
            {
                error = pfError
            }
        })
        
        return (user, error)
    }
    
    func getCurrentUser() -> User
    {
        var user: User
        var pfUser = PFUser.currentUser()
        
        let name = pfUser["name"] as String
        let picture = UIImage(data: NSData(contentsOfURL: NSURL(string: pfUser["photo"] as String)!)!)
        let requestLimit = pfUser["requestLimit"] as Int
        
        user = User(id: pfUser.objectId, name: name, picture: picture, requestLimit: requestLimit)
        
        return user
    }
    
    func createRequest(item: Item!) -> (request: Request?, error: NSError?)
    {
        var request: Request?
        var error: NSError?
        
        PFCloud.callFunctionInBackground("request", withParameters: ["item": item.name])
        {
            (pfResult: AnyObject!, pfError: NSError!) -> Void in
            if pfError == nil
            {
                let pfRequest = pfResult as PFObject
                let pfAuthor = pfRequest["author"] as PFObject
                let pfItem = pfRequest["item"] as PFObject
                
                var author: User
                let authorName = pfAuthor["name"] as String
                let authorPicture = UIImage(data: NSData(contentsOfURL: NSURL(string: pfAuthor["photo"] as String)!)!)
                let requestLimit = pfAuthor["requestLimit"] as Int
                
                author = User(id: pfAuthor.objectId, name: authorName, picture: authorPicture, requestLimit: requestLimit)
                
                var item: Item = Item(id: pfItem.objectId, name: pfItem["name"] as String)
                
                request = Request(id: pfRequest.objectId, author: author, item: item, dealing: false, closed: false, expired: false)
            }
            else
            {
                error = pfError
            }
        }
        
        return (request, error)
    }
    
    func getRequests(page: Int?, limit: Int?) -> (requests: [Request], error: NSError?)
    {
        var requests: [Request] = []
        var error: NSError?
        
        PFCloud.callFunctionInBackground("getRequests", withParameters: ["limit": limit!, "page": page!])
        {
            (pfResults: AnyObject!, pfError: NSError!) -> Void in
            if pfError == nil
            {
                for pfResult in pfResults as [AnyObject]
                {
                    let pfRequest = pfResult as PFObject
                    let pfAuthor = pfRequest["author"] as PFObject
                    let pfItem = pfRequest["item"] as PFObject
                    
                    var author: User
                    let authorName = pfAuthor["name"] as String
                    let authorPicture = UIImage(data: NSData(contentsOfURL: NSURL(string: pfAuthor["photo"] as String)!)!)
                    let requestLimit = pfAuthor["requestLimit"] as Int
                    
                    author = User(id: pfAuthor.objectId, name: authorName, picture: authorPicture, requestLimit: requestLimit)
                    
                    var item: Item = Item(id: pfItem.objectId, name: pfItem["name"] as String)
                    
                    let request = Request(id: pfRequest.objectId, author: author, item: item, dealing: false, closed: false, expired: false)
                    
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
    
    func getUserRequests(page: Int?, limit: Int?) -> (requests: [Request], error: NSError?)
    {
        var requests: [Request] = []
        var error: NSError?
        
        var item1 = Item(id: "01", name: "Livro de Design Patterns")
        var item2 = Item(id: "02", name: "Esmalte")
        var item3 = Item(id: "03", name: "Calculadora")
        var item4 = Item(id: "04", name: "Remédio para dor de cabeça")
        
        requests.append(Request(id: "01", author: getCurrentUser(), item: item1, dealing: false, closed: false, expired: false))
        requests.append(Request(id: "01", author: getCurrentUser(), item: item2, dealing: false, closed: false, expired: false))
        requests.append(Request(id: "01", author: getCurrentUser(), item: item3, dealing: false, closed: false, expired: false))
        requests.append(Request(id: "01", author: getCurrentUser(), item: item4, dealing: false, closed: false, expired: false))
        
        return (requests, error)
    }
    
    func getDealingRequests(page: Int?, limit: Int?) -> (requests: [Request], error: NSError?)
    {
        var requests: [Request] = []
        var error: NSError?
        
        var user1 = User(id: "01", name: "Fábio", picture: UIImage(named: "foto-Fabio"), requestLimit: 3)
        var user2 = User(id: "01", name: "Lucas", picture: UIImage(named: "foto-Lucas"), requestLimit: 3)
        var user3 = User(id: "01", name: "Pietro", picture: UIImage(named: "foto-Pietro"), requestLimit: 3)
        var user4 = User(id: "01", name: "Giancarlo", picture: UIImage(named: "foto-Giancarlo"), requestLimit: 3)
        
        var item1 = Item(id: "01", name: "Livro de Design Patterns")
        var item2 = Item(id: "01", name: "Esmalte")
        var item3 = Item(id: "01", name: "Calculadora")
        var item4 = Item(id: "01", name: "Remédio para dor de cabeça")
        
        requests.append(Request(id: "01", author: user1, item: item1, dealing: true, closed: false, expired: false))
        requests.append(Request(id: "01", author: user2, item: item2, dealing: true, closed: false, expired: false))
        requests.append(Request(id: "01", author: user3, item: item3, dealing: true, closed: false, expired: false))
        requests.append(Request(id: "01", author: user4, item: item4, dealing: true, closed: false, expired: false))
        
        return (requests, error)
    }
    
    func respondRequest(request: Request!, hasItem: Bool!) -> (request: Request?, error: NSError?)
    {
        request.dealing = false
        var error: NSError?
        
        return (request, error)
    }
    
    func closeRequest(request: Request!, successful: Bool!) -> (request: Request?, error: NSError?)
    {
        request.closed = true
        var error: NSError?
        
        return (request, error)
    }
    
    func cancelDeal(request: Request!) -> (request: Request?, error: NSError?)
    {
        request.dealing = false
        var error: NSError?
        
        return (request, error)
    }
    
    func sendMessage(request: Request!, messageContent: String!) -> (message: Message?, error: NSError?)
    {
        let message: Message = Message(id: "01", request: request, from: getCurrentUser(), content: messageContent)
        var error: NSError?
        
        return (message, error)
    }
    
    func getMessages(request: Request!, page: Int?, limit: Int?) -> (messages: [Message], error: NSError?)
    {
        var messages: [Message] = []
        var error: NSError?
        
        messages.append(Message(id: "01", request: request, from: getCurrentUser(), content: "Olá"))
        messages.append(Message(id: "01", request: request, from: getCurrentUser(), content: "Oi?"))
        messages.append(Message(id: "01", request: request, from: getCurrentUser(), content: "Você tá aí"))
        messages.append(Message(id: "01", request: request, from: getCurrentUser(), content: "Oieeee"))
        
        return (messages, error)
    }

}
