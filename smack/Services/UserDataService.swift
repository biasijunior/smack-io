//
//  UserDataService.swift
//  smack
//
//  Created by Biasi on 3/16/18.
//  Copyright © 2018 Biasi. All rights reserved.
//

import Foundation
class UserDataService{
    static let instance = UserDataService()
    
    public private(set) var  id = ""
    public private(set) var  avatarName = ""
    public private(set) var  avatarColor = ""
    public private(set) var  name = ""
    public private(set) var  email = ""

    func setUserData(id: String, color: String, avartaName: String, email: String, name: String){
        self.id = id
        self.avatarName = avartaName
        self.email = email
        self.name = name
        self.avatarColor = color
    }
    
    func setAvartaName(avartaName: String){
        self.avatarName = avartaName
    }
    
    func returnUIColor(components: String) -> UIColor{
        let scanner = Scanner(string: components )
        let skipped = CharacterSet(charactersIn:  "[], ")
        let comma = CharacterSet(charactersIn:  ",")
        scanner.charactersToBeSkipped = skipped
        
        var r, g, b, a : NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaulColor = UIColor.lightGray
        
        guard let rUnwrapped = r else{ return defaulColor}
        guard let gUnwrapped = g else{ return defaulColor}
        guard let bUnwrapped = b else{ return defaulColor}
        guard let aUnwrapped = a else{ return defaulColor}
        
        let rfloat = CGFloat(rUnwrapped.doubleValue)
        let gfloat = CGFloat(gUnwrapped.doubleValue)
        let bfloat = CGFloat(bUnwrapped.doubleValue)
        let afloat = CGFloat(aUnwrapped.doubleValue)
        
        let newUIcolor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        
        return newUIcolor
        
    }
    
    func logoutUser(){
        
        id = ""
        avatarName = ""
        avatarColor = ""
        name = ""
        email = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
    }
    
    
    
    
    

}
