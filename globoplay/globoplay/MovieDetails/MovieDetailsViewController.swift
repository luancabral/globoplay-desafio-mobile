//
//  MovieDetailsViewController.swift
//  globoplay
//
//  Created by Luan Cabral on 11/01/25.
//

import Foundation
import UIKit

final class MovieDetailsViewController: BaseViewController {
    private let customView = MovieDetailsView()
    private let viewModel: MovieDetailsViewModel
    
    override func loadView() {
        view = customView
    }
    
    init(movie: MovieModel, posterImage: UIImage?, viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init()
        customView.delegate = self
        customView.setup(movie, posterImage)
    }
    
    override func beginAppearanceTransition(_ isAppearing: Bool, animated: Bool) {
        super.beginAppearanceTransition(isAppearing, animated: animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension MovieDetailsViewController: MovieDetailsViewProtocol {
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func favoriteButtonTapped(movie: MovieModel) {
        viewModel.toggleFavorite(movie)
    }
}
