//
//  LunchViewController.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 27/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit

class LunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Lunch Tyme"

    }
}

extension LunchViewController: NavigationRightButtonProtocol {
    func mapButtonTapped(navigationController: UINavigationController) -> String {
        return "LUNCH"
    }
}
