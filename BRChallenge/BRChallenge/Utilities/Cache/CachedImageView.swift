//
//  CachedImageView.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 12/30/19.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit

class CachedImageView: UIImageView {
    
    // MARK: - Properties
    
    public static let imageCache = NSCache<NSString, DiscardableImageCacheItem>()
    private var urlStringForChecking: String?

    // MARK: - Public Methods

    /**
     Load image, check first if it's already cached - if not download asynchrony.
     - Parameter urlString: This string will be used for matching cached images and images that needs to be downloaded.
     - Parameter completion: This is optional if something needs to be done after image is loaded.
     */
    public func loadImage(urlString: String, completion: (() -> Void)? = nil) {
        image = nil
        self.urlStringForChecking = urlString
        
        let urlKey = urlString as NSString
        
        if let cachedItem = CachedImageView.imageCache.object(forKey: urlKey) {
            image = cachedItem.image
            completion?()
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            if error != nil {
                return
            }
            
            DispatchQueue.main.async {
                guard let data = data else { return }
                guard let image = UIImage(data: data) else { return }
                
                let cacheItem = DiscardableImageCacheItem(image: image)
                CachedImageView.imageCache.setObject(cacheItem, forKey: urlKey)

                if urlString == self?.urlStringForChecking {
                    self?.image = image
                    completion?()
                }
            }
        }).resume()
    }
}
