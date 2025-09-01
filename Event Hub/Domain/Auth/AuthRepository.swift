import Foundation

protocol AuthRepository {
    func login(username: String, password: String, completion: @escaping (Either<AuthEntity, Error>) -> Void)
}

enum AuthError: Error {
    case invalidCredentials
    case networkError
    case serverError
}
