//
//  MapViewController.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 27/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var mapView: BRMapView!
    fileprivate var restaurantsArray: [Restaurant]
    
    // MARK: - Init
    
    /**
     Creates a personalized MapViewController with array of restaurant objects.
     - Parameter coder: Coder.
     - Parameter restaurants: Array of restaurants fetched from the server.
     */
    init?(coder: NSCoder, restaurants: [Restaurant]) {
        self.restaurantsArray = restaurants
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a locations.")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.restaurantsArray = restaurantsArray
    }
}
