//
//  ViewController.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 02/11/22.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    private var viewModel: MainViewViewModel
    var cancellables: Set<AnyCancellable> = []
    
    var residents: AllCharacterResults?
    
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
        
        DispatchQueue.main.async { [weak self] in
            print("VIEWDIDLOAD======\(self?.viewModel.allCharacters.count)")
            print("VIEWDIDLOAD======\(self?.viewModel.allCharacters.isEmpty)")
            print("VIEWDIDLOAD======\(self?.viewModel.characterLocationDetails.count)")
            print("VIEWDIDLOAD======\(self?.viewModel.firstSeenEpisode.count)")
        }
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
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.firstSeenEpisode.count < 3 ||
        viewModel.allCharacters.count < 3 ||
        viewModel.characterLocationDetails.count < 3 ? 1 : viewModel.allCharacters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if !viewModel.firstSeenEpisode.isEmpty {
            DispatchQueue.main.async { [weak self] in
                print("CELLFORROWAT======\(String(describing: self?.viewModel.allCharacters.count))")
                print("CELLFORROWAT======\(String(describing: self?.viewModel.allCharacters.isEmpty))")
                print("CELLFORROWAT======\(String(describing: self?.viewModel.characterLocationDetails.count))")
                print("CELLFORROWAT======\(String(describing: self?.viewModel.firstSeenEpisode.count))")
            }
        }
        
        if viewModel.firstSeenEpisode.count < 3 || viewModel.allCharacters.count < 3 || viewModel.characterLocationDetails.count < 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyCollectionViewCell.identifier, for: indexPath) as! EmptyCollectionViewCell
            cell.delegate = self
            return cell
        }
        
        viewModel.$arrayOfCharacters.sink { characters in
            print("COMBINE/CELLFORROWAT=======\(characters.count)")
        }.store(in: &cancellables)
        
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
//        let firstSeenEpisode = viewModel.episodeResults[indexPath.row]
        print(character)
        
        // first we need to check by name if the origin for the current character does exists
        // in the character array of locations. if so, take the first index where this occurs
        // and return a new object
//        guard let location = viewModel.filterLocationDetails(character: character) else { return }
        
//        let viewModel = DetailsViewModel(characters: character, location: location, firstSeenEpisode: firstSeenEpisode)
//        let detailsViewController = DetailsViewController(viewModel: viewModel)
//        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

extension MainViewController: RetryDelegate {
    func didTapRetry() {
        mainView.collectionView.reloadData()
    }
}
