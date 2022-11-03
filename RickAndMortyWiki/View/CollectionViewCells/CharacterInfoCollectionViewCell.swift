//
//  CharacterInfoCollectionViewCell.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 02/11/22.
//

import UIKit

class CharacterInfoCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: CharacterInfoCollectionViewCell.self)
    
    lazy var characterImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .blue
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var descriptionContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .white
        return container
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupVisualElements() {
        setupCharacterImageViewConstraints()
        setupDescriptionContainerConstraints()
    }
    
    func setupCharacterImageViewConstraints() {
        contentView.addSubview(characterImageView)
        
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            characterImageView.widthAnchor.constraint(equalToConstant: (contentView.frame.width / 3) + 10)
        ])
    }
    
    func setupDescriptionContainerConstraints() {
        contentView.addSubview(descriptionContainer)
        
        NSLayoutConstraint.activate([
            descriptionContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            descriptionContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionContainer.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor),
            descriptionContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
