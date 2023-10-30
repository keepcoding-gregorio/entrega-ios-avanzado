//
//  HomeViewModel.swift
//  DragonBall
//
//  Created by Gonzalo Gregorio on 29/10/2023.
//

import Foundation

class HomeViewModel: HomeViewControllerDelegate {
    // MARK: - Dependencies -
    private let apiProvider: DragonBallDataProviderProtocol
    private let secureDataProvider: SecureDataProviderProtocol

    // MARK: - Properties -
    var viewState: ((HomeViewStateEnum) -> Void)?
    var totalCount: Int {
        characters.count
    }

    private var characters: Characters = []


    // MARK: - Initializers -
    init(apiProvider: DragonBallDataProviderProtocol,
         secureDataProvider: SecureDataProviderProtocol) {
        self.apiProvider = apiProvider
        self.secureDataProvider = secureDataProvider
    }

    // MARK: - Public functions -
    func onViewAppear() {
        viewState?(.loading(true))

        DispatchQueue.global().async {
            defer { self.viewState?(.loading(false)) }
            guard let token = self.secureDataProvider.getToken() else { return }

            self.apiProvider.getHeroes(by: nil,
                                       token: token) { characters in
                self.characters = characters
                self.viewState?(.updateData)
            }
        }
    }

    func getCharacterBy(index: Int) -> Character? {
        index >= 0 && index < totalCount ? characters[index] : nil
    }

    func detailViewModel(index: Int) -> DetailViewControllerDelegate? {
        guard let selectedCharacter = getCharacterBy(index: index) else { return nil }
        
        return DetailViewModel(
            hero: selectedCharacter,
            apiProvider: apiProvider,
            secureDataProvider: secureDataProvider
        )
    }
}
