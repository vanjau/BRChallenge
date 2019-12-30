//
//  LunchViewController.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 27/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit

struct Device {
    static let iPad = UIDevice.current.userInterfaceIdiom == .pad
    static let iPhone = UIDevice.current.userInterfaceIdiom == .phone
}

class LunchViewController: UIViewController {
  
    // MARK: - Properties

    @IBOutlet var restaurantsCollectionView: UICollectionView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = LocalConstants.Strings.vcTitle

    }
}

// MARK: - UICollectionViewDataSource

extension LunchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let restaurantCell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCollectionViewCell.cellIdentifier, for: indexPath) as! RestaurantCollectionViewCell
        if indexPath.item % 4 == 0 {
            restaurantCell.contentView.backgroundColor = .red
        } else if indexPath.item % 3 == 0 {
            restaurantCell.contentView.backgroundColor = .green
        } else if indexPath.item % 2 == 0 {
            restaurantCell.contentView.backgroundColor = .blue
        } else {
            restaurantCell.contentView.backgroundColor = .yellow

        }
        
        return restaurantCell
    }
}

// MARK: - UICollectionViewDelegate

extension LunchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Lunch", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RestaurantDetailsViewController") as! RestaurantDetailsViewController
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension LunchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat
        
        if Device.iPad {
            width = view.frame.width / 2
        } else {
            width = view.frame.width
        }
        
        return CGSize(width: width, height: LocalConstants.CollectionView.cellHeight)
    }
}

// MARK: - NavigationRightButtonProtocol

extension LunchViewController: NavigationRightButtonProtocol {
    func mapButtonTapped(navigationController: UINavigationController) -> String {
        return "LUNCH"
    }
}

// MARK: - Local Constants

extension LunchViewController {
    fileprivate enum LocalConstants {
        enum Strings {
            static let vcTitle = "Lunch Tyme"
        }
        
        enum CollectionView {
            static let cellHeight: CGFloat = CGFloat(180)
        }
    }
}
