//
//  Character.swift
//  SampleApp
//
//  Created by Kalyan on 9/16/20.
//  Copyright © 2020 Kalyan. All rights reserved.
//

import Foundation

// MARK: - Character
struct Character: Codable {
    var id: Int?
    var name, status, species, type: String?
    var gender: String?
    var origin, location: Location?
    var image: String?
    var episode: [String]?
    var url: String?
    var created: String?
}

// MARK: - Location
struct Location: Codable {
    var name: String?
    var url: String?
}
