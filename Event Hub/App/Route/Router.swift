//
//  Router.swift
//  Event Hub
//
//  Created by Fauzi Arda on 01/09/25.
//
import UIKit

protocol AppRouting {
    func navigate(to route: AppRoute, from viewController: UIViewController?)
}

final class AppRouter: AppRouting {
    /// Reference to the main application window.
    private weak var window: UIWindow?
    
    /// Main navigation controller for stack-based navigation.
    private let navigationController: UINavigationController
    
    /// Factory for creating feature view controllers.
    var factory: FeatureFactory?

    init(window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        navigationController.setNavigationBarHidden(true, animated: false)
    }

    func start() {
        navigate(to: .login)
    }
    
    /// Navigate to a specified route from an optional view controller.
    /// - Parameters:
    ///   - route: The destination route.
    ///   - viewController: The current view controller (optional).
    func navigate(to route: AppRoute, from viewController: UIViewController? = nil) {
        guard let factory else { return }
        switch route {
        case .login:
            let loginPage = factory.makeLogin()
            navigationController.setViewControllers([loginPage], animated: true)
            
        case .eventList:
            let eventListPage = factory.makeEventList()
            navigationController.setViewControllers([eventListPage], animated: true)
        }
    }
}
