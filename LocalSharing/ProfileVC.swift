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
        self.userPicture.image = user?.pictureLarge
        self.userPicture.layer.borderWidth=1.0
        self.userPicture.layer.masksToBounds = false
        self.userPicture.layer.borderColor = UIColor.whiteColor().CGColor
        //self.userPicture.layer.cornerRadius = 13
        self.userPicture.layer.cornerRadius = self.userPicture.frame.size.height/2
        self.userPicture.clipsToBounds = true
        
        userName.text = user?.name

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    

}
