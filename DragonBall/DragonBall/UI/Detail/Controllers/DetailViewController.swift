//
//  DetailViewController.swift
//  DragonBall
//
//  Created by Gonzalo Gregorio on 29/10/2023.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    // MARK: - IBOutlet -
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var characterDescription: UITextView!
    @IBOutlet weak var backButton: UIButton!

    // MARK: - IBAction -
    @IBAction func onBackTapped() {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
