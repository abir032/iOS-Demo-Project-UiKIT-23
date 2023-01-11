//
//  Post.swift
//  MdFahimFaezAbir-30028
//
//  Created by Bjit on 4/1/23.
//

import Foundation
struct Post: Decodable, Encodable{
    let id: Int
    let title, body: String
}
extension Post{
    static var post = [Post]()
}
