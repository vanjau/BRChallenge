//
//  RestaurantDetailsViewController.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 27/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit

class RestaurantDetailsViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var detailsTableView: UITableView!
    fileprivate var restaurant: Restaurant?
    
    // MARK: - Init
    
    /**
     Creates a personalized RestaurantDetailsViewController with restaurant object.
     - Parameter coder: Coder.
     - Parameter restaurant: Tapped restaurant object from the list of restaurants.
     */
    init?(coder: NSCoder, restaurant: Restaurant) {
        super.init(coder: coder)
        self.restaurant = restaurant
    }

    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a restaurant.")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = LocalConstants.Strings.vcTitle
    }
}

// MARK: - UITableViewDataSource

extension RestaurantDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocalConstants.Numbers.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case LocalConstants.CellType.map:
            let mapCell = tableView.dequeueReusableCell(withIdentifier: DetailsMapTableViewCell.cellIdentifier) as! DetailsMapTableViewCell
            mapCell.restaurant = restaurant

            return mapCell
        case LocalConstants.CellType.info:
            let infoCell = tableView.dequeueReusableCell(withIdentifier: DetailsRestaurantInfoTableViewCell.cellIdentifier) as! DetailsRestaurantInfoTableViewCell
            infoCell.restaurant = restaurant

            return infoCell
        case LocalConstants.CellType.contact:
            let contactCell = tableView.dequeueReusableCell(withIdentifier: DetailsRestaurantContactTableViewCell.cellIdentifier) as! DetailsRestaurantContactTableViewCell
            contactCell.restaurant = restaurant

            return contactCell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension RestaurantDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case LocalConstants.CellType.map:
            return LocalConstants.CellHeight.mapCellHeight
        case LocalConstants.CellType.info:
            return LocalConstants.CellHeight.infoCellHeight
        case LocalConstants.CellType.contact:
            return LocalConstants.CellHeight.contactCellHeight
        default:
            return .zero
        }
    }
}

// MARK: - NavigationRightButtonProtocol

extension RestaurantDetailsViewController: NavigationRightButtonDelegate {
    
    func didTapMapButton(_ navigationController: UINavigationController) -> [Restaurant] {
        guard let restaurant = restaurant else {
            return [Restaurant]()
        }
        return [restaurant]
    }
}

// MARK: - Local Constants

extension RestaurantDetailsViewController {
    
    fileprivate enum LocalConstants {
        enum Strings {
            static let vcTitle = "Details"
        }
        enum Numbers {
            static let numberOfCells = 3
        }
        enum CellHeight {
            static let mapCellHeight: CGFloat = 180
            static let infoCellHeight: CGFloat = 60
            static let contactCellHeight: CGFloat = 200
        }
        enum CellType {
            static let map: Int = 0
            static let info: Int = 1
            static let contact: Int = 2
        }
    }
}

