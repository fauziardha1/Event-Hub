import Foundation

/// ViewModel for handling login logic.
final class LoginViewModel {
    private let authUseCase: AuthBusinessLogic
    
    var onLoginSuccess: (() -> Void)?
    var onLoginFailure: ((String) -> Void)?
    
    init(authUseCase: AuthBusinessLogic) {
        self.authUseCase = authUseCase
    }
    
    /// Handles the login process.
    /// - Parameters:
    ///   - username: username input by user
    ///   - password: password input by user
    func login(username: String, password: String) {
        guard !username.isEmpty, !password.isEmpty else {
            onLoginFailure?("Please enter username and password")
            return
        }
        
        authUseCase.login(username: username, password: password) { [weak self] result in
            switch result {
            case .left(_):
                self?.onLoginSuccess?()
                print("Login successful")
            case .right(let error):
                self?.onLoginFailure?(error.localizedDescription)
            }
        }
    }
}
