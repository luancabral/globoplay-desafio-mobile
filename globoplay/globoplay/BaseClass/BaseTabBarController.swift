//
//  BaseTabBarController.swift
//  globoplay
//
//  Created by Luan Cabral on 11/01/25.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        setupDesign()
    }
    
    private func setupDesign() {
        tabBar.barTintColor = .black
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
        tabBar.isTranslucent = false
    }
    
    private func setupTabs() {
        let movieListViewController = MovieListBuilder().buildWithNavigationController()
        let favoriteMoviesViewController = FavoriteMoviesBuilder().buildWithNavigationController()
        self.setViewControllers([movieListViewController, favoriteMoviesViewController], animated: true)
    }
}
