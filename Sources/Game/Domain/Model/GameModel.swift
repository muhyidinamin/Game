//
//  File.swift
//  
//
//  Created by Muhamad Muhyidin Amin on 14/02/21.
//

import Foundation
import Genre

public struct GameModel: Equatable, Identifiable {
 
    public let id: Int
    public let title: String
    public let image: String
    public var desc: String = ""
    public var metacritic: Int = 0
    public var released: String = ""
    public var website: String = ""
    public var rating: Double = 0.0
    public var genres: [GenreModel] = []
    public var favorite: Bool = false
    public var alternativeNames: [String] = []
    public var parentPlatforms: [String] = []
    public var platforms: [String] = []
    public var publishers: [String] = []
    public var developers: [String] = []
  
  public init(id: Int, title: String, image: String, desc: String, metacritic: Int,
              released: String, website: String, rating: Double, genres: [GenreModel], favorite: Bool, alternativeNames: [String],
              parentPlatforms: [String], platforms: [String], publishers: [String],
              developers: [String]) {
      self.id = id
      self.title = title
      self.image = image
      self.desc = desc
      self.metacritic = metacritic
      self.released = released
      self.website = website
      self.rating = rating
      self.genres = genres
      self.favorite = favorite
      self.alternativeNames = alternativeNames
      self.parentPlatforms = parentPlatforms
      self.platforms = platforms
      self.publishers = publishers
      self.developers = developers
    }
}
