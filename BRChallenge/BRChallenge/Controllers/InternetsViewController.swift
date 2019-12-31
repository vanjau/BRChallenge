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
    
    lazy fileprivate var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        toolbarItems = [progressButton]
        navigationController?.isToolbarHidden = false
        
        return progressView
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        webViewSetup()
    }
    
    // MARK: - Private Methods
    
    fileprivate func webViewSetup() {
        view.addSubview(webView)
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
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    // MARK - Observers

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == LocalConstants.Keys.estimatedProgress {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
}

// MARK - WKNavigationDelegate

extension InternetsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        navigationController?.isToolbarHidden = true
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        navigationController?.isToolbarHidden = false
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        navigationController?.isToolbarHidden = true
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
        enum Keys {
            static let estimatedProgress = "estimatedProgress"
        }
    }
}
