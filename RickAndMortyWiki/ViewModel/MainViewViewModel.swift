//
//  MainViewViewModel.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 04/11/22.
//

import Foundation

class MainViewViewModel {
    private var allCharacters: Character?
    private var allEpisodes: EpisodeResults?
    
    public var getCharacters: Character? {
        return allCharacters ?? nil
    }
    
    func fetchAllCharacters(completion: @escaping ([CharacterResults]) -> Void) {
        Service.getAllCharacters { result in
            switch result {
            case .success(let success):
                completion(success.results)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

