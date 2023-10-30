//
//  CharacterMapPin.swift
//  DragonBall
//
//  Created by Gonzalo Gregorio on 29/10/2023.
//

import UIKit
import MapKit

class CharacterMapPin: NSObject, MKAnnotation {
    static let identifier: String = "CharacterMapPin"

    var title: String?
    var info: String?
    var coordinate: CLLocationCoordinate2D

    init(title: String? = nil, info: String? = nil, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.info = info
        self.coordinate = coordinate
    }
}
