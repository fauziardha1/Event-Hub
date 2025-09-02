import Foundation
import UIKit

class CreateEventViewModel {
    private let eventRepository: EventRepository
    
    init(eventRepository: EventRepository) {
        self.eventRepository = eventRepository
    }
    
    func createEvent(_ event: EventEntity, image: UIImage?, completion: @escaping (Result<Void, Error>) -> Void) {
        // If there's an image, save it to the documents directory first
        var eventWithImage = event
        if let image = image {
            if let imagePath = saveImage(image, withName: event.id) {
                eventWithImage = EventEntity(
                    id: event.id,
                    name: event.name,
                    description: event.description,
                    location: event.location,
                    startDate: event.startDate,
                    endDate: event.endDate,
                    organizer: event.organizer,
                    thumbnailPath: imagePath
                )
            }
        }
        
        eventRepository.createEvent(eventWithImage) { result in
            switch result {
            case .success:
                NotificationCenter.default.post(name: .eventCreated, object: nil)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func saveImage(_ image: UIImage, withName name: String) -> String? {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
        let filename = name + ".jpg"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsDirectory.appendingPathComponent(filename)
        
        do {
            try data.write(to: fileURL)
            return fileURL.path
        } catch {
            print("Error saving image: \(error)")
            return nil
        }
    }
}

extension Notification.Name {
    static let eventCreated = Notification.Name("eventCreated")
}
