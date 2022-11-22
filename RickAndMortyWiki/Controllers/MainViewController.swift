//
//  ViewController.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 02/11/22.
//

import UIKit

class MainViewController: UIViewController {
    private var viewModel: MainViewViewModel
    
    lazy var refreshControl: UIRefreshControl = UIRefreshControl()
    lazy var activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    lazy var mainView: MainView = {
        let main = MainView()
        main.collectionView.delegate = self
        main.collectionView.dataSource = self
        return main
    }()
    
    init(viewModel: MainViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setActivityIndicator()
        setRefreshControl()
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
    
    func setRefreshControl() {
        mainView.collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func setActivityIndicator() {
        self.view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
    
    @objc func refresh() {
        mainView.collectionView.refreshControl?.beginRefreshing()
        // remove all items in order to populate it again
        viewModel.allCharacters.removeAll()
        viewModel.firstSeenEpisode.removeAll()
        viewModel.characterLocationDetails.removeAll()
        
        viewModel.fetchAllCharacters()
        viewModel.fetchLocationDetails()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.mainView.collectionView.reloadData()
            self?.mainView.collectionView.refreshControl?.endRefreshing()
        }
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel.firstSeenEpisode.count < 3 ||
//        viewModel.allCharacters.count < 3 ||
//        viewModel.characterLocationDetails.count < 3 ? 1 : viewModel.allCharacters.count
        return viewModel.allCharacters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if !viewModel.firstSeenEpisode.isEmpty {
//            DispatchQueue.main.async { [weak self] in
//                print("CELLFORROWAT======\(String(describing: self?.viewModel.allCharacters.count))")
//                print("CELLFORROWAT======\(String(describing: self?.viewModel.allCharacters.isEmpty))")
//                print("CELLFORROWAT======\(String(describing: self?.viewModel.characterLocationDetails.count))")
//                print("CELLFORROWAT======\(String(describing: self?.viewModel.firstSeenEpisode.count))")
//            }
//        }
        
//        if viewModel.firstSeenEpisode.count < 3 || viewModel.allCharacters.count < 3 || viewModel.characterLocationDetails.count < 3 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyCollectionViewCell.identifier, for: indexPath) as! EmptyCollectionViewCell
//            cell.delegate = self
//            return cell
//        }
        
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
        return viewModel.allCharacters.isEmpty
        ? CGSize(width: collectionView.frame.width - 20, height: collectionView.frame.height - 100)
        : CGSize(width: self.view.bounds.width - 10, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = viewModel.allCharacters[indexPath.row]
        let firstSeenEpisode = viewModel.firstSeenEpisode[indexPath.row]
        print(character)
        
        // first we need to check by name if the origin for the current character does exists
        // in the character array of locations. if so, take the first index where this occurs
        // and return a new object
        guard let location = viewModel.filterLocationDetails(character: character) else { return }
        
        let viewModel = DetailsViewModel(characters: character, location: location, firstSeenEpisode: firstSeenEpisode)
        let detailsViewController = DetailsViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

extension MainViewController: RetryDelegate {
    func didTapRetry() {
        mainView.collectionView.reloadData()
    }
}

extension MainViewController: MainViewDelegate {
    func showLoading() {
        print("SHOW LOADING...")
        DispatchQueue.main.async { [weak self] in
            if let self {
                while self.viewModel.allCharacters.count < 3 ||
                        self.viewModel.characterLocationDetails.count < 3 ||
                        self.viewModel.firstSeenEpisode.count < 3 {
                    self.activityIndicator.startAnimating()
                }
            }
        }
    }
    
    func stopLoading() {
        print("STOP LOADING...")
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
}
