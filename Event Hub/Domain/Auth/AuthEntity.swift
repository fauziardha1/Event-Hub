//
//  AuthEntity.swift
//  Event Hub
//
//  Created by Fauzi Arda on 01/09/25.
//

import Foundation

/// Entity representing authentication details.
struct AuthEntity {
    let code: String
    
    init(code: String) {
        self.code = code
    }
}
