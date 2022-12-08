//
//  SearchResultsViewController.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 25/11/22.
//

import UIKit

protocol SearchDelegate: AnyObject {
    func didTapCharacter(character: CharacterResults, firstSeenEpisode: EpisodeResults, location: LocationDetails)
}

class SearchResultsViewController: UIViewController {
    private var viewModel: SearchResultsViewModel
    
    weak var delegate: SearchDelegate?
    
    init(viewModel: SearchResultsViewModel = SearchResultsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView = {
        // flow layout
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        
        // create collection
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CharacterInfoCollectionViewCell.self, forCellWithReuseIdentifier: CharacterInfoCollectionViewCell.identifier)
        collection.register(EmptyCollectionViewCell.self, forCellWithReuseIdentifier: EmptyCollectionViewCell.identifier)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        setCollectionConstraints()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func setCollectionConstraints() {
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -5)
        ])
    }
    
    public func configure(characters: [CharacterResults], firstSeenEpisode: [EpisodeResults], location: [LocationDetails]) {
        self.viewModel.charactersSearched = characters
        self.viewModel.firstSeenEpisodeSearched = firstSeenEpisode
        self.viewModel.characterLocationSearched = location
    }
}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.charactersSearched.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterInfoCollectionViewCell.identifier, for: indexPath) as? CharacterInfoCollectionViewCell else { return UICollectionViewCell() }
        
        if !viewModel.charactersSearched.isEmpty && !viewModel.firstSeenEpisodeSearched.isEmpty {
            DispatchQueue.main.async { [weak self] in
                if let self {
                    cell.configure(characterInfo: self.viewModel.charactersSearched[indexPath.row], epName: self.viewModel.firstSeenEpisodeSearched[indexPath.row])
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width - 10, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let character = viewModel.charactersSearched[indexPath.row]
        let firstSeenEpisode = viewModel.firstSeenEpisodeSearched[indexPath.row]
        
        // first we need to check by name if the location for the current character does exists
        // in the character array of locations. if so, take the first index where this occurs
        // and return a new object
        guard let location = viewModel.filterLocationDetails(character: character) else { return }
        
        delegate?.didTapCharacter(character: character, firstSeenEpisode: firstSeenEpisode, location: location)
        
//        let viewModel = DetailsViewModel(characters: character, location: location, firstSeenEpisode: firstSeenEpisode)
//        let detailsViewController = DetailsViewController(viewModel: viewModel)
//        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
