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
    case credits
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
    func getCategories(from endpoint: MovieListEndpoint, errorHandler: @escaping ErrorHandler, successHandler: @escaping SuccessHandler) {
        if let url = URL(string: "\(Constants.API.BASE_URL)/\(endpoint.rawValue)/movie/list?api_key=\(Constants.API.API_KEY)&language=en-US") {
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
                        guard let jsonDict = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
                              let genresDict = jsonDict["genres"],
                              let genresData = try? JSONSerialization.data(withJSONObject: genresDict, options: .init()) else {
                            return errorHandler(NetworksErrors.invalidData)
                        }
                        let allGenres = try JSONDecoder().decode([Genre].self, from: genresData)
                        successHandler(allGenres)
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
    func getCredits(from movieId: Int, endpoint: MovieListEndpoint, errorHandler: @escaping ErrorHandler, successHandler: @escaping SuccessHandler) {
        if let url = URL(string: "\(Constants.API.BASE_URL)/movie/\(movieId)/\(endpoint.rawValue)?api_key=\(Constants.API.API_KEY)&language=en-US") {
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
                        let allCredits = try JSONDecoder().decode(CreditsList.self, from: jsonData)
                        successHandler(allCredits)
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


