//
//  NavigationController.swift
//  FruitApp
//
//  Created by Pawan Sharma on 21/08/23.
//

import Foundation
import UIKit

//Solid Interface Segration Principle

protocol PushNavigationProtocol {
    /// To push new view controller in stack
    func push(viewController: UIViewController, animated: Bool)
}

protocol PopNavigationProtocol {
    /// To pop current top view controller in stack
    func pop(animated: Bool)
    
    /// To pop all view controller in stack except root
    func popToRoot(animated: Bool)
    
    /// Pop specific view controller in stack
    func popTo(viewController: UIViewController, animated: Bool)
}

protocol PresentNavigationProtocol {
    /// Present ViewController without navigation controller, if presented with this function then push/present over new controller will not work
    func presentViewController(viewController: UIViewController,
                               animated: Bool, completion: (() -> Void)?)
    
    /// Present ViewController navigation controller, Use this function if presented view controller should have a NavigationController
    func presentWithNavigator(viewController: UIViewController,
                              modalPresentationStyle: UIModalPresentationStyle,
                              completion: (() -> Void)?) -> AppNavigationControllerProtocol
    
    /// This function will dismiss the navigation controller on which this is called
    func dismiss(completion: (() -> Void)?, animated: Bool)
}

typealias AppNavigationControllerProtocol = PushNavigationProtocol & PopNavigationProtocol & PresentNavigationProtocol

/// Custome AppNavigationController which is subclass of UINavigationController
final class AppNavigationController: UINavigationController {
    
    /// View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        isNavigationBarHidden = false
    }

}

/// AppNavigationControllerProtocol
extension AppNavigationController: AppNavigationControllerProtocol {

    /// To push new view controller in stack
    func push(viewController: UIViewController, animated: Bool) {
        self.pushViewController(viewController, animated: animated)
    }
    
    /// To pop current top view controller in stack
    func pop(animated: Bool) {
        self.popViewController(animated: animated)
    }
    
    /// To pop all view controller in stack except root
    func popToRoot(animated: Bool) {
        self.popToRootViewController(animated: true)
    }
    
    /// Pops to specific view controller in stack
    func popTo(viewController: UIViewController, animated: Bool) {
        self.popToViewController(viewController, animated: true)
    }
    
    /// Present ViewController without navigation controller
    func presentViewController(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        self.present(viewController, animated: animated, completion: completion)
    }
    
    /// Present ViewController with navigation controller
    func presentWithNavigator(viewController: UIViewController,
                              modalPresentationStyle: UIModalPresentationStyle,
                              completion: (() -> Void)?) -> AppNavigationControllerProtocol {
        let newNavigationController = AppNavigationController(rootViewController: viewController)
        newNavigationController.modalPresentationStyle = modalPresentationStyle
        self.presentViewController(viewController: newNavigationController,
                                   animated: true, completion: completion)
        return newNavigationController
    }
    
    /// This function will dismiss the navigation controller on which this is called
    func dismiss(completion: (() -> Void)?, animated: Bool) {
        self.dismiss(animated: animated, completion: completion)
    }
}

/// UINavigationControllerDelegate
extension AppNavigationController: UINavigationControllerDelegate {
    /// Navigation Controller will show
    /// - Parameters:
    ///   - navigationController: navigation
    ///   - viewController: show view
    ///   - animated: with animation
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let coordinator = navigationController.topViewController?.transitionCoordinator {
            coordinator.notifyWhenInteractionChanges { (context) in
                if !context.isCancelled {
                    /* NotificationCenter.default.post(name: .swipeBack, object: nil) */
                }
            }
        }
    }
}
