//
//  Array+Extension.swift
//  globoplay
//
//  Created by Luan Cabral on 11/01/25.
//

import Foundation

extension Array {
    subscript (safe index: Index) -> Element? {
        guard index >= startIndex, index < endIndex else { return nil }
        return self[index]
    }
}
