//
//  Episode.swift
//  SampleApp
//
//  Created by Kalyan on 9/16/20.
//  Copyright © 2020 Kalyan. All rights reserved.
//

import Foundation

// MARK: - Episode
struct Episode: Codable {
    var info: Info?
    var results: [Result]?
}

// MARK: - Info
struct Info: Codable {
    var count, pages: Int?
    var next: String?
    var prev: String?
}

// MARK: - Result
struct Result: Codable {
    var id: Int?
    var name, airDate, episode: String?
    var characters: [String]?
    var url: String?
    var created: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}
