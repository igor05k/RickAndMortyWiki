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
    case invalidUrl
}

struct ConstanstsAPI {
    static let base_url = "https://rickandmortyapi.com/api"
}

class Service {
    func getAllCharacters(completion: @escaping (Result<Character, NetworkError>) -> Void) {
        guard let url = URL(string: ConstanstsAPI.base_url + Endpoints.characters.rawValue + "/?page=" + String(Int.random(in: 1...42))) else { return }
//        guard let url = URL(string: ConstanstsAPI.base_url + Endpoints.characters.rawValue + "/?page=41") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let json = try JSONDecoder().decode(Character.self, from: data)
                completion(.success(json))
            } catch {
                completion(.failure(.decoding))
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getCharactersById(id: Int, completion: @escaping (Result<AllCharacterResults, NetworkError>) -> Void) {
        guard let url = URL(string: ConstanstsAPI.base_url + Endpoints.characters.rawValue + "/" + String(id)) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                do {
                    let json = try JSONDecoder().decode(AllCharacterResults.self, from: data)
                    completion(.success(json))
                } catch {
                    completion(.failure(.decoding))
                    print(error)
                }
            }
        }.resume()
    }
    
    func getSpecificCharacterBy(url: String, completion: @escaping (Result<AllCharacterResults, NetworkError>) -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
                do {
                    let json = try JSONDecoder().decode(AllCharacterResults.self, from: data)
                    completion(.success(json))
                } catch {
                    completion(.failure(.decoding))
                    print("getSpecificCharacterBy ======== ", error)
                }
        }.resume()
    }

    
    func getEpisodesDetails(url: String, completion: @escaping (Result<EpisodeResults, NetworkError>) -> Void) {
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
    
    func getLocationBy(url: String, completion: @escaping (Result<LocationDetails, NetworkError>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let json = try JSONDecoder().decode(LocationDetails.self, from: data)
                completion(.success(json))
            } catch {
                completion(.failure(.decoding))
            }
        }.resume()
    }
}
