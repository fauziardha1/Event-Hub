import Foundation

/// A repository responsible for handling authentication-related operations.
final class AuthRepositoryImpl: AuthRepository {
    private let authAPI: AuthAPI
    
    init(authAPI: AuthAPI = AuthAPI()) {
        self.authAPI = authAPI
    }
    
    /// Logs in a user with the provided username and password.
    /// - Parameters:
    ///   - username: The username of the user.
    ///   - password: The password of the user.
    ///   - completion: A closure that gets called with the result of the login attempt, either an `AuthEntity` on success or an `Error` on failure.
    func login(username: String, password: String, completion: @escaping (Either<AuthEntity, Error>) -> Void) {
        authAPI.login(username: username, password: password) { result in
            switch result {
            case .left(let response):
                let response = AuthEntity(code: response.code)
                completion(.left(response))
            case .right(let error):
                completion(.right(error))
            }
        }
    }
}
