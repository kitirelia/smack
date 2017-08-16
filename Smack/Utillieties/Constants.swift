//
//  Constants.swift
//  Smack
//
//  Created by kitiwat chanluthin on 8/15/17.
//  Copyright © 2017 kitiwat chanluthin. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success:Bool)->()

//URL Constants

let BASE_URL = "https://chatservice3141.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"

// Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

// User DefaultsFoundation
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//Header
let HEADER  = ["Content-Type" : "application/json; charset = utf-8"]

//Colorapplicationlet
let smackPurplePlaceHolder = #colorLiteral(red: 0.3373009264, green: 0.3880975246, blue: 0.7862270474, alpha: 0.5665132705)

//Notification
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notiUserDataChanged")
