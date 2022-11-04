//
//  CharacterCollectionViewTableViewCell.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 04/11/22.
//

import UIKit

class CharacterCollectionViewTableViewCell: UITableViewCell {
    static let identifier = String(describing: CharacterCollectionViewTableViewCell.self)
    
    lazy var collectionView: UICollectionView = {
        // flow layout
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        
        // create collection
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .systemCyan
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
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
}
