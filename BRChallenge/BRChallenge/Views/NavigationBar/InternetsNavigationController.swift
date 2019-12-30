//
//  InternetsNavigationController.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 12/28/19.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit

protocol InternetsNavigationDelegate: AnyObject {
    func didTapBackButton(_ withNavigationController: InternetsNavigationController)
    func didTapReloadButton(_ withNavigationController: InternetsNavigationController)
    func didTapForwardButton(_ withNavigationController: InternetsNavigationController)
}

class InternetsNavigationController: BRNavigationController {


    public weak var internetsNavigationDelegate: InternetsNavigationDelegate?

    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        self.internetsNavigationDelegate = viewController as? InternetsNavigationDelegate
        
        let backImage = #imageLiteral(resourceName: "ic_webBack")
        let reloadImage = #imageLiteral(resourceName: "ic_webRefresh")
        let forwardImage = #imageLiteral(resourceName: "ic_webForward")

        let back = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backAction))
        let refresh = UIBarButtonItem(image: reloadImage, style: .plain, target: self, action: #selector(reloadAction))
        let forward = UIBarButtonItem(image: forwardImage, style: .plain, target: self, action: #selector(forwardAction))

        
        viewController.navigationItem.leftBarButtonItems = [back, refresh, forward]

    }
    
    @objc func backAction() {
        internetsNavigationDelegate?.didTapBackButton(self)
    }
    
    @objc func reloadAction() {
        internetsNavigationDelegate?.didTapReloadButton(self)

    }
    
    @objc func forwardAction() {
        internetsNavigationDelegate?.didTapForwardButton(self)

    }
}
