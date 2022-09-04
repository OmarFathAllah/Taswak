//
//  ProfileList.swift
//  Taswak
//
//  Created by omar  on 03/09/2022.
//

import Foundation

struct ProfileList: Decodable {
    let id: Int
    let title: String
    let image: String
    let VC: String
    let Storyboard: String
}
