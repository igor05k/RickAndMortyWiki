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
    
    func fetchAllCharacters(completion: @escaping ([AllCharacterResults]) -> Void) {
        Service.getAllCharacters { result in
            switch result {
            case .success(let success):
                completion(success.results)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchCharactersById(id: Int, completion: @escaping (Result<AllCharacterResults, NetworkError>) -> Void) {
        Service.getCharactersById(id: id) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(.invalidData))
                print(failure)
            }
        }
    }
    
    func fetchEpisodeDetails(url: String, completion: @escaping (Result<EpisodeResults, NetworkError>) -> Void) {
        Service.getEpisodesDetails(url: url) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}

