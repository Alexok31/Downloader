//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 1 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")
    
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 3 nibs.
  struct nib {
    /// Nib `DownloadingVideosCell`.
    static let downloadingVideosCell = _R.nib._DownloadingVideosCell()
    /// Nib `SelectionDownloadedVideoView`.
    static let selectionDownloadedVideoView = _R.nib._SelectionDownloadedVideoView()
    /// Nib `TopPageCell`.
    static let topPageCell = _R.nib._TopPageCell()
    
    /// `UINib(name: "DownloadingVideosCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.downloadingVideosCell) instead")
    static func downloadingVideosCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.downloadingVideosCell)
    }
    
    /// `UINib(name: "SelectionDownloadedVideoView", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.selectionDownloadedVideoView) instead")
    static func selectionDownloadedVideoView(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.selectionDownloadedVideoView)
    }
    
    /// `UINib(name: "TopPageCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.topPageCell) instead")
    static func topPageCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.topPageCell)
    }
    
    static func downloadingVideosCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> DownloadingVideosCell? {
      return R.nib.downloadingVideosCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? DownloadingVideosCell
    }
    
    static func selectionDownloadedVideoView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SelectionDownloadedVideoView? {
      return R.nib.selectionDownloadedVideoView.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SelectionDownloadedVideoView
    }
    
    static func topPageCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> TopPageCell? {
      return R.nib.topPageCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? TopPageCell
    }
    
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 1 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `TopPageCell`.
    static let topPageCell: Rswift.ReuseIdentifier<TopPageCell> = Rswift.ReuseIdentifier(identifier: "TopPageCell")
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
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
    try storyboard.validate()
  }
  
  struct nib {
    struct _DownloadingVideosCell: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "DownloadingVideosCell"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> DownloadingVideosCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? DownloadingVideosCell
      }
      
      fileprivate init() {}
    }
    
    struct _SelectionDownloadedVideoView: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "SelectionDownloadedVideoView"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> SelectionDownloadedVideoView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? SelectionDownloadedVideoView
      }
      
      fileprivate init() {}
    }
    
    struct _TopPageCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = TopPageCell
      
      let bundle = R.hostingBundle
      let identifier = "TopPageCell"
      let name = "TopPageCell"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> TopPageCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? TopPageCell
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try launchScreen.validate()
      try main.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UITabBarController
      
      let browserViewController = StoryboardViewControllerResource<BrowserViewController>(identifier: "BrowserViewController")
      let bundle = R.hostingBundle
      let downloadProcessViewController = StoryboardViewControllerResource<DownloadProcessViewController>(identifier: "DownloadProcessViewController")
      let name = "Main"
      let searchVideoViewController = StoryboardViewControllerResource<SearchVideoViewController>(identifier: "SearchVideoViewController")
      
      func browserViewController(_: Void = ()) -> BrowserViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: browserViewController)
      }
      
      func downloadProcessViewController(_: Void = ()) -> DownloadProcessViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: downloadProcessViewController)
      }
      
      func searchVideoViewController(_: Void = ()) -> SearchVideoViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: searchVideoViewController)
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "1.circle.fill", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named '1.circle.fill' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "externaldrive.badge.person.crop", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'externaldrive.badge.person.crop' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "folder.fill", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'folder.fill' is used in storyboard 'Main', but couldn't be loaded.") }
        if #available(iOS 11.0, *) {
        }
        if _R.storyboard.main().browserViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'browserViewController' could not be loaded from storyboard 'Main' as 'BrowserViewController'.") }
        if _R.storyboard.main().downloadProcessViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'downloadProcessViewController' could not be loaded from storyboard 'Main' as 'DownloadProcessViewController'.") }
        if _R.storyboard.main().searchVideoViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'searchVideoViewController' could not be loaded from storyboard 'Main' as 'SearchVideoViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
