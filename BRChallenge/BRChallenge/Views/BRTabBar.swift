//
//  BRTabBar.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 27/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit

class BRTabBar: UITabBar {
    
    @IBInspectable var tabBarHeight: CGFloat = 50.0
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let window = UIApplication.shared.windows.first else {
            return super.sizeThatFits(size)
        }
        var sizeThatFits = super.sizeThatFits(size)
        if tabBarHeight > 0.0 {
            sizeThatFits.height = tabBarHeight + window.safeAreaInsets.bottom
        }
        return sizeThatFits
    }
}
