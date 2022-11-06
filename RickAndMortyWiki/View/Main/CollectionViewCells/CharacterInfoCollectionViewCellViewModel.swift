//
//  CharacterInfoCollectionViewCellViewModel.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 03/11/22.
//

import Foundation

struct CharacterInfoCollectionViewCellViewModel {
    private var characterInfo: AllCharacterResults
    private var episodeResults: EpisodeResults
    
    init(characterInfo: AllCharacterResults, episodeResults: EpisodeResults) {
        self.characterInfo = characterInfo
        self.episodeResults = episodeResults
    }
    
    public var getEpisodeName: String {
        return episodeResults.name
    }
    
    public var getName: String {
        return characterInfo.name
    }

    public var getStatus: String {
        return characterInfo.status
    }

    public var getLastKnownLocation: Location {
        return characterInfo.location ?? Location(name: "Unknown", url: "")
    }
    
    public var getEpisode: [String] {
        return characterInfo.episode
    }

    public var getCharacterImage: String {
        return characterInfo.image
    }
    
    public var getSpecies: String {
        return characterInfo.species
    }
    
//    public var getEpisode: String {
//        return episodeInfo.name
//    }
    
}
