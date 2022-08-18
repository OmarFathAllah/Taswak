//
//  APIResponse.swift
//  Taswak
//
//  Created by omar  on 16/03/2022.
//

import Foundation
struct ApiResponse: Decodable {
    let status: Bool
    let message: String?
    let data: DataStruct
}

// MARK: - DataClass
struct DataStruct: Decodable {
//    let currentPage: Int
    let data: [Category]
//    let firstPageURL: String
//    let from, lastPage: Int
//    let lastPageURL: String
//    let nextPageURL: JSONNull?
//    let path: String
//    let perPage: Int
//    let prevPageURL: JSONNull?
//    let to, total: Int

//    enum CodingKeys: String, CodingKey, Decodable {
//        case currentPage = "current_page"
//        case data = "data"
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



// MARK: - Encode/decode helpers

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





