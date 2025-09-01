import Foundation

struct LoginResponseModel: Decodable {
    let code: String
    let message: String
}

struct LoginRequestModel: Codable {
    let username: String
    let password: String
}
