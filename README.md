# Event Hub iOS App

## Overview
Event Hub is an iOS application that allows users to manage events with features for authentication, event creation, and event listing. The app is built following Clean Architecture principles and modern iOS development practices.

## Features
- **User Authentication**
  - Login with email and password
  - Secure session management
  - Logout functionality with confirmation

- **Event Management**
  - View list of upcoming and recent events
  - Create new events with details:
    - Event name
    - Description
    - Location
    - Start and end dates
    - Organizer information
    - Event thumbnail image
  - Local storage using Core Data
  - Organized event display with featured upcoming event

## Technical Stack
- **Platform**: iOS 12+
- **Language**: Swift 5
- **Architecture**: Clean Architecture (4-layer)
  - Presentation Layer (MVVM)
  - Domain Layer
  - Data Layer
  - Infrastructure Layer
- **UI Framework**: UIKit (Programmatic, No Storyboards)
- **Persistence**: Core Data
- **Networking**: URLSession
- **Dependencies**: No external dependencies

## Project Structure
```
Event Hub/
├── App/                 # App composition, routing, DI
├── Presentation/        # UI Layer (ViewControllers, ViewModels)
├── Domain/             # Business Logic Layer
├── Data/               # Data Layer (Repositories, API)
├── Infrastructure/     # Cross-cutting concerns
└── Event_Hub.xcdatamodeld/  # Core Data model
```

## Architecture Overview

### Clean Architecture Implementation
1. **Presentation Layer**
   - ViewControllers (UI Logic)
   - ViewModels (Presentation Logic)
   - Custom Views and Cells

2. **Domain Layer**
   - Entities (Business Models)
   - Repository Interfaces
   - Use Cases

3. **Data Layer**
   - Repository Implementations
   - API Services
   - Data Models

4. **Infrastructure Layer**
   - Network Manager
   - Core Data Manager
   - Common Utilities

### Key Design Patterns
- MVVM for Presentation Layer
- Repository Pattern for Data Access
- Dependency Injection
- Observer Pattern for Events
- Coordinator Pattern for Navigation

## Getting Started

### Requirements
- Xcode 12.0+
- iOS 12.0+
- Swift 5.0+

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/event-hub.git
   ```

2. Open the project in Xcode:
   ```bash
   cd event-hub
   open Event\ Hub.xcodeproj
   ```

3. Build and run the project in Xcode

### Configuration
- No additional configuration required
- Login API endpoint is pre-configured
- Core Data model is included in the project

## Features Implementation

### Authentication
- Login endpoint: `POST https://skill-test2.free.beeceptor.com/api/login`
- Credentials stored securely in UserDefaults
- Session management handled by AuthRepository

### Event Management
- Events stored locally using Core Data
- Image assets saved to file system
- Automatic sorting of events by date
- Featured upcoming event display

### User Interface
- Fully programmatic UI using UIKit
- AutoLayout for responsive design
- Support for all iOS device sizes
- Dark mode support (iOS 13+)

## Testing (Next Steps)
- Unit Tests for ViewModels
- Integration Tests for Repositories
- UI Tests for critical paths
- Core Data Tests

## Code Style
- Swift Style Guide compliant
- Consistent naming conventions
- Documentation for public interfaces
- Clear separation of concerns

## Security (Next Steps)
- Secure storage of credentials
- API error handling
- Input validation
- Session management

## Performance (Next Steps)
- Efficient Core Data queries
- Image caching
- Lazy loading of resources
- Memory management best practices

## Contributing
1. Create a new branch from `releaseCandidate/vX.X.X`
2. Make your changes
3. Submit a pull request
4. Wait for code review

## License
This project is proprietary and confidential. All rights reserved.

## Contact
For any queries regarding this project, please contact:
- Project Owner: fauziarda
- Email: --
