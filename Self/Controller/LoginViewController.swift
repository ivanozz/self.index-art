//
//  ViewController.swift
//  Self
//
//  Created by admin on 27.04.2018.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController, SelfProtocol {
    
    let defaults = UserDataDefaults()
    
    var login : String = ""
    var password : String = ""
    
    var userId : String = ""
    var token : String = ""
    
    @IBOutlet var loginTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    @IBOutlet var containerLoginView: UIView!
    let selfApi = SelfApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        login = defaults.getLogin()
        password = defaults.getPassword()
        
        if login != "" && password != "" {
            runAuth(login: login, password: password)
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonEnterPressed(_ sender: UIButton) {
        
        if(loginTextfield.text == "") {
            SVProgressHUD.showError(withStatus: "Введите имя пользователя")
            return
        }
        
        if(passwordTextfield.text == "") {
            SVProgressHUD.showError(withStatus: "Введите пароль")
            return
        }
        
        if( loginTextfield.text != "" && passwordTextfield.text != "") {
            login = loginTextfield.text!
            password = passwordTextfield.text!
            runAuth(login: login, password: password)
        }
        
    }
    
    func tokenCreated(tokenInfo: ApiToken) {
        if tokenInfo.status {
            selfApi.auth(userId: String(tokenInfo.id), token: tokenInfo.token)
        } else {
            print(tokenInfo.error)
            SVProgressHUD.showError(withStatus: "Ошибка обращения к сервису")
        }
    }
    
    func authCompleted(authInfo: AuthResult, userId: Int, token: String) {
        if authInfo.status {
            SVProgressHUD.dismiss()
            self.userId = String(userId)
            self.token = token
            
            defaults.setLogin(value: login)
            defaults.setPassword(value: password)
            
            performSegue(withIdentifier: "goToSelf", sender: self)
        }
    }
    
    func runAuth(login: String, password: String) {
        //if(Reachability.isConnectedToNetwork()) {
            SVProgressHUD.show(withStatus: "Выполняется авторизация. Подождите...")
            selfApi.delegate = self
            selfApi.createTokenByLogin(login: login, password: password)
        /*} else {
            SVProgressHUD.showError(withStatus: "Подключение невозможно. Интернет-соедининение отсутствует.")
        }*/
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToSelf" {
            
            if let nav = segue.destination as? UINavigationController,
                let mainVC = nav.topViewController as? MainViewController {
                mainVC.userId = self.userId
                mainVC.token = self.token
            }
            
        }
        
    }
    
}

