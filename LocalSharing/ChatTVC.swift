//
//  ChatTVC.swift
//  LocalSharing
//
//  Created by Giancarlo Diaz Cavalcante on 3/23/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class ChatTVC: UITableViewController
{
    var dealingsList: [Request] = []
    var page: Int = 1
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        RequestDAO.getDealingRequests(page, limit: 10) { (dealings, error) -> Void in
            if error == nil
            {
                self.dealingsList += dealings
                self.tableView.reloadData()
            }
        }
        
        var backgroundView = UIView(frame: CGRectZero)
        self.tableView.tableFooterView = backgroundView
        self.tableView.backgroundColor = UIColor.whiteColor()
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
     }
}