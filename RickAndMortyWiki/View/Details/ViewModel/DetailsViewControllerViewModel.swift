//
//  DetailsViewControllerViewModel.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 13/11/22.
//

import Foundation

final class DetailsViewModel {
    var character: AllCharacterResults
    var location: LocationDetails
    var firstSeenEpisode: EpisodeResults
    
    var residents: [AllCharacterResults] = [AllCharacterResults]()
    
    private let service: Service
    
    init(_ service: Service = Service(), characters: AllCharacterResults, location: LocationDetails, firstSeenEpisode: EpisodeResults) {
        self.service = service
        self.character = characters
        self.location = location
        self.firstSeenEpisode = firstSeenEpisode
        fetchResidentsVIEWMODEL()
    }
    
    func fetchResidentsVIEWMODEL() {
        guard let origin = character.origin?.url else { return }
        service.getLocationBy(url: origin) { result in
            switch result {
            case .success(let locationDetails):
                for residents in locationDetails.residents {
                    self.service.getCharactersSpecific2(url: residents) { result in
                        switch result {
                        case .success(let residents):
                            self.residents.append(residents)
                            print(self.residents.count)
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
