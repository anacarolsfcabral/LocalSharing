//
//  DAO.swift
//  LocalSharing
//
//  Created by Giancarlo Diaz Cavalcante on 3/25/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//
//  This protocol acts as a contract between back-end and front-end
//  Usage:
//  let dao = DAOFactory.getDAO()
//  dao.getRequests(page: 1, limit: 30, then: {
//      (requests, error) in
//      if error == nil {
//          self.requests += requests
//      }
//  })

protocol DAO {
    
    func login              (then callback: (User?, NSError?) -> Void)
    
    func getCurrentUser     () -> User
    
    func createRequest      (item: String!, then callback: (Request?, NSError?) -> Void)
    
    func getRequests        (page: Int?,    limit: Int?,    then callback: ([Request], NSError?) -> Void)
    
    func getUserRequests    (page: Int?,    limit: Int?,    then callback: ([Request], NSError?) -> Void)
    
    func getDealingRequests (page: Int?,    limit: Int?,    then callback: ([Request], NSError?) -> Void)
    
    func cancelDeal         (request: Request!, then callback: (Request, NSError?) -> Void)
    
    func respondRequest     (request: Request!, hasItem: Bool!,     then callback: (Request, NSError?) -> Void)
    
    func closeRequest       (request: Request!, successful: Bool!,  then callback: (Request, NSError?) -> Void)
    
    func sendMessage        (request: Request!, content: String!,   then callback: (Message?, NSError?) -> Void)
    
    func getMessages        (request: Request!, page: Int?, limit: Int?,    then callback: ([Message], NSError?) -> Void)
    
    func getItems           (string: String!,   limit: Int?,    then callback: ([Item], NSError?) -> Void)
}
