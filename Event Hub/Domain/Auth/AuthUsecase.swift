//
//  AuthUsecase.swift
//  Event Hub
//
//  Created by Fauzi Arda on 01/09/25.
//
import Foundation

///  Protocol communication between  Usecase and Presentation layer
protocol AuthBusinessLogic {
    func login(username: String, password: String, completion: @escaping (_ result: Either<Bool, Error>)-> Void)
}


/// Usecase implementation for authentication
class AuthUsecase: AuthBusinessLogic {
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    /// Login method to authenticate user
    /// - Parameters:
    ///   - username: username string to login
    ///   - password: password string to login
    ///   - completion: completion handler to trigger  after login process finished
    func login(username: String, password: String, completion: @escaping (_ result: Either<Bool, Error>)-> Void) {
        let backgroundTask = DispatchWorkItem { [weak self] in
            guard let self else {return}
            
            self.authRepository.login(username: username, password: password) { result in
                    
                switch result {
                    
                    case .left(let success):
                        guard success.code == "00" else {
                            let credentialError = NetworkError.unknownError(message: "Invalid credentials")
                            DispatchQueue.main.async { completion(.right(credentialError)) }
                            return
                        }
                        DispatchQueue.main.async { completion(.left(true)) }
                        return
                    
                    case .right(let error):
                        DispatchQueue.main.async { completion(.right(error)) }
                        return
                }
            }
        }
        
        DispatchQueue.global(qos: .background).async(execute: backgroundTask)
        
    }
}


