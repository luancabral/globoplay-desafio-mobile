//
//  MovieService.swift
//  globoplay
//
//  Created by Luan Cabral on 10/01/25.
//

import Alamofire

protocol MovieServiceProtocol {
    func fetchMoviesByCategory(targetEndpoint: MovieAPI,completion: @escaping (Result<MovieListModel, ServiceError>) -> Void)
    func fetchMoviesById(id: Int, completion: @escaping (Result<MovieModel, ServiceError>) -> Void)
}

final class MovieService: ServiceManager, MovieServiceProtocol {
    func fetchMoviesByCategory(targetEndpoint: MovieAPI, completion: @escaping (Result<MovieListModel, ServiceError>) -> Void) {
        fetch(endPoint: targetEndpoint, dataType: MovieListModel.self) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func fetchMoviesById(id: Int, completion: @escaping (Result<MovieModel, ServiceError>) -> Void) {
        fetch(endPoint: MovieAPI.fetchMovieById(id: id), dataType: MovieModel.self) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
