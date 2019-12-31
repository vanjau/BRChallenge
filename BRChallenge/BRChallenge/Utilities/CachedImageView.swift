//
//  CachedImageView.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 12/30/19.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit

/**
 A convenient UIImageView to load and cache images.
 */
class CachedImageView: UIImageView {
    
    public static let imageCache = NSCache<NSString, DiscardableImageCacheItem>()
    
    open var shouldUseEmptyImage = true
    
    private var urlStringForChecking: String?
    private var emptyImage: UIImage? //PLACEHOLDER
    
//    public convenience init(cornerRadius: CGFloat = 0, tapCallback: @escaping (() ->())) {
//        self.init(cornerRadius: cornerRadius, emptyImage: nil)
//        self.tapCallback = tapCallback
//        isUserInteractionEnabled = true
//        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
//    }
    
//    @objc func handleTap() {
//        tapCallback?()
//    }
    
   //private var tapCallback: (() -> ())?
    
//    public init(cornerRadius: CGFloat = 0, emptyImage: UIImage? = nil) {
//        super.init(frame: .zero)
//        contentMode = .scaleAspectFill
//        clipsToBounds = true
//        layer.cornerRadius = cornerRadius
//        self.emptyImage = emptyImage
//    }
//
//    override init(frame: CGRect) {
//        <#code#>
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//       super.init(coder: aDecoder)
//    }
    
    /**
     Easily load an image from a URL string and cache it to reduce network overhead later.
     
     - parameter urlString: The url location of your image, usually on a remote server somewhere.
     - parameter completion: Optionally execute some task after the image download completes
     */

    open func loadImage(urlString: String, completion: (() -> ())? = nil) {
        image = nil
        
        self.urlStringForChecking = urlString
        
        let urlKey = urlString as NSString
        
        if let cachedItem = CachedImageView.imageCache.object(forKey: urlKey) {
            image = cachedItem.image
            completion?()
            return
        }
        
        guard let url = URL(string: urlString) else {
            if shouldUseEmptyImage {
                image = emptyImage
            }
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            if error != nil {
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    let cacheItem = DiscardableImageCacheItem(image: image)
                    CachedImageView.imageCache.setObject(cacheItem, forKey: urlKey)
                    
                    if urlString == self?.urlStringForChecking {
                        self?.image = image
                        completion?()
                    }
                }
            }
            
            }).resume()
    }
}
