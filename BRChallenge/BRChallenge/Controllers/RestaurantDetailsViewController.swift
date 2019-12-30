//
//  RestaurantDetailsViewController.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 27/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailsViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var restaurantDetailsMapView: MKMapView!
    @IBOutlet weak var restaurantInfoView: RestaurantInfoContainerView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var twitterHandleString: UILabel!
    fileprivate var restaurant: Restaurant? {
        didSet {
            addressLabel.text = restaurant?.location?.address
            phoneLabel.text = restaurant?.contact?.phone
        }
    }
    // MARK: - Init
    
    init?(coder: NSCoder, restaurant: Restaurant) {
        super.init(coder: coder)
        self.restaurant = restaurant
    }

    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a restaurant.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantInfoView.titleLabel.text = restaurant?.name
        restaurantInfoView.subtitleLabel.text = restaurant?.category
        
        let addressString = restaurant?.location?.address ?? ""
        let cityString = restaurant?.location?.city ?? ""
        let ccString = restaurant?.location?.cc ?? ""
        let postalCodeString = restaurant?.location?.postalCode ?? ""


        let twitterString = restaurant?.contact?.twitter ?? ""


        addressLabel.text = addressString + "\n" + cityString + ", " + ccString + " " + postalCodeString
        phoneLabel.text = restaurant?.contact?.formattedPhone
        twitterHandleString.text = "@" + twitterString
        self.navigationItem.title = "Details"
        
        let lat = restaurant?.location?.lat ?? 0
        let lon = restaurant?.location?.lng ?? 0

        
        let restaurantLocation = CLLocation(latitude: lat, longitude: lon)
        let regionRadius: CLLocationDistance = 1000.0
        let region = MKCoordinateRegion(center: restaurantLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        restaurantDetailsMapView.setRegion(region, animated: false)
        restaurantDetailsMapView.delegate = self
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = restaurantLocation.coordinate
        restaurantDetailsMapView.addAnnotation(annotation)
    }
}

extension RestaurantDetailsViewController: NavigationRightButtonProtocol {
    func mapButtonTapped(navigationController: UINavigationController) -> [CLLocation] {
        let lat = restaurant?.location?.lat ?? 0
        let lon = restaurant?.location?.lng ?? 0
        let restaurantLocation = CLLocation(latitude: lat, longitude: lon)

        return [restaurantLocation]
    }
}

