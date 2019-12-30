//
//  InternetsNavigationBarView.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 12/28/19.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit

class InternetsNavigationBarView: UIView {

    
    let inputsContainerView: UIView = {
        let view = UIView()
        let red = UIColor.red
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.backgroundColor = red.cgColor
        view.layer.masksToBounds = true
        return view
    }()

    var inputsContainerViewHeightAnchor: NSLayoutConstraint?

    func setUpInputContainer() {
        //Needs x, y, height, and width constraints for INPUTCONTAINER
        inputsContainerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: widthAnchor, constant: -24).isActive = true
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputsContainerViewHeightAnchor?.isActive = true


    }
    
    ///

    
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .red

        return contentView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
      
    }
    
    private func setupView() {
        backgroundColor = .red
        translatesAutoresizingMaskIntoConstraints = false
//        addSubview(contentView)

//        NSLayoutConstraint.activate([
//        //layout contentView
//        contentView.topAnchor.constraint(equalTo: topAnchor),
//        contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
//        contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
//        contentView.trailingAnchor.constraint(equalTo: trailingAnchor)
//        
//        ])
        
        
    }
    
}
