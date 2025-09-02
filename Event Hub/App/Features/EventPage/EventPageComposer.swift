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
    
    static func compose(dependency: EventPageDependency) -> UIViewController {
        let coreDataContainer = CoreDataManager.shared.persistentContainer
        let repository = EventRepositoryImpl(persistentContainer: coreDataContainer)
        let useCase = EventUsecase(eventRepository: repository)
        let viewmodel = EventListViewModel(eventUseCase: useCase, showFormAction: dependency.showFormAction)
        let controller = EventListViewController(viewModel: viewmodel)
        return controller
    }
}

struct EventPageDependency {
    // Add dependencies if needed in the future
    let showFormAction: () -> Void
    
    init(showFormAction: @escaping () -> Void) {
        self.showFormAction = showFormAction
    }
}
