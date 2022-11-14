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
        setupBinders()
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
    
    func setupBinders() {
//        viewModel.allResidentsFromCertainOrigin2 = { origin in
//            self.residents = origin
//        }
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
                               epName: self.viewModel.episodeResults[indexPath.row])
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
        let firstSeenEpisode = viewModel.episodeResults[indexPath.row]
        
        // first we need to check by name if the origin for the current character does exists
        // in the character array of locations. if so, take the first index where this occurs
        // and return a new object
        guard let location = viewModel.filterLocationDetails(character: character) else { return }

        if viewModel.residentsArray.isEmpty {
            viewModel.fetchResidents(locationFiltered: location)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let residents = self.viewModel.residentsArray
                print(residents)
                let detailsViewController = DetailsViewController(character: character, firstSeenEpisode: firstSeenEpisode, location: location, residents: residents)
                self.navigationController?.pushViewController(detailsViewController, animated: true)
            }
        } else {
            viewModel.residentsArray.removeAll()
            viewModel.fetchResidents(locationFiltered: location)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let residents = self.viewModel.residentsArray
//                print(residents)
                let detailsViewController = DetailsViewController(character: character, firstSeenEpisode: firstSeenEpisode, location:
                                                                    location, residents: residents)
                self.navigationController?.pushViewController(detailsViewController, animated: true)
            }
        }
    }
}

