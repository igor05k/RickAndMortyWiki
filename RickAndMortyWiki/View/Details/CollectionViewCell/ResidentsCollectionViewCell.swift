//
//  ResidentsCollectionViewCell.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 04/11/22.
//

import UIKit

class ResidentsCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: ResidentsCollectionViewCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
