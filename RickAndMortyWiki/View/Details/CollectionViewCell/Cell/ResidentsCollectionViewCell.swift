//
//  ResidentsCollectionViewCell.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 04/11/22.
//

import UIKit

class ResidentsCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: ResidentsCollectionViewCell.self)
    
    private var viewModel: ResidentsCollectionViewCellViewModel?
    
    // MARK: Setup
    func configure(with residents: CharacterResults) {
        viewModel = ResidentsCollectionViewCellViewModel(allCharacters: residents)
        
        characterName.text = viewModel?.getCharacterName
        statusLabel.text = viewModel?.getCharacterStatus
        speciesLabel.text = "\(viewModel?.getCharacterSpecies ?? "Unknown")"
        characterImageView.loadImageUsingCache(withUrl: viewModel?.getCharacterImage ?? "")
//        characterImageView.downloaded(from: viewModel?.getCharacterImage ?? "")
        
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
    
    lazy var characterName: UILabel = {
        let character = UILabel()
        character.text = "Rick Sanchez"
        character.textColor = .white
        character.numberOfLines = 0
        character.textAlignment = .center
        character.translatesAutoresizingMaskIntoConstraints = false
        return character
    }()
    
    lazy var statusCircle: UIView = {
        let circle = UIView()
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.backgroundColor = .yellow
        circle.layer.cornerRadius = 5
        circle.clipsToBounds = true
        return circle
    }()
    
    lazy var statusLabel: UILabel = {
        let status = UILabel()
        status.text = "Alive - "
        status.textColor = .yellow
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    lazy var speciesLabel: UILabel = {
        let status = UILabel()
        status.text = "Species"
        status.textColor = .white
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    lazy var topContainer: LabelContainer = LabelContainer()
    lazy var bottomContainer: LabelContainer = LabelContainer()
    
    lazy var labelsContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .init(red: 41 / 255, green: 43 / 255, blue: 49 / 255, alpha: 0.20)
        return container
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVisualElements()
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupVisualElements() {
        setupImageView()
        setupTopLabelContainer()
        setupBottomLabelContainer()
        setupNameLabelConstraints()
        setupStatusCircle()
    }
    
    func setupTopLabelContainer() {
        characterImageView.addSubview(topContainer)
        
        NSLayoutConstraint.activate([
            topContainer.topAnchor.constraint(equalTo: characterImageView.topAnchor, constant: 4),
            topContainer.leadingAnchor.constraint(equalTo: characterImageView.leadingAnchor, constant: 8),
            topContainer.trailingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: -4),
            topContainer.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    func setupBottomLabelContainer() {
        characterImageView.addSubview(bottomContainer)
        
        NSLayoutConstraint.activate([
            bottomContainer.bottomAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: -4),
            bottomContainer.leadingAnchor.constraint(equalTo: characterImageView.leadingAnchor),
            bottomContainer.trailingAnchor.constraint(equalTo: characterImageView.trailingAnchor),
            bottomContainer.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    
    func setupImageView() {
        contentView.addSubview(characterImageView)
        
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func setupNameLabelConstraints() {
        bottomContainer.addSubview(characterName)
        
        NSLayoutConstraint.activate([
            characterName.centerXAnchor.constraint(equalTo: bottomContainer.centerXAnchor),
            characterName.centerYAnchor.constraint(equalTo: bottomContainer.centerYAnchor)
        ])
    }
    
    func setupStatusCircle() {
        topContainer.addSubview(statusCircle)
        topContainer.addSubview(speciesLabel)
        
        NSLayoutConstraint.activate([
            statusCircle.topAnchor.constraint(equalTo: topContainer.topAnchor, constant: 8),
            statusCircle.leadingAnchor.constraint(equalTo: topContainer.leadingAnchor, constant: 12),
            statusCircle.widthAnchor.constraint(equalToConstant: 10),
            statusCircle.heightAnchor.constraint(equalToConstant: 10),
            
            speciesLabel.topAnchor.constraint(equalTo: topContainer.topAnchor, constant: 8),
            speciesLabel.leadingAnchor.constraint(equalTo: statusCircle.trailingAnchor, constant: 8),
            speciesLabel.trailingAnchor.constraint(equalTo: topContainer.trailingAnchor, constant: -8),
            speciesLabel.centerYAnchor.constraint(equalTo: statusCircle.centerYAnchor),
        ])
    }
}
