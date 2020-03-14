//
//  AuthService.swift
//  smack
//
//  Created by Biasi on 3/15/18.
//  Copyright © 2018 Biasi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService{
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool {
        get{
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set{
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    
    var authToken: String{
        get{
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set{
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String{
        get{
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set{
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping ComplitionHandler){
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            
            if response.result.error == nil {
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping ComplitionHandler){
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {

                //          THE APPLE WAY
                if let json = response.result.value as? Dictionary<String, Any>{
                        if let email = json["user"] as? String{
                                        self.userEmail = email
                                    }
                
                                if let token = json["token"] as? String{
                                    self.authToken = token
                                }
                            }
//USING SWIFT JSON
//
//                guard let data = response.data else { return }
//                let jso = JSON(data: data)
//                self.userEmail = jso["user"].stringValue
//                self.authToken = jso["token"].stringValue
                self.isLoggedIn = true
                completion(true)
            }
                
            else{
                completion(false)
                print(response.result.error as Any)
            }
        }
        
    }
    
    
    func creatUser(name: String, email:String, avartName: String, avartaColor: String, completion: @escaping ComplitionHandler){
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avartName,
            "avatarColor": avartaColor
        ]
        
  
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                if let json = response.result.value as? Dictionary<String, Any> {
                    
                    self.setUserInfo(data: json)
//                    let name = json["name"] as? String
//                    let email = json["email"] as? String
//                    let avatarName = json["avatarName"] as? String
//                    let color = json["avatarColor"] as? String
//                    let id = json["_id"] as? String
//
//                    UserDataService.instance.setUserData(id: id!, color: (color)!, avartaName: (avatarName)!, email: email!, name: name!)
   
                    completion(true)
                    
                }else{
                    completion(false)
                   
                    debugPrint(response.result.error as Any)
                }
            }
        }
        
    }
    
    func findUserByEmail(completion: @escaping ComplitionHandler){
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                debugPrint(response as Any)
                print("first in")
            }
        }
    }
    
    
    
    
    func setUserInfo(data: Dictionary<String, Any>){
        
        let name = data["name"] as? String
        let email = data["email"] as? String
        let avatarName = data["avatarName"] as? String
        let color = data["avatarColor"] as? String
        let id = data["_id"] as? String
    
        UserDataService.instance.setUserData(id: id!, color: (color)!, avartaName: (avatarName)!, email: email!, name: name!)
    }
    
    
}
    

