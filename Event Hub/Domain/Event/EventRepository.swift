import Foundation

protocol EventRepository {
    func getEvents(completion: @escaping (Either<[EventEntity], Error>) -> Void)
    func createEvent(_ event: EventEntity, completion: @escaping (Result<Void, Error>) -> Void)
}
