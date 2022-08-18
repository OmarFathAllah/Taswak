//
//  CartResponse.swift
//  Taswak
//
//  Created by omar  on 21/05/2022.


import Foundation

struct CartResponse:Decodable {
    let status:Bool
    let message: String
    let data:CartData?
}

struct CartData: Decodable {
    let id:Int
    let quantity:Int
    let product:ProductData?
}

struct ProductData:Decodable {
    let id:Int
    let price: Int
    let old_price: Int
    let discount: Int
    let image: String
}

