//
//  CharacterModel.swift
//  DragonBall
//
//  Created by Gonzalo Gregorio on 29/10/2023.
//

import Foundation

typealias Characters = [Character]

struct Character: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case photo
        case isFavorite = "favorite"
    }

    let id: String?
    let name: String?
    let description: String?
    let photo: String?
    let isFavorite: Bool?
}
