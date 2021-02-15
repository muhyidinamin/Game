//
//  File.swift
//  
//
//  Created by Muhamad Muhyidin Amin on 14/02/21.
//

import Foundation
import RealmSwift
import Genre

public class GameEntity: Object {

  @objc dynamic var id = 0
  @objc dynamic var title = ""
  @objc dynamic var image = ""
  @objc dynamic var desc = ""
  @objc dynamic var metacritic = 0
  @objc dynamic var released = ""
  @objc dynamic var website = ""
  @objc dynamic var rating = 0.0
  @objc dynamic var favorite = false

  var alternativeNames = List<String>()
  var genres = List<GenreEntity>()
  var parentPlatforms = List<String>()
  var platforms = List<String>()
  var publishers = List<String>()
  var developers = List<String>()

  public override static func primaryKey() -> String? {
    return "id"
  }
}
