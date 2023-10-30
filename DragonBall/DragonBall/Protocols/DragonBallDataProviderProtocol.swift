//
//  DragonBallDataProviderProtocol.swift
//  DragonBall
//
//  Created by Gonzalo Gregorio on 29/10/2023.
//

import Foundation

protocol DragonBallDataProviderProtocol {
    func login(for user: String, with password: String)
    func getHeroes(by name: String?, token: String, completion: ((Characters) -> Void)?)
    func getLocations(by heroId: String?, token: String, completion: ((CharacterLocations) -> Void)?)
}
