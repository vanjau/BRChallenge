//
//  MockSession.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 31/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import Foundation

class MockSession: URLSessionProtocol {
    
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    // Properties that enable us to set exactly what data or error
    // we want our mocked URLSession to return for any request.
    var data: Data?
    var error: Error?
    
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        let data = self.data
        let error = self.error

        return URLSessionDataTaskMock {
            completionHandler(data, nil, error)
        }
    }
}
