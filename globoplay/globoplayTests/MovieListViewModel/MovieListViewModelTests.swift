//
//  MovieListViewModelTests.swift
//  globoplayTests
//
//  Created by Luan Cabral on 13/01/25.
//

import Foundation
import XCTest
@testable import globoplay

final class MovieListViewModelTests: XCTestCase {
    private var viewModel: MovieListViewModel?
    private var onDidDelegateHit: ((DelegateHit) -> Void)?
    
    enum DelegateHit {
        case reloadView
        case error(ServiceError)
    }
    
    func makeViewModel(service: MovieServiceProtocol = MovieServiceDummy()) {
        viewModel = MovieListViewModel(service: service)
        viewModel?.viewDelegate = self
    }
    
    func testFetchTopRatedMoviesSuccess() throws {
        let expectation = expectation(description: "testFetchTopRatedMoviesSuccess")
        let mockedModel = try XCTUnwrap(JSONModelFactory.makeModel(MovieListModel.self,
                                                                   fromJSON: "MovieList"))
        
        let serviceStub = MovieServiceStub()
        serviceStub.fetchMoviesByCategoryResult = .success(mockedModel)
        makeViewModel(service: serviceStub)
        
        onDidDelegateHit = { hit in
            if case .reloadView = hit {
                XCTAssertEqual(self.viewModel?.topRatedMovies, mockedModel.results)
                expectation.fulfill()
            }
        }
        
        viewModel?.fetchTopRatedMovies()
        waitForExpectations(timeout: 10)
    }
    
    
    func testFetchTopRatedMoviesFailure() throws {
        let expectation = expectation(description: "testFetchTopRatedMoviesFailure")
        
        let serviceStub = MovieServiceStub()
        serviceStub.fetchMoviesByCategoryResult = .failure(.network)
        makeViewModel(service: serviceStub)
        
        onDidDelegateHit = { hit in
            if case .error(let error) = hit {
                XCTAssertEqual(error, .network)
                expectation.fulfill()
            }
        }
        
        viewModel?.fetchTopRatedMovies()
        waitForExpectations(timeout: 10)
    }
}

extension MovieListViewModelTests: MovieListViewModelViewDelegate {
    func reloadData() {
        onDidDelegateHit?(.reloadView)
    }
    
    func set(loading: Bool) {}
    
    func set(error: ServiceError, tryAgainAction: (() -> Void)?) {
        onDidDelegateHit?(.error(error))
    }
}
