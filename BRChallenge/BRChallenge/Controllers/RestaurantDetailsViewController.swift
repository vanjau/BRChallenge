//
//  RestaurantDetailsViewController.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 27/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailsViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var restaurantDetailsMapView: BRMapView!
    @IBOutlet weak var restaurantInfoView: RestaurantInfoContainerView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var twitterHandleString: UILabel!
    fileprivate var restaurant: Restaurant?
    
    // MARK: - Init
    
    init?(coder: NSCoder, restaurant: Restaurant) {
        super.init(coder: coder)
        self.restaurant = restaurant
    }

    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a restaurant.")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Details"
        restaurantInfoViewSetup()
        mapSetup()
        restaurantContactSetup()
    }
    
    // MARK: - Setup

    fileprivate func mapSetup() {
        guard let restaurant = restaurant else {
            return
        }
        restaurantDetailsMapView.restaurantsArray = [restaurant]
    }
    
    fileprivate func restaurantInfoViewSetup() {
        restaurantInfoView.titleLabel.text = restaurant?.name
        restaurantInfoView.subtitleLabel.text = restaurant?.category
    }
    
    fileprivate func restaurantContactSetup() {
        let addressString = restaurant?.location?.address ?? ""
        let cityString = restaurant?.location?.city ?? ""
        let ccString = restaurant?.location?.cc ?? ""
        let postalCodeString = restaurant?.location?.postalCode ?? ""
        let twitterString = restaurant?.contact?.twitter ?? ""

        addressLabel.text = addressString + "\n" + cityString + ", " + ccString + " " + postalCodeString
        phoneLabel.text = restaurant?.contact?.formattedPhone
        twitterHandleString.text = "@" + twitterString
    }
}

// MARK: - NavigationRightButtonProtocol

extension RestaurantDetailsViewController: NavigationRightButtonProtocol {
    func didTapMapButton(navigationController: UINavigationController) -> [Restaurant] {
        guard let restaurant = restaurant else {
            return [Restaurant]()
        }
        return [restaurant]
    }
}

