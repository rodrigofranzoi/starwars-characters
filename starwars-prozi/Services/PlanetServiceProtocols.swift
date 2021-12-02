//
//  PlanetServiceProtocols.swift
//  starwars-prozi
//
//  Created by Rodrigo Franzoi on 01/12/21.
//

import Foundation

import Alamofire

protocol PlanetServiceInput: AnyObject {
    var output: PlanetServiceOutput? { get set }
    func getPlanet(url: String)
}

protocol PlanetServiceOutput: AnyObject {
    func response(planet: Planet)
    func error()
}

class PlanetService: PlanetServiceInput {
  
    weak var output: PlanetServiceOutput?
    private let api =  RestManager.manager
    public var isFetching: Bool = false
    
    func getPlanet(url: String) {
        if isFetching { return }
        guard let urlReq = URL(string: url) else { return }
        let req = URLRequest(url: urlReq, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 100)
        self.isFetching = true
        api.request(req).responseJSON { [output] (request) in
            self.isFetching = false
            switch request.result {
            case .success:
                do {
                    let planet = try JSONDecoder().decode(Planet.self, from: request.data!)
                    output?.response(planet: planet)
                } catch {
                    output?.error()
                }
            case .failure:
                output?.error()
            }
        }
    }
}
