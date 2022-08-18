//
//  HomeAndBanner.swift
//  Taswak
//
//  Created by omar  on 07/05/2022.
//

import Foundation

// MARK: - HomeAndBanner
struct HomeAndBanner: Decodable {
    let status: Bool
//    let message: JSONNull?
    let data: ClassOfData
}

// MARK: - ClassOfData
struct ClassOfData: Decodable {
    let banners: [Banner]
    let products: [OneProduct]
    let ad: String
}

// MARK: - Banner
struct Banner: Decodable {
    let id: Int
    let image: String
//    let category, product: JSONNull?
}

// MARK: - Product


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
