import UIKit

enum LogoutComposer {
    static func compose(withDependency dependency: LogoutDependency) -> UIViewController {
        let viewModel = LogoutViewModel(routeToLogin: dependency.routeToLogin)
        let viewController = LogoutConfirmationViewController(viewModel: viewModel)
        return viewController
    }
}

struct LogoutDependency {
    let routeToLogin: () -> Void
    
    init(routeToLogin: @escaping () -> Void) {
        self.routeToLogin = routeToLogin
    }
}

