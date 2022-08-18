//
//  OneCategory.swift
//  Taswak
//
//  Created by omar  on 16/03/2022.
//

import Foundation

// MARK: - Welcome
struct OneCategory: Decodable {
//    let status: Bool
//    let message: JSONNull?
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Decodable {
//    let currentPage: Int
    let data: [OneProduct]
//    let firstPageURL: String
//    let from, lastPage: Int
//    let lastPageURL: String
//    let nextPageURL: JSONNull?
//    let path: String
//    let perPage: Int
//    let prevPageURL: JSONNull?
//    let to, total: Int

//    enum CodingKeys: String, CodingKey {
//        case currentPage = "current_page"
//        case data
//        case firstPageURL = "first_page_url"
//        case from
//        case lastPage = "last_page"
//        case lastPageURL = "last_page_url"
//        case nextPageURL = "next_page_url"
//        case path
//        case perPage = "per_page"
//        case prevPageURL = "prev_page_url"
//        case to, total
//    }
}

// MARK: - Datum
struct OneProduct: Decodable {
    let id: Int
    let price, oldPrice: Double?
    let discount: Int?
    let image: String
    let name, description: String
    let images: [String]
    let inFavorites, inCart: Bool

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case price = "price"
        case oldPrice = "old_price"
        case discount = "discount"
        case image = "image"
        case name = "name"
        case description = "description"
        case images = "images"
        case inFavorites = "in_favorites"
        case inCart = "in_cart"
    }
}

// MARK: - Encode/decode helpers
//
//class JSONNull: Decodable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
