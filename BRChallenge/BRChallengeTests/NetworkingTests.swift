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
        session.data = Data()
        var result: RestaurantResult?

        let expectation = self.expectation(description: "Restaurants urlFailure expectation")

        let client = NetworkManager(session: session)
        client.get(withUrlString: url) { res in
            result = res
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0) { (error) in
            if error != nil {
                XCTFail(error!.localizedDescription)
            } else {
                XCTAssertEqual(result, .failure(RestaurantError.urlFailure))
            }
        }
    }
    
    func testDataFailure() {
        let url = "https://mock.url"
        let session = MockSession()
        session.data = nil
        var result: RestaurantResult?
        let expectation = self.expectation(description: "Restaurants dataFailure expectation")

        let client = NetworkManager(session: session)
        client.get(withUrlString: url) { res in
            result = res
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0) { (error) in
            if error != nil {
                XCTFail(error!.localizedDescription)
            } else {
                XCTAssertEqual(result, .failure(RestaurantError.canNotProcessData))
            }
        }
    }

    func testSuccessRespons() {
        let url = "https://mock.url"
        let data = Data()
        let session = MockSession()
        session.data = data
        var result: RestaurantResult?
        let expectation = self.expectation(description: "Restaurants success expectation")

        let client = NetworkManager(session: session)
        client.get(withUrlString: url) { res in
            result = res
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0) { (error) in
            if error != nil {
                XCTFail(error!.localizedDescription)
            } else {
                XCTAssertEqual(result, .success(data))
            }
        }
    }
}
