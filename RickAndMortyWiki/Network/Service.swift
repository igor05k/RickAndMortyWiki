//
//  Service.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 03/11/22.
//

import Foundation

enum Endpoints: String {
    case characters = "/character"
    case episode = "/episode"
    case location = "/location"
}

enum NetworkError: Error {
    case decoding
    case invalidData
}

struct ConstanstsAPI {
    static let base_url = "https://rickandmortyapi.com/api"
}

class Service {
    static func getAllCharacters(completion: @escaping (Result<Character, NetworkError>) -> Void) {
        guard let url = URL(string: ConstanstsAPI.base_url + Endpoints.characters.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            DispatchQueue.main.async {
                do {
                    let json = try JSONDecoder().decode(Character.self, from: data)
                    completion(.success(json))
                } catch {
                    completion(.failure(.decoding))
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    static func getFirstCharacterEpisode(completion: @escaping (Result<[String], NetworkError>) -> Void) {
        getAllCharacters { result in
            switch result {
            case .success(let success):
                completion(.success(success.results[0].episode))
            case .failure(let failure):
                print(failure)
                completion(.failure(.decoding))
            }
        }
    }
    
    static func getEpisodesDetails(url: String, completion: @escaping (Result<EpisodeResults, NetworkError>) -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                do {
                    let json = try JSONDecoder().decode(EpisodeResults.self, from: data)
                    completion(.success(json))
                } catch {
                    completion(.failure(.decoding))
                    print(error)
                }
            }
        }.resume()
    }
}
