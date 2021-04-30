//
//  SerieCharacter.swift
//  RickAndMortyProject
//
//  Created by LPIEM on 24/02/2021.
//

import Foundation

struct SerieCharacter: Hashable {
    let identifier: Int
    let name: String
    let imageURL: URL
    let createdDate: Date
    let species: String
}

extension SerieCharacter: Decodable {
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name = "name"
        case imageURL = "image"
        case createdDate = "created"
        case species = "species"
    }
}
