//
//  SplashViewModel.swift
//  DragonBall
//
//  Created by Gonzalo Gregorio on 29/10/2023.
//

import Foundation

class SplashViewModel: SplashViewControllerDelegate {
    private let apiDataProvider: DragonBallDataProviderProtocol
    private let secureDataProvider: SecureDataProviderProtocol

    var viewState: ((SplashViewStateEnum) -> Void)?

    lazy var loginViewModel: LoginViewControllerDelegate = {
        LoginViewModel(
            apiProvider: apiDataProvider,
            secureDataProvider: secureDataProvider
        )
    }()

    lazy var homeViewModel: HomeViewControllerDelegate = {
        HomeViewModel(
            apiProvider: apiDataProvider,
            secureDataProvider: secureDataProvider
        )
    }()

    private var isLogged: Bool {
        secureDataProvider.getToken()?.isEmpty == false
    }


    init(apiProvider: DragonBallDataProviderProtocol, secureDataProvider: SecureDataProviderProtocol) {
        self.apiDataProvider = apiProvider
        self.secureDataProvider = secureDataProvider
    }

    func onViewAppear() {
        viewState?(.loading(true))

        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(2)) {
            self.isLogged ? self.viewState?(.navigateToHome) : self.viewState?(.navigateToLogin)
        }
    }
}
