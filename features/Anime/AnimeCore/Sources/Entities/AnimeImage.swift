import Foundation

public struct AnimeImage: Equatable, Codable {
  var original: URL
  var preview: URL
  var x96: URL
  var x48: URL

  public var small: URL? {
    // TODO: перенести хардкод ссылки, но куда?
    URL(string: "https://desu.shikimori.one\(original.absoluteString)")
  }

  public init(original: URL, preview: URL, x96: URL, x48: URL) {
    self.original = original
    self.preview = preview
    self.x96 = x96
    self.x48 = x48
  }
}
