//
//  DAO.swift
//  LocalSharing
//
//  Created by Giancarlo Diaz Cavalcante on 3/23/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//

// DAO = Data Access Object

// Nessa classe... EXPLICA TUDO SOBRE O DAO AQUI!

import UIKit

class DAO
{
    func getRequests (limit: Int?, page: Int?) -> [Request]
    {
        var resultTemp: [Request] = []
        var user1 = User(id: "01", name: "Fábio", picture: UIImage(named: "foto-Fabio"), requestLimit: 3)
        var user2 = User(id: "02", name: "Lucas", picture: UIImage(named: "foto-Lucas"), requestLimit: 3)
        var user3 = User(id: "03", name: "Pietro", picture: UIImage(named: "foto-Pietro"), requestLimit: 3)
        var user4 = User(id: "04", name: "Giancarlo", picture: UIImage(named: "foto-Giancarlo"), requestLimit: 3)
        
        var item1 = Item(id: "01", name: "Livro de Design Patterns")
        var item2 = Item(id: "02", name: "Esmalte")
        var item3 = Item(id: "03", name: "Calculadora")
        var item4 = Item(id: "04", name: "Remédio para dor de cabeça")
        
        resultTemp.append(Request(id: "01", author: user1, item: item1, dealing: false, closed: false, expired: false))
        resultTemp.append(Request(id: "02", author: user2, item: item2, dealing: false, closed: false, expired: false))
        resultTemp.append(Request(id: "03", author: user3, item: item3, dealing: false, closed: false, expired: false))
        resultTemp.append(Request(id: "04", author: user4, item: item4, dealing: false, closed: false, expired: false))
        
        return resultTemp
    }
    
}
