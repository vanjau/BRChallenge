//
//  NetworkManager.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 30/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import Foundation

enum RestaurantError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct NetworkManager {
    let baseURL = "https://s3.amazonaws.com/br-codingexams/restaurants.json"
    let versionURL = ""
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func get(url: String, callback: @escaping(Result<Data, RestaurantError>) -> Void ) {
        guard let link = URL(string: url) else {
            callback(.failure(.noDataAvailable))
            return
        }
        let req = URLRequest(url: link)
        let task = session.dataTask(with: req) { (data, response, error) in
            guard let jsonData = data else {
                callback(.failure(.noDataAvailable))
                return
            }
            callback(.success(jsonData))
        }
        task.resume()
    }
}
