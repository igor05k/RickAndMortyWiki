//
//  ViewController.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 02/11/22.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    private var allCharacters: [AllCharacterResults] = [AllCharacterResults]()
    private var allEpisodes: [EpisodeResults] = [EpisodeResults]()
    
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
        
        viewModel.fetchAllCharacters { characterArray in
            self.allCharacters = characterArray
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        return 1
//        return allCharacters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterInfoCollectionViewCell.identifier, for: indexPath) as! CharacterInfoCollectionViewCell
        
        viewModel.fetchAllCharacters { characterArray in
            DispatchQueue.main.async {
                cell.configure(with: characterArray[indexPath.row], epName: EpisodeResults(id: 1, name: "", airDate: "", episode: "", characters: [""], url: "", created: ""))
            }
        }
        
//        Service.getAllCharacters { [weak self] result in
//            switch result {
//            case .success(let characters):
//                Service.getCharacterBy(id: characters.results[0].id) { result in
//                    switch result {
//                    case .success(let characterDetails):
//                        Service.getEpisodesDetails(url: characterDetails[indexPath.row].episode[0]) { result in
//                            switch result {
//                            case .success(let episodeDetails):
//                                guard let self = self else { return }
//                                DispatchQueue.main.async {
//                                    self.allCharacters = characters.results
//                                    self.allEpisodes = [episodeDetails]
//                                    cell.configure(with: self.allCharacters[indexPath.row],
//                                                   epName: self.allEpisodes[0])
//                                }
//                            case .failure(let failure):
//                                print(failure)
//                            }
//                        }
//                    case .failure(let failure):
//                        print(failure)
//                    }
//                }
//            case .failure(let failure):
//                print(failure)
//            }
//        }
        
        cell.layer.cornerRadius = 15
        cell.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width - 10, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.fetchAllCharacters { characterArray in
            self.viewModel.fetchCharactersById(id: characterArray[indexPath.row].id) { result in
                switch result {
                case .success(let success):
                    print(success)
                case .failure(let failure):
                    print(failure)
                }
            }
//            DispatchQueue.main.async {
//                cell.configure(with: characterArray[indexPath.row], epName: EpisodeResults(id: 1, name: "", airDate: "", episode: "", characters: [""], url: "", created: ""))
//            }
        }
//        let character = allCharacters[indexPath.row]
//        print(character.id)
//        Service.getCharacterBy(id: character.id) { result in
//            switch result {
//            case .success(let character):
//                // MARK: Get origin/location details
//                // if origin is not empty, use origin url; otherwise use location url
//                if let origin = character[indexPath.row].origin?.url,
//                   let location = character[indexPath.row].location?.url {
//                    Service.getLocationBy(url: !origin.isEmpty ? origin : location) { result in
//                        switch result {
//                        case .success(let location):
//                            // MARK: Get Episode Details
//                            Service.getEpisodesDetails(url: character[indexPath.row].episode[0]) { result in
//                                switch result {
//                                case .success(let episodeDetails):
//                                    DispatchQueue.main.async { [weak self] in
//                                        let detailvc = DetailsViewController()
//                                        detailvc.configureEpisodeDetails(with: episodeDetails)
//                                        detailvc.configure(with: character[indexPath.row])
//                                        detailvc.configureLocations(with: location)
//
//                                        self?.navigationController?.pushViewController(detailvc, animated: true)
//                                    }
//                                case .failure(let failure):
//                                    print(failure)
//                                }
//                            }
//                        case .failure(let failure):
//                            print(failure)
//                        }
//                    }
//                }
//            case .failure(let failure):
//                print(failure)
//            }
//        }
    }
}

