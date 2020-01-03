//
//  MockURLSessionDataTask.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 31/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}
