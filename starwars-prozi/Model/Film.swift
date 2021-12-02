//
//  Film.swift
//  starwars-prozi
//
//  Created by Rodrigo Franzoi on 01/12/21.
//

import Foundation

struct Film: Decodable {
    let title: String
    let episode_id: Int
    let opening_crawl: String
    let director: String
    let producer: String
    let release_date: String
}
