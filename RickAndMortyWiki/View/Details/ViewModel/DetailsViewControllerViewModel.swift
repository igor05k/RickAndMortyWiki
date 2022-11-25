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
    
    @Published var residents: [AllCharacterResults] = [AllCharacterResults]()
    
    private let service: Service
    
    init(_ service: Service = Service(), characters: AllCharacterResults, location: LocationDetails, firstSeenEpisode: EpisodeResults) {
        self.service = service
        self.character = characters
        self.location = location
        self.firstSeenEpisode = firstSeenEpisode
        fetchResidents()
    }
    
    func fetchResidents() {
        guard let location = character.location?.url else { return }
        service.getLocationBy(url: location) { result in
            switch result {
            case .success(let locationDetails):
                for residents in locationDetails.residents {
                    self.service.getSpecificCharacterBy(url: residents) { result in
                        switch result {
                        case .success(let residents):
                            if self.residents.count < 20 {
                                self.residents.append(residents)
                            } else {
                                break
                            }
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
