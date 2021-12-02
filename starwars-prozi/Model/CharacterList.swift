//
//  CharacterList.swift
//  starwars-prozi
//
//  Created by Rodrigo Franzoi on 01/12/21.
//

import Foundation

struct CharacterList: Decodable {
    let count: Int
    let next: String
    let previous: String?
    let results: [Character]
}
