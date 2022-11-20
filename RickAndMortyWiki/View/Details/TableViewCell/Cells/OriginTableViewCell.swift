//
//  OriginTableViewCell.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 04/11/22.
//

import UIKit

class OriginTableViewCell: UITableViewCell {
    static let identifier = String(describing: OriginTableViewCell.self)
    
    private var viewModel: OriginTableViewCellViewModel?
    
    // MARK: Configure method
    func configure(with model: LocationDetails) {
        viewModel = OriginTableViewCellViewModel(model: model)
        originPlanetLabel.text = "Planet: \(viewModel?.getPlanetName ?? "Unknown")"
        originTypeLabel.text = "Type: \(viewModel?.getTypeName ?? "Unknown")"
        dimensionLabel.text = "Dimension: \(viewModel?.getDimensionName ?? "Unknown")"
    }
    
    lazy var originPlanetLabel: UILabel = {
        let origin = UILabel()
        origin.translatesAutoresizingMaskIntoConstraints = false
        origin.text = "Planet Earth"
        origin.font = .systemFont(ofSize: 22, weight: .light)
        return origin
    }()
    
    lazy var originTypeLabel: UILabel = {
        let type = UILabel()
        type.translatesAutoresizingMaskIntoConstraints = false
        type.text = "Type: Planet"
        type.font = .systemFont(ofSize: 22, weight: .light)
        return type
    }()
    
    lazy var dimensionLabel: UILabel = {
        let dimension = UILabel()
        dimension.translatesAutoresizingMaskIntoConstraints = false
        dimension.text = "Dimension C-137"
        dimension.font = .systemFont(ofSize: 22, weight: .light)
        return dimension
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupElements() {
        setOriginPlanetLabelConstraints()
        setOriginTypeLabelConstraints()
        setDimensionLabelConstraints()
    }
    
    func setOriginPlanetLabelConstraints() {
        contentView.addSubview(originPlanetLabel)
        
        NSLayoutConstraint.activate([
            originPlanetLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            originPlanetLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            originPlanetLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
        ])
    }
    
    func setOriginTypeLabelConstraints() {
        contentView.addSubview(originTypeLabel)
        
        NSLayoutConstraint.activate([
            originTypeLabel.topAnchor.constraint(equalTo: originPlanetLabel.bottomAnchor, constant: 10),
            originTypeLabel.trailingAnchor.constraint(equalTo: originPlanetLabel.trailingAnchor),
            originTypeLabel.leadingAnchor.constraint(equalTo: originPlanetLabel.leadingAnchor)
        ])
    }
    
    func setDimensionLabelConstraints() {
        contentView.addSubview(dimensionLabel)
        
        NSLayoutConstraint.activate([
            dimensionLabel.topAnchor.constraint(equalTo: originTypeLabel.bottomAnchor, constant: 10),
            dimensionLabel.trailingAnchor.constraint(equalTo: originTypeLabel.trailingAnchor),
            dimensionLabel.leadingAnchor.constraint(equalTo: originTypeLabel.leadingAnchor)
        ])
    }
}
