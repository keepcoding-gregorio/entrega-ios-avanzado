//
//  HeroesViewControllerDelegate.swift
//  DragonBall
//
//  Created by Gonzalo Gregorio on 29/10/2023.
//

import Foundation

protocol HomeViewControllerDelegate {
    var viewState: ((HomeViewStateEnum) -> Void)? { get set }
    var totalCount: Int { get }

    func onViewAppear()
    func getCharacterBy(index: Int) -> Character?
    func detailViewModel(index: Int) -> DetailViewControllerDelegate?
}
