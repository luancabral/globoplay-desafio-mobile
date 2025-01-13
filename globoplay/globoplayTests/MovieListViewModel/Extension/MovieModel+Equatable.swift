//
//  MovieModel+Equatable.swift
//  globoplayTests
//
//  Created by Luan Cabral on 13/01/25.
//

import Foundation
@testable import globoplay

extension MovieModel: Equatable {
    public static func == (lhs: MovieModel, rhs: MovieModel) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.overview == rhs.overview &&
        lhs.posterPath == rhs.posterPath &&
        lhs.originalLanguage == rhs.originalLanguage &&
        lhs.voteAverage == rhs.voteAverage &&
        lhs.isFavorite == rhs.isFavorite &&
        lhs.releaseDate == rhs.releaseDate
    }
    
    
}
