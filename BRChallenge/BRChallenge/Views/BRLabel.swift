//
//  BRLabel.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 30/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit

@IBDesignable
class BRLabel: UILabel {

    @IBInspectable var cornerRadius: CGFloat = 4.0 {
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
      
    }
}
