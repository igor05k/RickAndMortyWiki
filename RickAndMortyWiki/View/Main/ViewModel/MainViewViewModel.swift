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

//    var residentsArray: [AllCharacterResults] = [AllCharacterResults]()
    
    private var service: Service
    
    init(_ service: Service = Service()) {
        self.service = service
        fetchAllCharacters()
        fetchEpDetails()
        fetchLocationDetails()
    }
    
    /// fetch character origin if it exists.
    func filterLocationDetails(character: AllCharacterResults) -> LocationDetails? {
        guard let origin = character.origin else { return nil }
        return characterLocationDetails.filter({ $0.name == origin.name }).first(where: { $0.name == origin.name })
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
    
//    func fetchResidents(locationFiltered: LocationDetails) {
//        service.getCharactersSpecific(url: locationFiltered.residents) { result in
//            switch result {
//            case .success(let characterResult):
//                self.residentsArray.append(characterResult)
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//    }
    
    /*
     service.getAllCharacters { result in
         switch result {
         case .success(let success):
             for episode in success.results {
                 guard let origin = episode.origin else { return }
                 self.service.getLocationBy(url: origin.url) { result in
                     switch result {
                     case .success(let success):
                         self.characterLocationDetails.append(success)
                     case .failure(let failure):
                         print(failure)
                     }
                 }
             }
         case .failure(let failure):
             print(failure)
         }
     }
     */
    
//    func fetchResidents2(character: AllCharacterResults) {
//        guard let origin = character.origin?.url else { return }
//        service.getLocationBy(url: origin) { result in
//            switch result {
//            case .success(let locationDetails):
//                for residents in locationDetails.residents {
//                    self.service.getCharactersSpecific2(url: residents) { result in
//                        switch result {
//                        case .success(let residents):
//                            DispatchQueue.main.async {
//                                self.residentsArray.append(residents)
//                            }
//                        case .failure(let failure):
//                            print(failure)
//                        }
//                    }
//                }
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//    }
}

