//
//  SplashViewControllerDelegate.swift
//  DragonBall
//
//  Created by Gonzalo Gregorio on 29/10/2023.
//

import Foundation

protocol SplashViewControllerDelegate {
    var viewState: ((SplashViewStateEnum) -> Void)? { get set }
    var loginViewModel: LoginViewControllerDelegate { get }
    var homeViewModel: HomeViewControllerDelegate { get }

    func onViewAppear()
}
