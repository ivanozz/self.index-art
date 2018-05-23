//
//  ApiToken.swift
//  Describe data structrure what getting as result handling request
//  https://self.index-crm.ru/tree/api/api.php?module=users&method=createTokenByLogin&login=&password=
//
//  Created by admin on 05.05.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

class ApiToken {
    
    var status : Bool = false
    var error : String = ""
    var token : String = ""
    var id : Int = 0
    var in_home_net: Bool = false
    
}
