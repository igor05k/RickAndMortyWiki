//
//  MainViewViewModel.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 04/11/22.
//

import Foundation

final class MainViewViewModel {
    var allCharacters: [AllCharacterResults] = [AllCharacterResults]()
    var episodeResults: [EpisodeResults] = [EpisodeResults]()
    var characterLocationDetails: [LocationDetails] = [LocationDetails]()

    var residentsArray: [AllCharacterResults] = [AllCharacterResults]()
    
    private var service: Service
    
    init(_ service: Service = Service()) {
        self.service = service
        fetchAllCharacters()
        fetchEpDetails()
        fetchLocationDetails()
    }
    
    func fetchAllCharacters() {
        service.getAllCharacters { result in
            switch result {
            case .success(let success):
                self.allCharacters = success.results
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchEpDetails() {
        service.getAllCharacters { result in
            switch result {
            case .success(let success):
                for episode in success.results {
                    self.service.getEpisodesDetails(url: episode.episode[0]) { result in
                        switch result {
                        case .success(let episodesResults):
                            self.episodeResults.append(episodesResults)
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
        service.getAllCharacters { result in
            switch result {
            case .success(let success):
                for episode in success.results {
                    guard let origin = episode.origin else { return }
                    self.service.getLocationBy(url: origin.url) { result in
                        switch result {
                        case .success(let success):
                            self.characterLocationDetails.append(success)
                            print(self.characterLocationDetails)
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
    
    /// fetch character origin if it exists.
    func filterLocationDetails(character: AllCharacterResults) -> LocationDetails? {
        guard let origin = character.origin else { return nil }
        return characterLocationDetails.filter({ $0.name == origin.name }).first(where: { $0.name == origin.name })
    }
    
    func fetchResidents(locationFiltered: LocationDetails) {
        service.getCharactersSpecific(url: locationFiltered.residents) { result in
            switch result {
            case .success(let characterResult):
                self.residentsArray.append(characterResult)
//                print(self.residentsArray)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

