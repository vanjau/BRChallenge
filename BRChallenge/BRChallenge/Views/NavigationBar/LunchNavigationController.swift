//
//  LunchNavigationController.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 27/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit
import MapKit

protocol NavigationRightButtonProtocol: AnyObject {
    func didTapMapButton(navigationController: UINavigationController) -> [CLLocation]
}

class LunchNavigationController: BRNavigationController {

    public weak var navigationRightButtonDelegate: NavigationRightButtonProtocol?

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        self.navigationRightButtonDelegate = viewController as? NavigationRightButtonProtocol
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
        let mapImage = #imageLiteral(resourceName: "icon_map")
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: mapImage, style: .plain, target: self, action: #selector(mapTapped))
    }
    
    @objc func mapTapped() {
        let locations = navigationRightButtonDelegate?.didTapMapButton(navigationController: self) ?? [CLLocation]()
        
        guard let addTripViewController = storyboard?.instantiateViewController(identifier: MapViewController.storyboardIdentifier, creator: { coder in
            return MapViewController(coder: coder, locations: locations)
        }) else {
            fatalError("Failed to load MapViewController from storyboard.")
        }

        present(addTripViewController, animated: true, completion: nil)
    }
}
