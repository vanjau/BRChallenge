//
//  RestaurantCollectionViewCell.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 12/28/19.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties

    @IBOutlet weak var restaurantPhotoImageView: CachedImageView!
    @IBOutlet weak var restaurantInfoView: RestaurantInfoContainerView!
    
    public var restaurant: Restaurant? {
        didSet {
            let restaurantUrlString = restaurant?.backgroundImageURL ?? ""
            restaurantPhotoImageView.loadImage(urlString: restaurantUrlString)
            restaurantInfoView.titleLabel.text = restaurant?.name
            restaurantInfoView.subtitleLabel.text = restaurant?.category
        }
    }
}
