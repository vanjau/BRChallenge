//
//  DetailsRestaurantInfoTableViewCell.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 16/01/2020.
//  Copyright © 2020 Vanja Ruzic. All rights reserved.
//

import UIKit

class DetailsRestaurantInfoTableViewCell: UITableViewCell {

    // MARK: - Properties

    @IBOutlet weak var restaurantInfoView: RestaurantInfoContainerView!
    
    public var restaurant: Restaurant? {
        didSet {
            restaurantInfoView.titleLabel.text = restaurant?.name
            restaurantInfoView.subtitleLabel.text = restaurant?.category
        }
    }
}
