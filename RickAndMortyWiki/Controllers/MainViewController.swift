//
//  ViewController.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 02/11/22.
//

import UIKit
//import Combine

class MainViewController: UIViewController {
    private var viewModel: MainViewViewModel
//    private var anyCancellables: Set<AnyCancellable> = []
    
//    var episodeResults: EpisodeResults? {
//        didSet {
//            mainView.collectionView.reloadData()
//        }
//    }
    
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
        return viewModel.allCharacters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterInfoCollectionViewCell.identifier, for: indexPath) as! CharacterInfoCollectionViewCell
        
        viewModel.fetchEpDetails(index: indexPath.row)
        
        DispatchQueue.main.async {
            self.viewModel.firstSeenEpisode = { episodeResults in
                cell.configure(characterInfo: self.viewModel.allCharacters[indexPath.row],
                               epName: episodeResults)
            }
        }
        
//            DispatchQueue.main.async {
//                print(self.viewModel.firstSeenEpisode)
//                viewModel.$firstSeenEpisode.sink { episodeResultsObject in
//                    print(episodeResultsObject)
//                }.store(in: &anyCancellables)
//            }
        
        
        
//        DispatchQueue.main.async {
//            print(self.viewModel.firstSeenEpisode)
//            if let episodes = self.viewModel.firstSeenEpisode {
//                cell.configure(characterInfo: self.viewModel.allCharacters[indexPath.row],
//                               epName: episodes)
//            }
//        }
        
        
//        if let episodes = viewModel.firstSeenEpisode {
//            cell.configure(characterInfo: viewModel.allCharacters[indexPath.row],
//                           epName: episodes)
//        }
        
                    
//        DispatchQueue.main.async {
//            print(self.viewModel.firstSeenEpisode)
//        }

//        let service = Service()
//        service.getEpisodesDetails(url: viewModel.allCharacters[indexPath.row].episode[0]) { result in
//            switch result {
//            case .success(let success):
//                print(success)
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//        DispatchQueue.main.async {
//            print(self.viewModel.firstSeenEpisode)
//            cell.configure(characterInfo: self.viewModel.allCharacters[indexPath.row], epName: self.viewModel.firstSeenEpisode[indexPath.row])
//        }
        
        
        
//        viewModel.fetchEpDetails(index: indexPath.row)
//        DispatchQueue.main.async {
//            cell.configure(characterInfo: self.viewModel.allCharacters[indexPath.row], epName: self.viewModel.firstSeenEpisode[0])
//            print("INDEX PATH====\(indexPath.row) OBJECT/CHARACTER=====\(self.viewModel.firstSeenEpisode)")
//        }
        
//        viewModel.fetchEpDetails(indexPath: indexPath) {
//            cell.configure(characterInfo: self.viewModel.allCharacters[indexPath.row], epName: EpisodeResults(id: 1, name: "", airDate: "", episode: "", characters: [""], url: "", created: ""))
//            self.mainView.collectionView.reloadData()
//        }
//            self.viewModel.fetchEpDetails(indexPath: indexPath)=
            
//            cell.configure(characterInfo: self.viewModel.allCharacters[indexPath.row], epName: self.viewModel.firstSeenEpisode[indexPath.row])
//            self.mainView.collectionView.reloadData()
        
        
//        cell.configure(characterInfo: self.viewModel.allCharacters[indexPath.row], epName: EpisodeResults(id: 1, name: "", airDate: "", episode: "", characters: [""], url: "", created: ""))
        
        
        // in order to populate the cells right, we need not only charater info but
        // the episode info aswell, so to do this, another api call is needed.
        // first we fetch data to get character info (that's where episode details at)
        // then another request is make to obtain the episode's name.
//        viewModel.fetchAllCharacters { results in
//            switch results {
//            case .success(let characterResults):
//                self.viewModel.fetchEpisodeDetails(indexPath: indexPath) { result in
//                    switch result {
//                    case .success(let episodeDetails):
//                        DispatchQueue.main.async {
//                            self.allCharacters = characterResults
//                            self.allEpisodes = [episodeDetails]
//                            cell.configure(characterInfo: self.allCharacters[indexPath.row],
//                                           epName: self.allEpisodes[0])
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
        
//        let item = viewModel.allCharacters[indexPath.row]
//        print(item)
//        let item = viewModel.firstSeenEpisode
//        print(item)
        
        
//        print(allCharacters.count)
//        print(self.viewModel.getCharactersModel?.results.count)
//        let detailsViewController = DetailsViewController(item: item)
//        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

