//
//  EventListViewModel.swift
//  Event Hub
//
//  Created by Fauzi Arda on 01/09/25.
//

import Foundation

class EventListViewModel {
    private let eventUseCase: EventBusinessLogic
    
    var events: [EventEntity] = []
    var onEventsUpdated: (() -> Void)?
    
    var hasUpcomingEvent: Bool {
        return upcomingEvent != nil
    }
    
    var upcomingEvent: EventEntity? {
        return events.first { $0.isUpcoming }
    }
    
    init(eventUseCase: EventBusinessLogic) {
        self.eventUseCase = eventUseCase
    }
    
    func fetchEvents() {
        eventUseCase.getEvents { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .left(let events):
                self.events = self.sortEvents(events)
                self.onEventsUpdated?()
            case .right(let error):
                // Handle error (show alert through delegate/closure)
                print("Error fetching events: \(error)")
            }
        }
    }
    
    private func sortEvents(_ events: [EventEntity]) -> [EventEntity] {
//        // Sort events by date, putting upcoming events first
//        return events.sorted { event1, event2 in
//            // If both are upcoming or both are past, sort by date
//            if event1.isUpcoming == event2.isUpcoming {
//                return event1.startDate < event2.startDate
//            }
//            // Put upcoming events first
//            return event1.isUpcoming && !event2.isUpcoming
//        }
        []
    }
    
    func logout() {
//        authRepository.logout { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success:
//                DispatchQueue.main.async {
//                    self.router.navigate(to: .login)
//                }
//            case .failure(let error):
//                print("Error logging out: \(error)")
//            }
//        }
    }
    
    func navigateToCreateEvent() {
//        router.navigate(to: .createEvent)
    }
}
