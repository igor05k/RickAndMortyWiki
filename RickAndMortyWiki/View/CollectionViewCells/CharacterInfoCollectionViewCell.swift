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
    
    lazy var characterName: UILabel = {
        let character = UILabel()
        character.text = "Rick Sanchez"
        character.textColor = .darkText
        character.translatesAutoresizingMaskIntoConstraints = false
        return character
    }()
    
    lazy var statusStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fillEqually
        stack.backgroundColor = .orange
        return stack
    }()
    
    lazy var statusCircle: UIView = {
        let circle = UIView()
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.backgroundColor = .black
        circle.layer.cornerRadius = 6
        circle.clipsToBounds = true
        return circle
    }()
    
    lazy var statusLabel: UILabel = {
        let status = UILabel()
        status.text = "Alive -"
        status.textColor = .black
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    lazy var speciesLabel: UILabel = {
        let status = UILabel()
        status.text = "Alien"
        status.textColor = .black
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
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
        setupCharacterLabelConstraints()
        setupStatusCircleConstraints()
        setupStatusStackViewConstraints()
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
    
    func setupCharacterLabelConstraints() {
        contentView.addSubview(characterName)
        
        NSLayoutConstraint.activate([
            characterName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            characterName.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 5),
            characterName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 5),
        ])
    }
    
    func setupStatusCircleConstraints() {
        contentView.addSubview(statusCircle)

        NSLayoutConstraint.activate([
            statusCircle.topAnchor.constraint(equalTo: characterName.bottomAnchor, constant: 5),
            statusCircle.leadingAnchor.constraint(equalTo: characterName.leadingAnchor),
            statusCircle.heightAnchor.constraint(equalToConstant: 12),
            statusCircle.widthAnchor.constraint(equalToConstant: 12),
        ])
    }
    
    func setupStatusStackViewConstraints() {
        contentView.addSubview(statusStackView)
        statusStackView.addArrangedSubview(statusLabel)
        statusStackView.addArrangedSubview(speciesLabel)

        NSLayoutConstraint.activate([
            statusStackView.topAnchor.constraint(equalTo: characterName.bottomAnchor, constant: 5),
            statusStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
            statusStackView.leadingAnchor.constraint(equalTo: statusCircle.trailingAnchor, constant: 5),
            statusStackView.centerYAnchor.constraint(equalTo: statusCircle.centerYAnchor)
        ])
    }
}
