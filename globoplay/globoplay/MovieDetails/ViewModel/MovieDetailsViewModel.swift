//
//  MovieDetailsViewModel.swift
//  globoplay
//
//  Created by Luan Cabral on 13/01/25.
//

import Foundation

final class MovieDetailsViewModel {
    func toggleFavorite(_ activeMovie: MovieModel) {
        let defaults = UserDefaultManager(keyName: "favoriteMovies")
        if activeMovie.isFavorite {
            defaults.remove(an: activeMovie.id)
            return
        }
        
        defaults.update(with: activeMovie.id)
    }
}
