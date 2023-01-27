//
//  CoreDataStackProtocol.swift
//  sferaTest
//
//  Created by Иван on 26.12.22.
//

import Foundation

protocol CDStackProtocol {
    //MARK: - Character
    func update(with page: Int, where models: [Character],
                to action: PersistentState,
             and completion: @escaping (Result<PersistentState, Error>) -> Void)
    func fetchCharactersModels() -> [CharacterListItem]
    func fetchCharactersModels(with page: Int) -> [CharacterListItem]
    //func fetchCharactersModels(with params: CharacterURLParameters) -> [CharacterCDModel]
    func fetchCharactersModels(by urls: [String]) -> [CharacterListItem]
    //MARK: - Info
    func fetchInfoModels() -> [InfoItem]
}

enum PersistentState {
    case add, remove, update
}

enum PersistentInfo {
    case characters, locations, episodes
}

//enum PersistentConstants {
//    static let target = "TestTaskRickAndMorty"
//    static let infoModel = "InfoCDModel"
//    static let characterModel = "CharacterCDModel"
//    static let locationModel = "LocationCDModel"
//    static let episodeModel = "EpisodeCDModel"
//    static let characterFilterModel = "CharacterFilterCDModel"
//}
