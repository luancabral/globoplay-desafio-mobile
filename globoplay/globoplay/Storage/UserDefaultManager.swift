//
//  UserDefaultManager.swift
//  globoplay
//
//  Created by Luan Cabral on 13/01/25.
//

import Foundation

final class UserDefaultManager {
    private let defaults: UserDefaults
    private let keyName: String
    
    init(defaults: UserDefaults = UserDefaults.standard, keyName: String) {
        self.defaults = defaults
        self.keyName = keyName
        
    }
    
    func save(items: [Int]) {
        defaults.set(items, forKey: keyName)
    }
    
    func load() -> [Int]? {
        return defaults.array(forKey: keyName) as? [Int]
    }
    
    func update(with newElement: Int) {
        var aux = [Int]()
        if let savedContent = defaults.array(forKey: keyName) as? [Int] {
            aux = savedContent
        }
        aux.append(newElement)
        save(items: aux)
    }
    
    func remove(an element: Int) {
        guard let savedContent = load() else { return }
        var aux = [Int]()
        aux = savedContent.filter { $0 != element}
        save(items: aux)
    }
    
    func hasSome(element: Int) -> Bool {
        guard let savedContent = load() else { return false }
        return savedContent.contains(element)
    }
}
