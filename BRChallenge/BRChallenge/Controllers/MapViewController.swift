//
//  MapViewController.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 27/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    @IBOutlet weak var dummyTestLabel: UILabel!
    var dummyTestString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dummyTestLabel.text = dummyTestString
    }
}
