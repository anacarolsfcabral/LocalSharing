//
//  MessageDAO.swift
//  LocalSharing
//
//  Created by Giancarlo Diaz Cavalcante on 3/23/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit


class MessageDAO
{
    // Send message
    class func sendMessage(request: Request!, content: String!, then callback: (Message?, NSError?) -> Void)
    {
        var message: Message?
        
        PFCloud.callFunctionInBackground("sendMessage", withParameters: ["requestId": request.id, "content": content])
            {
                (pfResult, error) in
                if error == nil
                {
                    message = ParseDAO.getMessage(pfResult as PFObject)
                }
                
                callback(message, error)
        }
    }
    
    // Get messages
    class func getMessages(request: Request!, page: Int?, limit: Int?, then callback: ([Message], NSError?) -> Void)
    {
        var messages: [Message] = []
        
        PFCloud.callFunctionInBackground("getMessages", withParameters: ["requestId": request.id, "page": page ?? NSNull(), "limit": limit ?? NSNull()])
            {
                (pfResults, error) in
                if error == nil
                {
                    for pfResult in pfResults as [PFObject]
                    {
                        messages.append(ParseDAO.getMessage(pfResult))
                    }
                }
                
                callback(messages, error)
        }
    }
}