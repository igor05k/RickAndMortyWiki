//
//  CharacterCollectionViewTableViewCell.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 04/11/22.
//

import UIKit

class CharacterCollectionViewTableViewCell: UITableViewCell {
    static let identifier = String(describing: CharacterCollectionViewTableViewCell.self)
    private var characterSelected: [AllCharacterResults] = [AllCharacterResults]()
    private var episodeResults: EpisodeResults?
    
    private var cellViewModel: CharacterCollectionViewTableViewCellViewModel?
    
    lazy var collectionView: UICollectionView = {
        // flow layout
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        
        // create collection
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .darkGray
        collection.register(CharacterInfoCollectionViewCell.self, forCellWithReuseIdentifier: CharacterInfoCollectionViewCell.identifier)
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionViewConstraints() {
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    func configure(with model: AllCharacterResults, episodeName: EpisodeResults) {
        cellViewModel = CharacterCollectionViewTableViewCellViewModel(allCharacters: model, episodeResults: episodeName)
        
        if let cellViewModel {
            self.characterSelected = cellViewModel.getAllCharactersModel
            self.episodeResults = cellViewModel.getAllEpisodesResultsModel
        }
    }
}

extension CharacterCollectionViewTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterInfoCollectionViewCell.identifier, for: indexPath) as! CharacterInfoCollectionViewCell
        if let episodeResults {
            cell.configure(characterInfo: characterSelected[0], epName: episodeResults)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.contentView.bounds.width - 10, height: 200)
    }
}
