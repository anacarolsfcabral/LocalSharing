//
//  DealingVC.swift
//  LocalSharing
//
//  Created by Ana Carolina Cabral on 06/04/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class DealingVC: UIViewController {

    var page: Int = 1
    var messages: [Message] = []
    var request: Request?
    @IBOutlet weak var viewTextField: UIView!
    @IBOutlet weak var dealingTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MessageDAO.getMessages(request, page: page, limit: 30) { (message, error) -> Void in
            if error == nil
            {
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
