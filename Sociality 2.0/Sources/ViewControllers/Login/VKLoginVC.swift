//
//  VKLoginVC.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 05.08.2021.
//

import UIKit
import WebKit

final class VKLoginVC: UIViewController {

    // MARK: - Properties
    private var webView: WKWebView?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupConstraints()
        loadRequest()
    }

    deinit {
        print("VKLoginVC is deinitialized")
    }
}

// MARK: - ViewControllerSetupDelegate
extension VKLoginVC: ViewControllerSetupDelegate {
    func setupVC() {
        webView = WKWebView()

        guard let webView = webView else { return }

        webView.navigationDelegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(close))
        view.addSubview(webView)
    }

    func setupConstraints() {
        guard let webView = webView else { return }
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

// MARK: - Methods
extension VKLoginVC {
    private func loadRequest() {
        let url = getURL()
        let request = URLRequest(url: url)
        webView?.load(request)
    }

    private func getURL() -> URL {

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7802232"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "state", value: "succeded")
        ]

        let url = urlComponents.url

        guard let url = url else { return URL(fileURLWithPath: "") }
        return url
    }

}

// MARK: - WKNavigationDelegate
extension VKLoginVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment else {

            decisionHandler(.allow)
            return
        }

        let parameters = fragment.components(separatedBy: "&")
                        .map { $0.components(separatedBy: "=") }
                        .reduce([String: String]()) { result, parameters in
                            var dict = result
                            let key = parameters[0]
                            let value = parameters[1]
                            dict[key] = value
                            return dict
        }

        guard let token = parameters["access_token"],
              let userIdString = parameters["user_id"] else {
            decisionHandler(.allow)
            return
        }

        UserDefaults.standard.set(token, forKey: "token")
        UserDefaults.standard.set(Int(userIdString), forKey: "userID")

        NetworkManager.shared.loadFriends(url: URLs.getFriends, sender: self) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let friends):
                DataProvider.shared.allFriends = friends
            }
        }

        NetworkManager.shared.loadPhotos(token: token, userID: userIdString)
        
        decisionHandler(.cancel)
    }

}

// MARK: - Actions
extension VKLoginVC {
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }

}
