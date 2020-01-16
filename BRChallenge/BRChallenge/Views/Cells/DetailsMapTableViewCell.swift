//
//  DetailsMapTableViewCell.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 16/01/2020.
//  Copyright © 2020 Vanja Ruzic. All rights reserved.
//

import UIKit

class DetailsMapTableViewCell: UITableViewCell {
    
    // MARK: - Properties

    @IBOutlet weak var restaurantDetailsMapView: BRMapView!
    
    public var restaurant: Restaurant? {
        didSet {
            guard let restaurant = restaurant else {
                return
            }
            restaurantDetailsMapView.restaurantsArray = [restaurant]
        }
    }
}
