import UIKit

enum CreateEventComposer {
    static func compose(withDependency: CreateEventDependency) -> UIViewController {
        let coreDataManager = CoreDataManager.shared
        let eventRepository = EventRepositoryImpl(persistentContainer: coreDataManager.persistentContainer)
        let viewModel = CreateEventViewModel(eventRepository: eventRepository, refreshEventList: withDependency.refreshEventListAction)
        let viewController = CreateEventViewController(viewModel: viewModel)
        return viewController
    }
}

struct CreateEventDependency {
    let refreshEventListAction: () -> Void
    
    init(refreshEventListAction: @escaping () -> Void) {
        self.refreshEventListAction = refreshEventListAction
    }
}
