//
//  DetailsViewController.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 03/11/22.
//

import UIKit

class DetailsViewController: UIViewController {
    lazy var detailsView: DetailsView = {
        let details = DetailsView()
//        details.collectionView.delegate = self
//        details.collectionView.dataSource = self
        return details
    }()
    
    private var characterSelected: [CharacterResults] = [CharacterResults]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(characterSelected)
    }
    
    // MARK: Life cycles
    override func loadView() {
        self.view = detailsView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    public func configure(with model: CharacterResults) {
        self.characterSelected = [model]
    }
}
