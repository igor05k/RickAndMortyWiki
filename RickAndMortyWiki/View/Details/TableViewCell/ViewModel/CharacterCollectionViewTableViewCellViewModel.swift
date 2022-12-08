//
//  CharacterCollectionViewTableViewCellViewModel.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 10/11/22.
//

import Foundation

struct CharacterCollectionViewTableViewCellViewModel {
    private var allCharacters: CharacterResults
    private var episodeResults: EpisodeResults
    
    init(allCharacters: CharacterResults, episodeResults: EpisodeResults) {
        self.allCharacters = allCharacters
        self.episodeResults = episodeResults
    }
    
    public var getAllCharactersModel: [CharacterResults] {
        return [allCharacters]
    }
    
    public var getAllEpisodesResultsModel: EpisodeResults {
        return episodeResults
    }
}
