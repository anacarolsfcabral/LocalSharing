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
    var dao: DAO = DAOFactory.getDAO()
    var page: Int = 1
    var limit: Int = 30
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        dao.getDealingRequests(page, limit: limit, then: {
            (requests, error) in
            if error == nil {
                self.dealingsList += requests
                self.tableView.reloadData()
            }
        })
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return dealingsList.count
     }
}