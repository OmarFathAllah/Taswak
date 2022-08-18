//
//  FavoritesItems.swift
//  Taswak
//
//  Created by omar  on 25/07/2022.
//

import Foundation
struct FavoritesItems: Decodable {
    let status: Bool
    let message: String?
    let data: FavoritesComponents
}

// MARK: - DataClass
struct FavoritesComponents: Decodable {
    let data: [FavDatum]
    

}

// MARK: - Datum
struct FavDatum: Decodable {
    let id: Int
    let product: Favorites
}
struct Favorites:Decodable {
    let id:Int
    let price:Double
    let oldPrice:Double?
    let discount:Double?
    let image:String
    let name:String
    
    enum CodinKeys:String,CodingKey {
        case oldPrice = "old_price"
    }
}
