//
//  RegisterResponse.swift
//  Taswak
//
//  Created by omar  on 18/05/2022.
//

import Foundation

struct RegisterResponse:Decodable{
    let status:Bool
    let message:String
    let data: RegisterData?
}

struct RegisterData:Decodable {
    let name:String
    let phone:String
    let email:String
    let id:Int
    let image:String
    let token:String
}
