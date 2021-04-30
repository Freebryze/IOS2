//
//  PaginatedElements.swift
//  RickAndMortyProject
//
//  Created by LPIEM on 24/02/2021.
//

import Foundation

struct PaginatedElements<Element: Decodable> {
    let information: PaginationInformation
    let decodedElements: [Element]
}

extension PaginatedElements: Decodable {
    enum CodingKeys: String, CodingKey {
        case information = "info"
        case decodedElements = "results"
    }
}

