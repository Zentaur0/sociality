//
//  NetworkManager.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 05.08.2021.
//

import UIKit
import SwiftyJSON
import RealmSwift

class URLs {

    static let getFriends = "https://api.vk.com/method/friends.get?access_token=\(Session.shared.token)&user_id=\(Session.shared.userId)&name_case=nom&fields=photo_100,%20city&v=5.131"

    static let getGroups = "https://api.vk.com/method/groups.get?access_token=\(Session.shared.token)&user_id=\(Session.shared.userId)&extended=1&v=5.131"

    static let getSearchGroups = "https://api.vk.com/method/groups.search?access_token=\(Session.shared.token)&user_id=\(Session.shared.userId)&q=A&sort=0&v=5.131"


}

protocol NetworkManagerProtocol {
    func loadFriends(url: String, sender: UIViewController?, completion: @escaping (Result<[Friend], Error>) -> Void)

}

final class NetworkManager: NetworkManagerProtocol {

    // MARK: - Static
    static let shared = NetworkManager()
    
    private var friendNotification: NotificationToken?
    private var groupsNotification: NotificationToken?
    
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

    func loadFriends(url: String, sender: UIViewController? = nil, completion: @escaping (Result<[Friend], Error>) -> Void) {

        guard let url = URL(string: url) else { return }

        let session = URLSession.shared

        session.dataTask(with: url) { data, response, error in
            do {
                guard let data = data else { return }

                let json = try JSON(data: data)
                let friendJSON = json["response"]["items"].arrayValue
                let friends = friendJSON.map { Friend(json: $0) }
                
                completion(.success(friends))
                
                DispatchQueue.main.async {
                    self.saveToRealm(object: friends)
                }
            } catch {
                print(error, "<--- Friends Error")
                completion(.failure(error))
            }
        }.resume()
    }
    
    func loadFriendsPhotos(ownerID: String, friend: Friend, completion: @escaping (Result<[Photo], Error>) -> Void) {

        let url = "https://api.vk.com/method/photos.getAll?access_token=\(Session.shared.token)&owner_id=\(ownerID)&extended=1&v=5.131"
        
        guard let url = URL(string: url) else { return }

        let session = URLSession.shared
        
        session.dataTask(with: url) { data, response, error in
            do {
                guard let data = data else { return }
                let json = try JSON(data: data)
                let photoJSON = json["response"]["items"].arrayValue
                let photos = photoJSON.map { Photo(json: $0) }
                
                DispatchQueue.main.async { [weak self] in
                    self?.saveToRealm(object: photos)
                    self?.updateFriendPhotoRealm(photos: photos, friend: friend)
                    completion(.success(photos))
                }
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func loadGroups(url: String, completion: @escaping (Result<[Group], Error>) -> Void) {

        guard let url = URL(string: url) else { return }

        let session = URLSession.shared

        session.dataTask(with: url) { data, response, error in
            do {
                guard let data = data else { return }
                let json = try JSON(data: data)
                let groupJSON = json["response"]["items"].arrayValue
                let groups = groupJSON.map { Group(json: $0)}
                completion(.success(groups))

                DispatchQueue.main.async { [weak self] in
                    self?.saveToRealm(object: groups)
                }
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func loadGlobalGroups(text: String, completion: @escaping (Result<Group, Error>) -> Void) {
        let url = "https://api.vk.com/method/search.getHints?access_token=\(Session.shared.token)&user_id=\(Session.shared.userId)&q=\(text)&filters=groups&sort=0&search_global=1&v=5.131"

        guard let url = URL(string: url) else { return }
        
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

    private func saveToRealm<T: Object>(object: [T]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            print(realm.configuration.fileURL)
            realm.add(object, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func readFromRealm<T: Object>() -> [T] {
        do {
            let realm = try Realm()
            let realmObject = realm.objects(T.self)
            return Array(realmObject)
        } catch {
            print(error)
        }
        return []
    }
    
    func readPhotosFromRealm(ownerID: Int) -> [Photo] {
        do {
            let realm = try Realm()
            let realmObject = realm.objects(Photo.self).filter { $0.ownerID == ownerID }
            return Array(realmObject)
        } catch {
            print(error)
        }
        return []
    }
    
    private func updateFriendPhotoRealm(photos: [Photo], friend: Friend) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            for photo in photos {
                if !friend.images.contains(photo) {
                    friend.images.append(photo)
                }
            }
            realm.add(friend, update: .all)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
}
