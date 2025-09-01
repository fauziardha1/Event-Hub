//
//  DefaultFactory.swift
//  Event Hub
//
//  Created by Fauzi Arda on 01/09/25.
//

import UIKit

protocol FeatureFactory {
    func makeLogin() -> UIViewController
    func makeEventList() -> UIViewController
    // add other features if needed
}

final class DefaultFeatureFactory: FeatureFactory {
    private let router: AppRouting
    
    init(router: AppRouting) {
        self.router = router
    }
    
    func makeLogin() -> UIViewController {
        let loginVC = LoginComposer.compose()
        return loginVC
    }
    
    func makeEventList() -> UIViewController {
        return UIViewController()
    }
}
