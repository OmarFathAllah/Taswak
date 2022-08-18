//
//  AddDeleteFavoriteResponse.swift
//  Taswak
//
//  Created by omar  on 25/07/2022.
//

import Foundation
struct AddDeleteFavoriteResponse:Decodable{
    let status:Bool
    let message:String
    let data:FavoriteData
}
struct FavoriteData:Decodable {
    let id:Int
    let product:FavoriteProduct
}
struct FavoriteProduct:Decodable {
    let id:Int
    let price:Double
    let oldPrice:Double?
    let discount:Double?
    let image:String
    
    enum CodinKeys:String,CodingKey {
        case oldPrice = "old_price"
    }
}
