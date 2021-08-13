//
//  AlphabeticView.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 04.08.2021.
//

import UIKit

final class Spinner: UIViewController {
    
    // MARK: - Properties
    let spinner = UIActivityIndicatorView(style: .large)
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSpinner()
    }
}

// MARK: - Methods
extension Spinner {
    private func setupSpinner() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        spinner.color = .white
        
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        spinner.startAnimating()
    }
}
