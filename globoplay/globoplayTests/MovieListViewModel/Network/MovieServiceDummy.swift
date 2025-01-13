//
//  MovieServiceDummy.swift
//  globoplayTests
//
//  Created by Luan Cabral on 13/01/25.
//

import Foundation
@testable import globoplay

final class MovieServiceDummy: MovieServiceProtocol {
    func fetchMoviesByCategory(targetEndpoint: globoplay.MovieAPI, completion: @escaping (Result<globoplay.MovieListModel, globoplay.ServiceError>) -> Void) {}
    
    func fetchMoviesById(id: Int, completion: @escaping (Result<globoplay.MovieModel, globoplay.ServiceError>) -> Void) {}
}
