//
//  Extensions.swift
//  FruitApp
//
//  Created by Pawan Sharma on 14/08/23.
//

import Foundation
import UIKit

enum StoryboardScene {
    
   enum Main: StoryboardType {
     static let storyboardName = "Main"

     static let fruitDetails = SceneType<FruitApp.FruitDetailsViewController>(storyboard: Main.self, identifier: "FruitDetailsViewController")

     static let homeView = SceneType<FruitApp.HomeViewController>(storyboard: Main.self, identifier: "HomeViewController")
  }
}

// MARK: - Implementation Details

protocol StoryboardType {
  static var storyboardName: String { get }
}

extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: BundleToken.bundle)
  }
}

struct SceneType<T: UIViewController> {
   let storyboard: StoryboardType.Type
   let identifier: String

   func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }

  @available(iOS 13.0, tvOS 13.0, *)
   func instantiate(creator block: @escaping (NSCoder) -> T?) -> T {
    return storyboard.storyboard.instantiateViewController(identifier: identifier, creator: block)
  }
}

private final class BundleToken {
  static let bundle: Bundle = {
      return Bundle(for: BundleToken.self)
  }()
}

extension UIView {
  func addShadow() {
    self.layer.cornerRadius = 5.0
    self.layer.shadowColor = UIColor.gray.cgColor
    self.layer.shadowOffset = CGSize(width: 1, height: 1)
      self.layer.shadowOpacity = 0.5
  }
}

enum Category:CaseIterable {
    case AllFruits
    case FruitsByFamily
    case FruitsByGenus
    case FruitsByOrder
}
