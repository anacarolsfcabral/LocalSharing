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
        
        var user = UserDAO.getCurrentUser()
        self.userPicture.image = user?.picture
        
        userName.text = user?.name

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    

}
