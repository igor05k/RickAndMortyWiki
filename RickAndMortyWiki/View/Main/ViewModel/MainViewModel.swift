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
    
    weak var delegate: MainViewModelProtocol?
    
    init(_ service: Service = Service()) {
        self.service = service
        fetchAllCharacters()
    }
    
    func fetchAllCharacters() {
        service.getAllCharacters { [weak self] result in
            self?.delegate?.startLoading()
            switch result {
            case .success(let success):
                // remove all items in order to populate again
                self?.firstSeenEpisode.removeAll()
                self?.characterLocationDetails.removeAll()
                
                // assign the result to a list
                self?.allCharacters = success.results
                
                // fetch additional data for the characters
                self?.fetchFirstSeenEpisode()
                self?.fetchLocationDetails()
                
                self?.delegate?.stopLoading()
            case .failure(let failure):
                print(failure)
            }
        }
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
//        charactersSearched.removeAll()
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
    
    func fetchFirstSeenEpisode() {
        for character in allCharacters {
            guard let firstEpisode = character.episode.first else { return }
            self.service.getEpisodesDetails(url: firstEpisode) { result in
                switch result {
                case .success(let episodesResults):
                    self.firstSeenEpisode.append(episodesResults)
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
    
    func fetchLocationDetails() {
        for episode in allCharacters {
            guard let location = episode.location else { return }
            self.service.getLocationBy(url: location.url) { result in
                switch result {
                case .success(let success):
                    self.characterLocationDetails.append(success)
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
    
    func search(name: String) {
        service.searchCharacter(by: name) { [weak self] result in
            switch result {
            case .success(let success):
                if let self {
                    self.charactersSearched = success.results
                    
                    for character in success.results {
                        guard let firstEpisode = character.episode.first else { return }
                        self.service.getEpisodesDetails(url: firstEpisode) { result in
                            switch result {
                            case .success(let episodesResults):
                                self.firstSeenEpisodeSearched.append(episodesResults)
                                print("EPISODE DETAILS: \(String(describing: self.firstSeenEpisodeSearched.count))")
                            case .failure(let failure):
                                print(failure)
                            }
                        }
                    }
                    
                    for episode in success.results {
                        guard let location = episode.location else { return }
                        self.service.getLocationBy(url: location.url) { result in
                            switch result {
                            case .success(let success):
                                self.characterLocationSearched.append(success)
                                print("LOCATION DETAILS \(String(describing: self.characterLocationSearched.count))")
                            case .failure(let failure):
                                print(failure)
                            }
                        }
                    }
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

