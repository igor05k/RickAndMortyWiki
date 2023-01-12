//
//  MainViewViewModel.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 04/11/22.
//

import Foundation

protocol MainViewModelProtocol: AnyObject {
    func startLoading()
    func stopLoading()
    func success()
    func error(details: String)
}

final class MainViewModel {
    private var allCharacters: [CharacterResults] = [CharacterResults]()
    private var firstSeenEpisode: [EpisodeResults] = [EpisodeResults]()
    private var characterLocationDetails: [LocationDetails] = [LocationDetails]()
    
    // empty array so the results shows correctly
    var charactersSearched: [CharacterResults] = [CharacterResults]()
    var firstSeenEpisodeSearched: [EpisodeResults] = [EpisodeResults]()
    var characterLocationSearched: [LocationDetails] = [LocationDetails]()
    
    private var service: Service
    
    private var successfulRequests = 0
    
    weak var delegate: MainViewModelProtocol?
    
    init(_ service: Service = Service()) {
        self.service = service
        fetchData {
            self.delegate?.success()
        }
    }
    
    func fetchData(completion: @escaping () -> Void) {
        fetchAllCharacters {
            self.fetchFirstSeenEpisode {
                if !self.firstSeenEpisode.isEmpty {
                    self.successfulRequests += 1
                    if self.successfulRequests == 2 {
                        completion()
                    }
                }
            }
            
            self.fetchLocationDetails {
                if !self.characterLocationDetails.isEmpty {
                    self.successfulRequests += 1
                    if self.successfulRequests == 2 {
                        completion()
                    }
                }
            }
        }
    }
    
    func fetchAllCharacters(completion: @escaping () -> Void) {
        service.getAllCharacters { [weak self] result in
            switch result {
            case .success(let success):
                self?.allCharacters = success.results
                completion()
            case .failure(let failure):
                self?.delegate?.error(details: failure.localizedDescription)
                print(failure)
            }
        }
    }
    
    func fetchFirstSeenEpisode(completion: @escaping () -> Void) {
        for character in allCharacters {
            guard let firstEpisode = character.episode.first else { return }
            self.service.getEpisodesDetails(url: firstEpisode) { result in
                switch result {
                case .success(let episodesResults):
                    self.firstSeenEpisode.append(episodesResults)
                    completion()
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
    
    func fetchLocationDetails(completion: @escaping () -> Void) {
        for episode in allCharacters {
            guard let location = episode.location else { return }
            self.service.getLocationBy(url: location.url) { result in
                switch result {
                case .success(let success):
                    self.characterLocationDetails.append(success)
                    completion()
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
    
    func removeAllCharacters() {
        self.firstSeenEpisode.removeAll()
        self.characterLocationDetails.removeAll()
    }

    public var isCharacterArrayEmpty: Bool {
        return allCharacters.isEmpty
    }

    public var isFirstSeenEpisodeEmpty: Bool {
        return firstSeenEpisode.isEmpty
    }

    public var getCharactersSearched: [CharacterResults] {
        return charactersSearched
    }

    public var getFirstSeenEpisodeSearched: [EpisodeResults] {
        return firstSeenEpisodeSearched
    }

    public var getCharacterLocationSearched: [LocationDetails] {
        return characterLocationSearched
    }

    func cleanAllArraysAfterSearch() {
        firstSeenEpisodeSearched.removeAll()
        characterLocationSearched.removeAll()
    }

    // get number of items
    public var numberOfCharacters: Int {
        return allCharacters.count
    }

    public var numberOfFirstSeenEpisodes: Int {
        return firstSeenEpisode.count
    }

    public var numberOfCharacterLocationDetails: Int {
        return characterLocationDetails.count
    }

    // fetch items
    func currentCharacter(indexPath: IndexPath) -> CharacterResults {
        return allCharacters[indexPath.row]
    }

    func currentFirstSeenEpisode(indexPath: IndexPath) -> EpisodeResults {
        return firstSeenEpisode[indexPath.row]
    }

    func currentCharacterLocationDetails(indexPath: IndexPath) -> LocationDetails {
        return characterLocationDetails[indexPath.row]
    }


    // SEARCH
    func currentCharactersSearched(indexPath: IndexPath) -> CharacterResults {
        return charactersSearched[indexPath.row]
    }

    func currentFirstSeenEpisodeSearched(indexPath: IndexPath) -> EpisodeResults {
        return firstSeenEpisodeSearched[indexPath.row]
    }

    func currentCharacterLocationSearched(indexPath: IndexPath) -> LocationDetails {
        return characterLocationSearched[indexPath.row]
    }
    
    /// fetch character location if it exists.
    func filterLocationDetails(character: CharacterResults) -> LocationDetails? {
        guard let location = character.location else { return nil }
        return characterLocationDetails.filter({ $0.name == location.name }).first(where: { $0.name == location.name })
    }
}
