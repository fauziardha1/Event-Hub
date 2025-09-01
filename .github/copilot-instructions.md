# Copilot Instructions for Event Hub

## 📌 Project Context
This project is a **Mobile App Developer Technical Assignment**.  
The goal is to build a **scalable, reusable, and clean iOS application** following **Clean Architecture (Presentation, Domain, Data, App)** principles.  

The app should demonstrate:
- Object-Oriented Programming (OOP) practices.
- Separation of concerns between layers.
- Responsive UI (UIKit programmatic, no storyboard).
- Performance and security best practices.
- Local database usage (Core Data).
- API integration for login.
- Use swift 5 and support for iOS 12

---

## 🎯 Core Features (User Stories)

1. **Login**
   - API: `POST https://skill-test2.free.beeceptor.com/api/login`
   - Request body: `{"username": "user@gmail.com", "password": "12345"}`
   - Success when response code = `"00"`, else failure.

2. **Event List**
   - Display after login.
   - Sticky buttons: `Logout`, `New Event`.
   - Empty state if no events exist.
   - Closest upcoming event shown on top with:
     - Thumbnail, Name, Start/End date, Organizer, Location, Description.
   - Other events list: Name, Start date, Organizer, Location.

3. **Create Event**
   - Input: Name, Description, Location, Organizer.
   - Date picker: Start and End date.
   - Image picker: Select from device and display.
   - Save events in **Core Data** (use file path for images if possible).

4. **Logout**
   - Confirmation popup with `Logout` and `Cancel`.
   - On Logout: clear session and navigate to Login page.

---

## 🏛️ Architecture Guidelines
│   │       └── AuthAPI.swift

MyApp/
├── App
│   ├── Route
│   │   ├── Router.swift
│   │   └── routes.swift
│   ├── Factory
│   │   └── DefaultFactory.swift
│   ├── Features
│   │   └── Login
│   │       └── LoginComposer.swift
│   └── AppDelegate.swift
│
├── Presentation
│   ├── Login
│   │   ├── LoginViewController.swift
│   │   └── LoginViewModel.swift
│   └── Shared
│       └── BaseViewController.swift
│
├── Domain
│   ├── Auth
│   │   └── AuthEntity.swift
│   │   └── AuthUseCase.swift
│   └── └── EventRepository.swift
│
├── Data
│   ├── Repositories
│   │   └── Auth
│   │       └── AuthRepository.swift
│   ├── NetworkDataSource
│   │   └── Auth
│   │       └── AuthNetworkDataSource.swift
│   ├── LocalDataSource
│   │   └── Auth
│   │       └── AuthLocalDataSource.swift
│   └── Models
│       └── Auth
│           └── AuthModel.swift
├── InfraStructure
│   ├── Network
│   │   ├── NetworkManager.swift
│   │   ├── NetworkRequest.swift
│   │   └── NetworkError.swift
│   └── Types
│       └── Either.swift
├── Event_Hub.xcdatamodeld
├── Assets.xcassets
├── info.plist
└── LaunchScreen.storyboard

- **App Layer** → Composes dependencies and navigation (Coordinator pattern).
- **Presentation Layer** → UIKit programmatic Views + ViewModels.
- **Domain Layer** → Entities, Use Cases (pure Swift, no frameworks).
- **Data Layer** → Repository implementations, API (URLSession), Core Data storage.
- **Infrastructure Layer** → Networking, Persistence, and other low-level concerns.

---

## 🛠️ Technical Requirements

- **Language**: Swift
- **UI**: UIKit Programmatic (AutoLayout, SnapKit optional)
- **Networking**: `URLSession`
- **Database**: Core Data
- **Dependency Injection**: Constructor injection
- **Session Storage**: Keychain (preferred) or UserDefaults
- **Testing**: XCTest (unit tests for Use Cases, ViewModels, Repositories)

---

## 🧑‍💻 Coding Style

- Indentation: 4 spaces
- Line length: max 120 chars
- Naming:
  - Classes/Structs/Enums → `PascalCase`
  - Variables/Functions → `camelCase`
  - Constants → `UPPER_SNAKE_CASE`
  - Tests → `ClassNameTests`
- Always use `guard let` for optional unwrapping instead of nested `if let`.
- Use `private` by default for properties and methods.

---

## 🔀 Git Workflow

- Main stable branch: `main`
- Release candidate: `releaseCandidate/vX.X.X`
- Feature branches: `feature/<name>`
- Bug fix branches: `fix/<name>`
- Enhancement branches: `enhancement/<name>`

Rules:
- All feature/fix/enhancement branches must come from `releaseCandidate/vX.X.X`.
- All merges go into the active `releaseCandidate/vX.X.X` after code review.
- Builds for QA come from `releaseCandidate/vX.X.X`.
- Final release builds come from `main`.

---

## ✅ Tasks for Copilot

When generating code, **Copilot should:**
1. Follow Clean Architecture separation.
2. Write UIKit programmatic views (no storyboard).
3. Use Core Data for persistence with a repository pattern.
4. Write URLSession-based API calls.
5. Provide unit test stubs for Use Cases and ViewModels.
6. Use dependency injection for services (no singletons except truly global cases).
7. Suggest code in Swift 5+ style (async/await where applicable).