//
//  FilmServiceProtocols.swift
//  starwars-prozi
//
//  Created by Rodrigo Franzoi on 01/12/21.
//

import Foundation
import Alamofire

protocol FilmServiceInput: AnyObject {
    var output: FilmServiceOutput? { get set }
    func getFilm(url: String)
}

protocol FilmServiceOutput: AnyObject {
    func reloadData(film: Film)
    func error()
}

class FilmService: FilmServiceInput {
    
    weak var output: FilmServiceOutput?
    private let api =  RestManager.manager
    
    func getFilm(url: String) {
        guard let urlReq = URL(string: url) else { return }
        let req = URLRequest(url: urlReq, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 100)
        api.request(req).responseJSON { [output] request in
            switch request.result {
            case .success:
                do {
                    let film = try JSONDecoder().decode(Film.self, from: request.data!)
                    output?.reloadData(film: film)
                } catch {
                    output?.error()
                }
            case .failure:
                output?.error()
            }
        }
    }
}
