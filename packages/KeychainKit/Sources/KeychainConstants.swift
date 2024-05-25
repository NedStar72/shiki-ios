import Foundation
import Security

public enum KeychainConstants {
  /// Specifies a Keychain access group. Used for sharing Keychain items between apps.
  public static var accessGroup: String { kSecAttrAccessGroup as String }

  /**
   A value that indicates when your app needs access to the data in a keychain item.
   The default value is AccessibleWhenUnlocked.
   For a list of possible values, see KeychainAccessOptions.
   */
  public static var accessible: String { kSecAttrAccessible as String }

  /// Used for specifying a String key when setting/getting a Keychain value.
  public static var attrAccount: String { kSecAttrAccount as String }

  /// Used for specifying synchronization of keychain items between devices.
  public static var attrSynchronizable: String { kSecAttrSynchronizable as String }

  /// An item class key used to construct a Keychain search dictionary.
  public static var kClass: String { kSecClass as String }

  /// Specifies the number of values returned from the keychain. The library only supports single values.
  public static var matchLimit: String { kSecMatchLimit as String }

  /// A return data type used to get the data from the Keychain.
  public static var returnData: String { kSecReturnData as String }

  /// Used for specifying a value when setting a Keychain value.
  public static var valueData: String { kSecValueData as String }

  /// Used for returning a reference to the data from the keychain
  public static var returnReference: String { kSecReturnPersistentRef as String }

  /// A key whose value is a Boolean indicating whether or not to return item attributes
  public static var returnAttributes: String { kSecReturnAttributes as String }

  /// A value that corresponds to matching an unlimited number of items
  public static var secMatchLimitAll: String { kSecMatchLimitAll as String }
}
