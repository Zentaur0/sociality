//
//  ViewController.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 30.07.2021.
//

import UIKit
import SnapKit

class LoginVC: UIViewController {
    
    // MARK: - Properties
    private var socialityLabel: UILabel?
    private var usernameTextField: UITextField?
    private var passwordTextField: UITextField?
    private var loginButton: UIButton?
    private var scrollView: UIScrollView?
    private var contentView: UIView?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
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
        loginButton = UIButton(type: .system)
        
        guard let scrollView = scrollView,
              let contentView = contentView,
              let socialityLabel = socialityLabel,
              let usernameTextField = usernameTextField,
              let passwordTextField = passwordTextField,
              let loginButton = loginButton else { return }
        
        scrollView.keyboardDismissMode = .onDrag
        
        socialityLabel.text = "Sociality"
        socialityLabel.font = .systemFont(ofSize: 27, weight: .semibold)
        socialityLabel.textAlignment = .center
        
        loginButton.backgroundColor = .systemBlue
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        loginButton.layer.cornerRadius = 25
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(socialityLabel)
        contentView.addSubview(usernameTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(loginButton)
        
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.isHidden = true
        setupConstraints()
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(hideKeyboardGesture)
    }
    
    private func setupConstraints() {
        guard let scrollView = scrollView,
              let contentView = contentView,
              let socialityLabel = socialityLabel,
              let usernameTextField = usernameTextField,
              let passwordTextField = passwordTextField,
              let loginButton = loginButton else { return }
        
        scrollView.snp.makeConstraints { snp in
            snp.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { snp in
            snp.leading.trailing.top.bottom.height.width.equalTo(scrollView)
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
            snp.top.equalTo(passwordTextField.snp.bottom).offset(25)
        }
    }
    
    private func setupTextField(text: String, contentType: UITextContentType) -> UITextField {
        let attStr = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)])
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.clearsOnBeginEditing = true
        textField.textAlignment = .center
        textField.textContentType = contentType
        textField.layer.cornerRadius = 20
        textField.attributedPlaceholder = attStr
        return textField
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
}
