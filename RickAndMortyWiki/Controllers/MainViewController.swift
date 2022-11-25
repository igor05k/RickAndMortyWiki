//
//  ViewController.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 02/11/22.
//

import UIKit

class MainViewController: UIViewController {
    private var viewModel: MainViewViewModel
    
    lazy var mainView: MainView = {
        let main = MainView()
        main.collectionView.delegate = self
        main.collectionView.dataSource = self
        return main
    }()
    
    init(viewModel: MainViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setActivityIndicator()
        setRefreshControl()
        setSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Welcome"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = ""
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    func setSearchBar() {
        navigationItem.searchController = mainView.searchController
    }
    
    func setRefreshControl() {
        mainView.collectionView.refreshControl = mainView.refreshControl
        mainView.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func setActivityIndicator() {
        self.view.addSubview(mainView.activityIndicator)
        
        NSLayoutConstraint.activate([
            mainView.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            mainView.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
    
    @objc func refresh() {
        mainView.collectionView.refreshControl?.beginRefreshing()
        
        mainView.collectionView.isHidden = true
        mainView.activityIndicator.startAnimating()
        
        viewModel.fetchAllCharacters()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.mainView.collectionView.reloadData()
            self?.mainView.activityIndicator.stopAnimating()
            self?.mainView.collectionView.refreshControl?.endRefreshing()
            self?.mainView.collectionView.isHidden = false

        }
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.allCharacters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterInfoCollectionViewCell.identifier, for: indexPath) as! CharacterInfoCollectionViewCell
        
        DispatchQueue.main.async { [weak self] in
            if let self {
                cell.configure(characterInfo: self.viewModel.allCharacters[indexPath.row],
                               epName: self.viewModel.firstSeenEpisode[indexPath.row])
            }
        }
        
        cell.layer.cornerRadius = 15
        cell.clipsToBounds = true
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width - 10, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = viewModel.allCharacters[indexPath.row]
        let firstSeenEpisode = viewModel.firstSeenEpisode[indexPath.row]
        
        // first we need to check by name if the origin for the current character does exists
        // in the character array of locations. if so, take the first index where this occurs
        // and return a new object
        guard let location = viewModel.filterLocationDetails(character: character) else { return }
        print(location)
        
        let viewModel = DetailsViewModel(characters: character, location: location, firstSeenEpisode: firstSeenEpisode)
        let detailsViewController = DetailsViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
