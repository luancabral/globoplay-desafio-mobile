//
//  TypeNameHeaderView.swift
//  globoplay
//
//  Created by Luan Cabral on 10/01/25.
//

import UIKit

final class TypeNameHeaderView: UIView {
    // MARK: - UI Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Novelas"
        label.font = .boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .primary
        setupView()
    }
    
    func setup(_ title: String) {
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
       return nil
    }
}

// MARK: - ViewCode
extension TypeNameHeaderView: ViewCode {
    func buildHierarchy() {
        addSubview(titleLabel)
    }
    
    func buildConstratins() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
}
