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
    var page: Int = 1

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        RequestDAO.getUserRequests(page, limit: 10) { (requests, error) -> Void in
            if error == nil
            {
               self.userRequestsList += requests
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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return userRequestsList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! RequestTVCell
        
        let request : Request = self.userRequestsList[indexPath.item]
        
        
        cell.textField?.text = request.item?.name
        cell.userName?.text = request.author.name
        cell.userPicture?.image = request.author.picture
        cell.userPicture.layer.masksToBounds = false
        cell.userPicture.layer.cornerRadius = cell.userPicture.frame.size.height/2
        cell.userPicture.clipsToBounds = true
        
        
        return cell
    }
}