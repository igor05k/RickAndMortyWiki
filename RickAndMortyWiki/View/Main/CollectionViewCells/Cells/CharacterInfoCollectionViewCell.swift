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
    func configure(characterInfo: CharacterResults, epName: EpisodeResults) {
        cellViewModel = CharacterInfoCollectionViewCellViewModel(characterInfo: characterInfo, episodeResults: epName)

        characterName.text = cellViewModel?.getName
        statusLabel.text = cellViewModel?.getStatus
        speciesLabel.text = "- \(cellViewModel?.getSpecies ?? "Unknown")"
        locationLabel.text = cellViewModel?.getLastKnownLocation.name
        characterImageView.downloaded(from: cellViewModel?.getCharacterImage ?? "")
        episodeLabel.text = cellViewModel?.getEpisodeName
        
        
        if statusLabel.text == "Alive" {
            statusCircle.backgroundColor = .green
        } else {
            statusCircle.backgroundColor = .red
        }
    }
    
    lazy var characterImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var descriptionContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor(red: 60 / 255, green: 62 / 255, blue: 68 / 255, alpha: 1)
        return container
    }()
    
    lazy var characterName: UILabel = {
        let character = UILabel()
        character.text = "Rick Sanchez"
        character.textColor = .white
        character.translatesAutoresizingMaskIntoConstraints = false
        return character
    }()
    
    lazy var statusCircle: UIView = {
        let circle = UIView()
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.backgroundColor = .black
        circle.layer.cornerRadius = 5
        circle.clipsToBounds = true
        return circle
    }()
    
    lazy var statusLabel: UILabel = {
        let status = UILabel()
        status.text = "Alive"
        status.textColor = .white
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    lazy var speciesLabel: UILabel = {
        let status = UILabel()
        status.text = "Specie"
        status.textColor = .white
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    lazy var lastKnownLocationLabel: UILabel = {
        let last = UILabel()
        last.translatesAutoresizingMaskIntoConstraints = false
        last.text = "Last known location: "
        last.textColor = .lightGray
        return last
    }()
    
    lazy var locationLabel: UILabel = {
        let location = UILabel()
        location.translatesAutoresizingMaskIntoConstraints = false
        location.text = "Interdimensional cable"
        location.textColor = .white
        return location
    }()
    
    lazy var firstSeenLabel: UILabel = {
        let first = UILabel()
        first.translatesAutoresizingMaskIntoConstraints = false
        first.text = "First seen in:"
        first.textColor = .lightGray
        return first
    }()
    
    lazy var episodeLabel: UILabel = {
        let episode = UILabel()
        episode.translatesAutoresizingMaskIntoConstraints = false
        episode.text = "Morty's mind blowers"
        episode.textColor = .white
        return episode
    }()
    
    // MARK: Set Visual Elements
    func setupVisualElements() {
        setupCharacterImageViewConstraints()
        setupDescriptionContainerConstraints()
        setupCharacterLabelConstraints()
        setupStatusCircleConstraints()
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
        contentView.addSubview(statusLabel)
        contentView.addSubview(speciesLabel)


        NSLayoutConstraint.activate([
            statusCircle.topAnchor.constraint(equalTo: characterName.bottomAnchor, constant: 15),
            statusCircle.leadingAnchor.constraint(equalTo: characterName.leadingAnchor),
            statusCircle.heightAnchor.constraint(equalToConstant: 10),
            statusCircle.widthAnchor.constraint(equalToConstant: 10),
            statusCircle.centerYAnchor.constraint(equalTo: statusLabel.centerYAnchor),
            
            statusLabel.topAnchor.constraint(equalTo: characterName.bottomAnchor, constant: 5),
            statusLabel.leadingAnchor.constraint(equalTo: statusCircle.trailingAnchor, constant: 5),
            
            speciesLabel.topAnchor.constraint(equalTo: characterName.bottomAnchor, constant: 5),
            speciesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            speciesLabel.leadingAnchor.constraint(equalTo: statusLabel.trailingAnchor, constant: 5),
            speciesLabel.centerYAnchor.constraint(equalTo: statusLabel.centerYAnchor),
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
