//
//  LunchViewController.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 27/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit
import MapKit

struct Device {
    static let iPad = UIDevice.current.userInterfaceIdiom == .pad
    static let iPhone = UIDevice.current.userInterfaceIdiom == .phone
}

class LunchViewController: UIViewController {
  
    // MARK: - Properties

    @IBOutlet var restaurantsCollectionView: UICollectionView!
    fileprivate var restaurantArray: [Restaurant]?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = LocalConstants.Strings.vcTitle
        network()
    }
    
    
    func network() {
        let endpointString = "restaurants.json"
        let session = URLSession.shared
        let client = NetworkManager(session: session)
        
        client.get(withEndpoitString: endpointString) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let char):
                do {
                    let decoder = JSONDecoder()
                    let charityResponse = try decoder.decode(RestaurantsResponse.self, from: char)
                    print(charityResponse.restaurants[0])
                    print(charityResponse.restaurants[0].name ?? "")
                    self?.restaurantArray = charityResponse.restaurants
                    DispatchQueue.main.async {
                        self?.restaurantsCollectionView.reloadData()
                    }
                } catch {
                    print("FAIL")
                }
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        restaurantsCollectionView.collectionViewLayout.invalidateLayout()
    }
}

// MARK: - UICollectionViewDataSource

extension LunchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let restaurantCell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCollectionViewCell.cellIdentifier, for: indexPath) as! RestaurantCollectionViewCell
        restaurantCell.restaurant = restaurantArray?[indexPath.item]
        
        return restaurantCell
    }
}

// MARK: - UICollectionViewDelegate

extension LunchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let restaurant = restaurantArray?[indexPath.item] ?? Restaurant()
        guard let mapVC = storyboard?.instantiateViewController(identifier: RestaurantDetailsViewController.storyboardIdentifier, creator: { coder in
            return RestaurantDetailsViewController(coder: coder, restaurant: restaurant)
         }) else {
             fatalError("Failed to load MapViewController from storyboard.")
         }
        navigationController?.pushViewController(mapVC, animated: true)
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
    func didTapMapButton(navigationController: UINavigationController) -> [CLLocation] {
        
        var locations = [CLLocation]()

        for item in restaurantArray! {
            let lat = item.location?.lat ?? 0
            let lng = item.location?.lng ?? 0

            locations.append(CLLocation(latitude: lat, longitude: lng))
        }
        
        return locations
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
