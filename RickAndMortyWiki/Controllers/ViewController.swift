//
//  ViewController.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 02/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome"
        view.backgroundColor = .red
    }
    
    override func loadView() {
        self.view = mainView
    }
}

