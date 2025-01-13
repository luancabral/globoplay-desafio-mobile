//
//  MovieListBuilder.swift
//  globoplay
//
//  Created by Luan Cabral on 10/01/25.
//

import Foundation

struct MovieListBuilder {
    func build() -> MovieListViewController {
        let viewModel = MovieListViewModel(service: MovieService())
        let viewController = MovieListViewController(viewModel: viewModel)
        return viewController
    }
    
    func buildWithNavigationController() -> BaseNavigationController {
        BaseNavigationController(rootViewController: build(), title: "Início", tabBarImageName:  "home")
    }
}
