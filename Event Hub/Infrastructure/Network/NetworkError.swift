//
//  NetworkError.swift
//  Event Hub
//
//  Created by Fauzi Arda on 01/09/25.
//

import Foundation

/// Enum to catch an error that occure on perform a network request.
enum NetworkError: LocalizedError, Equatable {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
    case unknownError(message: String)
    case timeout
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("We couldn't connect. Please try again later.", comment: "Invalid URL Error")
        case .noData:
            return NSLocalizedString("We got no more data to show you right now. Enjoy, or try again later!", comment: "No Data Error")
        case .decodingError:
            return NSLocalizedString("Sorry, we couldn't process the information right now. Please try again later.", comment: "Decoding Error")
        case .serverError:
            return NSLocalizedString("The server is having a little trouble. Please try again soon.", comment: "Server Error")
        case .unknownError:
            return NSLocalizedString("Something went wrong. Please try again.", comment: "Unknown Error")
        case .timeout:
            return NSLocalizedString("It's taking longer than usual. Please check your connection and try again.", comment: "Request Time Out")
        }
    }

        var failureReason: String? {
            switch self {
            case .invalidURL:
                return NSLocalizedString("The provided URL is malformed.", comment: "Invalid URL Failure Reason")
            case .noData:
                return NSLocalizedString("The server responded with no data.", comment: "No Data Failure Reason")
            case .decodingError:
                return NSLocalizedString("The data could not be decoded.", comment: "Decoding Failure Reason")
            case .serverError(let statusCode):
                return String(format: NSLocalizedString("The server responded with a status code %d.", comment: "Server Error Failure Reason"), statusCode)
            case .unknownError(let message):
                return NSLocalizedString("An unexpected error occurred. \(message).", comment: "Unknown Failure Reason")
            case .timeout:
                return NSLocalizedString("The server did not respond within the expected time frame.", comment: "Timeout Failure Reason")
            }
        }

        var recoverySuggestion: String? {
            switch self {
            case .invalidURL:
                return NSLocalizedString("Please check the URL and try again.", comment: "Invalid URL Recovery Suggestion")
            case .noData:
                return NSLocalizedString("Please try again later.", comment: "No Data Recovery Suggestion")
            case .decodingError:
                return NSLocalizedString("Please verify the data format and try again.", comment: "Decoding Error Recovery Suggestion")
            case .serverError:
                return NSLocalizedString("Please try again later.", comment: "Server Error Recovery Suggestion")
            case .unknownError:
                return NSLocalizedString("Please try again later.", comment: "Unknown Error Recovery Suggestion")
            case .timeout:
                return NSLocalizedString("Check your internet connection and try again.", comment: "Timeout Recovery Suggestion")
            }
        }

        var helpAnchor: String? {
            return NSLocalizedString("For more information, visit our help center.", comment: "Help Anchor")
        }
}
