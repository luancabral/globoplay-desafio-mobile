//
//  MovieServiceStub.swift
//  globoplayTests
//
//  Created by Luan Cabral on 13/01/25.
//

import Foundation
@testable import globoplay

final class MovieServiceStub: MovieServiceProtocol {
    var fetchMoviesByCategoryResult: Result<MovieListModel, ServiceError> = .failure(.other)
    var fetchMoviesByIdResult: Result<MovieModel, ServiceError> = .failure(.other)
    
    func fetchMoviesByCategory(targetEndpoint: MovieAPI, completion: @escaping (Result<MovieListModel, ServiceError>) -> Void) {
        completion(fetchMoviesByCategoryResult)
    }
    
    func fetchMoviesById(id: Int, completion: @escaping (Result<MovieModel, ServiceError>) -> Void) {
        completion(fetchMoviesByIdResult)
    }
}
