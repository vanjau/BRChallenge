//
//  InternetsViewController.swift
//  BRChallenge
//
//  Created by Vanja Ruzic on 27/12/2019.
//  Copyright © 2019 Vanja Ruzic. All rights reserved.
//

import UIKit
import WebKit

class InternetsViewController: UIViewController {

    // MARK: - Properties
    
    lazy fileprivate var webView: WKWebView = {
        let view = WKWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    lazy fileprivate var activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.center = view.center
        spinner.hidesWhenStopped = true
        spinner.style = UIActivityIndicatorView.Style.medium
        
        return spinner
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        view.addSubview(activityIndicator)
        
        webView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        webView.navigationDelegate = self
        
        guard let url = URL(string: LocalConstants.Strings.brWebsite) else {
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

// MARK - WKNavigationDelegate

extension InternetsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}

// MARK - InternetsNavigationDelegate

extension InternetsViewController: InternetsNavigationDelegate {
    func didTapBackButton(_ withNavigationController: InternetsNavigationController) {
        webView.goBack()
    }
    
    func didTapReloadButton(_ withNavigationController: InternetsNavigationController) {
        webView.reload()
    }
    
    func didTapForwardButton(_ withNavigationController: InternetsNavigationController) {
        webView.goForward()
    }
}

// MARK: - Local Constants

extension InternetsViewController {
    fileprivate enum LocalConstants {
        enum Strings {
            static let brWebsite = "https://www.bottlerocketstudios.com"
        }
    }
}
