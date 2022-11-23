//
//  MainViewViewModel.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 04/11/22.
//

import Foundation

protocol MainViewDelegate: AnyObject {
    func showLoading()
    func stopLoading()
}

final class MainViewViewModel {
    var allCharacters: [AllCharacterResults] = [AllCharacterResults]()
    var firstSeenEpisode: [EpisodeResults] = [EpisodeResults]()
    var characterLocationDetails: [LocationDetails] = [LocationDetails]()
    
    weak var delegate: MainViewDelegate?
    
    private var service: Service
    
    init(_ service: Service = Service()) {
        self.service = service
        fetchAllCharacters()
        fetchLocationDetails()
    }
    
    /// fetch character origin if it exists.
    func filterLocationDetails(character: AllCharacterResults) -> LocationDetails? {
        guard let origin = character.origin else { return nil }
        return characterLocationDetails.filter({ $0.name == origin.name }).first(where: { $0.name == origin.name })
    }
    
    func fetchAllCharacters() {
        self.allCharacters.removeAll()
        service.getAllCharacters { [weak self] result in
            self?.delegate?.showLoading()
            switch result {
            case .success(let success):    
                self?.allCharacters = success.results
                self?.fetchFirstSeenEpisode()
                print("ALL CHARACTERS: \(String(describing: self?.allCharacters.count))")
                self?.delegate?.stopLoading()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchFirstSeenEpisode() {
        self.firstSeenEpisode.removeAll()
        service.getAllCharacters { [weak self] result in
            switch result {
            case .success(let success):
                for character in success.results {
                    guard let firstEpisode = character.episode.first else { return }
                    self?.service.getEpisodesDetails(url: firstEpisode) { result in
                        switch result {
                        case .success(let episodesResults):
                            
                            self?.firstSeenEpisode.append(episodesResults)
                            print("EPISODE DETAILS: \(String(describing: self?.firstSeenEpisode.count))")
                        case .failure(let failure):
                            print(failure)
                        }
                    }
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchLocationDetails() {
        self.characterLocationDetails.removeAll()
        service.getAllCharacters { result in
            switch result {
            case .success(let success):
                for episode in success.results {
                    guard let origin = episode.origin else { return }
                    self.service.getLocationBy(url: origin.url) { result in
                        switch result {
                        case .success(let success):
                            self.characterLocationDetails.append(success)
                            print("LOCATION DETAILS \(self.characterLocationDetails.count)")
                        case .failure(let failure):
                            print(failure)
                        }
                    }
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

