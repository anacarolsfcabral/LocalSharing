//
//  RequestsVC.swift
//  LocalSharing
//
//  Created by Ana Carolina Cabral on 16/03/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class RequestsVC: UITableViewController {
    var requestsList: [Request] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRequests()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        
        
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(sender: AnyObject) {
        
        requests.insertObject(NSNull(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        
        var cell = self.tableView.cellForRowAtIndexPath(indexPath) as RequestsTVCell
        cell.textField.becomeFirstResponder()
    }

//    func getRequests ()
//    {
//    
//        PFCloud.callFunctionInBackground("getRequests", withParameters:[:]) {
//            (result: AnyObject!, error: NSError!) -> Void in
//            if error == nil {
//                let results = result as NSMutableArray
//                for result in results {
//                    let item = result["item"] as PFObject
//                    let author = result["author"] as PFObject
//                    let request = Pedido()
//                    
//                    pedido.nomeItem = item["name"] as String
//                    pedido.autorPedido = autor["name"] as String
//                    pedido.autorFoto = autor["photo"] as String
//                    self.pedidosApp.addObject(pedido)
//                }
//                self.tableView.reloadData()
//                
//            }
//        }
    
    
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return requestsList.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as RequestTVCell
        
        let request : Request = self.requestsList[indexPath.item]
        
        
        cell.textField?.text = request.item.name
        cell.userName?.text = request.author.name
        cell.userPicture.image = request.author.picture
        
        return cell
    }
    
}
