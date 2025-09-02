//
//  EventPageComposer.swift
//  Event Hub
//
//  Created by Fauzi Arda on 01/09/25.
//

import UIKit
import CoreData

final class EventPageComposer {
    private init() {}
    static var triggerRefreshEventList: (() -> Void)?
    
    static func compose(dependency: EventPageDependency) -> UIViewController {
        let coreDataContainer = CoreDataManager.shared.persistentContainer
        let repository = EventRepositoryImpl(persistentContainer: coreDataContainer)
        let useCase = EventUsecase(eventRepository: repository)
        let viewmodel = EventListViewModel(eventUseCase: useCase, showFormAction: dependency.showFormAction, navigateToLogoutConfirmation: dependency.showLogoutConfirmation)
        let controller = EventListViewController(viewModel: viewmodel)
        self.triggerRefreshEventList = viewmodel.triggerRefreshFromOutside
        return controller
    }
}

struct EventPageDependency {
    let showFormAction: () -> Void
    let showLogoutConfirmation: () -> Void
    
    init(showFormAction: @escaping () -> Void, showLogoutConfirmation: @escaping () -> Void) {
        self.showFormAction = showFormAction
        self.showLogoutConfirmation = showLogoutConfirmation
    }
}
