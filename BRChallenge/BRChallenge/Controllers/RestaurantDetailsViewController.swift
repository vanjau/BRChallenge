//
//  RestaurantDetailsViewController.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 27/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit

class RestaurantDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Details"

    }
}

extension RestaurantDetailsViewController: NavigationRightButtonProtocol {
    func mapButtonTapped(navigationController: UINavigationController) -> String {
        return "DETAILS"
    }
}

