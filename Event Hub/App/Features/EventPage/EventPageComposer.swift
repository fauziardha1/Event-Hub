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
    
    static func compose() -> UIViewController {
        let coreDataContainer = CoreDataManager.shared.persistentContainer
        let repository = EventRepositoryImpl(persistentContainer: coreDataContainer)
        let useCase = EventUsecase(eventRepository: repository)
        let viewmodel = EventListViewModel(eventUseCase: useCase)
        let controller = EventListViewController(viewModel: viewmodel)
        return controller
    }
}
