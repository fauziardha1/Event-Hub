//
//  LogoutViewModel.swift
//  Event Hub
//
//  Created by Fauzi Arda on 02/09/25.
//

import Foundation

class LogoutViewModel {
    private let routeToLogin: () -> Void
    
    init(routeToLogin: @escaping () -> Void) {
        self.routeToLogin = routeToLogin
    }
    
    func performLogout() {
        // Perform any necessary cleanup or logout actions here
        
        // Navigate back to the login screen
        routeToLogin()
    }

}
