//
//  MainView.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 02/11/22.
//

import UIKit

class MainView: UIView {
    
    // MARK: Create visual elements
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
    
    // MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupElements() {
        collectionViewConstraints()
    }
}

