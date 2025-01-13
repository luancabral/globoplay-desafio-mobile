//
//  ViewCode.swift
//  globoplay
//
//  Created by Luan Cabral on 10/01/25.
//

import Foundation

protocol ViewCode {
    func buildHierarchy()
    func buildConstratins()
    func setupView()
}

extension ViewCode {
    func setupView() {
        buildHierarchy()
        buildConstratins()
    }
}

