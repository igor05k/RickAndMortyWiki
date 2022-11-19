//
//  DetailsViewModel.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 10/11/22.
//

import Foundation

final class ResidentsCollectionViewCellViewModel {
    private var allCharacters: AllCharacterResults
    
    init(allCharacters: AllCharacterResults) {
        self.allCharacters = allCharacters
    }
    
    public var getCharacterName: String {
        allCharacters.name
    }
    
    public var getCharacterStatus: String {
        allCharacters.status
    }
    
    public var getCharacterSpecies: String {
        allCharacters.species
    }
    
    public var getCharacterImage: String {
        allCharacters.image
    }
}
