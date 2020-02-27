//
//  LunchViewController.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 27/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit
import MapKit

class LunchViewController: UIViewController {
  
    // MARK: - Properties

    @IBOutlet var restaurantsCollectionView: UICollectionView!
    private var restaurantArray: [Restaurant]?
    
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
                self?.restaurantErrorHandlingManager(error)
            case .success(let data):
                RestaurantResponse.parseRestaurantResponse(data: data) { result in
                    switch result {
                    case .failure(let error):
                        self?.restaurantErrorHandlingManager(error)
                    case .success(let response):
                        self?.restaurantArray = response.restaurants
                         DispatchQueue.main.async {
                             self?.restaurantsCollectionView.reloadData()
                         }
                    }
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func restaurantErrorHandlingManager(_ restaurantError: RestaurantError) {
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
        let collectionViewWidth: CGFloat = collectionView.frame.width
        guard let interfaceOrientation = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.windowScene?.interfaceOrientation else { return CGSize.zero
        }
        let width: CGFloat = (interfaceOrientation.isLandscape || Utils.Device.iPad) ? collectionViewWidth / 2 : collectionViewWidth
        
        return CGSize(width: width, height: LocalConstants.CollectionView.cellHeight)
    }
}

// MARK: - NavigationRightButtonDelegate

extension LunchViewController: NavigationRightButtonDelegate {
    
    func didTapMapButton(_ navigationController: UINavigationController) -> [Restaurant] {
        return restaurantArray ?? [Restaurant]()
    }
}

// MARK: - Local Constants

extension LunchViewController {
    
    private enum LocalConstants {
        enum Strings {
            static let vcTitle = "Lunch Time".localized()
        }
        enum ErrorMessages {
            static let noInternetConnectionTitle = "There's no internet connection!".localized()
            static let noInternetConnectionMessage = "Check your internet connection and try again.".localized()
            static let urlFailureTitle = "Oooops!".localized()
            static let urlFailureMessage = "Something wrong happened, please try again.".localized()
            static let canNotProcessDataTitle = "Warning!".localized()
            static let canNotProcessDataMessage = "Please try again, something wrong happened on the server.".localized()
        }
        enum CollectionView {
            static let cellHeight: CGFloat = CGFloat(180)
        }
    }
}
