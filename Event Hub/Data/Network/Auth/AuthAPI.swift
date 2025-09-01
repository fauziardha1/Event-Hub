import Foundation

final class AuthAPI {
    private let networkManager: NetworkManager
    var authURLString = "https://skill-test2.free.beeceptor.com/api/login"
    
    init(networkManager: NetworkManager = .shared) {
        self.networkManager = networkManager
    }
    
    func login(username: String, password: String, completion: @escaping (Either<LoginResponseModel, Error>) -> Void) {
        let request = composeSummaryRequest(from: LoginRequestModel(username: username, password: password))
        networkManager.performRequest(request: request, responseType: LoginResponseModel.self) { result in
            switch result {
            case .success(let response):
                completion(.left(response))
            case .failure(let error):
                completion(.right(error))
            }
        }
    }
    
    private func composeSummaryRequest(from requestData: LoginRequestModel) -> NetworkRequest {
        let urlString = self.authURLString
        let url = URL(string: urlString) ?? URL(fileURLWithPath: "")
        
        do {
            let reqBody = try JSONEncoder().encode(requestData)
            return NetworkRequest(url: url, method: .POST, body: reqBody)
        } catch {
            print("Failed to encode request data to JSON body: \(error)")
            return NetworkRequest(url: url, method: .POST)
        }
    }
}
