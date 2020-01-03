//
//  NetworkReachability.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 1/2/20.
//  Copyright © 2020 Vanja Ruzic. All rights reserved.
//

import Foundation
import Network

class NetworkReachability {
    
    /**
     Monitoring if there is internet connection
     - Parameter callback: Returns Bool if there is connection or not.
     */
    static func isReachable(callback: @escaping (Bool) -> Void) {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)

        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                callback(true)
            } else {
                callback(false)
            }
        }
        monitor.cancel()
    }
}
