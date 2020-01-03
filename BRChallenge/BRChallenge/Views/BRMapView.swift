//
//  BRMapView.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 1/1/20.
//  Copyright © 2020 Vanja Ruzic. All rights reserved.
//

import UIKit
import MapKit

class BRMapView: MKMapView {
    public var restaurantsArray: [Restaurant]? {
        didSet {
            let annotations = restaurantsArray?.map { restaurant -> MKAnnotation in
                let annotation = MKPointAnnotation()
                let lat = restaurant.location?.lat ?? 0
                let lng = restaurant.location?.lng ?? 0
                let location = CLLocation(latitude: lat, longitude: lng)
                annotation.coordinate = location.coordinate
                annotation.title = restaurant.name ?? ""
                return annotation
            }
            guard let annotationsArray = annotations else {
                return
            }
            self.showAnnotations(annotationsArray, animated: false)
        }
    }
}
