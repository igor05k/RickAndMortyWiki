//
//  ViewController.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 02/11/22.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    public var allCharacters: [CharacterResults] = [CharacterResults]()
    public var allEpisodes: [EpisodeResults] = [EpisodeResults]()
    
    lazy var mainView: MainView = {
        let main = MainView()
        main.collectionView.delegate = self
        main.collectionView.dataSource = self
        return main
    }()
    
    // MARK: Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Service.getCharacterBy(id: 1) { result in
            switch result {
            case .success(let success):
                Service.getLocationBy(url: success[0].origin!.url) { result in
                    switch result {
                    case .success(let success):
                        print(success)
                    case .failure(let failure):
                        print(failure)
                    }
                }
            case .failure(let failure):
                print(failure)
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
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterInfoCollectionViewCell.identifier, for: indexPath) as! CharacterInfoCollectionViewCell
        
        Service.getAllCharacters { [weak self] result in
            switch result {
            case .success(let characters):
                Service.getCharacterBy(id: characters.results[0].id) { result in
                    switch result {
                    case .success(let characterDetails):
                        Service.getEpisodesDetails(url: characterDetails[indexPath.row].episode[0]) { result in
                            switch result {
                            case .success(let episodeDetails):
                                guard let self = self else { return }
                                DispatchQueue.main.async {
                                    self.allCharacters = characters.results
                                    self.allEpisodes = [episodeDetails]
                                    cell.configure(with: self.allCharacters[indexPath.row],
                                                   epName: self.allEpisodes[0].name)
                                }
                            case .failure(let failure):
                                print(failure)
                            }
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
        let character = allCharacters[indexPath.row]
        Service.getCharacterBy(id: character.id) { result in
            switch result {
            case .success(let success):
                let detailvc = DetailsViewController()
                self.navigationController?.pushViewController(detailvc, animated: true)
                detailvc.configure(with: success[indexPath.row])
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

