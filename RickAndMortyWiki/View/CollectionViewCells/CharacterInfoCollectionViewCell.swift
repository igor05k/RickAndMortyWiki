//
//  CharacterInfoCollectionViewCell.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 02/11/22.
//

import UIKit

class CharacterInfoCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: CharacterInfoCollectionViewCell.self)
    
    private var cellViewModel: CharacterInfoCollectionViewCellViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure method
    func configure(with charInfo: CharacterResults) {
//        cellViewModel = CharacterInfoCollectionViewCellViewModel(characterInfo: charInfo)
//        characterName.text = cellViewModel?.name
//        statusLabel.text = cellViewModel?.status
//        locationLabel.text = cellViewModel?.lastKnownLocation.name
        // todo
        
//        characterImageView.downloaded(from: cellViewModel?.characterImage ?? "")
    }
    
    
    
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
    
    lazy var lastKnownLocationLabel: UILabel = {
        let last = UILabel()
        last.translatesAutoresizingMaskIntoConstraints = false
        last.text = "Last known location: "
        last.textColor = .darkGray
        return last
    }()
    
    lazy var locationLabel: UILabel = {
        let location = UILabel()
        location.translatesAutoresizingMaskIntoConstraints = false
        location.text = "Interdimensional cable"
        return location
    }()
    
    lazy var firstSeenLabel: UILabel = {
        let first = UILabel()
        first.translatesAutoresizingMaskIntoConstraints = false
        first.text = "First seen in:"
        first.textColor = .darkGray
        return first
    }()
    
    lazy var episodeLabel: UILabel = {
        let episode = UILabel()
        episode.translatesAutoresizingMaskIntoConstraints = false
        episode.text = "Morty's mind blowers"
        episode.textColor = .black
        return episode
    }()
    
    // MARK: Set Visual Elements
    func setupVisualElements() {
        setupCharacterImageViewConstraints()
        setupDescriptionContainerConstraints()
        setupCharacterLabelConstraints()
        setupStatusCircleConstraints()
        setupStatusStackViewConstraints()
        setupLastKnownConstraints()
        setupLocationLabel()
        setupFirstSeen()
        setupEpisodeLabel()
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
    
    func setupLastKnownConstraints() {
        contentView.addSubview(lastKnownLocationLabel)
        
        NSLayoutConstraint.activate([
            lastKnownLocationLabel.topAnchor.constraint(equalTo: statusCircle.bottomAnchor, constant: 20),
            lastKnownLocationLabel.leadingAnchor.constraint(equalTo: statusCircle.leadingAnchor),
            lastKnownLocationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func setupLocationLabel() {
        contentView.addSubview(locationLabel)
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: lastKnownLocationLabel.bottomAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: lastKnownLocationLabel.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func setupFirstSeen() {
        contentView.addSubview(firstSeenLabel)
        
        NSLayoutConstraint.activate([
            firstSeenLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 20),
            firstSeenLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            firstSeenLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func setupEpisodeLabel() {
        contentView.addSubview(episodeLabel)
        
        NSLayoutConstraint.activate([
            episodeLabel.topAnchor.constraint(equalTo: firstSeenLabel.bottomAnchor),
            episodeLabel.leadingAnchor.constraint(equalTo: firstSeenLabel.leadingAnchor),
            episodeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
