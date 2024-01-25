//
//  NetworkClient.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation
import Combine

/// NetworkClient protocol
protocol NetworkClientProtocol: AnyObject {
    func request<R: Codable>(request: URLRequest, mapToModel: R.Type) -> AnyPublisher<R, NetworkError>

}

/// NetworkClient Concerate class
final class NetworkClient: NetworkClientProtocol {
    private var configuration: URLSessionConfiguration
    private var session: URLSession
    
    /// Init NetworkClient
    /// - Parameters:
    ///   - configuration: URLSessionConfigartions
    ///   - session: URLSession
    init(configuration: URLSessionConfiguration, session: URLSession) {
        self.configuration = configuration
        self.session = session
    }
    
    /// request URL and return Publisher of type <R:Codable, NetworkError>
    /// - Parameters:
    ///   - request: URLRequest
    ///   - mapToModel: Codable
    /// - Returns: AnyPublisher<R: Codable, NetworkError>
    func request<R: Codable>(request: URLRequest, mapToModel: R.Type) -> AnyPublisher<R, NetworkError> {
    
        return session.dataTaskPublisher(for: request)
            .tryMap { element -> Data in
                guard let response = element.response as? HTTPURLResponse,
                        (200...299).contains(response.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: R.self, decoder: JSONDecoder())
            .mapError({ error -> NetworkError in
                if let error = error as? NetworkError {
                    return error
                }
                if let decodingError = error as? Swift.DecodingError {
                    switch decodingError {
                    case .typeMismatch(let key, let value):
                        debugPrint("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
                    default: break
                    }
                }
                return NetworkError.normalError(error)
            })
            .eraseToAnyPublisher()
    }
}

