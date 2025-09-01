//
//  Either.swift
//  Event Hub
//
//  Created by Fauzi Arda on 01/09/25.
//

import Foundation

/// Type Utilty that can be used when it need to have one of two possible type, as a return or event as a params.
///  - Left: First Possible Type.
///  - Right: Second Possible Type.
/// - Description: We can use every data type for left or right type.
enum Either<Left, Right> {
    case left(Left)
    case right(Right)
}

extension Either {
    
    /// Property to handle when left condition is used
    var left: Left? {
        if case .left(let value) = self {
            return value
        }
        return nil
    }

    /// Property to handle when right condition is used
    var right: Right? {
        if case .right(let value) = self {
            return value
        }
        return nil
    }
    
    /// Method to handle both condition at same time, in case we need to return left and right condition at the same time.
    /// - Parameters:
    ///   - left: Action that will be applied to left condition.
    ///   - right: Action that will be applied to right condition.
    /// - Returns: Anything types that want to used in each action.
    func fold<T>(left: (Left) -> T, right: (Right) -> T) -> T {
        switch self {
        case .left(let l):
            return left(l)
        case .right(let r):
            return right(r)
        }
    }
}
