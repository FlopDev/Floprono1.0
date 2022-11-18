//
//  User.swift
//  FloProno1.0
//
//  Created by Florian Peyrony on 19/10/2022.
//  Copyright © 2022 Florian Peyrony. All rights reserved.
//

import Foundation

struct User {

   var username = ""

   var email = ""
    
    var isAdmin: Bool? = false {
        
        didSet {
            isAdmin = isAdmin ?? false
        }
    }
    

}
