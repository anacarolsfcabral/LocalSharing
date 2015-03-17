//
//  Perfil.swift
//  LocalSharing
//
//  Created by Ana Carolina Cabral on 16/03/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class Perfil: UIViewController {
    @IBOutlet weak var fotoUsuario: UIImageView!
    @IBOutlet weak var nomeUsuario: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var user = PFUser.currentUser()
        var str = user["photo"] as String
        var url = NSURL(string: str+"?type=large")
        var data = NSData(contentsOfURL: url!)
        self.fotoUsuario.image = UIImage(data: data!)
        
        nomeUsuario.text = user["name"] as? String

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
