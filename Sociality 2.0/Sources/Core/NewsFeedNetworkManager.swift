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
                    groups = response.groups.map { GroupModel(id: $0.id, name: $0.name, photo: $0.photo, date: 0) }
                }

                DispatchQueue.global(qos: .userInteractive).async(group: dispatchGroup) {
                    profiles = response.profiles.map { ProfileModel(id: $0.id,
                                                                    firstName: $0.firstName,
                                                                    lastName: $0.lastName,
                                                                    photo: $0.photo)
                    }
                }

                DispatchQueue.global(qos: .userInteractive).async(group: dispatchGroup) {
                    items = response.items.map {
                        ItemsModel(id: $0.id,
                                   date: $0.date,
                                   sourceID: $0.sourceID,
                                   comments: $0.comments?.count ?? 0,
                                   likes: $0.likes?.count ?? 0,
                                   text: $0.text,
                                   photoURL: $0.attachments?.last?.photo?.sizes.last?.url ?? "",
                                   photoWidth: $0.attachments?.last?.photo?.sizes.last?.width ?? 0,
                                   photoHeight: $0.attachments?.last?.photo?.sizes.last?.height ?? 0,
                                   isLiked: $0.likes?.userLikes == 1 ? true : false
                        )
                    }
                }

                dispatchGroup.notify(queue: .main) {
                    let newsFeedItems = NewsFeedItems(groups: groups, items: items, profiles: profiles, nextFrom: nextFromStr ?? "")
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
