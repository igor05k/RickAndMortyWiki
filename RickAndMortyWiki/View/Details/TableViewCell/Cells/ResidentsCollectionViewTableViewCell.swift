//
//  ResidentsCollectionViewTableViewCell.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 04/11/22.
//

import UIKit

class ResidentsCollectionViewTableViewCell: UITableViewCell {
    static let identifier = String(describing: ResidentsCollectionViewTableViewCell.self)
    private var residents: [AllCharacterResults] = [AllCharacterResults]()
    
    lazy var collectionView: UICollectionView = {
        // flow layout
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 190)
        
        // create collection
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(ResidentsCollectionViewCell.self, forCellWithReuseIdentifier: ResidentsCollectionViewCell.identifier)
        return collection
    }()
    
    // MARK: Configure
    func configure(with residents: [AllCharacterResults]) {
        self.residents = residents
    }
    
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
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
}

extension ResidentsCollectionViewTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResidentsCollectionViewCell.identifier, for: indexPath) as! ResidentsCollectionViewCell
        cell.configure(with: residents[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return residents.count
    }
}
