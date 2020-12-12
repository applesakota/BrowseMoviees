//
//  NetworkManager.swift
//  BrowseMoviees
//
//  Created by Petar  Sakotic on 12/11/20.
//  Copyright © 2020 Petar Sakotic. All rights reserved.
//

import Foundation

enum MovieListEndpoint: String {
    case trending = "popular"
    case genre
    case upcoming
}
enum NetworksErrors: Error {
    case networkError
    case badURL
    case server
    case invalidData
    case unknown
}


class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchMovies(from endpoint: MovieListEndpoint, errorHandler: @escaping ErrorHandler, successHandler: @escaping SuccessHandler) {
        if let url = URL(string: "\(Constants.API.BASE_URL)/movie/\(endpoint.rawValue)?api_key=\(Constants.API.API_KEY)&language=en-US&page=1") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let httpResponse = response as? HTTPURLResponse else {
                    return errorHandler(NetworksErrors.networkError)
                }
                switch httpResponse.statusCode {
                case 200...299:
                    guard let jsonData = data else {
                        return errorHandler(NetworksErrors.invalidData)
                    }
                    do {
                        let allMovies = try JSONDecoder().decode(MovieList.self, from: jsonData)
                        successHandler(allMovies)
                    }
                    catch{
                        errorHandler(NetworksErrors.invalidData)
                    }
                case 400...499:
                    errorHandler(NetworksErrors.badURL)
                case 500...599:
                    errorHandler(NetworksErrors.server)
                default:
                    errorHandler(NetworksErrors.unknown)
                }
            }.resume()
        }
    }
    
}
