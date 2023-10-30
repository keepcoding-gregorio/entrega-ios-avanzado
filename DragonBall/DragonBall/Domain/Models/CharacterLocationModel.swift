//
//  CharacterLocation.swift
//  DragonBall
//
//  Created by Gonzalo Gregorio on 29/10/2023.
//

import Foundation


typealias CharacterLocations = [CharacterLocation]

struct CharacterLocation: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case latitude = "latitud"
        case longitude = "longitud"
        case date = "dateShow"
        case character = "hero"
    }

    let id: String?
    let latitude: String?
    let longitude: String?
    let date: String?
    let character: Character?
}
