//
//  User.swift
//  MdFahimFaezAbir-30028
//
//  Created by Bjit on 6/1/23.
//

import Foundation


struct UserInfo: Codable{
    var userId: Int32
    var userName: String
    var userEmail: String
    var userPassword: String
    var isLoggedIn: Bool
}
