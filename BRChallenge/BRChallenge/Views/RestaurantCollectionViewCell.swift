//
//  RestaurantCollectionViewCell.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 12/28/19.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var restaurantPhotoImageView: UIImageView!
    @IBOutlet weak var restaurantInfoView: RestaurantInfoContainerView!
    
    public var restaurant: Restaurant? {
        didSet {
            let restaurantUrlString = restaurant?.backgroundImageURL ?? ""
            guard let restaurantUrl = URL(string: restaurantUrlString) else {
                return
            }
            
            restaurantPhotoImageView.load(url: restaurantUrl)
            
            restaurantInfoView.titleLabel.text = restaurant?.name
            restaurantInfoView.subtitleLabel.text = restaurant?.category
        }
    }
}
