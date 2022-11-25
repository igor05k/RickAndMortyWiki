//
//  LabelContainer.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 14/11/22.
//

import UIKit

class LabelContainer: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDefaultProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDefaultProperties() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .init(red: 41 / 255, green: 43 / 255, blue: 49 / 255, alpha: 0.30)
        self.clipsToBounds = true
    }
}
