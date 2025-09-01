//
//  EventModel.swift
//  Event Hub
//
//  Created by Fauzi Arda on 01/09/25.
//
import Foundation
import CoreData

// crud
extension Event {
    func createEvent(from entity: EventEntity) {
        let context = CoreDataManager.shared.context
        let event = Event(context: context)
        event.id = entity.id
        event.name = entity.name
        event.startDate = entity.startDate
        event.endDate = entity.endDate
        event.organizer = entity.organizer
        event.location = entity.location
        event.eventDescription = entity.description
        event.thumbnailPath = entity.thumbnailPath
        CoreDataManager.shared.saveContext()
    }
    
    func fetchEvents() -> [EventEntity] {
        let context = CoreDataManager.shared.context
        let request: NSFetchRequest<Event> = Event.fetchRequest()

        do {
            let events = try context.fetch(request)
            return events.map {
                EventEntity(
                    id: $0.id ?? "",
                    name: $0.name ?? "",
                    startDate: $0.startDate ?? Date(),
                    endDate: $0.endDate ?? Date(),
                    organizer: $0.organizer ?? "",
                    location: $0.location ?? "",
                    description: $0.eventDescription ?? "",
                    thumbnailPath: $0.thumbnailPath
                )
            }
        } catch {
            print("Error fetching events: \(error)")
            return []
        }
    }
    
    func updateEvent(_ entity: EventEntity) {
        let context = CoreDataManager.shared.context
        let request: NSFetchRequest<Event> = Event.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", entity.id)

        do {
            if let event = try context.fetch(request).first {
                event.name = entity.name
                event.startDate = entity.startDate
                event.endDate = entity.endDate
                event.organizer = entity.organizer
                event.location = entity.location
                event.eventDescription = entity.description
                event.thumbnailPath = entity.thumbnailPath
                CoreDataManager.shared.saveContext()
            }
        } catch {
            print("Error updating event: \(error)")
        }
    }
    
    func deleteEvent(by id: String) {
        let context = CoreDataManager.shared.context
        let request: NSFetchRequest<Event> = Event.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)

        do {
            if let event = try context.fetch(request).first {
                context.delete(event)
                CoreDataManager.shared.saveContext()
            }
        } catch {
            print("Error deleting event: \(error)")
        }
    }
}

extension EventEntity {
    init(from coreData: Event) {
        self.id = coreData.id ?? ""
        self.name = coreData.name ?? ""
        self.startDate = coreData.startDate ?? Date()
        self.endDate = coreData.endDate ?? Date()
        self.organizer = coreData.organizer ?? ""
        self.location = coreData.location ?? ""
        self.description = coreData.eventDescription ?? ""
        self.thumbnailPath = coreData.thumbnailPath ?? nil
    }
}
