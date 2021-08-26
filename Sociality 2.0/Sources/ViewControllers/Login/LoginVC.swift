//
//  ViewController.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 30.07.2021.
//

import UIKit
import SnapKit
import WebKit

final class LoginVC: UIViewController {
    
    // MARK: - Properties
    private var socialityLabel: UILabel?
    private var usernameTextField: UITextField?
    private var passwordTextField: UITextField?
    private var loginButton: UIButton?
    private var vkLoginButton: UIButton?
    private var scrollView: UIScrollView?
    private var contentView: UIView?
    private var spinner = Spinner()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupConstraints()

        let isAuthorized = UserDefaults.standard.bool(forKey: "isAuthorized")

        if isAuthorized {
            AppContainer.createSpinnerView(self, AppContainer.makeRootController())
        }
    }
    
    deinit {
        print("login screen is deinitialized")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - Methods
extension LoginVC {
    private func setupVC() {
        scrollView = UIScrollView()
        contentView = UIView()
        socialityLabel = UILabel()
        usernameTextField = setupTextField(text: "login", contentType: .username)
        passwordTextField = setupTextField(text: "password", contentType: .password)
        loginButton = setupLabel(#selector(loginButtonTap), "Login", .systemOrange)
        vkLoginButton = setupLabel(#selector(vkButtonTap), "VK", .systemBlue)

        guard let scrollView = scrollView,
              let contentView = contentView,
              let socialityLabel = socialityLabel,
              let usernameTextField = usernameTextField,
              let passwordTextField = passwordTextField,
              let loginButton = loginButton,
              let vkLoginButton = vkLoginButton else { return }

        scrollView.keyboardDismissMode = .onDrag

        socialityLabel.text = "Sociality"
        socialityLabel.font = .systemFont(ofSize: 27, weight: .semibold)
        socialityLabel.textAlignment = .center

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(socialityLabel)
        contentView.addSubview(usernameTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(loginButton)
        contentView.addSubview(vkLoginButton)

        view.backgroundColor = .systemGray3
        navigationController?.navigationBar.isHidden = true

        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(hideKeyboardGesture)
    }

    private func setupConstraints() {
        guard let scrollView = scrollView,
              let contentView = contentView,
              let socialityLabel = socialityLabel,
              let usernameTextField = usernameTextField,
              let passwordTextField = passwordTextField,
              let loginButton = loginButton,
              let vkLoginButton = vkLoginButton else { return }

        scrollView.snp.makeConstraints { snp in
            snp.edges.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints { snp in
            snp.edges.width.equalTo(scrollView)
            snp.height.equalToSuperview().priority(400)
        }

        socialityLabel.snp.makeConstraints { snp in
            snp.centerX.equalTo(contentView.snp.centerX)
            snp.bottom.equalTo(usernameTextField.snp.top).offset(-70)
        }

        usernameTextField.snp.makeConstraints { snp in
            snp.centerX.centerY.equalToSuperview()
            snp.leading.trailing.equalTo(contentView).inset(35)
            snp.height.equalTo(40)
        }

        passwordTextField.snp.makeConstraints { snp in
            snp.centerX.equalToSuperview()
            snp.leading.trailing.equalTo(contentView).inset(35)
            snp.height.equalTo(40)
            snp.top.equalTo(usernameTextField.snp.bottom).offset(15)
        }

        loginButton.snp.makeConstraints { snp in
            snp.centerX.equalToSuperview()
            snp.leading.trailing.equalTo(contentView).inset(35)
            snp.height.equalTo(50)
            snp.top.equalTo(passwordTextField.snp.bottom).offset(85)
            snp.bottom.equalTo(vkLoginButton.snp.top).offset(-10)
        }

        vkLoginButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(contentView).inset(35)
            $0.height.equalTo(50)
            $0.bottom.equalTo(scrollView).inset(50)
        }
    }
    
    private func setupTextField(text: String, contentType: UITextContentType) -> UITextField {
        let attStr = NSAttributedString(string: text,
                                        attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17,
                                                                                                    weight: .medium)])
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.clearsOnBeginEditing = true
        textField.textAlignment = .center
        textField.textContentType = contentType
        textField.layer.cornerRadius = 20
        textField.attributedPlaceholder = attStr
        return textField
    }
    
    private func checkLoginInfo(_ login: String, password: String) -> Bool {
        var isAuthorized: Bool
        if login.lowercased() == "login" && password == "1234" {
            UserDefaults.standard.set(false, forKey: "isAuthorized")
            isAuthorized = UserDefaults.standard.bool(forKey: "isAuthorized")
            showAlert()
        } else {
            UserDefaults.standard.set(true, forKey: "isAuthorized")
            isAuthorized = UserDefaults.standard.bool(forKey: "isAuthorized")
        }
        return isAuthorized
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Ups", message: "Wrong username or password", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    private func setupLabel(_ action: Selector,
                            _ text: String,
                            _ color: UIColor,
                            _ image: UIImage = UIImage(systemName: "chevron") ?? UIImage()) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = color
        button.setTitle(text, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: action, for: .touchUpInside)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 100, bottom: 5, right: 5)
        button.setBackgroundImage(image, for: .normal)
        return button
    }
}

// MARK: - Actions
extension LoginVC {
    @objc func hideKeyboard() {
        scrollView?.endEditing(true)
    }
    
    @objc func keyboardWasShown(notification: Notification) {
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    @objc func loginButtonTap() {
        let isAuthorized = checkLoginInfo(usernameTextField?.text ?? "", password: passwordTextField?.text ?? "")

        guard isAuthorized else { return }

        AppContainer.createSpinnerView(self, AppContainer.makeRootController())
    }

    @objc func vkButtonTap() {
        let vc = UINavigationController(rootViewController: VKLoginVC())
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
    }
}
