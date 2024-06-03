import Foundation

public struct ProfileImage: Codable {
  public var x16: URL
  public var x32: URL
  public var x48: URL
  public var x64: URL
  public var x80: URL
  public var x148: URL
  public var x160: URL
}

public struct Profile: Codable {
  public var id: Int
  public var nickname: String
  public var avatar: URL
  public var image: ProfileImage
  public var last_online_at: String
  public var url: URL
  public var name: String?
  public var sex: String?
  public var website: String?
  public var birth_on: String?
  public var full_years: Int?
  public var locale: String
}
