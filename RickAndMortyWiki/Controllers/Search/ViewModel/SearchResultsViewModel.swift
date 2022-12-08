//
//  SearchResultsViewModel.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 26/11/22.
//

import Foundation

class SearchResultsViewModel {
    private var charactersSearched: [CharacterResults] = [CharacterResults]()
    private var firstSeenEpisodeSearched: [EpisodeResults] = [EpisodeResults]()
    private var characterLocationSearched: [LocationDetails] = [LocationDetails]()
    
    /// fetch character location if it exists.
    func filterLocationDetails(character: CharacterResults) -> LocationDetails? {
        guard let location = character.location else { return nil }
        return characterLocationSearched.filter({ $0.name == location.name }).first(where: { $0.name == location.name })
    }
    
    public var isCharactersSearchedEmpty: Bool {
        return charactersSearched.isEmpty
    }
    
    public var numberOfItemsInSection: Int {
        return charactersSearched.count
    }
    
    public var isFirstSeenEpisodeSearchedEmpty: Bool {
        return firstSeenEpisodeSearched.isEmpty
    }
    
    func getCurrentCharacter(indexPath: IndexPath) -> CharacterResults {
        return charactersSearched[indexPath.row]
    }
    
    func getCurrentFirstSeenEpisode(indexPath: IndexPath) -> EpisodeResults {
        return firstSeenEpisodeSearched[indexPath.row]
    }
    
    func set(characters: [CharacterResults]) {
        self.charactersSearched = characters
    }
    
    func set(firstSeenEpisode: [EpisodeResults]) {
        self.firstSeenEpisodeSearched = firstSeenEpisode
    }
    
    func set(locationDetails: [LocationDetails]) {
        self.characterLocationSearched = locationDetails
    }
}
