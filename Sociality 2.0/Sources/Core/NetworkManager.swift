//
//  NetworkManager.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 05.08.2021.
//

import UIKit
import SwiftyJSON

// MARK: - NetworkManagerProtocol

protocol NetworkManagerProtocol: AnyObject {
    func loadFriends(url: URL, completion: @escaping (Result<[Friend], Error>) -> Void)
    func loadGlobalGroups(url: URL, completion: @escaping (Result<Group, Error>) -> Void)
}

// MARK: - NetworkManager

final class NetworkManager {

    // MARK: - Static
    static let shared = NetworkManager()
    
}

// MARK: - Methods

extension NetworkManager: NetworkManagerProtocol {
    
    func authorize(sender: UIViewController, isAuthorized: Bool) {
        if isAuthorized {
            UserDefaults.standard.set(true, forKey: "isAuthorized")
            
            DispatchQueue.main.async {
                sender.dismiss(animated: true) {
                    AppContainer.createSpinnerView(UIApplication.topViewController() ?? UIViewController(),
                                                   AppContainer.makeRootController())
                }
            }
        } else {
            UserDefaults.standard.set(false, forKey: "isAuthorized")

            DispatchQueue.main.async {
                sender.dismiss(animated: true) {
                    AppContainer.createSpinnerView(UIApplication.topViewController() ?? UIViewController(),
                                                   AppContainer.makeRootController())
                }
            }
        }
    }

    func loadFriends(url: URL, completion: @escaping (Result<[Friend], Error>) -> Void) {
        let session = URLSession.shared

        session.dataTask(with: url) { data, response, error in
            do {
                guard let data = data else { return }

                let json = try JSON(data: data)
                let friendJSON = json["response"]["items"].arrayValue
                let friends = friendJSON.map { Friend(json: $0) }
                
                completion(.success(friends))
                
                DispatchQueue.main.async {
                    RealmManager.shared.saveToRealm(object: friends)
                }
            } catch {
                print(error, "<--- Friends Error")
                completion(.failure(error))
            }
        }.resume()
    }
    
    func loadFriendsPhotos(friend: Friend, completion: @escaping (Result<[Photo], Error>) -> Void) {

        let url = "https://api.vk.com/method/photos.getAll?access_token=\(Session.shared.token)&owner_id=\(friend.id)&extended=1&v=5.131"
        
        guard let url = URL(string: url) else { return }

        let session = URLSession.shared
        
        session.dataTask(with: url) { data, response, error in
            do {
                guard let data = data else { return }
                let json = try JSON(data: data)
                let photoJSON = json["response"]["items"].arrayValue
                let photos = photoJSON.map { Photo(json: $0) }
                
                DispatchQueue.main.async {
                    RealmManager.shared.saveToRealm(object: photos)
                    RealmManager.shared.updateFriendPhotoRealm(photos: photos, friend: friend)
                    completion(.success(photos))
                }
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func loadGlobalGroups(url: URL, completion: @escaping (Result<Group, Error>) -> Void) {
        let session = URLSession.shared

        session.dataTask(with: url) { data, response, error in
            do {
                guard let data = data else { return }
                let json = try JSON(data: data)
                let groupJSON = json["response"]["items"].arrayValue.first?["group"]

                guard let groupJSON = groupJSON else { return }
                let group = Group(json: groupJSON)
                completion(.success(group))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
