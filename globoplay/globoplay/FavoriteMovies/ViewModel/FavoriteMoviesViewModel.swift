//
//  FavoriteMoviesViewModel.swift
//  globoplay
//
//  Created by Luan Cabral on 13/01/25.
//

import Foundation

protocol FavoriteMoviesViewModelDelegate: ViewModelDelegate {
    func reloadData()
}

final class FavoriteMoviesViewModel {
    private let service: MovieServiceProtocol
    private(set) var favoritesMovies = [MovieModel]()
    weak var viewDelegate: FavoriteMoviesViewModelDelegate?
    
    init(service: MovieServiceProtocol, _ favoritesMovies: [MovieModel] = [MovieModel]()) {
        self.service = service
        self.favoritesMovies = favoritesMovies
    }
    
    func loadFavoriteMovies() {
        favoritesMovies.removeAll()
        let defaults = UserDefaultManager(keyName: "favoriteMovies")
        guard let moviesIds = defaults.load() else { return }
        fetchFavoriteMovies(moviesIds: moviesIds.sorted())
    }
    
    func fetchFavoriteMovies(moviesIds: [Int]) {
         moviesIds.forEach { id in
            fetchMovieById(movieId: id)
        }
    }
    
    func fetchMovieById(movieId: Int) {
        service.fetchMoviesById(id: movieId) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let favoriteMovie):
                self.favoritesMovies.append(favoriteMovie)
                viewDelegate?.reloadData()
            case .failure(let error):
                viewDelegate?.set(error: error, tryAgainAction: { [weak self] in self?.fetchMovieById(movieId: movieId) })
            }
        }
    }
}
