//
//  File.swift
//  
//
//  Created by Muhamad Muhyidin Amin on 14/02/21.
//

import Core
import Genre
import RealmSwift

public struct GameTransformer<GenreMapper: Mapper>: Mapper
where
GenreMapper.Request == String,
GenreMapper.Response == [GenreResponse],
GenreMapper.Entity == [GenreEntity],
GenreMapper.Domain == [GenreModel] {
  
  public typealias Request = String
  public typealias Response = GameResponse
  public typealias Entity = GameEntity
  public typealias Domain = GameModel
      
  
  private let _genreMapper: GenreMapper
  
  public init(genreMapper: GenreMapper) {
      _genreMapper = genreMapper
  }
    
  public func transformResponseToEntity(request: String?, response: GameResponse) -> GameEntity {
    print(response)
    
    let genres = _genreMapper.mapGanreResponsesToListEntities(input: response.genres ?? [])
    let alternativeNames = mapGameResponseToListName(input: response.alternativeNames ?? [])
    let platforms = mapGameResponseToListPlatform(input: response.platforms ?? [])
    let developers = mapGameResponseToListDeveloper(input: response.developers ?? [])
    let parentPlatforms = mapGameResponseToListParentPlatformSlug(input: response.parentPlatforms ?? [])
    let publishers = mapGameResponseToListPublisher(input: response.publishers ?? [])
    
    let gameEntity = GameEntity()
    gameEntity.id = response.id ?? 0
    gameEntity.title = response.title ?? "Unknow"
    gameEntity.image = response.image ?? "Unknow"
    gameEntity.desc = response.desc ?? "Unknow"
    gameEntity.metacritic = response.metacritic ?? 0
    gameEntity.released = response.released ?? "Unknow"
    gameEntity.website = response.website ?? "Unknow"
    gameEntity.rating = response.rating ?? 0.0
    gameEntity.genres = genres
    gameEntity.alternativeNames = alternativeNames
    gameEntity.platforms = platforms
    gameEntity.parentPlatforms = parentPlatforms
    gameEntity.developers = developers
    gameEntity.publishers = publishers
    print(gameEntity)
    return gameEntity
    
  }
    
  public func transformEntityToDomain(entity: GameEntity) -> GameModel {
    let genres = _genreMapper.transformEntityToDomain(
      entity: Array(entity.genres)
    )
    let alternativeNames = Array(entity.alternativeNames)
    let parentPlatforms = Array(entity.parentPlatforms)
    let platforms = Array(entity.platforms)
    let publishers = Array(entity.publishers)
    let developers = Array(entity.developers)
    return GameModel(
      id: entity.id,
      title: entity.title,
      image: entity.image,
      desc: entity.desc,
      metacritic: entity.metacritic,
      released: entity.released,
      website: entity.website,
      rating: entity.rating,
      genres: genres,
      favorite: entity.favorite,
      alternativeNames: alternativeNames,
      parentPlatforms: parentPlatforms,
      platforms: platforms,
      publishers: publishers,
      developers: developers
    )
  }
}

extension GameTransformer {
  func mapGameResponseToListName(
    input alternativeNames: [String]
  ) -> List<String> {
    let listName = List<String>()
    for name in alternativeNames {
      listName.append(name)
    }
    return listName
  }
  
  func mapGameResponseToListParentPlatformSlug(
    input parentPlatforms: [PlatformsResponse]
  ) -> List<String> {
    let listParentPlatformSlug = List<String>()
    for parent in parentPlatforms {
      let item = parent.platform.slug ?? ""
      listParentPlatformSlug.append(item)
    }
    return listParentPlatformSlug
  }
  
  func mapGameResponseToListPlatform(
    input platforms: [PlatformsResponse]
  ) -> List<String> {
    let listPlatform = List<String>()
    for platform in platforms {
      let item = platform.platform.name ?? ""
      listPlatform.append(item)
    }
    return listPlatform
  }
  
  func mapGameResponseToListDeveloper(
    input developers: [DeveloperResponse]
  ) -> List<String> {
    let listDeveloper = List<String>()
    for developer in developers {
      let item = developer.name ?? ""
      listDeveloper.append(item)
    }
    return listDeveloper
  }
  
  func mapGameResponseToListPublisher(
    input publishers: [PublisherResponse]
  ) -> List<String> {
    let listPublisher = List<String>()
    for publisher in publishers {
      let item = publisher.name ?? ""
      listPublisher.append(item)
    }
    return listPublisher
  }
}
