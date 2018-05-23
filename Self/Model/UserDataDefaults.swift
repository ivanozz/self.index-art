//
//  UserDataDefaults.swift
//  Self
//
//  Created by admin on 13.05.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

class UserDataDefaults {
    
    var login : String = ""
    var password : String = ""
    let defaults : UserDefaults
    
    init() {
        defaults = UserDefaults.standard
    }
    
    func getLogin() -> String {
        let value = defaults.string(forKey: "login")
        return value != nil ? value! : ""
    }
    
    func getPassword() -> String {
        let value = defaults.string(forKey: "password")
        return value != nil ? value! : ""
    }
    
    func setLogin(value: String) {
        defaults.set(value, forKey: "login")
    }
    
    func setPassword(value: String) {
        defaults.set(value, forKey: "password")
    }
}
