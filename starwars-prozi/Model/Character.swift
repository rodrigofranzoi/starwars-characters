//
//  Character.swift
//  starwars-prozi
//
//  Created by Rodrigo Franzoi on 30/11/21.
//

import Foundation

struct Character: Decodable {
    let birth_year: String?
    let created: String?
    let edited: String?
    let eye_color: String?
    let films: [String]
    let gender: String?
    let hair_color: String?
    let height: String?
    let homeworld: String
    let mass: String?
    let name: String?
    let skin_color: String?
    let species: [String]?
    let starships: [String]?
    let url: String?
    let vehicles: [String]?
}
