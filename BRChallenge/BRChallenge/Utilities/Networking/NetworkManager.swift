//
//  NetworkManager.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 30/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import Foundation

enum RestaurantError: Error {
    case urlFailure
    case canNotProcessData
}

struct NetworkManager {
    let baseURL = "https://s3.amazonaws.com/br-codingexams/"
    let versionURL = "restaurants.json"
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func get(withEndpoitString: String, callback: @escaping(Result<Data, RestaurantError>) -> Void ) {
        guard let link = URL(string: baseURL + withEndpoitString) else {
            callback(.failure(.urlFailure))
            return
        }
        let req = URLRequest(url: link)
        let task = session.dataTask(with: req) { (data, response, error) in
            guard let jsonData = data else {
                callback(.failure(.canNotProcessData))
                return
            }
            callback(.success(jsonData))
        }
        task.resume()
    }
}
