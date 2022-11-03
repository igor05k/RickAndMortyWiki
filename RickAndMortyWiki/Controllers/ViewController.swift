//
//  ViewController.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 02/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var mainView: MainView = {
        let main = MainView()
        main.didTapCharacter = { [weak self] in
            self?.goToDetails()
        }
        return main
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome"
        view.backgroundColor = .red
        Service.getAllCharacters { _ in
            
        }
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    func goToDetails() {
        let detailsViewController = DetailsViewController()
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

