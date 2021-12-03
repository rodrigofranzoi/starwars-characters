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
    
    public let title = "Characters"
    public var delegate: MainViewDelegate?
    public var characters: [Character] = []
    
    private let characterService = CharactersService()
    private let planetService = PlanetService()
    private let favoritesManager = FavoritesManager.shared
    
    private var offlineMode: Bool = false
    
    private var selectedIndex: Int?
    
    init() {
        characterService.output = self
        planetService.output = self
    }
    
    func loadData() {
        if offlineMode { return }
        characterService.getNextPage()
    }
    
    func cellClicked(atIndex index: Int) {
        selectedIndex = index
        planetService.getPlanet(url: characters[index].homeworld)
    }
    
    func favorited(at index: Int) {
        guard let url = characters[index].url else { return }
        if (favoritesManager.isFavorited(url: url) == false) {
            favoritesManager.addFavorite(url: url)
            favoritesManager.saveCharacter(characters[index])
        } else {
            favoritesManager.removeFavorite(url: url)
            favoritesManager.deleteFavorites(char: characters[index])
        }
        if offlineMode {
            characters = getDataFromDb()
            delegate?.reloadTable()
        }
    }
    
    func getDataFromDb() -> [Character] {
        var char: [Character] = []
        for c in favoritesManager.retrieveCharacters() {
            if c.del == false {
                char.append(Character(charData: c))
            }
        }
        return char
    }
    
    func buttonForIndex(index: Int) -> String {
        guard let url = characters[index].url else { return "Favorite" }
        return favoritesManager.isFavorited(url: url) ? "Remove Favorite" : "Favorite"
    }
    
    func isFavorited(index: Int) -> Bool {
        guard let url = characters[index].url else { return false }
        return favoritesManager.isFavorited(url: url)
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
        offlineMode = true
        characters = getDataFromDb()
        delegate?.reloadTable()
    }
}

extension MainViewModel: PlanetServiceOutput {
    func response(planet: Planet) {
        guard let index = selectedIndex else { return }
        delegate?.goToDetail(character: characters[index], hometown: planet.name)
        selectedIndex = nil
    }
}
