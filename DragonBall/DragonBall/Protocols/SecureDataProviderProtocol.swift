//
//  SecureDataProviderProtocol.swift
//  DragonBall
//
//  Created by Gonzalo Gregorio on 29/10/2023.
//

import Foundation

protocol SecureDataProviderProtocol {
    func getToken() -> String?
    func save(token: String)
}
