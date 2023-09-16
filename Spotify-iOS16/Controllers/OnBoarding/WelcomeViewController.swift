//
//  WelcomeViewController.swift
//  Spotify-iOS16
//
//  Created by Amr Mohamad on 13/09/2023.
//

import UIKit

class WelcomeViewController: UIViewController {

    let  signInButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("Sing In with Sportify", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Spotify"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemGreen
        
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupSignInButtonConstraints()
    }
    
    
    /// Preparing the AuthViewController that contains the WebView of SpotifyAuth to get the data of the user
    @objc func didTapSignIn () {
        let authVC = AuthViewController()
        authVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(authVC, animated: true)
    }
    
    
    
    ///Updating the height constraint of the `signInButton` in the `viewDidLayoutSubviews()` method based on the device's orientation. Ant the height constraint is correctly updated when the device is in landscape or portrait orientation.
    ///
    ///Here's a summary of what code does:
    ///
    /// 1. It checks if there is an existing height constraint for the `signInButton` and deactivates it if it exists.
    ///
    /// 2. It activates a new height constraint for the `signInButton` based on the device's orientation. In landscape orientation, it sets the height to 35, and in portrait orientation, it sets the height to 75.
    ///
    /// 3. It also sets constraints for the bottom, leading, and trailing edges of the `signInButton` to position it relative to the view.
    ///
    /// 4. The debug output shows the list of constraints for the `signInButton`, and you can see that the height constraint is correctly updated based on the orientation.
    ///
    ///This approach should ensure that the `signInButton` has the correct height and position in both landscape and portrait orientations. If you have any further questions or need more assistance, feel free to ask!
    func setupSignInButtonConstraints () {
        
        if let existingHeightConstraint = signInButton
            .constraints
            .last(
                where: {
                    $0.firstAttribute == .height
                }
            ) {
                existingHeightConstraint.isActive = false
            }
        
        NSLayoutConstraint.activate(
            [
                signInButton.bottomAnchor
                    .constraint(
                        equalTo: view.bottomAnchor,
                        constant: -25
                    ),
                signInButton.leadingAnchor
                    .constraint(
                        equalTo: view.leadingAnchor,
                        constant: 56
                    ),
                signInButton.trailingAnchor
                    .constraint(
                        equalTo: view.trailingAnchor,
                        constant: -56
                    )
            ]
        )
        switch UIDevice.current.orientation {
        case .landscapeLeft, .landscapeRight :
            NSLayoutConstraint.activate(
                [
                    signInButton.heightAnchor
                        .constraint(
                            equalToConstant: 35
                        )
                ]
            )
        case .portrait :
            NSLayoutConstraint.activate(
                [
                    signInButton.heightAnchor
                        .constraint(
                            equalToConstant: 75
                        )
                ]
            )
        default:
            print("error")
        }
        
    }
}
