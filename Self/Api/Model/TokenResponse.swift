//
//  createTokenByLogin.swift
//  Self
//
//  Created by admin on 28.04.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import SwiftyJSON

class TokenResponse {
    
    var status : Bool
    var error : String
    var token : String
    var id : Int
    var in_home_net : Bool

    //init(response: JSON) {
//        status = response.status ? response.status : false
//        error = response.error ? response.error : ""
//        token = response.token ? response.token : ""
//        id = response.id ? response.id : 0
//        in_home_net = response.in_home_net ? response.in_home_net : false
    //}
}
