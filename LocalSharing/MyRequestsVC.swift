//
//  MyRequestsVC.swift
//  LocalSharing
//
//  Created by Ana Carolina Cabral on 17/03/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class MyRequestsVC: UITableViewController {
    var myRequestsList: [Request] = []

    override func viewDidLoad() {
        super.viewDidLoad()
                
//                PFCloud.callFunctionInBackground("getUserRequests", withParameters:[:]) {
//                    (result: AnyObject!, error: NSError!) -> Void in
//                    if error == nil {
//                        let results = result as NSMutableArray
//                        for result in results {
//                            let item = result["item"] as PFObject
//                            let autor = result["author"] as PFObject
//                            let pedido = Pedido()
//                            
//                            pedido.nomeItem = item["name"] as String
//                            pedido.autorPedido = autor["name"] as String
//                            pedido.autorFoto = autor["photo"] as String
//                            self.pedidosApp.addObject(pedido)
//                        }
//                        self.tableView.reloadData()
//                        
//                    }
//                }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
 
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return myRequestsList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as RequestTVCell
        
        let request : Request = self.myRequestsList[indexPath.item]
        
        
        cell.textField?.text = request.item.name
        cell.userName?.text = request.author.name
        cell.userPicture.image = request.author.picture
        
        
        return cell
    }
}