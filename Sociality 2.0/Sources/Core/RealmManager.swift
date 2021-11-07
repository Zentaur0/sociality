//
//  RealmManager.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 15.09.2021.
//

import UIKit
import RealmSwift

// MARK: - RealmManager

final class RealmManager {
    
    // MARK: - Static
    
    static let shared = RealmManager()
    
    // MARK: - Properties
    
    private var notificationToken: NotificationToken?
    private var friendNotification: NotificationToken?
    private var groupsNotification: NotificationToken?
    private var friendPhotosNotification: NotificationToken?
    
    // MARK: - Init
    
    private init() {}
    
    // MARK: - Methods
    
    func saveToRealm<T: Object>(object: [T]) {
        do {
            let realm = try Realm()
            if realm.isEmpty {
                realm.beginWrite()
                print(realm.configuration.fileURL ?? "")
                realm.add(object, update: .modified)
                try realm.commitWrite()
            } else {
                let realmObject = realm.objects(T.self)
                notificationToken = realmObject.observe { change in
                    switch change {
                    case .error(let error):
//                        print(error)
                    break
                    case .initial(let object):
//                        print(object)
                    break
                    case .update(let object, let deletions, let insertions, let modifications):
//                        print(object)
//                        print(deletions)
//                        print(insertions)
//                        print(modifications)
                    break
                    }
                }
            }
        } catch {
            print(error)
        }
    }
    
    func readFromRealm<T: Object>() -> [T] {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            let realmObject = realm.objects(T.self)
            return Array(realmObject)
        } catch {
            print(error)
        }
        return []
    }
    
    func readPhotosFromRealm(ownerID: Int) -> [Photo] {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            let realmObject = realm.objects(Photo.self).filter { $0.ownerID == ownerID }
            return Array(realmObject)
        } catch {
            print(error)
            return []
        }
    }
    
    func updateFriendPhotoRealm(photos: [Photo], friend: RLMFriend) {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
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
