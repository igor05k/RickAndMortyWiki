//
//  DetailsView.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 03/11/22.
//

import UIKit

enum Sections: Int {
    case characterDetails = 0
    case originDetails = 1
    case residentDetails = 2
}

class DetailsView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


