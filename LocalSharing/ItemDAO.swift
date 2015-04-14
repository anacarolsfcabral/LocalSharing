//
//  ItemDAO.swift
//  LocalSharing
//
//  Created by Giancarlo Diaz Cavalcante on 3/23/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit
import Parse


class ItemDAO
{
    // Get items
    class func getItems(string: String!, limit: Int?, then callback: ([Item], NSError?) -> Void)
    {
        var items: [Item] = []
        
        PFCloud.callFunctionInBackground("getItems", withParameters: ["string": string, "limit": limit ?? NSNull()])
            {
                (pfResults, error) in
                if error == nil
                {
                    for pfResult in pfResults as! [PFObject]
                    {
                        items.append(ParseDAO.getItem(pfResult))
                    }
                }
                
                callback(items, error)
        }
    }
}
