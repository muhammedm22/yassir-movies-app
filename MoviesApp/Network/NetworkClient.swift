//
//  NetworkClient.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation
protocol NetworkClientProtocol: AnyObject {
    func request<R: Codable>(request: URLRequest, mapToModel: R.Type, completion: @escaping (Result<R, NetworkError>) -> Void)
}
final class NetworkClient: NetworkClientProtocol {
    private var configuration: URLSessionConfiguration
    private var session: URLSession
    init(configuration: URLSessionConfiguration, session: URLSession) {
        self.configuration = configuration
        self.session = session
    }
    func request<R: Codable>(request: URLRequest, mapToModel: R.Type, completion: @escaping (Result<R, NetworkError>) -> Void) {
        session.dataTask(with: request, completionHandler: { data, response, error in
            guard let url = URL(string: request.url?.absoluteString ?? "") else {
                completion(.failure(NetworkError.badURL))
                return
            }
            if let error = error {
                completion(.failure(NetworkError.normalError(error)))
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                return
            }
            guard let data = data else { return }
            do {
                let decodedData = try JSONDecoder().decode(R.self, from: data)
                completion(.success(decodedData))
            } catch {
                if let decodingError = error as? Swift.DecodingError {
                    switch decodingError {
                    case .typeMismatch(let key, let value):
                        debugPrint("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
                    default: break
                    }
                }
            }
        }).resume()
    }
}

