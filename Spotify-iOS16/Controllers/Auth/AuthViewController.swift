//
//  AuthViewController.swift
//  Spotify-iOS16
//
//  Created by Amr Mohamad on 13/09/2023.
//

import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate {
    
    let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }()
    
    /// completionHandler for once the user successfully signs in or cancels, we want to go ahead and return is done or not.
    public var completionHandler : ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Sign In"
        view.backgroundColor = .systemBackground
        webView.navigationDelegate = self
        view.addSubview(webView)
        guard let url = AuthManager.shared.signInURL else {return}
        webView.load(URLRequest(url: url))
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
        navigationController?.overrideUserInterfaceStyle = .dark
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.overrideUserInterfaceStyle = .unspecified
    }
}
