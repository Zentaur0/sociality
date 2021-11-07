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
    func getNewsPosts(httpMethod: HTTPMethod, url: URL, completion: @escaping (Result<NewsFeedItems, Error>, String) -> Void)
}

// MARK: - NewsFeedNetworkManager

final class NewsFeedNetworkManager {
    
    private let viewModelFactory = NewsViewModelFactory()
    
    // MARK: - Methods
    
    private func getData(url: URL, completion: @escaping (Result<NewsFeedItems, Error>, String) -> Void) {
        self.decodeObjects(url: url, completion: completion)
    }
    
    private func decodeObjects(url: URL,
                               completion: @escaping (Result<NewsFeedItems, Error>, String) -> Void) {
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { data, _, error in
            do {
                guard let data = data else { return }
                
                let jsonObject = try JSONDecoder().decode(NewsResponse.self, from: data)
                
                let response = jsonObject.response
                let dispatchGroup = DispatchGroup()
                
                let nextFromStr = response.next_from

                var profiles = [ProfileModel]()
                var groups = [GroupModel]()
                var items = [ItemsModel]()

                DispatchQueue.global(qos: .userInteractive).async(group: dispatchGroup) {
                    groups = self.viewModelFactory.constructGroupViewModels(groups: response.groups)
                }

                DispatchQueue.global(qos: .userInteractive).async(group: dispatchGroup) {
                    profiles = self.viewModelFactory.constructProfileViewModels(profiles: response.profiles)
                }

                DispatchQueue.global(qos: .userInteractive).async(group: dispatchGroup) {
                    items = self.viewModelFactory.constructItemViewModels(items: response.items)
                }

                dispatchGroup.notify(queue: .main) {
                    let newsFeedItems = self.viewModelFactory.constructNewsViewModels(groups: groups,
                                                                                      items: items,
                                                                                      profiles: profiles,
                                                                                      nextFrom: nextFromStr ?? "")
                    completion((.success(newsFeedItems)), nextFromStr ?? "")
                }
            } catch {
                completion((.failure(error)), "")
            }
        }
        
        dataTask.resume()
    }
    
}

// MARK: - NewsFeedProtocol

extension NewsFeedNetworkManager: NewsFeedProtocol {
    
    func getNewsPosts(httpMethod: HTTPMethod,
                      url: URL,
                      completion: @escaping (Result<NewsFeedItems, Error>, String) -> Void) {
        switch httpMethod {
        case .GET:
            getData(url: url, completion: completion)
        case .POST:
            break
        }
    }
    
}
