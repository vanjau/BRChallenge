//
//  BRNavigationController.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 12/28/19.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit

class BRNavigationController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        navigationBar.tintColor = .white
        
        let standard = UINavigationBarAppearance()
        standard.configureWithOpaqueBackground()
        standard.backgroundColor = #colorLiteral(red: 0.2632806003, green: 0.9094750285, blue: 0.5833142996, alpha: 1)
        let font: UIFont = UIFont(name: "AvenirNext-DemiBold", size: 17) ?? UIFont.systemFont(ofSize: 10)
        standard.titleTextAttributes = [.foregroundColor: UIColor.white, NSAttributedString.Key.font: font]
          
        UINavigationBar.appearance().standardAppearance = standard
    }
    

}
