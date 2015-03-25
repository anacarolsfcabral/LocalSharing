//
//  DAO.swift
//  LocalSharing
//
//  Created by Giancarlo Diaz Cavalcante on 3/25/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

protocol DAO {
    
    func login() -> User
    
    func getCurrentUser() -> User
    
    func createRequest(item: Item!) -> Request
    
    func getRequests(page: Int?, limit: Int?) -> [Request]
    
    func getUserRequests(page: Int?, limit: Int?) -> [Request]
    
    func getDealingRequests(page: Int?, limit: Int?) -> [Request]
    
    func respondRequest(request: Request!, hasItem: Bool!) -> Request
    
    func closeRequest(request: Request!, successful: Bool!) -> Request
    
    func cancelDeal(request: Request!) -> Request
    
    func sendMessage(request: Request!, messageContent: String!) -> Message
    
    func getMessages(request: Request!, page: Int?, limit: Int?) -> [Message]
}
