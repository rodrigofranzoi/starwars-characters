//
//  DetailViewModel.swift
//  starwars-prozi
//
//  Created by Rodrigo Franzoi on 01/12/21.
//

import Foundation
import UIKit

protocol DetailViewModelDelegate {
    func reloadData()
}

class DetailViewModel {
    
    private let data: [DetailViewModel.Data]
    private let character: Character
    private let service: FilmService = FilmService()
    private var movieList: [DetailViewModel.Data]

    public var skinColor: UIColor {content[0][3].detail.color}
    public var title: String {character.name ?? "Character"}
    public let headers = ["Details", "Films"]
    public var content: [[DetailViewModel.Data]] { [data, movieList] }
    public var delegate: DetailViewModelDelegate?
    
    public var googleURL: String { "https://www.google.com/search?q=" + (character.name ?? "").replacingOccurrences(of: " ", with: "%20") }
    
    init(chatacter: Character, hometown: String) {
        self.character = chatacter
        self.data = [ .init(title: "Name", detail: chatacter.name ?? "Unknown"),
                      .init(title: "Gender", detail: chatacter.gender),
                      .init(title: "Hometown", detail: hometown),
                      .init(title: "Skin Color", detail: chatacter.skin_color ?? "Unknown")]
        self.movieList = []
        self.service.output = self
        for movie in chatacter.films {
            service.getFilm(url: movie)
        }
    }
    
    struct Data {
        let title: String
        let detail: String
        init(title: String, detail: String) {
            self.title = title
            self.detail = detail
        }
    }
}

extension DetailViewModel: FilmServiceOutput {
    func reloadData(film: Film) {
        self.movieList.append(.init(title: "Film:", detail: film.title))
        self.delegate?.reloadData()
    }

    func error() { }
}
