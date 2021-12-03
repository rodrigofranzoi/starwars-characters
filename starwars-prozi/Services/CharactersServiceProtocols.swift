//
//  CharactersServiceProtocols.swift
//  starwars-prozi
//
//  Created by Rodrigo Franzoi on 01/12/21.
//

import Foundation
import Alamofire

protocol CharactersServiceInput: AnyObject {
    var output: CharactersServiceOutput? { get set }
    func getNextPage()
}

protocol CharactersServiceOutput: AnyObject {
    func reloadData(list: [Character])
    func addCharacter(character: Character)
    func error()
}

class CharactersService: CharactersServiceInput {
  
    weak var output: CharactersServiceOutput?
    private let api =  RestManager.manager
    private var pageIndex: Int
    
    private var isFetching: Bool = false
    private var stopFetching: Bool { pageIndex >= 9}
    
    init() {
        pageIndex = 1
    }
    
    func getNextPage() {
        if isFetching == false && stopFetching == false {
            getCharactesList(index: pageIndex)
        }
    }
    
    private func getCharactesList(index: Int){
        let getCaractersUrl = RestManager.baseUrl
                                .appending("/people/")
                                .appending("?page=\(index)")
        self.isFetching = true
        api.request(getCaractersUrl, method: .get, parameters: nil).responseJSON { [output] (request) in
            self.isFetching = false
            switch request.result {
            case .success:
                do {
                    let charList = try JSONDecoder().decode(CharacterList.self, from: request.data!)
                    self.pageIndex += 1
                    if (index == 1) {
                        output?.reloadData(list: charList.results)
                    } else {
                        _ = charList.results.map { output?.addCharacter(character: $0)}
                    }
                } catch {
                    self.pageIndex -= 1
                    output?.error()
                }
            case .failure:
                self.pageIndex -= 1
                output?.error()
            }
        }
    }
}
