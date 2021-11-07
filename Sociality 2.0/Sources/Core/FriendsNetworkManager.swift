//
//  FriendsNetworkManager.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 26.09.2021.
//

import PromiseKit
import SwiftyJSON

// MARK: - FriendsNetworkManager

final class FriendsNetworkManager {
    
    // MARK: - Static
    
    static let shared = FriendsNetworkManager()
    
    // MARK: - Init
    
    private init() {}

}

// MARK: - Methods

extension FriendsNetworkManager {
    
    func loadFriendsWithPromise(url: URL) -> Promise<[Friend]> {
        
        let (promise, resolver) = Promise<[Friend]>.pending()
        
        firstly {
            URLSession.shared.dataTask(.promise, with: URLRequest(url: url))
        }.map {
            let json = try JSON(data: $0.data)
            let friendJSON = json["response"]["items"].arrayValue
            let friends = friendJSON.map { Friend(json: $0)}
            resolver.fulfill(friends)
        }.catch { error in
            resolver.reject(error)
        }
        
        return promise
    }
    
}
