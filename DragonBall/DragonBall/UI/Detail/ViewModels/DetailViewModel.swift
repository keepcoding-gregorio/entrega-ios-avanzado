//
//  DetailViewModel.swift
//  DragonBall
//
//  Created by Gonzalo Gregorio on 29/10/2023.
//

import Foundation

class DetailViewModel: DetailViewControllerDelegate {
    
    private let apiProvider: DragonBallDataProviderProtocol
    private let secureDataProvider: SecureDataProviderProtocol
    
    var viewState: ((DetailViewStateEnum) -> Void)?
    private var character: Character
    private var characterLocations: CharacterLocations = []
    
    init(hero: Character,
         apiProvider: DragonBallDataProviderProtocol,
         secureDataProvider: SecureDataProviderProtocol) {
        self.character = hero
        self.apiProvider = apiProvider
        self.secureDataProvider = secureDataProvider
    }
    
    func onViewAppear() {
        viewState?(.loading(true))
        
        DispatchQueue.global().async {
            defer { self.viewState?(.loading(false)) }
            guard let token = self.secureDataProvider.getToken() else {
                return
            }
//            solo si no hay data
            self.apiProvider.getLocations(
                by: self.character.id,
                token: token
            ) { [weak self] characterLocations in
                self?.characterLocations = characterLocations
                self?.viewState?(.updateData(character: self?.character, locations: characterLocations))
            }
        }
    }
}
