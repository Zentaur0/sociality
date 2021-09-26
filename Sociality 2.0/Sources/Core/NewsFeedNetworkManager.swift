//
//  NewsFeedNetworkManager.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 20.09.2021.
//

import UIKit

// MARK: - HTTPMethod

enum HTTPMethod {
    case GET
    case POST
}

// MARK: - NewsFeedProtocol

protocol NewsFeedProtocol: AnyObject {
    func getNewsPosts(httpMethod: HTTPMethod, completion: @escaping (Result<NewsResponse, Error>) -> Void)
}

// MARK: - NewsFeedNetworkManager

final class NewsFeedNetworkManager {
    
    // MARK: - Methods
    
    private func getData<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { data, _, error in
            do {
                guard let data = data else { return }
                
                let jsonObject = try JSONDecoder().decode(T.self, from: data)
                
                completion(.success(jsonObject))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}

// MARK: - NewsFeedProtocol

extension NewsFeedNetworkManager: NewsFeedProtocol {
    
    func getNewsPosts(httpMethod: HTTPMethod, completion: @escaping (Result<NewsResponse, Error>) -> Void) {
        switch httpMethod {
        case .GET:
            let url = URLs.getNewsPostURL()
            getData(url: url, completion: completion)
        case .POST:
            break
        }
    }
    
}
