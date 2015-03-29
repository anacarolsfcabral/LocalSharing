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
    var dao: DAO = DAOFactory.getDAO()
    
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var userName: UILabel!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var user = dao.getCurrentUser()
        
        self.userPicture.image = user?.picture
        self.userName.text = user?.name

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    

}
