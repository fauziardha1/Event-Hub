import Foundation

struct Event: Equatable {
    let id: String
    let name: String
    let startDate: Date
    let endDate: Date
    let organizer: String
    let location: String
    let description: String
    let thumbnailPath: String?
    
    var isUpcoming: Bool {
        return startDate > Date()
    }
}

protocol EventRepository {
    func getEvents(completion: @escaping (Either<Error, [Event]>) -> Void)
    func saveEvent(_ event: Event, completion: @escaping (Either<Error, Void>) -> Void)
    func deleteEvent(_ eventId: String, completion: @escaping (Either<Error, Void>) -> Void)
}

protocol EventUseCase {
    func getUpcomingEvents(completion: @escaping (Either<Error, [Event]>) -> Void)
}