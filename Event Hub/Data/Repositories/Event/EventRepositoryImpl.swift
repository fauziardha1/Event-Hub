import Foundation
import CoreData

class EventRepositoryImpl: EventRepository {
    private let persistentContainer: NSPersistentContainer
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func getEvents(completion: @escaping (Either<[EventEntity], Error>) -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Event>(entityName: "Event")
        
        do {
            let eventModels = try context.fetch(fetchRequest)
            guard !eventModels.isEmpty else { insertSampleEvents(); return }
            let events: [EventEntity] = eventModels.compactMap { model in
                
                if model.id == nil && model.name == nil && model.organizer == nil && model.location == nil {
                    return nil
                }
                
                return EventEntity(from: model)
            }
            
            completion(.left(events))
        } catch {
            completion(.right(error))
        }
    }
    
    func createEvent(_ event: EventEntity, completion: @escaping (Result<Void, Error>) -> Void) {
        let context = persistentContainer.viewContext
        
        let _ = Event(context: context).createEvent(from: event)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    
    func insertSampleEvents() {
        let samples: [EventEntity] = [
            EventEntity(
                id: UUID().uuidString,
                name: "iOS Dev Conference",
                startDate: Date().addingTimeInterval(86400), // tomorrow
                endDate: Date().addingTimeInterval(172800),  // day after
                organizer: "Swift Community",
                location: "Tokyo, Japan",
                description: "Annual iOS and Swift developers meetup.",
                thumbnailPath: nil
            ),
            EventEntity(
                id: UUID().uuidString,
                name: "Startup Pitch Night",
                startDate: Date().addingTimeInterval(259200), // 3 days later
                endDate: Date().addingTimeInterval(259200 + 3600),
                organizer: "Tech Hub",
                location: "Jakarta, Indonesia",
                description: "Pitch your startup idea in front of investors.",
                thumbnailPath: nil
            ),
            EventEntity(
                id: UUID().uuidString,
                name: "Music Festival",
                startDate: Date().addingTimeInterval(604800), // 1 week later
                endDate: Date().addingTimeInterval(604800 + 7200),
                organizer: "Live Nation",
                location: "Singapore",
                description: "Outdoor music festival with multiple bands.",
                thumbnailPath: "festival.jpg"
            )
        ]

        let context = CoreDataManager.shared.context
        samples.forEach { entity in
            let event = Event(context: context)
            event.id = entity.id
            event.name = entity.name
            event.startDate = entity.startDate
            event.endDate = entity.endDate
            event.organizer = entity.organizer
            event.location = entity.location
            event.eventDescription = entity.description
            event.thumbnailPath = entity.thumbnailPath
        }

        CoreDataManager.shared.saveContext()
    }
}
