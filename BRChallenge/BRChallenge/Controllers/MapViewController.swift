//
//  MapViewController.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 27/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var dummyTestLabel: UILabel!
    var dummyTestString: String
    
    // MARK: - Init
    
    init?(coder: NSCoder, dummyTestString: String) {
        self.dummyTestString = dummyTestString
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a selectedContinent.")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        dummyTestLabel.text = dummyTestString
    }
}
