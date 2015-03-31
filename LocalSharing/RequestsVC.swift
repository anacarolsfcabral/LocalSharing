//
//  RequestsVC.swift
//  LocalSharing
//
//  Created by Ana Carolina Cabral on 16/03/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class RequestsVC: UITableViewController, UITableViewDataSource
{
    var requestsList: [Request] = []
    var page: Int = 1
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        RequestDAO.getRequests(page, limit: 20) { (requests, error) -> Void in
            if error == nil
            {
                self.requestsList += requests
                self.tableView.reloadData()
            }
        }
        
        var backgroundView = UIView(frame: CGRectZero)
        self.tableView.tableFooterView = backgroundView
        self.tableView.backgroundColor = UIColor.whiteColor()

        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func insertNewRequest(sender: UIBarButtonItem) {
        
        requestsList.insert(Request(author: UserDAO.getCurrentUser()!), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        
        var cell = self.tableView.cellForRowAtIndexPath(indexPath) as RequestTVCell
        cell.textField.becomeFirstResponder()
    
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
        return requestsList.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as RequestTVCell
        
        let request : Request = self.requestsList[indexPath.item]
        
        if request.item ==  nil
        {
            cell.textField.userInteractionEnabled = true;
        }
        
        cell.textField?.text = request.item?.name
        cell.userName?.text = request.author.name
        cell.userPicture?.image = request.author.picture
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        
        if editingStyle == .Delete
        {
            let request : Request = self.requestsList[indexPath.item]
            
            if request.author.name == UserDAO.getCurrentUser()?.name
            {
                self.requestsList.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                
                //sem certeza se o método abaixo está deletando do DB
                RequestDAO.closeRequest(request, successful: false, then: { (request, error) -> Void in
                    if error == nil
                    {
                    
                    }
                })
            }
            else
            {
                if editingStyle == .None
                {
                
                }
                self.editButtonItem().enabled = false
            }
            
        }
    }
    
}
