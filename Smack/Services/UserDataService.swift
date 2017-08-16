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
    
    func updateAvatarName(avatarName:String){
        self.avatarName = avatarName
    }
    
    func setAvatarName(avatarName:String){
        self.avatarName = avatarName
    }
    
}
