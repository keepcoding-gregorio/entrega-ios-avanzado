//
//  LoginViewControllerDelegate.swift
//  DragonBall
//
//  Created by Gonzalo Gregorio on 29/10/2023.
//

import Foundation

protocol LoginViewControllerDelegate {
    var viewState: ((LoginViewStateEnum) -> Void)? { get set }
    var homeViewModel: HomeViewControllerDelegate { get }
    
    func onLoginTapped(email: String?, password: String?)
}
