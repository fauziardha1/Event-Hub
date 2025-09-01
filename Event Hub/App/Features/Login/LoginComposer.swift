//
//  LoginComposer.swift
//  Event Hub
//
//  Created by Fauzi Arda on 01/09/25.
//

import UIKit

final class LoginComposer {
    private init() {}
    
    static func compose() -> UIViewController {
        let repository = AuthRepositoryImpl()
        let useCase = AuthUsecase(authRepository: repository)
        let viewModel = LoginViewModel(authUseCase: useCase)
        let controller = LoginViewController(viewModel: viewModel)
        return controller
    }
}
