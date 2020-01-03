//
//  LunchNavigationController.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 27/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit
import MapKit

protocol NavigationRightButtonDelegate: AnyObject {
    /**
     Opens MapViewController and passing array of restaurants after tapping map button in navigation bar.
     - Parameter withNavigationController:
     */
    func didTapMapButton(_ withNavigationController: UINavigationController) -> [Restaurant]
}

class LunchNavigationController: BRNavigationController {

    public weak var navigationRightButtonDelegate: NavigationRightButtonDelegate?

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        self.navigationRightButtonDelegate = viewController as? NavigationRightButtonDelegate
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
        let mapImage = #imageLiteral(resourceName: "icon_map")
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: mapImage, style: .plain, target: self, action: #selector(mapTapped))
    }
    
    @objc func mapTapped() {
        let locations = navigationRightButtonDelegate?.didTapMapButton(self) ?? [Restaurant]()
        
        guard let addTripViewController = storyboard?.instantiateViewController(identifier: MapViewController.storyboardIdentifier, creator: { coder in
            return MapViewController(coder: coder, restaurants: locations)
        }) else {
            fatalError("Failed to load MapViewController from storyboard.")
        }

        present(addTripViewController, animated: true, completion: nil)
    }
}
