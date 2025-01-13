//
//  APIService.swift
//  globoplay
//
//  Created by Luan Cabral on 10/01/25.
//

import Foundation
import Alamofire

enum MovieAPI {
    case topRatedMovie
    case nowPlayingMovies
    case weekTrending
    case fetchMovieById(id: Int)
}

extension MovieAPI: APIConfiguration {
    var method: HTTPMethod {
        switch self {
        case .topRatedMovie,
             .nowPlayingMovies,
             .weekTrending,
             .fetchMovieById:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .topRatedMovie:
            return "movie/top_rated"
        case .nowPlayingMovies:
            return "movie/now_playing"
        case .weekTrending:
            return "trending/movie/week"
        case .fetchMovieById(let id):
            return "/movie/\(id)"
        }
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = "https://api.themoviedb.org/3/" + path
        
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0NGY1NTgxZTY2ZTgwMzQ1Mjc4YTI5NGIzYjEzZGJmMiIsIm5iZiI6MTczNjU0NDg1Ni44NTQsInN1YiI6IjY3ODE5MjU4YzVkMmU5NmUyNjdiNTExZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.TC-j6FKYVjX1xPkDtsa5qgAFU8hYrTbjj1XlU7k6vdY"]
        
        return urlRequest
    }
}
