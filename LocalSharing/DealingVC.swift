//
//  DealingVC.swift
//  LocalSharing
//
//  Created by Ana Carolina Cabral on 06/04/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class DealingVC: UIViewController, UITextFieldDelegate, UITableViewDelegate {

    var page: Int = 1
    var messages: [Message] = []
    var request: Request?
    @IBOutlet weak var viewTextField: UITextField!
    @IBOutlet weak var dealingTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MessageDAO.getMessages(request, page: page, limit: 30) { (messages, error) -> Void in
            if error == nil
            {
                self.messages += messages
                self.dealingTableView.reloadData()
            }
        }
        
        self.viewTextField.delegate = self
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        MessageDAO.sendMessage(request, content: self.viewTextField.text) { (message, error) -> Void in
            print(message)
            self.messages.append(message!)
            self.dealingTableView.reloadData()
        }
        
        self.viewTextField.text = ""
        
        return true
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) 
        
        let message : Message = self.messages[indexPath.item]
       
        cell.textLabel?.text = message.content
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
