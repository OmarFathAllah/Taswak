//
//  Route.swift
//  Taswak
//
//  Created by omar  on 10/03/2022.
//

import Foundation

enum Route {
    static let baseUrl = "https://student.valuxapps.com/api/"
    case allCategories
    case oneCategory(Int)
    case homeAndBanner
    case loginIn
    case register
    case addOrDeleteToCart
    case getCart
    case searchProducts
    case addOrDeletefavorites
    case getFavorites
    
    
    var description: String{
        switch self {
        case .allCategories: return "categories"
        case .oneCategory(let categoryID): return "categories/\(categoryID)"
        case .homeAndBanner: return "home"
        case .loginIn: return "login"
        case .register: return "register"
        case .addOrDeleteToCart: return "carts"
        case .getCart: return "carts"
        case .searchProducts: return "products/search"
        case .addOrDeletefavorites: return "favorites"
        case.getFavorites: return "favorites"
        }
    }
}
