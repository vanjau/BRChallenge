//
//  InternetsNavigationController.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 12/28/19.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit
import WebKit

protocol InternetsNavigationDelegate: AnyObject {
    /**
     Go back in the web view after tapping back button in navigation bar.
     - Parameter withNavigationController:
     */
    func didTapBackButton(_ withNavigationController: InternetsNavigationController)
    
    /**
     Refresh web view after tapping reload in navigation bar.
     - Parameter withNavigationController:
     */
    func didTapReloadButton(_ withNavigationController: InternetsNavigationController)
    
    /**
     Go forward in the web view after tapping forward button in navigation bar.
     - Parameter withNavigationController:
     */
    func didTapForwardButton(_ withNavigationController: InternetsNavigationController)
}

class InternetsNavigationController: BRNavigationController {

    // MARK: - Properties
    
    public weak var internetsNavigationDelegate: InternetsNavigationDelegate?
    public var backBarItem: UIBarButtonItem?
    public var forwardBarItem: UIBarButtonItem?
    public var refreshBarItem: UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        internetsNavigationBarDefaultState()
    }
    
    private func internetsNavigationBarDefaultState() {
        let backImage = #imageLiteral(resourceName: "ic_webBack")
        let reloadImage = #imageLiteral(resourceName: "ic_webRefresh")
        let forwardImage = #imageLiteral(resourceName: "ic_webForward")

        backBarItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backAction))
        backBarItem!.isEnabled = false
        refreshBarItem = UIBarButtonItem(image: reloadImage, style: .plain, target: self, action: #selector(reloadAction))
        forwardBarItem = UIBarButtonItem(image: forwardImage, style: .plain, target: self, action: #selector(forwardAction))
        forwardBarItem!.isEnabled = false
    }
    
    // MARK: - Actions
    
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
