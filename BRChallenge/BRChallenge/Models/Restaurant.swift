//
//  Restaurant.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 30/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import Foundation

struct RestaurantsResponse: Decodable {
    var restaurants: [Restaurant]?
}

struct Restaurant: Decodable {
    var name: String?
    var backgroundImageURL: String?
    var category: String?
    var contact: Contact?
    var location: Location?
}

struct Contact: Decodable {
    var phone: String?
    var formattedPhone: String?
    var twitter: String?
}

struct Location: Decodable {
    var address: String?
    var crossStreet: String?
    var lat: Double?
    var lng: Double?
    var postalCode: String?
    var cc: String?
    var city: String?
    var state: String?
    var country: String?
    var formattedAddress: [String]?
}
