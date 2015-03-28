//
//  DAOFactory.swift
//  LocalSharing
//
//  Created by Diego Haz on 3/28/15.
//  Copyright (c) 2015 Ana Carolina Cabral. All rights reserved.
//
//  This class acts as a Singleton for instantiating concrete DAO's in front-end. Usage:
//  let dao: DAO = DAOFactory.getDAO()
//  If data source changes, just update the line:
//  Static.dao = SourceDAO()

class DAOFactory {
    private struct Static {
        static var dao: DAO?
    }
    
    class func getDAO() -> DAO {
        if (Static.dao == nil) {
            Static.dao = ParseDAO()
        }
        
        return Static.dao!
    }
}
