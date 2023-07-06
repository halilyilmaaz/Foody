//
//  LoginUserReq.swift
//  Foody
//
//  Created by halil yılmaz on 14.06.2023.
//

import Foundation

struct LoginUserModel {
    let email: String
    let password: String
}


struct User: Codable {
    var username: String?
    var email: String
    var userUID: String
}
