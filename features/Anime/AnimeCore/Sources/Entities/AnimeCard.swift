import Foundation

public protocol AnimeCard {
  var id: Int { get }
  var name: String { get }
  var russianName: String { get }
  var image: AnimeImage { get }
  var url: URL { get }
  var kind: AnimeKind { get }
  var score: String { get }
  var status: AnimeStatus { get }
  var episodes: Int { get }
  var episodesAired: Int { get }
  var airedOn: String { get }
  var releasedOn: String? { get }
}
