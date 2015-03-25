//
//  RequestsVC.swift
//  LocalSharing
//
//  Created by Ana Carolina Cabral on 16/03/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class RequestsVC: UITableViewController
{
    var requestsList: [Request] = []
    var dao: DAO = ParseDAO()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        requestsList = dao.getRequests(0, limit: 0)
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func insertNewRequest(sender: UIBarButtonItem) {
        
        //requestsList.insert(NSNull(), atIndex: 0)
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
        
        
        cell.textField?.text = request.item.name
        cell.userName?.text = request.author.name
        cell.userPicture.image = request.author.picture
        
        return cell
    }
    
}
