//
//  CharacterDAO.swift
//  DragonBall
//
//  Created by Gonzalo Gregorio on 29/10/2023.
//

import Foundation
import CoreData

@objc(CharacterDAO)
class CharacterDAO: NSManagedObject {
    static let entityName = "CharacterDAO"

    @NSManaged var id: String?
    @NSManaged var name: String?
    @NSManaged var heroDescription: String?
    @NSManaged var photo: String?
    @NSManaged var favorite: Bool
}
