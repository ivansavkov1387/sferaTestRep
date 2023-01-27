//
//  CoreDataStack+CharactersLise.swift
//  sferaTest
//
//  Created by Иван on 26.12.22.
//

import Foundation
import CoreData

extension CDStack: CDStackProtocol {
    //MARK: - Character table
    func update(with page: Int, where models: [Character], to action: PersistentState, and completion: @escaping (Result<PersistentState, Error>) -> Void) {
        switch action  {
        case .add:
            backgroundViewContext.performAndWait {
                models.forEach {
                    ///updating
                    if let characters = try? self.fetchRequest(for: $0).execute().first {
                        characters.update(with: $0, and: page, isUpdatingPage: false)
                        ///adding
                    } else {
                        let characterCD = CharacterListItem(context: backgroundViewContext)
                        characterCD.configNew(with: $0, and: page)
                    }
                }
                saveContext()
            }
        case .update:
            break
        case .remove:
            break
        }
    }
    
    func fetchCharactersModels() -> [CharacterListItem] {
        let request: NSFetchRequest<CharacterListItem> = CharacterListItem.fetchRequest()
        request.returnsObjectsAsFaults = false
        let sort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sort]
        let table = try? mainViewContext.fetch(request)
        guard let tablе = table else { return [CharacterListItem]() }
        return tablе
    }
    
    func fetchCharactersModels(with page: Int) -> [CharacterListItem] {
        let request: NSFetchRequest<CharacterListItem> = CharacterListItem.fetchRequest()
        let sort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sort]
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "page == %i", page)
        let table = try? mainViewContext.fetch(request)
        guard let tablе = table else { return [CharacterListItem]() }
        return tablе
    }
    
    func fetchCharactersModels(by urls: [String]) -> [CharacterListItem] {
        let request: NSFetchRequest<CharacterListItem> = CharacterListItem.fetchRequest()
        let sort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sort]
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "url IN %@", urls)
        let table = try? mainViewContext.fetch(request)
        guard let tablе = table else { return [CharacterListItem]() }
        return tablе
    }
    
    func fetchInfoModels() -> [InfoItem] {
        let request: NSFetchRequest<InfoItem> = InfoItem.fetchRequest()
        request.returnsObjectsAsFaults = false
        let table = try? mainViewContext.fetch(request)
        guard let tablе = table else { return [InfoItem]() }
        return tablе
    }

}

private extension CDStack {
    func fetchRequest(for character: Character) -> NSFetchRequest<CharacterListItem> {
        let request: NSFetchRequest<CharacterListItem> = CharacterListItem.fetchRequest()
        request.predicate = .init(format: "id == %i", character.id)
        return request
    }
}

fileprivate extension CharacterListItem {
    func update(with character: Character, and characterPage: Int, isUpdatingPage: Bool) {
        var originDict: [String: String] = [:]
        var locationDict: [String: String] = [:]
        
        if isUpdatingPage {
            let page = Int64(characterPage)
        }
        
        name = character.name
        status = character.status.lowercased().capitalized
        species = character.species
        type = character.type
        gender = character.gender.lowercased().capitalized
        
        originDict[character.origin.name] = character.origin.url
        origin = originDict
        
        locationDict[character.location.name] = character.location.url
        location = locationDict
        
        image = character.image
        episode = character.episode
        created = character.created
        url = character.url
    }
        
    func configNew(with character: Character, and characterPage: Int) {
        id = Int64(character.id)
        update(with: character, and: characterPage, isUpdatingPage: true)
    }
}



