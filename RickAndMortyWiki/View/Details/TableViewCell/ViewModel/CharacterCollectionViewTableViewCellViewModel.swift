//
//  CharacterCollectionViewTableViewCellViewModel.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 10/11/22.
//

import Foundation

final class CharacterCollectionViewTableViewCellViewModel {
    private var allCharacters: AllCharacterResults
    private var episodeResults: EpisodeResults
    
    init(allCharacters: AllCharacterResults, episodeResults: EpisodeResults) {
        self.allCharacters = allCharacters
        self.episodeResults = episodeResults
    }
    
    public var getAllCharactersModel: [AllCharacterResults] {
        return [allCharacters]
    }
    
    public var getAllEpisodesResultsModel: EpisodeResults {
        return episodeResults
    }
}
