//
//  Config.swift
//  MoviesApp
//
//  Created by Mohamed Allam on 24/01/2024.
//

import Foundation

class AppConfig {
    enum Keys: String {
        case baseURL = "baseURL"
        case imagesURL = "imagesBaseURL"
        case apiToken = "apiToken"
    }
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    static let baseURL: String = {
        guard let baseURL = AppConfig.infoDictionary[Keys.baseURL.rawValue] as? String else {
            fatalError("API Key not set in plist for this environment")
        }
        return baseURL
    }()
    static let imagesBaseURL: String = {
        guard let baseURL = AppConfig.infoDictionary[Keys.imagesURL.rawValue] as? String else {
            fatalError("API Key not set in plist for this environment")
        }
        return baseURL
    }()
    
    static let apiToken: String = {
        guard let apiToken = AppConfig.infoDictionary[Keys.apiToken.rawValue] as? String else {
            fatalError("API Key not set in plist for this environment")
        }
        return apiToken
    }()
}
