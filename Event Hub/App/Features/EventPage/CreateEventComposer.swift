import UIKit

enum CreateEventComposer {
    static func compose() -> UIViewController {
        let coreDataManager = CoreDataManager.shared
        let eventRepository = EventRepositoryImpl(persistentContainer: coreDataManager.persistentContainer)
        let viewModel = CreateEventViewModel(eventRepository: eventRepository)
        let viewController = CreateEventViewController(viewModel: viewModel)
        return viewController
    }
}
