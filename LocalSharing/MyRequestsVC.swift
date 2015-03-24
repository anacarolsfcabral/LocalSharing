//
//  MyRequestsVC.swift
//  LocalSharing
//
//  Created by Ana Carolina Cabral on 17/03/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class MyRequestsVC: UITableViewController {
    
    var requests:NSMutableArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
                
                PFCloud.callFunctionInBackground("getUserRequests", withParameters:[:]) {
                    (result: AnyObject!, error: NSError!) -> Void in
                    if error == nil {
                        let results = result as NSMutableArray
                        for result in results {
                            let item = result["item"] as PFObject
                            let autor = result["author"] as PFObject
                            let pedido = Pedido()
                            
                            pedido.nomeItem = item["name"] as String
                            pedido.autorPedido = autor["name"] as String
                            pedido.autorFoto = autor["photo"] as String
                            self.pedidosApp.addObject(pedido)
                        }
                        self.tableView.reloadData()
                        
                    }
                }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
 
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return pedidosApp.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as RequestsTVCell
        
        let pedido : Pedido? = self.pedidosApp[indexPath.item] as? Pedido
        
        if pedido == nil
        {
            let currentUser = PFUser.currentUser() as PFUser
            
            cell.textField.userInteractionEnabled = true
            cell.nomeUsuario.text = currentUser["name"] as? String
            var str = currentUser["photo"] as String
            var url = NSURL(string: str)
            var data = NSData(contentsOfURL: url!)
            cell.fotoUsuario.image = UIImage(data: data!)
            
        }
        else
        {
            cell.textField?.text = pedido?.nomeItem
            cell.nomeUsuario?.text = pedido?.autorPedido
            var str = pedido?.autorFoto
            var url = NSURL(string: str!)
            var data = NSData(contentsOfURL: url!)
            cell.fotoUsuario.image = UIImage(data: data!)
        }
        
        return cell
    }
