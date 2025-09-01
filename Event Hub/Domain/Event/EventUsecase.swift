//
//  EventUsecase.swift
//  Event Hub
//
//  Created by Fauzi Arda on 01/09/25.
//
import Foundation

protocol EventBusinessLogic {
    func getUpcomingEvents(completion: @escaping (Either<[EventEntity], Error>) -> Void)
    func getEvents(completion: @escaping (Either<[EventEntity], Error>) -> Void)
}

final class EventUsecase: EventBusinessLogic {
    private let eventRepository: EventRepository
    
    init(eventRepository: EventRepository) {
        self.eventRepository = eventRepository
    }
    
    func getUpcomingEvents(completion: @escaping (Either<[EventEntity], Error>) -> Void) {
        eventRepository.getEvents(completion: { result in
            switch result {
            case .left(let events):
                DispatchQueue.main.async { completion(.left(events)) }
                
            case .right(let error):
                DispatchQueue.main.async { completion(.right(error)) }
            }
        })
    }
    
    func getEvents(completion: @escaping (Either<[EventEntity], Error>) -> Void) {
        eventRepository.getEvents(completion: { result in
            switch result {
            case .left(let events):
                DispatchQueue.main.async { completion(.left(events)) }
                
            case .right(let error):
                DispatchQueue.main.async { completion(.right(error)) }
            }
        })
    }
}


