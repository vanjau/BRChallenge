//
//  RestaurantResponse.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 1/3/20.
//  Copyright © 2020 Vanja Ruzic. All rights reserved.
//

import Foundation

class RestaurantResponse {
    
    static func parseRestaurantResponse(data: Data, callback: @escaping (Result<RestaurantsResponse, RestaurantError>) -> Void) {
        do {
            let decoder = JSONDecoder()
            let restaurantsResponse = try decoder.decode(RestaurantsResponse.self, from: data)
            callback(.success(restaurantsResponse))
        } catch {
            callback(.failure(.canNotProcessData))
        }
    }
}
