//
//  KeychainDataProvider.swift
//  DragonBall
//
//  Created by Gonzalo Gregorio on 29/10/2023.
//

import Foundation
import KeychainSwift

final class KeychainDataProvider: SecureDataProviderProtocol {
    private let keychain = KeychainSwift()
    
    func getToken() -> String? {
        keychain.get(KeychainEnum.token)
    }
    
    func save(token: String) {
        keychain.set(token, forKey: KeychainEnum.token)
    }

}
