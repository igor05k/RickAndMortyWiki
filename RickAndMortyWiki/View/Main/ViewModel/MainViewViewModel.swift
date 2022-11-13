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
                    self.service.getLocationBy(url: episode.origin!.url) { result in
                        switch result {
                        case .success(let success):
                            self.characterLocationDetails.append(success)
//                            print(success)
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
    
//    var locationDetails: AllCharacterResults {
//        guard let origin = character.origin else { return }
//        let locationFiltered = characterLocationDetails.filter({ $0.name == origin.name }).first(where: { $0.name == origin.name })
//    }
    
    func filterLocationDetails(character: AllCharacterResults) -> LocationDetails? {
        guard let origin = character.origin else { return nil }
        return characterLocationDetails.filter({ $0.name == origin.name }).first(where: { $0.name == origin.name })
    }
    
//    func fetchResidents() {
//        service.getCharactersSpecific(url: locationFiltered.residents) { result in
//            switch result {
//            case .success(let success):
//                print(success)
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//    }
}

