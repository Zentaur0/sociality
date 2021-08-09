//
//  NetworkManager.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 05.08.2021.
//

import UIKit

final class NetworkManager {

    // MARK: - Static
    static let shared = NetworkManager()

    func loadFriend(token: String, userID: String, sender: UIViewController? = nil)  {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "user_id", value: userID),
            URLQueryItem(name: "name_case", value: "nom"),
            URLQueryItem(name: "fields", value: "photo_100"),
            URLQueryItem(name: "v", value: "5.131")
        ]

        guard let url = urlComponents.url else { return }

        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                guard let data = data else { return }
                let json = try JSONSerialization.jsonObject(with: data)
                print(json)
                UserDefaults.standard.set(true, forKey: "isAuthorized")
                DispatchQueue.main.async {
                    sender?.dismiss(animated: true) {
                        AppContainer.createSpinnerView(UIApplication.topViewController() ?? UIViewController(),
                                                       AppContainer.makeRootController())
                    }
                }
            } catch {
                print(error, "<--- Friends Error")
                UserDefaults.standard.set(false, forKey: "isAuthorized")
                DispatchQueue.main.async {
                    sender?.dismiss(animated: true) {
                        AppContainer.createSpinnerView(UIApplication.topViewController() ?? UIViewController(),
                                                       AppContainer.makeRootController())
                    }
                }
            }
        }

        dataTask.resume()
    }

    func loadPhotos(token: String, userID: String) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.getAll"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.131")
        ]

        guard let url = urlComponents.url else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                guard let data = data else { return }
                let json = try JSONSerialization.jsonObject(with: data)
                print(json)
            } catch {
                print(error, "<--- Photos Error")
            }
        }

        dataTask.resume()
    }

    func loadGroups(token: String, userID: String) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "user_id", value: userID),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.131")
        ]

        guard let url = urlComponents.url else { return }

        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                guard let data = data else { return }
                let json = try JSONSerialization.jsonObject(with: data)
                print(json, "<--- Groups")
            } catch {
                print(error, "<--- error")
            }
        }

        dataTask.resume()
    }

    func loadGlobalGroups(token: String, userID: String, text: String? = nil) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.search"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "user_id", value: userID),
            URLQueryItem(name: "q", value: text),
            URLQueryItem(name: "sort", value: "0"),
            URLQueryItem(name: "v", value: "5.131")
        ]

        guard let url = urlComponents.url else { return }
        print(url)

        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                guard let data = data else { return }
                print(url)
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(json)
            } catch {
                print(error, "<--- Search error")
            }
        }

        dataTask.resume()
    }
}
