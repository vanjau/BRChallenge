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
        navigationItem.title = LocalConstants.Strings.vcTitle
        fetchRestaurants()
    }
    
    // MARK: - Networking

    func fetchRestaurants() {
        let urlString = Constants.API.baseURL + Constants.API.restaurnatsEndpoint
        let session = URLSession.shared
        let client = NetworkManager(session: session)
        
        client.get(withUrlString: urlString) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                self?.restaurantErrorHandlingManager(error)
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let restaurantsResponse = try decoder.decode(RestaurantsResponse.self, from: data)
                    self?.restaurantArray = restaurantsResponse.restaurants
                    DispatchQueue.main.async {
                        self?.restaurantsCollectionView.reloadData()
                    }
                } catch {
                    print("FAIL")
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    
    fileprivate func restaurantErrorHandlingManager(_ restaurantError: RestaurantError) {
        var errorMessageTitle = ""
        var errorMessageMessage = ""
        DispatchQueue.main.async {
            switch restaurantError {
            case .noInternetConnection:
                errorMessageTitle = LocalConstants.ErrorMessages.noInternetConnectionTitle
                errorMessageMessage = LocalConstants.ErrorMessages.noInternetConnectionMessage
            case .urlFailure:
                errorMessageTitle = LocalConstants.ErrorMessages.urlFailureTitle
                errorMessageMessage = LocalConstants.ErrorMessages.urlFailureMessage
            case .canNotProcessData:
                errorMessageTitle = LocalConstants.ErrorMessages.canNotProcessDataTitle
                errorMessageMessage = LocalConstants.ErrorMessages.canNotProcessDataMessage
            }
            
            self.showSimpleAlertWindow(title: errorMessageTitle, message: errorMessageMessage, completionHandler: {
                 self.fetchRestaurants()
            })
        }
    }
    
    // MARK: - Orientation change

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
        let width = Device.iPad ? view.frame.width / 2 : view.frame.width
        
        return CGSize(width: width, height: LocalConstants.CollectionView.cellHeight)
    }
}

// MARK: - NavigationRightButtonProtocol

extension LunchViewController: NavigationRightButtonProtocol {
    func didTapMapButton(navigationController: UINavigationController) -> [Restaurant] {
        var locations = [CLLocation]()

        for item in restaurantArray! {
            let lat = item.location?.lat ?? 0
            let lng = item.location?.lng ?? 0

            locations.append(CLLocation(latitude: lat, longitude: lng))
        }
        
        return restaurantArray ?? [Restaurant]()
    }
}

// MARK: - Local Constants

extension LunchViewController {
    fileprivate enum LocalConstants {
        enum Strings {
            static let vcTitle = "Lunch Tyme"
        }
        enum ErrorMessages {
            static let noInternetConnectionTitle = "There's no internet connection!"
            static let noInternetConnectionMessage = "Check your internet connection and try again."
            static let urlFailureTitle = "Oooops!"
            static let urlFailureMessage = "Something wrong happened, please try again."
            static let canNotProcessDataTitle = "Warning!"
            static let canNotProcessDataMessage = "Please try again, something wrong happened on the server."
        }
        enum CollectionView {
            static let cellHeight: CGFloat = CGFloat(180)
        }
    }
}
