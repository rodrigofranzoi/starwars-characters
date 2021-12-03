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
    let gender: String
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
    
    init(charData: CharacterData) {
        self.birth_year = charData.birth_year
        self.created = charData.created
        self.edited = charData.edited
        self.eye_color = charData.eye_color
        self.gender = charData.gender ?? ""
        self.hair_color = charData.hair_color
        self.height = charData.height
        self.homeworld = charData.homeworld ?? ""
        self.mass = charData.mass
        self.name = charData.name
        self.skin_color = charData.skin_color
        self.url = charData.url
        self.vehicles = []
        self.starships = []
        self.species = []
        self.films = []
    }
    
}
