public protocol ProfileGateway {
  func fetchProfile() async throws -> Profile
}
