//
//  BRChallengeTests.swift
//  BRChallengeTests
//
//  Created by Vanja Ruzic on 27/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import XCTest
@testable import BRChallenge

class BRChallengeTests: XCTestCase {

    var resData: Data? = nil
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccesNetworking() {
        let url = "https://mock.url"
        let session = MockSession()
        let client = NetworkManager(session: session)
        client.get(url: url) { result in
            switch result {
            case (.failure(let error)):
                print(error)
            case (.success(let data)):
                self.resData = data
            }
        }
        let pred = NSPredicate(format: "resData != nil")
        let exp = expectation(for: pred, evaluatedWith: self, handler: nil)
        let res = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if res == XCTWaiter.Result.completed {
            XCTAssertNotNil(resData, "No data recieved from the server")
        } else {
            XCTAssert(false, "Call run into some other error")
        }
    }
    
//    func testFailedNetworking() {
//        //let url = "https://mock.url"
//        let url = ""
//
//        let session = MockSession()
//        session.data = nil
//        //session.error = RestaurantError.canNotProcessData
//        var result: Result<Data, RestaurantError>?
//
//        let client = NetworkManager(session: session)
//        client.get(url: url) { res in
//            result = res
////            switch result {
////            case (.failure(let error)):
////                print(error)
////            case (.success(let data)):
////                self.resData = data
////            }
//        }
////        let pred = NSPredicate(format: "resData != nil")
////        let exp = expectation(for: pred, evaluatedWith: self, handler: nil)
////        let res = XCTWaiter.wait(for: [exp], timeout: 5.0)
////        if res == XCTWaiter.Result.completed {
////            XCTAssertNotNil(resData, "No data recieved from the server")
////        } else {
////            XCTAssert(false, "Call run into some other error")
////        }
//        XCTAssertEqual(result, .failure(RestaurantError.urlFailure))
//
//    }
    
    func testSuccessfulResponse() {
        // Setup our objects
        let session = MockSession()
        let manager = NetworkManager(session: session)

        // Create data and tell the session to always return it
//        let data = Data(bytes: [0, 1, 0, 1])
        let data = Data()

        session.data = data

        // Create a URL (using the file path API to avoid optionals)
        //let url = URL(fileURLWithPath: "url")

        // Perform the request and verify the result
        var result: Result<Data, RestaurantError>?
        manager.get(url: "url") { res in
            result = res
        }
        XCTAssertEqual(result, .success(data))
    }
}
