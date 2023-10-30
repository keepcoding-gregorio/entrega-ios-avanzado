//
//  LoginViewStateEnum.swift
//  DragonBall
//
//  Created by Gonzalo Gregorio on 29/10/2023.
//

import Foundation

enum LoginViewStateEnum {
    case loading(_ isLoading: Bool)
    case showEmailError(_ error: String?)
    case showPasswordError(_ error: String?)
    case navigateToNext
}
