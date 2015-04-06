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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "presentAlert:", name: "goToAlert", object: nil);
        
        RequestDAO.getRequests(page, limit: 20) { (requests, error) -> Void in
            if error == nil
            {
                self.requestsList += requests
                self.tableView.reloadData()
            }
        }
        
        var feedIconBar: UITabBarItem = self.tabBarController?.tabBar.items![0] as UITabBarItem
        feedIconBar.image = UIImage(named: "feedIcon")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        var tradeIconBar: UITabBarItem = self.tabBarController?.tabBar.items![1] as UITabBarItem
        tradeIconBar.image = UIImage(named: "tradeIcon")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        var messageIconBar: UITabBarItem = self.tabBarController?.tabBar.items![2] as UITabBarItem
        messageIconBar.image = UIImage(named: "messageIcon")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        var profileIconBar: UITabBarItem = self.tabBarController?.tabBar.items![3] as UITabBarItem
        profileIconBar.image = UIImage(named: "profileIcon")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        
        
        
        var backgroundView = UIView(frame: CGRectZero)
        self.tableView.tableFooterView = backgroundView
        self.tableView.separatorInset = UIEdgeInsetsZero
        self.tableView.backgroundColor = UIColor.whiteColor()

        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
    }
    
    func presentAlert(notification:NSNotification){
        let alert: AlertVC = AlertVC()
        alert.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        presentViewController(alert, animated: true, completion: nil)
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
        
        cell.parent = self
        cell.request = request
        cell.textField?.text = request.item?.name
        cell.userName?.text = request.author.name
        cell.userPicture?.image = request.author.picture
        cell.userPicture.layer.borderWidth=2.0
        cell.userPicture.layer.masksToBounds = false
        cell.userPicture.layer.borderColor = UIColor(red: 41.0/255, green: 166.0/255, blue: 117.0/255, alpha: 1.0).CGColor
        cell.userPicture.layer.cornerRadius = cell.userPicture.frame.size.height/2
        cell.userPicture.clipsToBounds = true
        
        cell.layoutMargins = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        
        if editingStyle == .Delete
        {
            let request : Request = self.requestsList[indexPath.item]
            
            if request.author.id == UserDAO.getCurrentUser()?.id
            {
                self.requestsList.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                
                RequestDAO.closeRequest(request, successful: false, then: { (request, error) -> Void in
                    if error == nil
                    {
                    }
                })
            }
        }
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle
    {
        let request : Request = self.requestsList[indexPath.item]
        
        if request.author.id != UserDAO.getCurrentUser()?.id
        {
            return UITableViewCellEditingStyle.None
        }
        else
        {
            return UITableViewCellEditingStyle.Delete
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (sender as? RequestTVCell) != nil
        {
            let cell = sender as RequestTVCell
            let destination = segue.destinationViewController as DealingVC
            destination.request = cell.request
        }
    }
    
}
