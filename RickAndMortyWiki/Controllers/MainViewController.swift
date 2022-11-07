//
//  ViewController.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 02/11/22.
//

import UIKit

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
    
    private var service: Service
    
    init(viewModel: MainViewViewModel, service: Service = Service()) {
        self.viewModel = viewModel
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData() {
        viewModel.fetchAllCharacters { _ in
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
        return viewModel.getCharactersModel?.results.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterInfoCollectionViewCell.identifier, for: indexPath) as! CharacterInfoCollectionViewCell
        
        viewModel.fetchAllCharacters { results in
            switch results {
            case .success(let characterResults):
                self.viewModel.fetchEpisodeDetails(indexPath: indexPath) { result in
                    switch result {
                    case .success(let episodeDetails):
                        DispatchQueue.main.async {
                            self.allCharacters = characterResults
                            self.allEpisodes = [episodeDetails]
                            cell.configure(characterInfo: self.allCharacters[indexPath.row],
                                           epName: self.allEpisodes[0])
                        }
                    case .failure(let failure):
                        print(failure)
                    }
                }
                
            case .failure(let failure):
                print(failure)
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
//        print(viewModel.getCharactersModel?.results.count)
//        viewModel.fetchAllCharacters { characterArray in
//            self.viewModel.fetchCharactersById(id: characterArray[indexPath.row].id) { result in
//                switch result {
//                case .success(let success):
//                    print(success)
//                case .failure(let failure):
//                    print(failure)
//                }
//            }
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
//}

