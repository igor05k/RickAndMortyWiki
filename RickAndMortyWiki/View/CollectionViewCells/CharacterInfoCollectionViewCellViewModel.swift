//
//  CharacterInfoCollectionViewCellViewModel.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 03/11/22.
//

import Foundation

struct CharacterInfoCollectionViewCellViewModel {
    private var characterInfo: Results
    
    init(characterInfo: Results) {
        self.characterInfo = characterInfo
    }
    
    public var name: String {
        return characterInfo.name
    }
    
    public var status: String {
        return characterInfo.status
    }
    
    public var lastKnownLocation: Location {
        return characterInfo.location ?? Location(name: "Unknown", url: "")
    }
    
    public var episode: [String] {
        return characterInfo.episode
    }
    
    public var characterImage: String {
        return characterInfo.image
    }
    
    
    /*
     let id: Int
     let name, status, species, type: String
     let gender: String
     let origin, location: Location?
     let image: String
     let episode: [String]
     let url: String
     let created: String
     */
    
}
