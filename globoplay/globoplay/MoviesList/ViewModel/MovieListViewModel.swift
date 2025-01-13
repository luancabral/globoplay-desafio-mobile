//
//  MovieListViewModel.swift
//  globoplay
//
//  Created by Luan Cabral on 10/01/25.
//

import Foundation

protocol MovieListViewModelViewDelegate: ViewModelDelegate {
    func reloadData()
}

final class MovieListViewModel {
    let service: MovieServiceProtocol
    var topRatedMovies = [MovieModel]()
    var nowPlayingMovies = [MovieModel]()
    var weekTrending = [MovieModel]()
    private(set) var sections: [Sections] = []
    
    weak var viewDelegate: MovieListViewModelViewDelegate?
    
    init(service: MovieServiceProtocol) {
        self.service = service
    }
    
    func fetchTopRatedMovies() {
        viewDelegate?.set(loading: true)
        service.fetchMoviesByCategory(targetEndpoint: .topRatedMovie) { [weak self] result in
            guard let self else { return }
            self.viewDelegate?.set(loading: false)
            switch result {
            case .success(let topRatedModel):
                self.topRatedMovies = topRatedModel.results
                updateSections()
                viewDelegate?.reloadData()
            case .failure(let error):
                viewDelegate?.set(error: error, tryAgainAction: fetchTopRatedMovies)
            }
        }
    }
    
    func fetchNowPlayingMovies() {
        viewDelegate?.set(loading: true)
        service.fetchMoviesByCategory(targetEndpoint: .nowPlayingMovies) { [weak self] result in
            guard let self else { return }
            self.viewDelegate?.set(loading: false)
            switch result {
            case .success(let weekTrending):
                self.weekTrending = weekTrending.results
                updateSections()
                viewDelegate?.reloadData()
            case .failure(let error):
                viewDelegate?.set(error: error, tryAgainAction: fetchNowPlayingMovies)
            }
        }
    }
    
    func fetchWeekTrendingMovies() {
        viewDelegate?.set(loading: true)
        service.fetchMoviesByCategory(targetEndpoint: .weekTrending) { [weak self] result in
            guard let self else { return }
            self.viewDelegate?.set(loading: false)
            switch result {
            case .success(let nowPlayingMovies):
                self.nowPlayingMovies = nowPlayingMovies.results
                updateSections()
                viewDelegate?.reloadData()
            case .failure(let error):
                viewDelegate?.set(error: error, tryAgainAction: fetchWeekTrendingMovies)
            }
        }
    }
}

// MARK: - TableView Methods
extension MovieListViewModel {
    enum Sections {
        case category(title: String, content: [MovieModel])
    }
    
    private func updateSections() {
        sections = []
        
        if !weekTrending.isEmpty {
            sections.append(.category(title: "Queridinhos da semana", content: weekTrending))
        }
        
        if !topRatedMovies.isEmpty {
            sections.append(.category(title: "Populares", content: topRatedMovies))
        }
        
        if !nowPlayingMovies.isEmpty {
            sections.append(.category(title: "Nos cinemas", content: nowPlayingMovies))
        }
    }
}
