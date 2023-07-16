// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Address:
  internal static let address = L10n.tr("Localizable", "address", fallback: "Address:")
  /// Another keyword:
  internal static let anotherKeyword = L10n.tr("Localizable", "anotherKeyword", fallback: "Another keyword:")
  /// Date:
  internal static let date = L10n.tr("Localizable", "date", fallback: "Date:")
  /// Description:
  internal static let description = L10n.tr("Localizable", "description", fallback: "Description:")
  /// Dismiss
  internal static let dismiss = L10n.tr("Localizable", "dismiss", fallback: "Dismiss")
  /// Email:
  internal static let email = L10n.tr("Localizable", "email", fallback: "Email:")
  /// Error
  internal static let error = L10n.tr("Localizable", "error", fallback: "Error")
  /// Authentication error.
  internal static let errorAuthenticationError = L10n.tr("Localizable", "errorAuthenticationError", fallback: "Authentication error.")
  /// Decoding failed
  internal static let errorDecodingFailed = L10n.tr("Localizable", "errorDecodingFailed", fallback: "Decoding failed")
  /// Invalid response data.
  internal static let errorInvalidData = L10n.tr("Localizable", "errorInvalidData", fallback: "Invalid response data.")
  /// Invalid network response.
  internal static let errorInvalidResponse = L10n.tr("Localizable", "errorInvalidResponse", fallback: "Invalid network response.")
  /// Invalid URL.
  internal static let errorInvalidURL = L10n.tr("Localizable", "errorInvalidURL", fallback: "Invalid URL.")
  /// The network request failed.
  internal static let errorRequestFailed = L10n.tr("Localizable", "errorRequestFailed", fallback: "The network request failed.")
  /// You don't need any subcription for this article
  internal static let free = L10n.tr("Localizable", "free", fallback: "You don't need any subcription for this article")
  /// Keyword:
  internal static let keyword = L10n.tr("Localizable", "keyword", fallback: "Keyword:")
  /// Login
  internal static let login = L10n.tr("Localizable", "login", fallback: "Login")
  /// More details
  internal static let moreDetails = L10n.tr("Localizable", "moreDetails", fallback: "More details")
  /// My profile
  internal static let myProfile = L10n.tr("Localizable", "myProfile", fallback: "My profile")
  /// Name:
  internal static let name = L10n.tr("Localizable", "name", fallback: "Name:")
  /// You don't have subcription for this article
  internal static let notPaid = L10n.tr("Localizable", "notPaid", fallback: "You don't have subcription for this article")
  /// You have subcription for this article
  internal static let paid = L10n.tr("Localizable", "paid", fallback: "You have subcription for this article")
  /// Password
  internal static let password = L10n.tr("Localizable", "password", fallback: "Password")
  /// Phone:
  internal static let phone = L10n.tr("Localizable", "phone", fallback: "Phone:")
  /// Subscription:
  internal static let subscription = L10n.tr("Localizable", "subscription", fallback: "Subscription:")
  /// Timeline
  internal static let timeline = L10n.tr("Localizable", "timeline", fallback: "Timeline")
  /// Title:
  internal static let title = L10n.tr("Localizable", "title", fallback: "Title:")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
