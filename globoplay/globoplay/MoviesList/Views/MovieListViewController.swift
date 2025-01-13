//
//  MovieListViewController.swift
//  globoplay
//
//  Created by Luan Cabral on 10/01/25.
//

import UIKit

class MovieListViewController: BaseViewController {
    private let viewModel: MovieListViewModel
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.sectionFooterHeight = 0
        tableView.separatorStyle = .none
        tableView.backgroundColor = .primary
        tableView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationControllerImage()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        setupDelegates()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchData()
    }
    
    override func beginAppearanceTransition(_ isAppearing: Bool, animated: Bool) {
        super.beginAppearanceTransition(isAppearing, animated: animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.viewDelegate = self
    }
    
    private func fetchData() {
        viewModel.fetchTopRatedMovies()
        viewModel.fetchNowPlayingMovies()
        viewModel.fetchWeekTrendingMovies()
    }
    
    func setupNavigationControllerImage() {
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 50))
        let logo = UIImage(named: "globoplayLogo")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 50))//UIImageView(image: logo)
        imageView.image = logo
        imageView.contentMode = .scaleAspectFit
        logoContainer.addSubview(imageView)
        self.navigationItem.titleView = logoContainer
    }
}

// MARK: - ViewCode
extension MovieListViewController: ViewCode {
    func buildHierarchy() {
        self.view.addSubview(tableView)
    }
    
    func buildConstratins() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier,
                                                       for: indexPath) as? MovieTableViewCell,
              let section = viewModel.sections[safe: indexPath.section],
              case let .category(_, content) = section else { return .init() }
        cell.setup(movies: content, collectionViewDelegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = viewModel.sections[safe: section],
              case let .category(title, _) = section else { return nil }
        let sectionTitle = TypeNameHeaderView()
        sectionTitle.setup(title)
        return sectionTitle
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

// MARK: - MovieCollectionViewCellProtocol
extension MovieListViewController: MovieCollectionViewCellProtocol {
    func movieClicked(movie: MovieModel, posterImage: UIImage?) {
        let movieDetailsViewController = MovieDetailsBuilder().build(movie: movie, posterImage: posterImage)
        navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
}

extension MovieListViewController: MovieListViewModelViewDelegate {
    func reloadData() {
        tableView.reloadData()
    }
}
