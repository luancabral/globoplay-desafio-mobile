//
//  FavoriteMoviesViewController.swift
//  globoplay
//
//  Created by Luan Cabral on 13/01/25.
//

import Foundation
import UIKit

final class FavoriteMoviesViewController: BaseViewController {
    let viewModel: FavoriteMoviesViewModel
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (view.frame.size.width/3)-3, height: 170)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register( FavoriteMoviesCollectionViewCell.self, forCellWithReuseIdentifier:  FavoriteMoviesCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .primary
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(viewModel: FavoriteMoviesViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        setupView()
        setupNavigationControllerImage()
        viewModel.viewDelegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadFavoriteMovies()
    }
    
    override func beginAppearanceTransition(_ isAppearing: Bool, animated: Bool) {
        super.beginAppearanceTransition(isAppearing, animated: animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupNavigationControllerImage() {
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 50))
        let label = UILabel(frame: CGRect(x: -110, y: 0, width: 150, height: 50))
        label.text = "Minha lista"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        logoContainer.addSubview(label)
        self.navigationItem.titleView = logoContainer
    }
}

extension FavoriteMoviesViewController: ViewCode {
    func buildHierarchy() {
        view.addSubview(collectionView)
    }
    
    func buildConstratins() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


extension FavoriteMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.favoritesMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteMoviesCollectionViewCell.identifier,
                                                            for: indexPath) as?  FavoriteMoviesCollectionViewCell else { return .init() }
        cell.setup(delegate: self,
                   movie: viewModel.favoritesMovies[safe: indexPath.row],
                   imageSize: CGSize(width: (collectionView.frame.size.width/3)-3, height: 170))
        return cell
    }
}


extension FavoriteMoviesViewController: FavoriteMoviesCollectionViewCellProtocol {
    func movieClicked(movie: MovieModel, posterImage: UIImage?) {
        let movieDetailsViewController = MovieDetailsBuilder().build(movie: movie, posterImage: posterImage)
        navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}

extension FavoriteMoviesViewController: FavoriteMoviesViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
