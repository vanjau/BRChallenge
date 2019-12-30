//
//  MapViewController.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 27/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    // MARK: - Properties

    @IBOutlet weak var mapView: MKMapView!
    fileprivate var locationArray: [CLLocation]
    
    // MARK: - Init
    
    init?(coder: NSCoder, locations: [CLLocation]) {
        self.locationArray = locations
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a locations.")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        let annotations = locationArray.map { location -> MKAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            return annotation
        }
        mapView.showAnnotations(annotations, animated: false)
    }
}
