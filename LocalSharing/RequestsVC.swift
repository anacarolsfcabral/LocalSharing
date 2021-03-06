//
//  RequestsVC.swift
//  LocalSharing
//
//  Created by Ana Carolina Cabral on 16/03/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

var isCreatingItem: Bool = false

class RequestsVC: UITableViewController
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
        
        self.tabBarController?.becomeFirstResponder()
        
        let feedIconBar: UITabBarItem = self.tabBarController!.tabBar.items![0]
        feedIconBar.image = UIImage(named: "feedIcon")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        let tradeIconBar: UITabBarItem = self.tabBarController!.tabBar.items![1] 
        tradeIconBar.image = UIImage(named: "tradeIcon")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        let messageIconBar: UITabBarItem = self.tabBarController!.tabBar.items![2] 
        messageIconBar.image = UIImage(named: "messageIcon")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        let profileIconBar: UITabBarItem = self.tabBarController!.tabBar.items![3]
        profileIconBar.image = UIImage(named: "profileIcon")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        
        
        
        let backgroundView = UIView(frame: CGRectZero)
        self.tableView.tableFooterView = backgroundView
        self.tableView.separatorInset = UIEdgeInsetsZero
        self.tableView.backgroundColor = UIColor.whiteColor()

        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func insertNewRequest(sender: UIBarButtonItem)
    {
        if !isCreatingItem
        {
        
            if UserDAO.getCurrentUser()?.requestLimit == 0
            {
                let alert = UIAlertView()
                alert.title = "Ops!"
                alert.message = "Acabaram seus RPs!"
                alert.addButtonWithTitle("Ok")
                alert.show()
            }
            else
            {
                requestsList.insert(Request(author: UserDAO.getCurrentUser()!), atIndex: 0)
                let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                
                let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! RequestTVCell
                cell.textField.becomeFirstResponder()
                isCreatingItem = false
            }
        }
    
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
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! RequestTVCell
        
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
        cell.userPicture.layer.masksToBounds = false
        cell.userPicture.layer.cornerRadius = cell.userPicture.frame.size.height/2
        cell.userPicture.clipsToBounds = true
                
        if request.author.id == UserDAO.getCurrentUser()?.id
        {
            cell.hideButton()
        }
        
        cell.layoutMargins = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        
        if editingStyle == .Delete
        {
            let request : Request = self.requestsList[indexPath.item]
            
            if request.id != nil && request.author.id == UserDAO.getCurrentUser()?.id
            {
                
                RequestDAO.closeRequest(request, successful: false, then: { (request, error) -> Void in
                    if error == nil
                    {
                    }
                })
            }
            
            self.requestsList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
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
            let cell = sender as! RequestTVCell
            let destination = segue.destinationViewController as! DealingVC
            destination.request = cell.request
        }
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        print("Opa!")
    }
}

//var alert = UIAlertController(title: "Ops!", message: "Você esqueceu de preencher o item!", preferredStyle: UIAlertControllerStyle.Alert)
//alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
//self.presentViewController(alert, animated: true, completion: nil)
