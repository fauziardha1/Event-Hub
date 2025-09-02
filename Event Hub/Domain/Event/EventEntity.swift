import Foundation

struct EventEntity {
    let id: String
    let name: String
    let description: String
    let location: String
    let startDate: Date
    let endDate: Date
    let organizer: String
    let thumbnailPath: String?
    
    init(
        id: String = UUID().uuidString,
        name: String,
        description: String,
        location: String,
        startDate: Date,
        endDate: Date,
        organizer: String,
        thumbnailPath: String? = nil
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.location = location
        self.startDate = startDate
        self.endDate = endDate
        self.organizer = organizer
        self.thumbnailPath = thumbnailPath
    }
    
    var isUpcoming: Bool {
        return startDate > Date()
    }
}
