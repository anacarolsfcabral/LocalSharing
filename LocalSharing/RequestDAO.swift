//
//  RequestDAO.swift
//  LocalSharing
//
//  Created by Giancarlo Diaz Cavalcante on 3/23/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class RequestDAO
{
    // Create request
    class func createRequest(item: String!, then callback: (Request?, NSError?) -> Void)
    {
        var request: Request?
        
        PFCloud.callFunctionInBackground("createRequest", withParameters: ["item": item])
            {
                (pfResult, error) in
                if error == nil
                {
                    request = ParseDAO.getRequest(pfResult as PFObject)
                }
                
                callback(request, error)
        }
    }
    
    // Get requests
    class func getRequests(page: Int?, limit: Int?, callback: ([Request], NSError?) -> Void)
    {
        var requests: [Request] = []
        
        PFCloud.callFunctionInBackground("getRequests", withParameters: ["page": page ?? NSNull(), "limit": limit ?? NSNull()])
            {
                (pfResults, error) in
                if error == nil
                {
                    for pfResult in pfResults as [PFObject]
                    {
                        requests.append(ParseDAO.getRequest(pfResult))
                    }
                }
                
                callback(requests, error)
        }
    }
    
    // Get user requests
    class func getUserRequests(page: Int?, limit: Int?, then callback: ([Request], NSError?) -> Void)
    {
        var requests: [Request] = []
        
        PFCloud.callFunctionInBackground("getUserRequests", withParameters: ["page": page ?? NSNull(), "limit": limit ?? NSNull()])
            {
                (pfResults, error) in
                if error == nil
                {
                    for pfResult in pfResults as [PFObject]
                    {
                        requests.append(ParseDAO.getRequest(pfResult))
                    }
                }
                
                callback(requests, error)
        }
    }
    
    // Get dealing requests
    class func getDealingRequests(page: Int?, limit: Int?, then callback: ([Request], NSError?) -> Void)
    {
        var requests: [Request] = []
        
        PFCloud.callFunctionInBackground("getDealingRequests", withParameters: ["page": page ?? NSNull(), "limit": limit ?? NSNull()])
            {
                (pfResults, error) in
                if error == nil
                {
                    for pfResult in pfResults as [PFObject]
                    {
                        requests.append(ParseDAO.getRequest(pfResult))
                    }
                }
                
                callback(requests, error)
        }
    }
    
    // Respond request
    class func respondRequest(request: Request!, hasItem: Bool!, then callback: (Request, NSError?) -> Void)
    {
        PFCloud.callFunctionInBackground("respondRequest", withParameters: ["requestId": request.id, "hasItem": hasItem])
            {
                (pfResult, error) in
                if error == nil
                {
                    let pfRequest   = pfResult as PFObject
                    request.helper  = ParseDAO.getUser(pfRequest["helper"] as? PFUser)
                    request.dealing = true
                }
                
                callback(request, error)
        }
    }
    
    // Cancel deal
    class func cancelDeal(request: Request!, then callback: (Request, NSError?) -> Void)
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
    
    // Close request
    class func closeRequest(request: Request!, successful: Bool!, then callback: (Request, NSError?) -> Void)
    {
        PFCloud.callFunctionInBackground("closeRequest", withParameters: ["requestId": request.id, "successful": successful])
            {
                (pfResult, error) in
                if error == nil
                {
                    let pfRequest   = pfResult as PFObject
                    request.helper  = ParseDAO.getUser(pfRequest["helper"] as? PFUser)
                    request.dealing = false
                    request.closed  = true
                }
                
                callback(request, error)
        }
    }
}
