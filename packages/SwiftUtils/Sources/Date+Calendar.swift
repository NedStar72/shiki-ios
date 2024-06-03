import Foundation

public extension Date {
  func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
    calendar.dateComponents(Set(components), from: self)
  }

  func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
    calendar.component(component, from: self)
  }
}
