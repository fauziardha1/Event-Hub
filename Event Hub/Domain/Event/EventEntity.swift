import Foundation

struct EventEntity: Equatable {
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
