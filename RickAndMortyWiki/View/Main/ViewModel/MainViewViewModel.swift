//
//  MainViewViewModel.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 04/11/22.
//

import Foundation
import Combine

final class MainViewViewModel {
    var allCharacters: [AllCharacterResults] = [AllCharacterResults]()
    var firstSeenEpisode: ((EpisodeResults) -> Void)?
    
    private var service: Service
    
    init(_ service: Service = Service()) {
        self.service = service
        fetchAllCharacters()
    }
    
    func fetchAllCharacters() {
        service.getAllCharacters { result in
            switch result {
            case .success(let success):
                self.allCharacters = success.results
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchEpDetails(index: Int) {
        service.getEpisodesDetails(url: allCharacters[index].episode[0]) { result in
            switch result {
            case .success(let episodeResults):
                self.firstSeenEpisode?(episodeResults)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
//    func fetchAllCharacters2() {
//        service.getAllCharacters { [weak self] result in
//            switch result {
//            case .success(let success):
//                self?.allCharacters = success.results
//                self?.service.getEpisodesDetails(url: success.results[0].episode[0]) { result in
//                    switch result {
//                    case .success(let success):
//                        self?.firstSeenEpisode = [success]
//                        print(success)
//                    case .failure(let failure):
//                        print(failure)
//                    }
//                }
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//    }
    
//    func fetchEpisodeDetails(index: Int) {
//        service.getAllCharacters { [weak self] result in
//            switch result {
//            case .success(let success):
//                self?.service.getEpisodesDetails(url: success.results[0].episode[index]) { result in
//                    switch result {
//                    case .success(let success):
//                        DispatchQueue.main.async {
//                            self?.firstSeenEpisode = [success]
//                            print(success)
//                        }
//                    case .failure(let failure):
//                        print(failure)
//                    }
//                }
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//    }
    
    //        viewModel.fetchAllCharacters { results in
    //            switch results {
    //            case .success(let characterResults):
    //                self.viewModel.fetchEpisodeDetails(indexPath: indexPath) { result in
    //                    switch result {
    //                    case .success(let episodeDetails):
    //                        DispatchQueue.main.async {
    //                            self.allCharacters = characterResults
    //                            self.allEpisodes = [episodeDetails]
    //                            cell.configure(characterInfo: self.allCharacters[indexPath.row],
    //                                           epName: self.allEpisodes[0])
    //                        }
    //                    case .failure(let failure):
    //                        print(failure)
    //                    }
    //                }
    //            case .failure(let failure):
    //                print(failure)
    //            }
    //        }
    
    /*
     let service = Service()
     service.getEpisodesDetails(url: viewModel.allCharacters[indexPath.row].episode[0]) { result in
         switch result {
         case .success(let success):
             print(success)
         case .failure(let failure):
             print(failure)
         }
     }
     */
    
//    func fetchEpDetails(index: Int) {
//        service.getAllCharacters { result in
//            switch result {
//            case .success(_):
//                self.service.getEpisodesDetails(url: self.allCharacters[index].episode[0]) { result in
//                    switch result {
//                    case .success(let episodeResults):
//                        self.firstSeenEpisode = episodeResults
//                        print(self.firstSeenEpisode)
//                    case .failure(let failure):
//                        print(failure)
//                    }
//                }
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//    }
    
//    func fetchEpisodeDetails() {
//        service.getAllCharacters { [weak self] result in
//            switch result {
//            case .success(let success):
//                self?.service.getEpisodesDetails(url: success.results[0].episode[0]) { result in
//                    switch result {
//                    case .success(let success):
//                        self?.firstSeenEpisode = success
//                        print(success)
//                    case .failure(let failure):
//                        print(failure)
//                    }
//                }
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//    }
    
//    func fetchEpisodeDetails(indexPath: IndexPath, completion: @escaping (Result<EpisodeResults, NetworkError>) -> Void) {
//        service.getAllCharacters { result in
//            switch result {
//            case .success(let character):
//                self.service.getEpisodesDetails(url: character.results[indexPath.row].episode[0]) { result in
//                    switch result {
//                    case .success(let episodeResult):
//                        self.allEpisodes = episodeResult
//                        completion(.success(episodeResult))
//                    case .failure(let failure):
//                        print(failure)
//                    }
//                }
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//    }
    
    //    func fetchCharactersById(id: Int, completion: @escaping (Result<AllCharacterResults, NetworkError>) -> Void) {
    //        service.getAllCharacters { result in
    //            switch result {
    //            case .success(let character):
    //                self.service.getCharactersById(id: id) { result in
    //                    switch result {
    //                    case .success(let allCharacterResults):
    //                        completion(.success(success))
    //                    case .failure(let failure):
    //                        completion(.failure(.invalidData))
    //                        print(failure)
    //                    }
    //                }
    //            case .failure(let failure):
    //                print(failure)
    //            }
    //        }
    //    }
    
    //    func fetchCharactersById(id: Int, completion: @escaping (Result<AllCharacterResults, NetworkError>) -> Void) {
    //        service.getCharactersById(id: id) { result in
    //            switch result {
    //            case .success(let success):
    //                completion(.success(success))
    //            case .failure(let failure):
    //                completion(.failure(.invalidData))
    //                print(failure)
    //            }
    //        }
    //    }
    
    //    func fetchEpisodeDetails(url: String, completion: @escaping (Result<EpisodeResults, NetworkError>) -> Void) {
    //        service.getEpisodesDetails(url: url) { result in
    //            switch result {
    //            case .success(let success):
    //                completion(.success(success))
    //            case .failure(let failure):
    //                completion(.failure(failure))
    //            }
    //        }
    //    }
}

