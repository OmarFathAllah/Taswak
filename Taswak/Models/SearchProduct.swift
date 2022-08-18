//
//  SearchProduct.swift
//  Taswak
//
//  Created by omar  on 24/07/2022.
//

import Foundation


// MARK: - Welcome
struct SearchProduct: Decodable {
    let status: Bool
//    let message: String?
    let data: SearchData
}

// MARK: - DataClass
struct SearchData: Decodable {
    let currentPage: Int
    let data: [OneProduct]
//    let firstPageURL: String
//    let from: Int
//    let  lastPage: Int
//    let lastPageURL: String
//    let nextPageURL: JSONNull?
//    let path: String
//    let perPage: Int
//    let prevPageURL: JSONNull?
//    let to: Double
//    let total: Double

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data = "data"
//        case firstPageURL = "first_page_url"
//        case from = "from"
//        case lastPage = "last_page"
//        case lastPageURL = "last_page_url"
//        case nextPageURL = "next_page_url"
//        case path = "path"
//        case perPage = "per_page"
//        case prevPageURL = "prev_page_url"
//        case to = "to"
//        case total = "total"
    }
}


// MARK: - Encode/decode helpers

//class JSONNull: Codable, Hashable {
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
