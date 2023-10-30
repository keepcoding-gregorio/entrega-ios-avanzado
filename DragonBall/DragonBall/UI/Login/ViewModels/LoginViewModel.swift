//
//  LoginViewModel.swift
//  DragonBall
//
//  Created by Gonzalo Gregorio on 29/10/2023.
//

import Foundation

class LoginViewModel: LoginViewControllerDelegate {
    // MARK: - Dependencies -
    private let apiProvider: DragonBallDataProviderProtocol
    private let secureDataProvider: SecureDataProviderProtocol

    // MARK: - Properties -
    var viewState: ((LoginViewStateEnum) -> Void)?
    var homeViewModel: HomeViewControllerDelegate {
        HomeViewModel(
            apiProvider: apiProvider,
            secureDataProvider: secureDataProvider
        )
    }


    // MARK: - Initializers -
    init(
        apiProvider: DragonBallDataProviderProtocol,
        secureDataProvider: SecureDataProviderProtocol
    ) {
        self.apiProvider = apiProvider
        self.secureDataProvider = secureDataProvider

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onLoginResponse),
            name: NotificationCenter.apiLoginNotification,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Public functions -
    func onLoginTapped(email: String?, password: String?) {
        viewState?(.loading(true))

        DispatchQueue.global().async {
            guard self.isValid(email: email) else {
                self.viewState?(.loading(false))
                self.viewState?(.showEmailError("Invalid email domain provider"))
                return
            }

            guard self.isValid(password: password) else {
                self.viewState?(.loading(false))
                self.viewState?(.showPasswordError("Password should contain at least 8 characters"))
                return
            }

            self.doLoginWith(
                email: email ?? "",
                password: password ?? ""
            )
        }
    }

    @objc func onLoginResponse(_ notification: Notification) {
        defer { viewState?(.loading(false)) }

        // Parsear resultado que vendrá en notification.userInfo
        guard let token = notification.userInfo?[NotificationCenter.tokenKey] as? String,
              !token.isEmpty else {
            return
        }

        secureDataProvider.save(token: token)
        viewState?(.navigateToNext)
    }

    // MARK: - Private functions -
    private func isValid(email: String?) -> Bool {
        email?.isEmpty == false && (email?.contains("@") ?? false)
    }

    private func isValid(password: String?) -> Bool {
        password?.isEmpty == false && (password?.count ?? 0) >= 8
    }

    private func doLoginWith(email: String, password: String) {
        apiProvider.login(for: email,
                          with: password)
    }
}
