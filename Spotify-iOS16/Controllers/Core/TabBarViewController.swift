//
//  TabBarViewController.swift
//  Spotify-iOS16
//
//  Created by Amr Mohamad on 13/09/2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /// a reference of HomeViewController
        let vc1 = HomeViewController()
        /// a reference of SearchViewController
        let vc2 = SearchViewController()
        /// a reference of LibraryViewController
        let vc3 = LibraryViewController()
        
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        
        /// a start point of UINavigation for HomeViewController
        let nav1 = UINavigationController(rootViewController: vc1)
        /// a start point of UINavigation for SearchViewController
        let nav2 = UINavigationController(rootViewController: vc2)
        /// a start point of UINavigation for LibraryViewController
        let nav3 = UINavigationController(rootViewController: vc3)
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"), tag: 1)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        
        // link ViewControllers to tabBar
        setViewControllers([nav1,nav2,nav3], animated: false)
    }
    


}
