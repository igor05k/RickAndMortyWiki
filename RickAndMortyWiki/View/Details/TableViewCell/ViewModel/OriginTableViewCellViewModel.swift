//
//  OriginTableViewCellViewModel.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 04/11/22.
//

import Foundation


class OriginTableViewCellViewModel {
    var model: LocationDetails
    
    init(model: LocationDetails) {
        self.model = model
    }
    
    public var getPlanetName: String {
        return model.name
    }
    
    public var getTypeName: String {
        return model.type
    }
    
    public var getDimensionName: String {
        return model.dimension
    }
    
}
