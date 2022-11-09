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
        
        cell.configure(characterInfo: self.viewModel.allCharacters[indexPath.row], epName: EpisodeResults(id: 1, name: "", airDate: "", episode: "", characters: [""], url: "", created: ""))
        
        
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
        
        let item = viewModel.allCharacters[indexPath.row]
        print(item)
        
        
//        print(allCharacters.count)
//        print(self.viewModel.getCharactersModel?.results.count)
//        let detailsViewController = DetailsViewController(item: item)
//        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

