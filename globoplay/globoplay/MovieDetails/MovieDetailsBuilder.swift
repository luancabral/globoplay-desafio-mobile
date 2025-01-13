//
//  MovieDetailsBuilder.swift
//  globoplay
//
//  Created by Luan Cabral on 11/01/25.
//

import Foundation
import UIKit

struct MovieDetailsBuilder {
    func build(movie: MovieModel, posterImage: UIImage?) -> MovieDetailsViewController {
        let viewModel = MovieDetailsViewModel()
        let viewController = MovieDetailsViewController(movie: movie, posterImage: posterImage, viewModel: viewModel)
        return viewController
    }
}
