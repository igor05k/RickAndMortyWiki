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
    func configure(with residents: AllCharacterResults) {
        viewModel = ResidentsCollectionViewCellViewModel(allCharacters: residents)
        
        characterName.text = viewModel?.getCharacterName
        statusLabel.text = viewModel?.getCharacterStatus
        speciesLabel.text = "- \(viewModel?.getCharacterSpecies ?? "Unknown")"
        characterImageView.downloaded(from: viewModel?.getCharacterImage ?? "")
        
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupVisualElements() {
        setupImageView()
        setupNameLabelConstraints()
        setupStatusCircle()
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
        contentView.addSubview(characterName)
        
        NSLayoutConstraint.activate([
            characterName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            characterName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            characterName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    func setupStatusCircle() {
        contentView.addSubview(statusCircle)
        contentView.addSubview(statusLabel)
        contentView.addSubview(speciesLabel)
        
        NSLayoutConstraint.activate([
            statusCircle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 13),
            statusCircle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            statusCircle.widthAnchor.constraint(equalToConstant: 10),
            statusCircle.heightAnchor.constraint(equalToConstant: 10),
            statusCircle.centerYAnchor.constraint(equalTo: statusLabel.centerYAnchor),
            
            statusLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            statusLabel.leadingAnchor.constraint(equalTo: statusCircle.trailingAnchor, constant: 5),
            
            speciesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            speciesLabel.leadingAnchor.constraint(equalTo: statusLabel.trailingAnchor, constant: 4),
            speciesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }
}
