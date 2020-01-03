//
//  Utils.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 1/3/20.
//  Copyright © 2020 Vanja Ruzic. All rights reserved.
//

import UIKit

struct Utils {
    enum Device {
        static let iPad = UIDevice.current.userInterfaceIdiom == .pad
        static let iPhone = UIDevice.current.userInterfaceIdiom == .phone
    }
    
    enum Fonts {
        static let brFontRegular = UIFont(name: "AvenirNext-Regular", size: 10)
        static let brFontDemiBold = UIFont(name: "AvenirNext-DemiBold", size: 17)
    }
}


