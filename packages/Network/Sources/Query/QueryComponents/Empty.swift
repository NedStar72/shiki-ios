struct Empty: QueryComponent {
  func modify(_ query: inout Query) -> Query {
    query
  }
}
