//
//  File.swift
//  
//
//  Created by Muhamad Muhyidin Amin on 14/02/21.
//

import Foundation
import Genre

public struct GamesResponse: Decodable {

  let results: [GameResponse]
  
}

public struct GameResponse: Decodable {

  private enum CodingKeys: String, CodingKey {
    case id = "id"
    case title = "name"
    case image = "background_image"
    case desc = "description"
    case metacritic = "metacritic"
    case released = "released"
    case website = "website"
    case rating = "rating"
    case genres = "genres"
    case alternativeNames = "alternative_names"
    case parentPlatforms = "parent_platforms"
    case platforms = "platforms"
    case publishers = "publishers"
    case developers = "developers"
  }

  let id: Int?
  let title: String?
  let image: String?
  let desc: String?
  let metacritic: Int?
  let released: String?
  let website: String?
  let rating: Double?
  let genres: [GenreResponse]?
  let alternativeNames: [String]?
  let parentPlatforms: [PlatformsResponse]?
  let platforms: [PlatformsResponse]?
  let publishers: [PublisherResponse]?
  let developers: [DeveloperResponse]?

}

struct PlatformsResponse: Decodable {
  let platform: PlatformResponse
}

struct PlatformResponse: Decodable {
  let id: Int?
  let slug: String?
  let name: String?
}

struct DeveloperResponse: Decodable {
  let name: String?
}

struct PublisherResponse: Decodable {
  let name: String?
}
