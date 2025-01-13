//
//  MovieDetailsView.swift
//  globoplay
//
//  Created by Luan Cabral on 11/01/25.
//

import UIKit

protocol MovieDetailsViewProtocol: AnyObject {
    func favoriteButtonTapped(movie: MovieModel)
    func backButtonTapped()
}

final class MovieDetailsView: UIView {
    var movie: MovieModel?
    
    weak var delegate: MovieDetailsViewProtocol?
    
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back")?.withTintColor(.white), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollView: UIScrollView = {
        var view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = true
        view.showsHorizontalScrollIndicator = false
        view.bounces = false
        return view
    }()
    
    private let backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "penguin")
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()
    
    private let blurEffectView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .light)
        let view =  UIVisualEffectView(effect: blur)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let movieImageView: UIImageView = {
        let movieImageView = UIImageView()
        movieImageView.contentMode = .scaleAspectFit
        movieImageView.image = UIImage(named: "penguin")
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        return movieImageView
    }()
    
    private let watchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        button.tintColor = .primary
        button.setTitle("Assista", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        //        button.addTarget(self, action: #selector(watchButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.primary.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 37, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 27, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Ação"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let buttonStackView: UIStackView = {
        var stack = UIStackView()
        stack.spacing = 10
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let informationView: UIView = {
        let view = UIView()
        view.backgroundColor = .primary
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .primary
    }
    
    func setup(_ movie: MovieModel, _ posterImage: UIImage?) {
        self.movie = movie
        backgroundImageView.image = posterImage
        movieImageView.image = posterImage
        titleLabel.text = movie.title
        detailsLabel.text = movie.overview
        updateButtonImage()
        setupView()
        setupDetails(movie: movie)
    }
    
    func setupDetails(movie: MovieModel) {
        let finalText =
            """
            Título Original: \(movie.title)
            Nota: \(movie.voteAverage)
            Idioma: \(movie.originalLanguage.uppercased())
            """
        
        informationLabel.text = finalText
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    @objc
    func favoriteButtonTapped() {
        guard let movie else { return }
        delegate?.favoriteButtonTapped(movie: movie)
        updateButtonImage()
    }
    
    @objc
    func backButtonTapped() {
        delegate?.backButtonTapped()
    }
    
    private func updateButtonImage() {
        guard let movie else { return }
        let title = movie.isFavorite ? "Adicionado" : "Minha Lista"
        favoriteButton.setTitle(title, for: .normal)
        let icon = movie.isFavorite ? "check" : "star"
        favoriteButton.setImage(UIImage(named: icon)?.withTintColor(.white), for: .normal)
    }
}

extension MovieDetailsView: ViewCode {
    func buildHierarchy() {
        addSubview(scrollView)
        
        addSubview(topView)
        containerView.addSubview(backgroundImageView)
        topView.addSubview(backButton)
        containerView.addSubview(blurEffectView)
        containerView.addSubview(movieImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(genderLabel)
        containerView.addSubview(detailsLabel)
        containerView.addSubview(buttonStackView)
        
        
        scrollView.addSubview(containerView)
        scrollView.addSubview(informationView)
        
        informationView.addSubview(informationLabel)
        
        buttonStackView.addArrangedSubview(watchButton)
        buttonStackView.addArrangedSubview(favoriteButton)
        
        
    }
    
    func buildConstratins() {
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: topAnchor),
            topView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 110),
            
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 6),
            
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -10),
            backgroundImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            blurEffectView.topAnchor.constraint(equalTo: topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 10),
            
            movieImageView.widthAnchor.constraint(equalToConstant: 180),
            movieImageView.heightAnchor.constraint(equalToConstant: 300),
            movieImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50),
            movieImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            genderLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            genderLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            genderLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            detailsLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 24),
            detailsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            detailsLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            watchButton.heightAnchor.constraint(equalToConstant: 50),
            favoriteButton.heightAnchor.constraint(equalToConstant: 50),
            
            buttonStackView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 20),
            buttonStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            buttonStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            buttonStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24),
            
            informationView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 24),
            informationView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            informationView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            informationView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            informationView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            informationLabel.topAnchor.constraint(equalTo: informationView.topAnchor, constant: 10),
            informationLabel.leadingAnchor.constraint(equalTo: informationView.leadingAnchor, constant: 24),
            informationLabel.trailingAnchor.constraint(equalTo: informationView.trailingAnchor, constant: -24),
            informationLabel.bottomAnchor.constraint(equalTo: informationView.bottomAnchor, constant: -24)
        ])
    }
}
