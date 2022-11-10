//
//  DetailsViewModel.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 10/11/22.
//

import Foundation

final class DetailsViewModel {
    private var characterSelected: [AllCharacterResults] = [AllCharacterResults]()
    private var locationDetailsArray: [LocationDetails] = [LocationDetails]()
    private var episodeDetails: [EpisodeResults] = [EpisodeResults]()
    
    
    
    public func configure(with model: AllCharacterResults) {
        self.characterSelected = [model]
    }

    public func configureLocations(with model: LocationDetails) {
        self.locationDetailsArray = [model]
    }

    public func configureEpisodeDetails(with model: EpisodeResults) {
        self.episodeDetails = [model]
    }
}
