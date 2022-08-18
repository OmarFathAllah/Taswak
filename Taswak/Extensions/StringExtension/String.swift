//
//  String.swift
//  Taswak
//
//  Created by omar  on 09/03/2022.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
