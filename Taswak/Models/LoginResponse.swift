//
//  LoginResponse.swift
//  Taswak
//
//  Created by omar  on 09/05/2022.
//

import Foundation
struct LoginResponse:Decodable {
    let status:Bool
    let message: String
    let data:LoginData?
}

struct LoginData: Codable {
    let id:Int
    let name:String
    let email:String
    let phone:String
    let image: String
    let points: Int
    let credit: Int
    let token: String
}
