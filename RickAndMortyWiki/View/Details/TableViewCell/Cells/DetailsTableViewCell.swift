//
//  DetailsTableViewCell.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 04/11/22.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    static let identifier = String(describing: DetailsTableViewCell.self)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
