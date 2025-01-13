//
//  FavoriteMoviesBuilder.swift
//  globoplay
//
//  Created by Luan Cabral on 13/01/25.
//

import Foundation

struct FavoriteMoviesBuilder {
    func build() -> FavoriteMoviesViewController {
        let viewModel = FavoriteMoviesViewModel(service: MovieService())
        let viewController = FavoriteMoviesViewController(viewModel: viewModel)
        return viewController
    }
    
    func buildWithNavigationController() -> BaseNavigationController {
        BaseNavigationController(rootViewController: build(), title: "Minha Lista", tabBarImageName:  "star")
    }
}
