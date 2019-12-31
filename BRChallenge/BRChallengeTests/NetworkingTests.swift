//
//  NetworkingTests.swift
//  BRChallengeTests
//
//  Created by Vanja Ruzic on 31/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import XCTest
@testable import BRChallenge

class NetworkingTests: XCTestCase {

    func testUrlFailure() {
        let url = ""

        let session = MockSession()
        session.data = nil
        var result: Result<Data, RestaurantError>?

        let client = NetworkManager(session: session)
        client.get(url: url) { res in
            result = res
        }
        
        XCTAssertEqual(result, .failure(RestaurantError.urlFailure))
    }
    
    func testDataFailure() {
        let url = "https://mock.url"
        let session = MockSession()
        session.data = nil
        var result: Result<Data, RestaurantError>?

        let client = NetworkManager(session: session)
        client.get(url: url) { res in
            result = res
        }
        
        XCTAssertEqual(result, .failure(RestaurantError.canNotProcessData))
    }
    
    func testSuccessRespons() {
        let url = "https://mock.url"
        let data = Data()
        let session = MockSession()
        session.data = data
        var result: Result<Data, RestaurantError>?

        let client = NetworkManager(session: session)
        client.get(url: url) { res in
            result = res
        }
        
        XCTAssertEqual(result, .success(data))
    }
}
