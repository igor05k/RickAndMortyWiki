//
//  ResidentsCollectionViewCell.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 04/11/22.
//

import UIKit

class ResidentsCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: ResidentsCollectionViewCell.self)
    
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
        self.backgroundColor = .black
        setupVisualElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupVisualElements() {
        setupNameLabelConstraints()
        setupStatusCircle()
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
