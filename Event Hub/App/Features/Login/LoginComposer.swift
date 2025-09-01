//
//  LoginComposer.swift
//  Event Hub
//
//  Created by Fauzi Arda on 01/09/25.
//

import UIKit

final class LoginComposer {
    private init() {}
    
    static func compose(with LoginDependency: LoginDependency) -> UIViewController {
        let repository = AuthRepositoryImpl()
        let useCase = AuthUsecase(authRepository: repository)
        let viewModel = LoginViewModel(authUseCase: useCase, routeToEventPage: LoginDependency.routeToEventPage)
        let controller = LoginViewController(viewModel: viewModel)
        return controller
    }
}


struct LoginDependency {
    let routeToEventPage: () -> Void
    
    init(routeToEventPage: @escaping () -> Void) {
        self.routeToEventPage = routeToEventPage
    }
    
}
