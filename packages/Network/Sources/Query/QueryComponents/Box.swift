struct Box: QueryComponent {
  private let components: [QueryComponent]

  init(_ components: [QueryComponent]) {
    self.components = components
  }

  func modify(_ query: inout Query) -> Query {
    for component in components {
      component.modify(&query)
    }
    return query
  }
}
