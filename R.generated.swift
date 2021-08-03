//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 3 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")
    /// Color `black.white`.
    static let blackWhite = Rswift.ColorResource(bundle: R.hostingBundle, name: "black.white")
    /// Color `white.black`.
    static let whiteBlack = Rswift.ColorResource(bundle: R.hostingBundle, name: "white.black")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "black.white", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func blackWhite(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.blackWhite, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "white.black", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func whiteBlack(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.whiteBlack, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "black.white", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func blackWhite(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.blackWhite.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "white.black", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func whiteBlack(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.whiteBlack.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 12 images.
  struct image {
    /// Image `FedericoBruno_Avatar`.
    static let federicoBruno_Avatar = Rswift.ImageResource(bundle: R.hostingBundle, name: "FedericoBruno_Avatar")
    /// Image `GulertAnastasia_Avatar`.
    static let gulertAnastasia_Avatar = Rswift.ImageResource(bundle: R.hostingBundle, name: "GulertAnastasia_Avatar")
    /// Image `TomVekerfield_Avatar`.
    static let tomVekerfield_Avatar = Rswift.ImageResource(bundle: R.hostingBundle, name: "TomVekerfield_Avatar")
    /// Image `TompsonAlisha_Avatar`.
    static let tompsonAlisha_Avatar = Rswift.ImageResource(bundle: R.hostingBundle, name: "TompsonAlisha_Avatar")
    /// Image `VictorMiheev_Avatar`.
    static let victorMiheev_Avatar = Rswift.ImageResource(bundle: R.hostingBundle, name: "VictorMiheev_Avatar")
    /// Image `accecoriesAvatar`.
    static let accecoriesAvatar = Rswift.ImageResource(bundle: R.hostingBundle, name: "accecoriesAvatar")
    /// Image `carsAvatar`.
    static let carsAvatar = Rswift.ImageResource(bundle: R.hostingBundle, name: "carsAvatar")
    /// Image `disliked`.
    static let disliked = Rswift.ImageResource(bundle: R.hostingBundle, name: "disliked")
    /// Image `liked`.
    static let liked = Rswift.ImageResource(bundle: R.hostingBundle, name: "liked")
    /// Image `memsAvatar`.
    static let memsAvatar = Rswift.ImageResource(bundle: R.hostingBundle, name: "memsAvatar")
    /// Image `psychologyAvatar`.
    static let psychologyAvatar = Rswift.ImageResource(bundle: R.hostingBundle, name: "psychologyAvatar")
    /// Image `travelAvatar`.
    static let travelAvatar = Rswift.ImageResource(bundle: R.hostingBundle, name: "travelAvatar")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "FedericoBruno_Avatar", bundle: ..., traitCollection: ...)`
    static func federicoBruno_Avatar(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.federicoBruno_Avatar, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "GulertAnastasia_Avatar", bundle: ..., traitCollection: ...)`
    static func gulertAnastasia_Avatar(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.gulertAnastasia_Avatar, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "TomVekerfield_Avatar", bundle: ..., traitCollection: ...)`
    static func tomVekerfield_Avatar(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.tomVekerfield_Avatar, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "TompsonAlisha_Avatar", bundle: ..., traitCollection: ...)`
    static func tompsonAlisha_Avatar(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.tompsonAlisha_Avatar, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "VictorMiheev_Avatar", bundle: ..., traitCollection: ...)`
    static func victorMiheev_Avatar(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.victorMiheev_Avatar, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "accecoriesAvatar", bundle: ..., traitCollection: ...)`
    static func accecoriesAvatar(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.accecoriesAvatar, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "carsAvatar", bundle: ..., traitCollection: ...)`
    static func carsAvatar(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.carsAvatar, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "disliked", bundle: ..., traitCollection: ...)`
    static func disliked(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.disliked, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "liked", bundle: ..., traitCollection: ...)`
    static func liked(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.liked, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "memsAvatar", bundle: ..., traitCollection: ...)`
    static func memsAvatar(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.memsAvatar, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "psychologyAvatar", bundle: ..., traitCollection: ...)`
    static func psychologyAvatar(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.psychologyAvatar, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "travelAvatar", bundle: ..., traitCollection: ...)`
    static func travelAvatar(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.travelAvatar, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 4 localization keys.
    struct localizable {
      /// Value: All Groups
      static let all_groups_title = Rswift.StringResource(key: "all_groups_title", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Friends
      static let friends_title = Rswift.StringResource(key: "friends_title", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Groups
      static let groups_title = Rswift.StringResource(key: "groups_title", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: News
      static let news_title = Rswift.StringResource(key: "news_title", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)

      /// Value: All Groups
      static func all_groups_title(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("all_groups_title", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "all_groups_title"
        }

        return NSLocalizedString("all_groups_title", bundle: bundle, comment: "")
      }

      /// Value: Friends
      static func friends_title(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("friends_title", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "friends_title"
        }

        return NSLocalizedString("friends_title", bundle: bundle, comment: "")
      }

      /// Value: Groups
      static func groups_title(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("groups_title", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "groups_title"
        }

        return NSLocalizedString("groups_title", bundle: bundle, comment: "")
      }

      /// Value: News
      static func news_title(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("news_title", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "news_title"
        }

        return NSLocalizedString("news_title", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
