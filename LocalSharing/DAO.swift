//
//  DAO.swift
//  LocalSharing
//
//  Created by Giancarlo Diaz Cavalcante on 3/25/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//
//  This protocol acts as a contract between back-end and front-end

protocol DAO {
    
    func login() -> (user: User?, error: NSError?)
    
    func getCurrentUser() -> User
    
    func createRequest(item: String!) -> (request: Request?, error: NSError?)
    
    func getRequests(page: Int?, limit: Int?) -> (requests: [Request], error: NSError?)
    
    func getUserRequests(page: Int?, limit: Int?) -> (requests: [Request], error: NSError?)
    
    func getDealingRequests(page: Int?, limit: Int?) -> (requests: [Request], error: NSError?)
    
    func respondRequest(request: Request!, hasItem: Bool!) -> (request: Request, error: NSError?)
    
    func closeRequest(request: Request!, successful: Bool!) -> (request: Request, error: NSError?)
    
    func cancelDeal(request: Request!) -> (request: Request, error: NSError?)
    
    func sendMessage(request: Request!, messageContent: String!) -> (message: Message?, error: NSError?)
    
    func getMessages(request: Request!, page: Int?, limit: Int?) -> (messages: [Message], error: NSError?)
    
    func getItems(string: String!, limit: Int?) -> (items: [Item], error: NSError?)
}
