//
//  PedidosTableViewCell.swift
//  LocalSharing
//
//  Created by Ana Carolina Cabral on 17/03/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

import UIKit

class PedidosTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var nomeUsuario: UILabel!
    @IBOutlet weak var fotoUsuario: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.textField.delegate = self
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        println("digitando")
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.textField.resignFirstResponder()
        PFCloud.callFunctionInBackground("request", withParameters:["item" : textField.text]) {
            (result: AnyObject!, error: NSError!) -> Void in
            if error == nil {
            }
            else
            {
                println(error)
            }
        }
        self.textField.userInteractionEnabled = false
        
        return true
    }
}
