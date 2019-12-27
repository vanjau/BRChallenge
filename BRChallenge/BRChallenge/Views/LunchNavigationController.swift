//
//  LunchNavigationController.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 27/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit

protocol NavigationRightButtonProtocol: AnyObject {
    func mapButtonTapped(navigationController: UINavigationController) -> String
}

class LunchNavigationController: UINavigationController, UINavigationControllerDelegate {

    public weak var navigationRightButtonDelegate: NavigationRightButtonProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self

        navigationBar.tintColor = .white
        
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItems = [share]
        
        let standard = UINavigationBarAppearance()
        standard.configureWithOpaqueBackground()
        standard.backgroundColor = #colorLiteral(red: 0.2632806003, green: 0.9094750285, blue: 0.5833142996, alpha: 1)
        let font: UIFont = UIFont(name: "AvenirNext-DemiBold", size: 17) ?? UIFont.systemFont(ofSize: 10)
        standard.titleTextAttributes = [.foregroundColor: UIColor.white, NSAttributedString.Key.font: font]
          
        UINavigationBar.appearance().standardAppearance = standard
    }
    

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        self.navigationRightButtonDelegate = viewController as? NavigationRightButtonProtocol
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
        let mapImage = #imageLiteral(resourceName: "icon_map")
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(image: mapImage, style: .plain, target: self, action: #selector(mapTapped))

    }
    
    @objc func mapTapped() {
        let vc = storyboard?.instantiateViewController(withIdentifier: MapViewController.storyboardIdentifier) as! MapViewController
        vc.dummyTestString = navigationRightButtonDelegate?.mapButtonTapped(navigationController: self) ?? ""
        present(vc, animated: true, completion: nil)
    }
}


//let vc = storyboard?.instantiateViewController(withIdentifier: MapViewController.storyboardIdentifier) as! MapViewController
//vc.dummyTestString = "DETAILS"
//present(vc, animated: true, completion: nil)
