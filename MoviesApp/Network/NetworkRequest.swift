//
//  NetworkRequest.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation

protocol NetworkRequest {
  var baseURL: String { get  }
  var endPoint: String { get }
  var headers: [String: String]? { get }
  var queryParams: [String: Any]? { get }
  var parameters: [String: Any]? { get }
  var method: NetworkHTTPMethod { get }

}

extension NetworkRequest {
  var makeRequest: URLRequest {
    guard var urlComponents = URLComponents(string: baseURL) else { return URLRequest(url: URL(string: "") ?? URL(fileURLWithPath: "")) }
    urlComponents.path = "\(urlComponents.path)\(endPoint)"

    if let queryParams = queryParams {
      urlComponents.queryItems = self.addQueryItems(queryParams: queryParams)
    }
    guard let url = urlComponents.url else { return URLRequest(url: URL(string: baseURL)!) }
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    if let headers = headers {
      _ = headers.map({
        request.addValue($0.value, forHTTPHeaderField: "\($0.key)")}
      )
    }
    if let params = parameters {
      let jsonData = try? JSONSerialization.data(withJSONObject: params)
      request.httpBody = jsonData
    }
    return request
  }

  private func addQueryItems(queryParams: [String: Any]) -> [URLQueryItem] {
    return queryParams.map({
      URLQueryItem(name: $0.key, value: "\($0.value)")}
    )
  }
}
