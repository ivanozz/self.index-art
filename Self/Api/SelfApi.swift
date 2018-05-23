//
//  Self.swift
//  Self
//
//  Created by admin on 28.04.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol SelfProtocol {
    func tokenCreated(tokenInfo: ApiToken)
    func authCompleted(authInfo: AuthResult, userId: Int, token: String)
}

protocol NewsProtocol {
    func newsLoaded(list: [News])
}

class SelfApi {
    
    let API_URL = "https://self.index-crm.ru/tree/api/api.php"
    let AUTH_HEADER = "Basic aW5kZXg6VHJvZ2xvZGl0MjY="
    
    let info = ApiToken()
    let auth = AuthResult()
    
    var newsArray : [News] = [News]()
    
    var delegate : SelfProtocol?
    var delegateNews : NewsProtocol?
    
    func createTokenByLogin(login: String, password: String) {
        
        let params: [String : String] = [
            "module": "users",
            "method": "createTokenByLogin",
            "login": login,
            "password": password
        ]
        
        Alamofire.request(API_URL, method: .get, parameters: params, encoding: URLEncoding.default, headers: ["Authorization": AUTH_HEADER]).responseJSON {
            response in
            
            if response.result.isSuccess {
                let tokenResponseJson : JSON = JSON(response.result.value!)
                
                self.info.id = tokenResponseJson["id"].intValue
                self.info.error = tokenResponseJson["error"].stringValue
                self.info.in_home_net = tokenResponseJson["in_home_net"].boolValue
                self.info.status = tokenResponseJson["status"].boolValue
                self.info.token = tokenResponseJson["token"].stringValue
                
            } else {
                self.info.error = "Request wrong \(response.result.error!)"
            }
            
            self.delegate?.tokenCreated(tokenInfo: self.info)
        }
    }
    
    func auth(userId: String, token: String) {
        
        let params: [String : String] = [
            "module": "users",
            "method": "auth",
            "user_id": userId,
            "token": token
        ]
            
        Alamofire.request(API_URL, method: .get, parameters: params, encoding: URLEncoding.default, headers: ["Authorization":
                AUTH_HEADER]).responseJSON {
            response in
            if response.result.isSuccess {
                let newsResponseJson : JSON = JSON(response.result.value!)
                self.auth.status = newsResponseJson["status"].boolValue
            } else {
                self.auth.error = "Request wrong \(response.result.error!)"
            }
            self.delegate?.authCompleted(authInfo: self.auth, userId: Int(userId)!, token: token)
        }
    }
    
    func getNews(userId: String, token: String) {
        let params: [String : String] = [
            "module": "news",
            "method": "getList",
            "user_id": userId,
            "token": token
        ]
        
        Alamofire.request(API_URL, method: .get, parameters: params, encoding: URLEncoding.default, headers: ["Authorization":
            AUTH_HEADER]).responseJSON {
                response in
                var newsList : [News] = []
                if response.result.isSuccess {
                    let newsResponseJson : JSON = JSON(response.result.value!)
                    
                    for (_, news) in newsResponseJson["list"] {
                        let newsOne = News()
                        newsOne.id = news["id"].stringValue
                        newsOne.name = news["name"].stringValue
                        newsOne.text = news["text"].stringValue
                        newsOne.short_text = news["short_text"].stringValue
                        newsOne.autor = news["autor"].stringValue
                        newsOne.date = news["date"].stringValue
                        
                        newsList.append(newsOne)
                    }
                } else {
                    self.auth.error = "Request wrong \(response.result.error!)"
                }
                self.delegateNews?.newsLoaded(list: newsList)
        }
    }
    
    
}
