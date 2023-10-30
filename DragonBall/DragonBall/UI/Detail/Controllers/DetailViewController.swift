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
    @IBOutlet weak var loadingView: UIView!

    // MARK: - IBAction -
    @IBAction func onBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Public Properties -
    var viewModel: DetailViewControllerDelegate?

    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        setObservers()
        viewModel?.onViewAppear()
        setDefaultMapRegion()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Private functions -
    private func initViews() {
        mapView.delegate = self
    }

    private func setObservers() {
        viewModel?.viewState = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .loading(let isLoading):
                    self?.loadingView.isHidden = !isLoading
                    
                case .updateData(let character, let locations):
                    self?.updateViews(character: character,
                                      characterLocations: locations)
                }
            }
        }
    }

    private func updateViews(character: Character?, characterLocations: CharacterLocations) {
        picture.kf.setImage(with: URL(string: character?.photo ?? ""))
        makeRounded(image: picture)
        
        name.text = character?.name
        characterDescription.text = character?.description

        characterLocations.forEach {
            mapView.addAnnotation(
                CharacterMapPin(
                    title: character?.name,
                    info: character?.id,
                    coordinate: .init(latitude: Double($0.latitude ?? "") ?? 0.0,
                                      longitude: Double($0.longitude ?? "") ?? 0.0)
                )
            )
        }
    }
    
    private func makeRounded(image: UIImageView) {
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.white.cgColor.copy(alpha: 0.6)
        image.layer.cornerRadius = image.frame.height / 2
        image.layer.masksToBounds = false
        image.clipsToBounds = true
    }
    
    private func setDefaultMapRegion() {
          // Set the default region to Spain
          let spainRegion = MKCoordinateRegion(
              center: CLLocationCoordinate2D(latitude: 40.4168, longitude: -3.7038), // Coordinates for Spain
              span: MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 5.0) // Adjust the span as needed
          )
          mapView.setRegion(spainRegion, animated: true)
      }
}

//MARK: — MKMapView Delegate Methods
extension DetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = CharacterMapPin.identifier
        let annotationView = mapView.dequeueReusableAnnotationView(
            withIdentifier: identifier
        ) ?? MKAnnotationView(
            annotation: annotation,
            reuseIdentifier: identifier
        )

        annotationView.canShowCallout = true
        if annotation is MKUserLocation {
            return nil
        } else if annotation is CharacterMapPin {
            // Resize image
            let pinImage = UIImage(named: "img_map_pin")
            let size = CGSize(width: 30, height: 30)
            UIGraphicsBeginImageContext(size)
            pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()

            annotationView.image = resizedImage
            return annotationView
        } else {
            return nil
        }
    }
}
