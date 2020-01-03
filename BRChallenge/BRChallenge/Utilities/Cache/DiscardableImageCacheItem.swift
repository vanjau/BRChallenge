//
//  DiscardableImageCacheItem.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 12/30/19.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import Foundation
import UIKit

class DiscardableImageCacheItem: NSObject, NSDiscardableContent {
    
    // MARK: - Properties

    private(set) public var image: UIImage?
    private var accessCount: UInt = 0
    
    // MARK: - Init

    public init(image: UIImage) {
        self.image = image
    }
    
    // MARK: - NSDiscardableContent

    public func beginContentAccess() -> Bool {
        if image == nil {
            return false
        }
        
        accessCount += 1
        return true
    }
    
    public func endContentAccess() {
        if accessCount > 0 {
            accessCount -= 1
        }
    }
    
    public func discardContentIfPossible() {
        if accessCount == 0 {
            image = nil
        }
    }
    
    public func isContentDiscarded() -> Bool {
        return image == nil
    }
}
