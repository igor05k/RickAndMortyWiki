//
//  ViewController.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 02/11/22.
//

import UIKit

class MainViewController: UIViewController {
    private var allCharacters: [CharacterResults] = [CharacterResults]()
    private var allEpisodes: [EpisodeResults] = [EpisodeResults]()
    
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
//        Service.getAllCharacters { [weak self] result in
//            switch result {
//            case .success(let success):
//                self?.allCharacters = success.results
//                print(self?.allCharacters)
//            case .failure(let failure):
//                print(failure)
//            }
//        }
        
        Service.getFirstCharacterEpisode { result in
            switch result {
            case .success(let success):
                Service.getEpisodesDetails(url: success[0]) { result in
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
        
//        Service.getEpisodesDetails(url: "https://rickandmortyapi.com/api/episode/51") { _ in
//
//        }
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
        DispatchQueue.main.async {
//            cell.configure(with: self.allCharacters[indexPath.row])
//            cell.configure(with: allCharacters[indexPath.row])
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

