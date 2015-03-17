//
//  FirstViewController.swift
//  LocalSharing
//
//  Created by Ana Carolina Cabral on 16/03/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class FirstViewController: UITableViewController {
    var pedidosApp:NSMutableArray = NSMutableArray()
    
    //var detailViewController: DetailViewController? = nil
    var objects = [AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        getRequests()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        
        
        
//        if let split = self.splitViewController {
//            let controllers = split.viewControllers
//            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(sender: AnyObject) {
        
        pedidosApp.insertObject(NSNull(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        
        var cell = self.tableView.cellForRowAtIndexPath(indexPath) as PedidosTableViewCell
        cell.textField.becomeFirstResponder()
    }

    func getRequests ()
    {
    
        PFCloud.callFunctionInBackground("getRequests", withParameters:[:]) {
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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return pedidosApp.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as PedidosTableViewCell
        
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
