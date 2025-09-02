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
    func makeCreateEvent() -> UIViewController
    func makeLogoutConfirmation() -> UIViewController
}

final class DefaultFeatureFactory: FeatureFactory {
    private let router: AppRouting
    
    init(router: AppRouting) {
        self.router = router
    }
    
    func makeLogin() -> UIViewController {
        let loginDependency = LoginDependency(routeToEventPage: { [weak self] in
            guard let self = self else { return }
            self.router.navigate(to: .eventList, from: nil)
        })
        let loginVC = LoginComposer.compose(with: loginDependency)
        return loginVC
    }
    
    func makeEventList() -> UIViewController {
        let eventPageDependency = EventPageDependency(showFormAction: { [weak self] in
            guard let self = self else { return }
            self.router.navigate(to: .createEvent, from: nil)
        }, showLogoutConfirmation: { [weak self] in
            guard let self = self else { return }
            self.router.navigate(to: .logout, from: nil)
        })
        let eventPage = EventPageComposer.compose(dependency: eventPageDependency)
        return eventPage
    }
    
    func makeCreateEvent() -> UIViewController {
        let createEventDependency = CreateEventDependency(refreshEventListAction: {
            EventPageComposer.triggerRefreshEventList?()
        })
        let createEventPage = CreateEventComposer.compose(withDependency: createEventDependency)
        return createEventPage
    }
    
    func makeLogoutConfirmation() -> UIViewController {
        let logoutDependency = LogoutDependency(routeToLogin: { [weak self] in
            guard let self = self else { return }
            self.router.navigate(to: .login, from: nil)
        })
        let logoutConfirmationPage = LogoutComposer.compose(withDependency: logoutDependency)
        return logoutConfirmationPage
    }
}
