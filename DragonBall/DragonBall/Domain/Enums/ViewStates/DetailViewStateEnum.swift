//
//  HeroDetailViewState.swift
//  DragonBall
//
//  Created by Gonzalo Gregorio on 29/10/2023.
//

import Foundation

enum DetailViewStateEnum {
    case loading(_ isLoading: Bool)
    case updateData(character: Character?, locations: CharacterLocations)
}
