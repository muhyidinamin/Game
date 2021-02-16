//
//  File.swift
//  
//
//  Created by Muhamad Muhyidin Amin on 14/02/21.
//

import Core
import Genre
import Combine
import RealmSwift
import Foundation

public struct GetSearchGamesLocaleDataSource: LocaleDataSource {
  public typealias Request = String
  public typealias Response = GameEntity

  private let _realm: Realm

  public init(realm: Realm) {
      _realm = realm
  }
    
  public func list(request: String?) -> AnyPublisher<[GameEntity], Error> {
    return Future<[GameEntity], Error> { completion in
      guard let request = request else { return completion(.failure(DatabaseError.requestFailed)) }

      let games: Results<GameEntity> = {
        self._realm.objects(GameEntity.self).filter("title contains[c] %@", request)
        .sorted(byKeyPath: "title", ascending: true)
      }()
      
      completion(.success(games.toArray(ofType: GameEntity.self)))
      
    }.eraseToAnyPublisher()
  }
    
  public func add(entities: [GameEntity]) -> AnyPublisher<Bool, Error> {
      return Future<Bool, Error> { completion in
          do {
            try self._realm.write {
                  for game in entities {
                    if let gameEntity = self._realm.object(ofType: GameEntity.self, forPrimaryKey: game.id) {
                      if gameEntity.id == game.id {
                        game.favorite = gameEntity.favorite
                        self._realm.add(game, update: .all)
                      } else {
                        self._realm.add(game, update: .all)
                      }
                    } else {
                      self._realm.add(game, update: .all)
                    }
                  }
                  completion(.success(true))
              }
          } catch {
              completion(.failure(DatabaseError.requestFailed))
          }
          
      }.eraseToAnyPublisher()
  }
  
  public func get(id: Int) -> AnyPublisher<GameEntity, Error> {
    return Future<GameEntity, Error> { completion in
      let games: Results<GameEntity> = {
        self._realm.objects(GameEntity.self)
          .filter("id = \(id)")
      }()
      
      guard let game = games.first else {
        completion(.failure(DatabaseError.requestFailed))
        return
      }
      
      completion(.success(game))
    }.eraseToAnyPublisher()
  }
  
  public func update(id: Int, entity: GameEntity) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let gameEntity = {
        self._realm.objects(GameEntity.self).filter("id = \(id)")
        }().first {
          do {
            try self._realm.write {
              gameEntity.setValue(entity.alternativeNames, forKey: "alternativeNames")
              gameEntity.setValue(entity.website, forKey: "website")
              gameEntity.setValue(entity.developers, forKey: "developers")
              gameEntity.setValue(entity.publishers, forKey: "publishers")
              gameEntity.setValue(entity.desc, forKey: "desc")
              gameEntity.setValue(entity.favorite, forKey: "favorite")
            }
            completion(.success(true))

          } catch {
            completion(.failure(DatabaseError.requestFailed))
          }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
}
