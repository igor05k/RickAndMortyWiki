//
//  DetailsViewController.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 03/11/22.
//

import UIKit

class DetailsViewController: UIViewController {
    private var characterSelected: [AllCharacterResults] = [AllCharacterResults]()
    private var locationDetailsArray: [LocationDetails] = [LocationDetails]()
    private var episodeDetails: [EpisodeResults] = [EpisodeResults]()
    
    private var viewModel: MainViewViewModel
    
    init(viewModel: MainViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
    }
    
    // MARK: Life cycles
    override func loadView() {
        self.view = detailsView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    lazy var detailsView: DetailsView = {
        let details = DetailsView()
        return details
    }()
    
    // MARK: Create visual elements
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .darkGray
//        table.register(DetailsTableViewCell.self, forCellReuseIdentifier: DetailsTableViewCell.identifier)
        table.register(OriginTableViewCell.self, forCellReuseIdentifier: OriginTableViewCell.identifier)
        table.register(CharacterCollectionViewTableViewCell.self, forCellReuseIdentifier: CharacterCollectionViewTableViewCell.identifier)
        table.register(ResidentsCollectionViewTableViewCell.self, forCellReuseIdentifier: ResidentsCollectionViewTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    public func configure(with model: AllCharacterResults) {
        self.characterSelected = [model]
    }
    
    public func configureLocations(with model: LocationDetails) {
        self.locationDetailsArray = [model]
    }
    
    public func configureEpisodeDetails(with model: EpisodeResults) {
        self.episodeDetails = [model]
    }
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Sections.characterDetails.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCollectionViewTableViewCell.identifier, for: indexPath) as! CharacterCollectionViewTableViewCell
            cell.configure(with: characterSelected[0], episodeName: episodeDetails[0])
            return cell
        case Sections.originDetails.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: OriginTableViewCell.identifier, for: indexPath) as! OriginTableViewCell
            cell.configure(with: locationDetailsArray[indexPath.row])
            return cell
        case Sections.residentDetails.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: ResidentsCollectionViewTableViewCell.identifier, for: indexPath)
            return cell
        default:
            return UITableViewCell()
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
