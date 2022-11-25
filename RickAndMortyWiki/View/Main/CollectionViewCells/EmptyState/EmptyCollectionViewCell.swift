//
//  EmptyCollectionViewCell.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 21/11/22.
//

import UIKit

protocol RetryDelegate: AnyObject {
    func didTapRetry()
}

class EmptyCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "EmptyCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setElementsConstraints()
    }
    
    weak var delegate: RetryDelegate?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var warningMessage: UILabel = {
        let character = UILabel()
        character.text = "Oops.. something went wrong."
        character.textColor = .black
        character.textAlignment = .center
        character.translatesAutoresizingMaskIntoConstraints = false
        return character
    }()
    
    lazy var retryButton: UIButton = {
        let retry = UIButton()
        retry.translatesAutoresizingMaskIntoConstraints = false
        retry.setTitle("Retry", for: .normal)
        retry.setTitleColor(.blue, for: .normal)
        return retry
    }()
    
    @objc func retryTapped() {
        self.delegate?.didTapRetry()
    }
    
    func setElementsConstraints() {
        contentView.addSubview(warningMessage)
        contentView.addSubview(retryButton)
        retryButton.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            warningMessage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            warningMessage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            retryButton.topAnchor.constraint(equalTo: warningMessage.bottomAnchor, constant: 10),
            retryButton.leadingAnchor.constraint(equalTo: warningMessage.leadingAnchor),
            retryButton.trailingAnchor.constraint(equalTo: warningMessage.trailingAnchor),
        ])
    }
}
