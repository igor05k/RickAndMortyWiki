//
//  DetailsViewController.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 03/11/22.
//

import UIKit

class DetailsViewController: UIViewController {
    lazy var detailsView = DetailsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = detailsView
    }
}
