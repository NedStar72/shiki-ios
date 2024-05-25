import Foundation

// MARK: - WeakMapTable

public final class WeakMapTable<Key, Value> where Key: AnyObject {
  private var dictionary: [Weak<Key>: Value] = [:]
  private let lock = NSRecursiveLock()

  // MARK: Initializing

  public init() {}

  // MARK: Getting and Setting Values

  public func value(forKey key: Key) -> Value? {
    let weakKey = Weak(key)

    lock.lock()
    defer {
      self.lock.unlock()
      self.installDeallocHook(to: key)
    }

    return unsafeValue(forKey: weakKey)
  }

  public func value(forKey key: Key, default: @autoclosure () -> Value) -> Value {
    let weakKey = Weak(key)

    lock.lock()
    defer {
      self.lock.unlock()
      self.installDeallocHook(to: key)
    }

    if let value = unsafeValue(forKey: weakKey) {
      return value
    }

    let defaultValue = `default`()
    unsafeSetValue(defaultValue, forKey: weakKey)
    return defaultValue
  }

  public func forceCastedValue<T>(forKey key: Key, default: @autoclosure () -> T) -> T {
    value(forKey: key, default: `default`() as! Value) as! T
  }

  public func setValue(_ value: Value?, forKey key: Key) {
    let weakKey = Weak(key)

    lock.lock()
    defer {
      self.lock.unlock()
      if value != nil {
        self.installDeallocHook(to: key)
      }
    }

    if let value {
      dictionary[weakKey] = value
    } else {
      dictionary.removeValue(forKey: weakKey)
    }
  }

  // MARK: Getting and Setting Values without Locking

  private func unsafeValue(forKey key: Weak<Key>) -> Value? {
    dictionary[key]
  }

  private func unsafeSetValue(_ value: Value?, forKey key: Weak<Key>) {
    if let value {
      dictionary[key] = value
    } else {
      dictionary.removeValue(forKey: key)
    }
  }

  // MARK: Dealloc Hook

  private var deallocHookKey: Void?

  private func installDeallocHook(to key: Key) {
    let isInstalled = (objc_getAssociatedObject(key, &deallocHookKey) != nil)
    guard !isInstalled else { return }

    let weakKey = Weak(key)
    let hook = DeallocHook(handler: { [weak self] in
      self?.lock.lock()
      self?.dictionary.removeValue(forKey: weakKey)
      self?.lock.unlock()
    })
    objc_setAssociatedObject(key, &deallocHookKey, hook, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }
}

// MARK: - Weak

private final class Weak<T>: Hashable where T: AnyObject {
  private let objectHashValue: Int
  weak var object: T?

  init(_ object: T) {
    objectHashValue = ObjectIdentifier(object).hashValue
    self.object = object
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(objectHashValue)
  }

  static func == (lhs: Weak<T>, rhs: Weak<T>) -> Bool {
    lhs.objectHashValue == rhs.objectHashValue
  }
}

// MARK: - DeallocHook

private final class DeallocHook {
  private let handler: () -> Void

  init(handler: @escaping () -> Void) {
    self.handler = handler
  }

  deinit {
    self.handler()
  }
}
