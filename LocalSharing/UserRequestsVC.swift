//
//  UserRequestsVC.swift
//  LocalSharing
//
//  Created by Ana Carolina Cabral on 17/03/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class UserRequestsVC: UITableViewController
{
    var userRequestsList: [Request] = []
    var dao: DAO()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        userRequestsList = dao.getUserRequests(page: 0, limit: 0) -> [Request]
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return userRequestsList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as RequestTVCell
        
        let request : Request = self.userRequestsList[indexPath.item]
        
        
        cell.textField?.text = request.item.name
        cell.userName?.text = request.author.name
        cell.userPicture.image = request.author.picture
        
        
        return cell
    }
}