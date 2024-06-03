import SwiftUI

public struct AnimeCard: View {
  var image: URL?
  var title: String
  var type: String
  var year: Int

  public init(image: URL? = nil, title: String, type: String, year: Int) {
    self.image = image
    self.title = title
    self.type = type
    self.year = year
  }

  public var body: some View {
    VStack {
      CachedAsyncImage(url: image) { phase in
        VStack {
          Spacer()
          switch phase {
          case .empty:
            ProgressView()
          case let .success(image):
            image
              .resizable()
              .cornerRadius(6)
          case .failure:
            Image(systemName: "photo")
          @unknown default:
            EmptyView()
          }
          Spacer()
        }
        .aspectRatio(67 / 100, contentMode: .fill)
      }
      HStack {
        Text(title)
          .font(.system(size: 16))
          .bold()
        Spacer()
      }
      HStack {
        Text(type)
        Spacer()
        Text(String(year))
      }
      .font(.system(size: 14))
      .foregroundStyle(.secondary)
    }
    .lineLimit(1)
  }
}

#Preview {
  VStack {
    AnimeCard(
      image: URL(string: "https://desu.shikimori.one/uploads/poster/mangas/2/1b55dd3a4afe472f28ce0c9d4f507005.jpeg"),
      title: "Берсерк",
      type: "Манга",
      year: 1989
    )
  }
  .frame(width: 300)
  .clipped()
}
