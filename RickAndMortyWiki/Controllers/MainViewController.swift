//
//  ViewController.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 02/11/22.
//

import UIKit
import Combine

class MainViewController: UIViewController {
//    private var viewModel = MainViewViewModel()
    public var allCharacters: [CharacterResults] = [CharacterResults]()
    public var allEpisodes: [EpisodeResults] = [EpisodeResults]()
    
    lazy var mainView: MainView = {
        let main = MainView()
        main.collectionView.delegate = self
        main.collectionView.dataSource = self
        return main
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome"
        view.backgroundColor = .red
    }
    
    override func loadView() {
        self.view = mainView
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterInfoCollectionViewCell.identifier, for: indexPath) as! CharacterInfoCollectionViewCell
        
        Service.getAllCharacters { result in
            switch result {
            case .success(let characters):
                Service.getCharacterDetails(id: characters.results[0].id) { result in
                    switch result {
                    case .success(let characterDetails):
                        Service.getEpisodesDetails(url: characterDetails[indexPath.row].episode[0]) { result in
                            switch result {
                            case .success(let episodeDetails):
                                DispatchQueue.main.async {
                                    self.allCharacters = characters.results
                                    self.allEpisodes = [episodeDetails]
                                    cell.configure(with: self.allCharacters[indexPath.row], epName: self.allEpisodes[0].name)
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
        
        cell.backgroundColor = .black
        cell.layer.borderColor = UIColor.green.cgColor
        cell.layer.borderWidth = 5
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width - 10, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

