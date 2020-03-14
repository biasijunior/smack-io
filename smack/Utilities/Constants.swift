//
//  Constants.swift
//  smack
//
//  Created by Biasi on 3/13/18.
//  Copyright © 2018 Biasi. All rights reserved.
//

import Foundation
import Alamofire

typealias ComplitionHandler = (_ Success: Bool) -> ()

//URL_CONSTATS

//http://localhost:3005
let BASE_URL = "https://quizito.herokuapp.com/v1/"
//let BASE_URL = "http://127.0.0.1:3005/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)channel"

//COLORS
let smackPurpleColor = #colorLiteral(red: 0.3266413212, green: 0.4215201139, blue: 0.7752227187, alpha: 0.6762093322)

//Notification Constants
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("userDataChanged")


//to segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindtoChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

//USER DEFAULTS
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//HEADERS
let HEADER = [
    "Content-Type": "application/json"
]

let BEARER_HEADER = [
    "Authorization":"Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]
