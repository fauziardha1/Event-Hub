//
//  NetworkManager.swift
//  Event Hub
//
//  Created by Fauzi Arda on 01/09/25.
//

import Foundation
import Network

/// Class that handle the network request action
class NetworkManager: NSObject {
    static let shared = NetworkManager()
    var lastResData = String()
    var setProcessPercentage: (Int) -> Void = { _ in }
    private var session: URLSession = URLSession.shared
    
    private let monitor = NWPathMonitor()
    private let monitorQueue = DispatchQueue(label: "NetworkMonitor")
    private(set) var interfaceType: NWInterface.InterfaceType? = nil
    private(set) var isConnected: Bool = false
    //
    static let networkStatusChanged = Notification.Name("NetworkStatusChanged")
    
    override init() {
        super.init()
        self.session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        startMonitoring()
    }
    
    deinit {
        stopMonitoring()
    }
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else {return}
            self.isConnected = path.status == .satisfied
            self.interfaceType = path.availableInterfaces.filter{ path.usesInterfaceType($0.type) }.first?.type
            
            NotificationCenter.default.post(name: Self.networkStatusChanged, object: nil) // broadcast observer
            let connectionName = self.getConnectionName()
            print("Network status changed: \(self.isConnected == true ? "Online using \(connectionName)" : "Offline")")
        }
        monitor.start(queue: monitorQueue)
    }
    
    private func stopMonitoring() {
        monitor.cancel()
    }
    
    private func getConnectionName() -> String {
        if !NetworkManager.shared.isConnected {
            return "Offline"
        }
        
        switch interfaceType {
           case .wifi:
               return "Wi-Fi"
           case .cellular:
               return "Cellular"
           case .wiredEthernet:
               return "Ethernet"
           case .loopback:
               return "Loopback"
           case .other:
               return "Other"
           default:
               return "Unknown"
           }
    }
    
    /// Method to perform request to remote or network data source.
    /// - Parameters:
    ///   - request: Request data that needed to perform a network request.
    ///   - responseType: Data type to catch the value from json to data object.
    ///   - completion: Action that consist results of this request.
    /// - Returns: Void
    func performRequest<T: Decodable>(request: NetworkRequest, responseType: T.Type, completion: @escaping (_ result: Result<T, NetworkError>) -> Void) {
        let urlRequest = composeURLRequest(from: request)
        let jsonBody = String(data: request.body ?? Data() , encoding: .utf8)?.prettify() ?? String()
        log(request: urlRequest)
        
        let task = session.dataTask(with: urlRequest) { data, httpResponse, error in
            self.log(response: (httpResponse as? HTTPURLResponse) ?? HTTPURLResponse(), data: data ?? Data())
            if error != nil {
                guard let error = error as? NSError, error.code == NSURLErrorTimedOut else {
                    return completion(.failure(.unknownError(message: error?.localizedDescription ?? "Unkown Error")))
                }
                return completion(.failure(.timeout))
            }
            
            guard let httpResponse = httpResponse as? HTTPURLResponse else {
                return completion(.failure(.unknownError(message: "No HTTPResponse returned.")))
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                return completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
            }
            
            guard let data = data, !data.isEmpty else {  return completion(.failure(.noData)) }
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                return completion(.success(decodedResponse))
            } catch {
                print(error.localizedDescription)
                print(error)
                return completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
    
    /// Method to compose a url request from a network request data
    /// - Parameter request: all data that need to compose url request
    /// - Returns: complete url request
    private func composeURLRequest(from request: NetworkRequest) -> URLRequest {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod       = request.method.rawValue
        urlRequest.httpBody         = request.body
        urlRequest.timeoutInterval  = request.requestTimeOut
        
        for (key,value) in request.headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        return urlRequest
    }
    
     func isConnectionAvailable(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://www.apple.com") else {
            completion(false)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        log(request: request)
         
        URLSession.shared.dataTask(with: request) { data, response, error in
            self.log(response: (response as? HTTPURLResponse) ?? HTTPURLResponse(), data: data ?? Data())
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                completion(true)
            } else {
                completion(false)
            }
        }.resume()
    }
    
    func log(request: URLRequest) {
        print("\n======== Request ========")
        print("URL: \(request.url?.absoluteString ?? String())")
        print("Method: \(request.httpMethod ?? String())")
        print("Header: \(request.allHTTPHeaderFields ?? [:])")
        print("Request Time: \(Date())")
        print("RequestTimeOut: \(request.timeoutInterval.description)")
        print("\nRequest Body: \(String(data: request.httpBody ?? Data(), encoding: .utf8)?.prettify() ?? String())" )
    }
    
    func log(response: HTTPURLResponse, data: Data?) {
        print("\n======== Response  ========")
        print("URL: \(response.url?.absoluteString ?? String())")
        print("Status Code: \(response.statusCode)" )
        print("Response Time: \(Date())")
        let headers = response.allHeaderFields.map { "\($0.key): \($0.value)" }
        print("Header: \(headers)")
        print("\nResponse Body: \(String(data: data ?? Data(), encoding: .utf8)?.prettify() ?? String())")
    }
    
    func cancelAllTasks() {
        session.invalidateAndCancel()
        session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        print("All tasks cancelled and session reset.")
    }
}


 extension String {
    func prettify() -> Self {
        let cleanedString = self
            .replacingOccurrences(of: "\\n", with: "\n")
            .replacingOccurrences(of: "\\\"", with: "\"")

        if let jsonData = cleanedString.data(using: .utf8) {
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                if let prettyString = String(data: prettyData, encoding: .utf8) {
                    return prettyString
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        } else {
            print("Failed to create Data from the raw string.")
        }
        return self
    }
}

extension NetworkManager: URLSessionTaskDelegate {
    func urlSession(_ session: URLSession,
                    task: URLSessionTask,
                    didSendBodyData bytesSent: Int64,
                    totalBytesSent: Int64,
                    totalBytesExpectedToSend: Int64) {
        let progress = Double(totalBytesSent) / Double(totalBytesExpectedToSend)
        print(String(format: "Upload progress: %.2f%%", progress * 100))
        let percent = Int(progress * 100)
        guard percent < 100 else {
            setProcessPercentage(percent)
            self.setProcessPercentage = { _ in }
            return
        }
        setProcessPercentage(percent)
    }
}
