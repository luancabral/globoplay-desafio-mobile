//
//  MovieCollectionViewCell.swift
//  globoplay
//
//  Created by Luan Cabral on 10/01/25.
//

import UIKit
import SDWebImage

protocol MovieCollectionViewCellProtocol: AnyObject {
    func movieClicked(movie: MovieModel, posterImage: UIImage?)
}

final class MovieCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieCollectionViewCell"
    var movie: MovieModel?
    
    weak var delegate: MovieCollectionViewCellProtocol?
    var imageSize = CGSize(width: 180, height: 300)
    
    private lazy var movieImageView: UIImageView = {
        let movieImageView = UIImageView()
        movieImageView.contentMode = .scaleAspectFit
        movieImageView.isUserInteractionEnabled = true
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        return movieImageView
    }()
    
    override func prepareForReuse() {
        movieImageView.image = nil
    }
    
    func setup(delegate: MovieCollectionViewCellProtocol?,
               movie: MovieModel?,
               imageSize: CGSize = CGSize(width: 180, height: 300)) {
        guard let movie else { return }
        self.imageSize = imageSize
        self.movie = movie
        setupView()
        setupMovieTap()
        self.delegate = delegate
        movieImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w300/\(movie.posterPath)"))
    }
    
    private func setupMovieTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        movieImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func handleTap() {
        guard let movie else { return }
        delegate?.movieClicked(movie: movie, posterImage: movieImageView.image)
    }
}

extension MovieCollectionViewCell: ViewCode {
    func buildHierarchy() {
        contentView.addSubview(movieImageView)
    }
    
    func buildConstratins() {
        NSLayoutConstraint.activate([
            movieImageView.widthAnchor.constraint(equalToConstant: imageSize.width),
            movieImageView.heightAnchor.constraint(equalToConstant: imageSize.height),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24)
//            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
        ])
    }
}
