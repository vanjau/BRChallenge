//
//  DetailsRestaurantContactTableViewCell.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 16/01/2020.
//  Copyright © 2020 Vanja Ruzic. All rights reserved.
//

import UIKit

class DetailsRestaurantContactTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var twitterHandleString: UILabel!
    
    public var restaurant: Restaurant? {
        didSet {
            guard let restaurant = restaurant else { return }
            configureLabels(restaurant: restaurant)
        }
    }
    
    // MARK: - Helpers

    private func configureLabels(restaurant: Restaurant) {
        let addressString = restaurant.location?.address ?? ""
        let cityString = restaurant.location?.city ?? ""
        let ccString = restaurant.location?.cc ?? ""
        let postalCodeString = restaurant.location?.postalCode ?? ""
        let twitterString = restaurant.contact?.twitter ?? ""

        addressLabel.text = generateAddressText(address: addressString, city: cityString, cc: ccString, postalCode: postalCodeString)
        phoneLabel.text = restaurant.contact?.formattedPhone ?? "no number available"
        twitterHandleString.text = twitterString.isEmpty ? "no twitter available" : twitterString
    }
    
    private func generateAddressText(address: String, city: String, cc: String, postalCode: String) -> String {
        return address + "\n" + cc + ", " + cc + " " + postalCode
    }
}
