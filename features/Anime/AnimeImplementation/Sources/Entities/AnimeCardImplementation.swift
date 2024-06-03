import AnimeCore
import Foundation

public struct AnimeCardImplementation: AnimeCard, Equatable, Codable {
  public var id: Int
  public var name: String
  public var russianName: String
  public var image: AnimeImage
  public var url: URL // Srting
  public var kind: AnimeKind
  public var score: String
  public var status: AnimeStatus
  public var episodes: Int
  public var episodesAired: Int
  public var airedOn: String
  public var releasedOn: String?
}

extension AnimeCardImplementation {
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case russianName = "russian"
    case image
    case url
    case kind
    case score
    case status
    case episodes
    case episodesAired = "episodes_aired"
    case airedOn = "aired_on"
    case releasedOn = "released_on"
  }
}
