//
//  Character.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 03/11/22.
//

import Foundation

struct Character: Codable {
    let results: [AllCharacterResults]
}

struct AllCharacterResults: Codable {
    let id: Int
    let name, status, species: String
    let type: String?
    let gender: String
    let origin, location: Location?
    let image: String
    let episode: [String]
    let url: String?
    let created: String
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}
