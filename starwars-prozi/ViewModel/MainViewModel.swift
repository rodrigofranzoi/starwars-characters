//
//  MainViewModel.swift
//  starwars-prozi
//
//  Created by Rodrigo Franzoi on 01/12/21.
//

import Foundation
import UIKit

protocol MainViewDelegate {
    func reloadTable()
    func addCharacter(character: Character)
    func goToDetail(character: Character, hometown: String)
}

class MainViewModel {
    
    public var delegate: MainViewDelegate?
    public var characters: [Character] = []
    
    let characterService = CharactersService()
    let planetService = PlanetService()
    
    private var selectedIndex: Int?
    
    init() {
        characterService.output = self
        planetService.output = self
    }
    
    func loadData() {
        characterService.getNextPage()
    }
    
    func cellClicked(atIndex index: Int) {
        selectedIndex = index
        planetService.getPlanet(url: characters[index].homeworld)
    }
    
}

extension MainViewModel: CharactersServiceOutput {
    
    func reloadData(list: [Character]) {
        characters = list
        delegate?.reloadTable()
    }
    
    func addCharacter(character: Character) {
        characters.append(character)
        delegate?.addCharacter(character: character)
    }
    
    func error() {
        
    }
}

extension MainViewModel: PlanetServiceOutput {
    func response(planet: Planet) {
        guard let index = selectedIndex else { return }
        delegate?.goToDetail(character: characters[index], hometown: planet.name)
        selectedIndex = nil
    }
}
