import AnimeCore
import ShikiUIKit
import SwiftUI
import SwiftUtils

private let sharedSpacing = 10.0

public struct AnimeList: View {
  @ObservedObject var viewModel: AnimeListViewModel

  public init(viewModel: AnimeListViewModel) {
    self.viewModel = viewModel
  }

  public var body: some View {
    VStack {
      Button("Refresh") {
        viewModel.action.send(.fetchAnimeList)
      }
      TextField("Title", text: $viewModel.text)
      Spacer()
      if viewModel.state.isFetching {
        ProgressView()
      } else if viewModel.state.isError {
        Text("Error!")
      } else {
        ScrollView {
          LazyVGrid(
            columns: [
              GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: sharedSpacing),
              GridItem(.flexible(minimum: 0, maximum: .infinity)),
            ],
            spacing: sharedSpacing
          ) {
            ForEach(viewModel.state.animes, id: \.id) {
              AnimeCard(
                image: $0.image.small,
                title: $0.russianName,
                type: "Аниме",
                year: $0.airedOn.toDate(.isoDate)?.get(.year) ?? 0
              )
            }
          }
          .padding(sharedSpacing)
        }
      }
      Spacer()
    }
    .onMount {
      viewModel.action.send(.fetchAnimeList)
    }
    .navigationTitle("Поиск")
    .navigationBarTitleDisplayMode(.inline)
  }
}
