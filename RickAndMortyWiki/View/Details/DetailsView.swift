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
    // MARK: Create visual elements
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .darkGray
        table.register(DetailsTableViewCell.self, forCellReuseIdentifier: DetailsTableViewCell.identifier)
        table.register(OriginTableViewCell.self, forCellReuseIdentifier: OriginTableViewCell.identifier)
        table.register(CharacterCollectionViewTableViewCell.self, forCellReuseIdentifier: CharacterCollectionViewTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
        self.addSubview(tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = self.bounds
    }
}

extension DetailsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Sections.characterDetails.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCollectionViewTableViewCell.identifier, for: indexPath)
            return cell
        case Sections.originDetails.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: OriginTableViewCell.identifier, for: indexPath)
            return cell
            // only 2 cells are needed to dequeue, that being origin and residents cells
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.identifier, for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case Sections.originDetails.rawValue:
            return 130
        default:
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case Sections.characterDetails.rawValue:
            return nil
        case Sections.originDetails.rawValue:
            return "Origin"
        case Sections.residentDetails.rawValue:
            return "Residents"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        header.textLabel?.frame = header.bounds
        header.textLabel?.textAlignment = .left
    }
}
