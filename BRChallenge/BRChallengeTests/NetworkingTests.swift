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
        checkExpectedResultType(urlString: "", data: Data(), expectationDescription: "Restaurants urlFailure expectation", expectedResult: .failure(RestaurantError.urlFailure))
    }
    
    func testDataFailure() {
        checkExpectedResultType(urlString: "https://mock.url", data: nil, expectationDescription: "Restaurants dataFailure expectation", expectedResult: .failure(RestaurantError.canNotProcessData))
    }

    func testSuccessRespons() {
        checkExpectedResultType(urlString: "https://mock.url", data: Data(), expectationDescription: "Restaurants success expectation", expectedResult: .success(Data()))
    }
    
    //MARK: - Helpers
    
    private func checkExpectedResultType(urlString: String, data: Data?, expectationDescription: String, expectedResult: RestaurantResult) {
        let url = urlString
        let session = MockSession()
        session.data = data
        var result: RestaurantResult?
        let expectation = self.expectation(description: expectationDescription)
        
        let client = NetworkManager(session: session)
        client.get(withUrlString: url) { res in
            result = res
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0) { (error) in
            if error != nil {
                XCTFail(error!.localizedDescription)
            } else {
                XCTAssertEqual(result, expectedResult, "Unexpected Result type.")
            }
        }
    }
}
