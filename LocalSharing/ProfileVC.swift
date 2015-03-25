//
//  ProfileVC.swift
//  LocalSharing
//
//  Created by Ana Carolina Cabral on 16/03/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController
{
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var userName: UILabel!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var user = PFUser.currentUser()
        var str = user["photo"] as String
        var url = NSURL(string: str+"?type=large")
        var data = NSData(contentsOfURL: url!)
        self.userPicture.image = UIImage(data: data!)
        
        userName.text = user["name"] as? String

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    

}
