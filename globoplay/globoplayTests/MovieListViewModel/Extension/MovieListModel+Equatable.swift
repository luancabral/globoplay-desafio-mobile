//
//  MovieListModel+Equatable.swift
//  globoplayTests
//
//  Created by Luan Cabral on 13/01/25.
//

import Foundation
@testable import globoplay

extension MovieListModel: Equatable {
    public static func == (lhs: MovieListModel, rhs: MovieListModel) -> Bool {
        return lhs.page == rhs.page &&
        lhs.results == rhs.results
    }
}
