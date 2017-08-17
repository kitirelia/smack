//
//  UserDataService.swift
//  Smack
//
//  Created by kitiwat chanluthin on 8/16/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import Foundation

class UserDataService {
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserDataService(id:String,avatarColor:String,avatarName:String,email:String,name:String){
        self.id = id
        self.avatarColor = avatarColor
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    
    //JohnyB
    func setUserData(id: String, color: String, avatarName: String, email: String, name: String) {
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    //-----
    
    
    func updateAvatarName(avatarName:String){
        self.avatarName = avatarName
    }
    
    func setAvatarName(avatarName:String){
        self.avatarName = avatarName
    }
    
    func returnUIColor(component:String)->UIColor{
        let scanner = Scanner(string:component)
        let skipped = CharacterSet(charactersIn: "[],")
        let comma = CharacterSet(charactersIn:",")
        scanner.charactersToBeSkipped = skipped
        
        var r,g,b,a: NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaulColor = UIColor.lightGray
        
        guard let rUnwrapped = r else { return defaulColor }
        guard let gUnwrapped = g else { return defaulColor }
        guard let bUnwrapped = b else { return defaulColor }
        guard let aUnwrapped = a else { return defaulColor }
        
        let rfloat = CGFloat(rUnwrapped.doubleValue)
        let gfloat = CGFloat(gUnwrapped.doubleValue)
        let bfloat = CGFloat(bUnwrapped.doubleValue)
        let afloat = CGFloat(aUnwrapped.doubleValue)
        
        let newUIColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        
        return newUIColor
    }
    
    func logoutUser(){
        self.id = ""
        self.avatarColor = ""
        self.avatarName = ""
        self.email = ""
        self.name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
        MessageService.instance.clearChannels()
    }
    
}
