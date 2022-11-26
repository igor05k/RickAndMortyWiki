//
//  SearchResultsViewModel.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 26/11/22.
//

import Foundation

class SearchResultsViewModel {
    var charactersSearched: [CharacterResults] = [CharacterResults]()
    var firstSeenEpisodeSearched: [EpisodeResults] = [EpisodeResults]()
    var characterLocationSearched: [LocationDetails] = [LocationDetails]()
    
    /// fetch character location if it exists.
    func filterLocationDetails(character: CharacterResults) -> LocationDetails? {
        guard let location = character.location else { return nil }
        return characterLocationSearched.filter({ $0.name == location.name }).first(where: { $0.name == location.name })
    }
}
