//
//  BRTabBar.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 27/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit

class BRTabBar: UITabBar {
    
    // MARK: - Properties
    
    @IBInspectable var tabBarHeight: CGFloat = 50.0
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTabBarFont()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTabBarFont()
    }
    
    // MARK: - Override Methods

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
    
    // MARK: - Private Methods

    fileprivate func setupTabBarFont() {
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font: Utils.Fonts.brFontRegular]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
    }
}
