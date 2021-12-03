//
//  RestManager.swift
//  starwars-prozi
//
//  Created by Rodrigo Franzoi on 30/11/21.
//

import Alamofire
import Foundation

class RestManager {
    
    static let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    static let baseUrl = "https://swapi.dev/api/"
    
    
    // We neet to fetch the species language, then fetch the avatar
    static func getLanguageImage(url: String?, response: @escaping (CompletionStatus<Data>)->()) {
        guard let url = url else {
            getUserImg() { status in
                switch status {
                case .succeeded(let data):
                    response(.succeeded(data))
                case .failed:
                    response(.failed)
                }
            }
            return
        }
        guard let urlReq = URL(string: url) else { return }
        let req = URLRequest(url: urlReq, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 100)
        manager.request(req).responseJSON { (request) in
            switch request.result {
            case .success:
                do {
                    let species = try JSONDecoder().decode(Species.self, from: request.data!)
                    getUserImg(initials: species.language.initials()) { status in
                        switch status {
                        case .succeeded(let data):
                            response(.succeeded(data))
                        case .failed:
                            response(.failed)
                        }
                    }
                } catch {
                    response(.failed)
                }
            case .failure:
                response(.failed)
            }
        }
    }
    
    //Return an Avatar and save url data in cache
    static func getUserImg(initials: String = "un", completion: @escaping (CompletionStatus<Data>)->()) {
        let url = "https://eu.ui-avatars.com/api/?size=48&name=".appending(initials)
        guard let urlReq = URL(string: url) else { return }
        //caching the request
        let req = URLRequest(url: urlReq, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 100)
        manager.request(req).responseData { response in
            switch response.result {
            case .success(let data):
                completion(.succeeded(data))
            case .failure:
                completion(.failed)
            }
        }
    }
}
