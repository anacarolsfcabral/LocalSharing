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
    func login() -> User
    {
        let user: User = User(name: "Fábio", picture: UIImage(named: "foto-Fabio"), requestLimit: 3)
        
//        PFFacebookUtils.logInWithPermissions(["public_profile"],
//        {
//            (user: PFUser!, error: NSError!) -> Void in
//            if user
//            {
//                if user.isNew
//                {
//                    println("User signed up and logged in through Facebook!")
//                }
//                else
//                {
//                    println("User logged in through Facebook!")
//                }
//            }
//            else
//            {
//                println("Uh oh. The user cancelled the Facebook login.")
//            }
//        })
        
        return user
    }
    
    
    func getCurrentUser() -> User
    {
        let user: User = User(name: "Fábio", picture: UIImage(named: "foto-Fabio"), requestLimit: 3)
        
        return user
    }
    
    func createRequest(item: Item!) -> Request
    {
        let item: Item = Item(name: "Esmalte")
        let request: Request = Request(author: getCurrentUser(), item: item, dealing: false, closed: false, expired: false)
        
        return request
    }
    
    func getRequests(page: Int?, limit: Int?) -> [Request]
    {
        var requests: [Request] = []
        
        var user1 = User(name: "Fábio", picture: UIImage(named: "foto-Fabio"), requestLimit: 3)
        var user2 = User(name: "Lucas", picture: UIImage(named: "foto-Lucas"), requestLimit: 3)
        var user3 = User(name: "Pietro", picture: UIImage(named: "foto-Pietro"), requestLimit: 3)
        var user4 = User(name: "Giancarlo", picture: UIImage(named: "foto-Giancarlo"), requestLimit: 3)
        
        var item1 = Item(name: "Livro de Design Patterns")
        var item2 = Item(name: "Esmalte")
        var item3 = Item(name: "Calculadora")
        var item4 = Item(name: "Remédio para dor de cabeça")
        
        requests.append(Request(author: user1, item: item1, dealing: false, closed: false, expired: false))
        requests.append(Request(author: user2, item: item2, dealing: false, closed: false, expired: false))
        requests.append(Request(author: user3, item: item3, dealing: false, closed: false, expired: false))
        requests.append(Request(author: user4, item: item4, dealing: false, closed: false, expired: false))
        
        return requests
    }
    
    func getUserRequests(page: Int?, limit: Int?) -> [Request]
    {
        var requests: [Request] = []
        
        var item1 = Item(name: "Livro de Design Patterns")
        var item2 = Item(name: "Esmalte")
        var item3 = Item(name: "Calculadora")
        var item4 = Item(name: "Remédio para dor de cabeça")
        
        requests.append(Request(author: getCurrentUser(), item: item1, dealing: false, closed: false, expired: false))
        requests.append(Request(author: getCurrentUser(), item: item2, dealing: false, closed: false, expired: false))
        requests.append(Request(author: getCurrentUser(), item: item3, dealing: false, closed: false, expired: false))
        requests.append(Request(author: getCurrentUser(), item: item4, dealing: false, closed: false, expired: false))
        
        return requests
    }
    
    func getDealingRequests(page: Int?, limit: Int?) -> [Request]
    {
        var requests: [Request] = []
        
        var user1 = User(name: "Fábio", picture: UIImage(named: "foto-Fabio"), requestLimit: 3)
        var user2 = User(name: "Lucas", picture: UIImage(named: "foto-Lucas"), requestLimit: 3)
        var user3 = User(name: "Pietro", picture: UIImage(named: "foto-Pietro"), requestLimit: 3)
        var user4 = User(name: "Giancarlo", picture: UIImage(named: "foto-Giancarlo"), requestLimit: 3)
        
        var item1 = Item(name: "Livro de Design Patterns")
        var item2 = Item(name: "Esmalte")
        var item3 = Item(name: "Calculadora")
        var item4 = Item(name: "Remédio para dor de cabeça")
        
        requests.append(Request(author: user1, item: item1, dealing: true, closed: false, expired: false))
        requests.append(Request(author: user2, item: item2, dealing: true, closed: false, expired: false))
        requests.append(Request(author: user3, item: item3, dealing: true, closed: false, expired: false))
        requests.append(Request(author: user4, item: item4, dealing: true, closed: false, expired: false))
        
        return requests
    }
    
    func respondRequest(request: Request!, hasItem: Bool!) -> Request
    {
        request.dealing = false
        
        return request
    }
    
    func closeRequest(request: Request!, successful: Bool!) -> Request
    {
        request.closed = true
        
        return request
    }
    
    func cancelDeal(request: Request!) -> Request
    {
        request.dealing = false
        
        return request
    }
    
    func sendMessage(request: Request!, messageContent: String!) -> Message
    {
        let message: Message = Message(request: request, from: getCurrentUser(), content: messageContent)
        
        return message
    }
    
    func getMessages(request: Request!, page: Int?, limit: Int?) -> [Message]
    {
        var messages: [Message] = []
        
        messages.append(Message(request: request, from: getCurrentUser(), content: "Olá"))
        messages.append(Message(request: request, from: getCurrentUser(), content: "Oi?"))
        messages.append(Message(request: request, from: getCurrentUser(), content: "Você tá aí"))
        messages.append(Message(request: request, from: getCurrentUser(), content: "Oieeee"))
        
        return messages
    }

}
