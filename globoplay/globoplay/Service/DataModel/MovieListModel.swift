//
//  MovieListModel.swift
//  globoplay
//
//  Created by Luan Cabral on 10/01/25.
//

import Foundation

struct MovieListModel: Codable {
    let page: Int
    let results: [MovieModel]
}

struct MovieModel: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    let originalLanguage: String
    let voteAverage: Double
    
    var isFavorite: Bool {
        let defaults = UserDefaultManager(keyName: "favoriteMovies")
        return defaults.hasSome(element: id)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case voteAverage = "vote_average"
    }
}
