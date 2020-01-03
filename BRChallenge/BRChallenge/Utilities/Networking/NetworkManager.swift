//
//  NetworkManager.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 30/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import Foundation

enum RestaurantError: Error {
    case noInternetConnection
    case urlFailure
    case canNotProcessData
}

typealias RestaurantResult = Result<Data, RestaurantError>

struct NetworkManager {
    private let session: URLSessionProtocol
    
    public init(session: URLSessionProtocol) {
        self.session = session
    }
    
    public func get(withUrlString urlString: String, callback: @escaping (RestaurantResult) -> Void ) {
        NetworkReachability.isReachable { reachable in
            if !reachable {
                callback(.failure(.noInternetConnection))
            } else {
                guard let link = URL(string: urlString) else {
                    callback(.failure(.urlFailure))
                    return
                }
                let req = URLRequest(url: link)
                let task = self.session.dataTask(with: req) { (data, response, error) in
                    guard let jsonData = data else {
                        callback(.failure(.canNotProcessData))
                        return
                    }
                    callback(.success(jsonData))
                }
                task.resume()
            }
        }
    }
}
