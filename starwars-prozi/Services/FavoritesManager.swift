//
//  FavoritesManager.swift
//  starwars-prozi
//
//  Created by Rodrigo Franzoi on 02/12/21.
//

import Foundation
import CoreData
import UIKit

class FavoritesManager {
    
    private let key = "favorites"
    static let shared = FavoritesManager()
    
    var favorites: [String]? {  UserDefaults.standard.value(forKey: key) as? [String] }
    
    private lazy var userEntity: NSEntityDescription = {
        let managedContext = getContext()
        return NSEntityDescription.entity(forEntityName: "Character", in: managedContext!)!
    }()
    
    func addFavorite(url: String) {
        let favorites = favorites ?? []
        var newFav = favorites
        if newFav.contains(url) == false {
            newFav.append(url)
            UserDefaults.standard.set(newFav, forKey: key)
        }
    }
    
    func removeFavorite(url: String) {
        guard let favorites = favorites else { return }
        var newFav = favorites
        if let index = newFav.firstIndex(of: url) {
            newFav.remove(at: index)
            UserDefaults.standard.set(newFav, forKey: key)
        }
    }
    
    func isFavorited(url: String) -> Bool {
        guard let favorites = favorites else { return false}
        return favorites.contains(url)
    }
    
    private func getContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.persistentContainer.viewContext
    }
    
    func retrieveCharacters() -> [CharacterData] {
        var characterList: [CharacterData] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CharacterData")
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results
            {
                let char = result as! CharacterData
                characterList.append(char)
            }
        } catch {
            print("Fetch Failed")
        }
        return characterList
    }
    
    func saveCharacter(_ char: Character) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "CharacterData", in: context) else {return}
        let newChar = CharacterData(entity: entity, insertInto: context)
        newChar.url = char.url
        newChar.name = char.name
        do
        {
            try context.save()
        }
        catch
        {
            print("context save error")
        }
    
    }
    
}
