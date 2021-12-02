//
//  Planet.swift
//  starwars-prozi
//
//  Created by Rodrigo Franzoi on 01/12/21.
//

import Foundation

struct Planet: Decodable {
    let name: String
    let rotation_period: String?
    let orbital_period: String?
    let diameter: String?
    let climate: String?
    let gravity: String?
    let terrain: String?
    let surface_water: String?
    let population: String?
}
