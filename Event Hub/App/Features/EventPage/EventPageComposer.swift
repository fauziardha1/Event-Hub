//
//  EventPageComposer.swift
//  Event Hub
//
//  Created by Fauzi Arda on 01/09/25.
//

import UIKit

final class EventPageComposer {
    private init() {}
    
    static func compose() -> UIViewController {
        let controller = EventListViewController(viewModel: EventListViewModel())
        return controller
    }
}
