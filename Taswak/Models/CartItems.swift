//
//  CartItems.swift
//  Taswak
//
//  Created by omar  on 21/05/2022.
//

//import Foundation
//
//struct CartItems:Decodable {
//    let status:Bool
//    let message: String?
//    let data:CartComponent?
//
//
//}
//struct CartComponent:Decodable {
//    let cart_items:[OneProduct]
//    let sub_total:Int
//    let total:Int
//    let
//}


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct CartItems: Decodable {
    let status: Bool
    let message: JSONNull?
    let data: CartComponent
}

// MARK: - DataClass
struct CartComponent: Decodable {
    let cartItems: [CartItem]
    let total: Double
    let subTotal: Double

    enum CodingKeys: String, CodingKey {
        case cartItems = "cart_items"
        case subTotal = "sub_total"
        case total
    }
}

// MARK: - CartItem
struct CartItem: Decodable {
    let id, quantity: Int
    let product: Product
}

// MARK: - Product
struct Product: Decodable {
    let id, discount: Int
    let price:Double
    let oldPrice:Double
    let image: String
    let name, productDescription: String
    let images: [String]
    let inFavorites, inCart: Bool

    enum CodingKeys: String, CodingKey {
        case id, price
        case oldPrice = "old_price"
        case discount, image, name
        case productDescription = "description"
        case images
        case inFavorites = "in_favorites"
        case inCart = "in_cart"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Decodable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

