//
//  Episodes.swift
//  RickAndMortyWiki
//
//  Created by Igor Fernandes on 03/11/22.
//

import Foundation

// MARK: - Result
struct EpisodeResults: Codable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}
