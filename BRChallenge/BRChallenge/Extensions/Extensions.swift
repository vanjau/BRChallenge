//
//  Extensions.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 27/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIViewController

extension UIViewController {
    
    static internal var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    internal func showSimpleAlertWindow(title: String, message: String, completionHandler: @escaping ()->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            _ in
            completionHandler()
        }))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewCell

extension UICollectionViewCell {
    
    static internal var cellIdentifier: String {
        return String(describing: self)
    }
}
