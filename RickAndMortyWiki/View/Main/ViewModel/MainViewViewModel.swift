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
//        fetchLocationDetails()
    }
    
    /// fetch character location if it exists.
    func filterLocationDetails(character: AllCharacterResults) -> LocationDetails? {
        guard let location = character.location else { return nil }
        return characterLocationDetails.filter({ $0.name == location.name }).first(where: { $0.name == location.name })
    }
    
    func fetchAllCharacters() {
        service.getAllCharacters { [weak self] result in
            self?.delegate?.showLoading()
            switch result {
            case .success(let success):
                // remove all items in order to populate again
                self?.firstSeenEpisode.removeAll()
                self?.characterLocationDetails.removeAll()
                
                // assign the result to a list
                self?.allCharacters = success.results
                
                // fetch additional data for the characters
                self?.fetchFirstSeenEpisode()
                self?.fetchLocationDetails()
                print("ALL CHARACTERS: \(String(describing: self?.allCharacters.count))")
                self?.delegate?.stopLoading()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchFirstSeenEpisode() {
        for character in allCharacters {
            guard let firstEpisode = character.episode.first else { return }
            self.service.getEpisodesDetails(url: firstEpisode) { result in
                switch result {
                case .success(let episodesResults):
                    self.firstSeenEpisode.append(episodesResults)
                    print("EPISODE DETAILS: \(String(describing: self.firstSeenEpisode.count))")
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
    
    func fetchLocationDetails() {
        for episode in allCharacters {
            guard let location = episode.location else { return }
            self.service.getLocationBy(url: location.url) { result in
                switch result {
                case .success(let success):
                    self.characterLocationDetails.append(success)
                    print("LOCATION DETAILS \(self.characterLocationDetails.count)")
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
}

